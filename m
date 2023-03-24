Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303666C820D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCXQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947A222C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679673635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07VOxlALNLKaWDkjoN/aehXC/dxN7MylPi136nBJvgk=;
        b=QdJVX/vF8QjusTX/X19wiOQI9pAtJ5Qe089bDBMMzaZJf3DxIq1rrMg4c2mum7c7Lh/wz6
        gRbTCA9dMjIh1c4gIN9thDC9fXmUltnWwuiQ/DUyXuo9HO3fmGzLy5VFv2lY7Rj1b1BIXi
        4JJZndB70B3J8gEI/IQGPdopjHZHz2c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-f88pObpsOnOEHLOHZZAtqQ-1; Fri, 24 Mar 2023 12:00:34 -0400
X-MC-Unique: f88pObpsOnOEHLOHZZAtqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C75A1C09066;
        Fri, 24 Mar 2023 16:00:33 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85690202701E;
        Fri, 24 Mar 2023 16:00:32 +0000 (UTC)
Date:   Fri, 24 Mar 2023 16:58:55 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230324165855.23084947@rotkaeppchen>
In-Reply-To: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, 22 Mar 2023 20:09:21 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

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

Great analysis!

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> kexec: Fix kexec_file_load for llvm16
> 
> When upreving llvm I realised that kexec stopped working on my test
> platform. This patch fixes it.
> 
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v3:
> - Fix initial value. Thanks Ross!
> - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> 
> Changes in v2:
> - Fix if condition. Thanks Steven!.
> - Update Philipp email. Thanks Baoquan.
> - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> ---
>  kernel/kexec_file.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..25a37d8f113a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		}
>  
>  		offset = ALIGN(offset, align);
> +
> +		/*
> +		 * Check if the segment contains the entry point, if so,
> +		 * calculate the value of image->start based on it.
> +		 * If the compiler has produced more than one .text sections
> +		 * (Eg: .text.hot), they are generally after the main .text
> +		 * section, and they shall not be used to calculate
> +		 * image->start. So do not re-calculate image->start if it
> +		 * is not set to the initial value.
> +		 */
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start == pi->ehdr->e_entry) {

I'm not entirely sure if this is the solution to go with. As you state
in the comment above this solution assumes that the .text section comes
before any other .text.* section. But this assumption isn't much
stronger than the assumption that there is only a single .text section,
which is used nowadays.

The best solution I can come up with right now is to introduce a linker
script for the purgatory that simply merges the .text sections into
one. Similar to what I did for s390 in
arch/s390/purgatory/purgatory.lds.S (although for a different reason).
But that would require every architecture to get one. An alternative
would be to find a way to get rid of the -r option on the LD_FLAGS,
which IIRC is the reason why both section overlap in the first place.

Thanks
Philipp

>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,

