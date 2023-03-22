Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E596C4DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCVOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCVOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0F2A6E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7DE96212D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A71DC433EF;
        Wed, 22 Mar 2023 14:34:51 +0000 (UTC)
Date:   Wed, 22 Mar 2023 10:34:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBsSBr87al9ccG96@home.goodmis.org>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> Clang16 links the purgatory text in two sections:
> 
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>        00000000000011a1  0000000000000000  AX       0     0     16
>   [ 2] .rela.text        RELA             0000000000000000  00003498
>        0000000000000648  0000000000000018   I      24     1     8
>   ...
>   [17] .text.hot.        PROGBITS         0000000000000000  00003220
>        000000000000020b  0000000000000000  AX       0     0     1
>   [18] .rela.text.hot.   RELA             0000000000000000  00004428
>        0000000000000078  0000000000000018   I      24    17     8
> 
> And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> area pointed by `e_entry`.
> 
> This causes that image->start is calculated twice, once for .text and
> another time for .text.hot. The second calculation leaves image->start
> in a random location.
> 
> Because of this, the system crashes inmediatly after:
> 
> kexec_core: Starting new kernel
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/kexec_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..b1a25d97d5e2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start != pi->ehdr->e_shnum) {

Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {

?

As you want to only do this update when it's not equal to the initial value.
If this did work, then you may want to make sure that was the initial value.

Also, please add a comment about why you are doing this check.

Thanks!

-- Steve

>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
