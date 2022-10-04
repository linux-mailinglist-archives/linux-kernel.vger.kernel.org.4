Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66FD5F4C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJDXPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJDXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FBB1EEDA;
        Tue,  4 Oct 2022 16:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C51B6155B;
        Tue,  4 Oct 2022 23:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D05EC433D6;
        Tue,  4 Oct 2022 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664925328;
        bh=S4DdoGHDMzJA5NbN/80N0nWBBHHnAaPWeujSWyBPUXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjaKa4fXNH8jdytNgYgxV1Dc+mxTa1iXR05yzfVvopcrl9f1khArqOT2h4uS1vaWR
         CEW8b/kJhegGT6V2beTorGphwUrPVMrrnHeouw7yg5Ednm37uBS5TfqZZhRQslecGc
         tCB7eKsEVe67rRZnia7trdiA3JRt2Nxdolk1jbUqNVIsgt/RB336TGRSrQEzkArzsT
         NSpkfM71vvF57t1QkOWqAbRNhT9SnjAk21Ywk82I+c9nGuZ1NCrUJ4/3/mX5x1Vftn
         gpgRemx63hdsprdzlq4PIumin0Xunn3u6AtmUv1//T0YV8cqBkg+JIG7U0ujRAyvE5
         +fE2vcVaz07vw==
Date:   Wed, 5 Oct 2022 02:15:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys <borysp@invisiblethingslab.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?utf-8?Q?Micha=C5=82?= Kowalczyk <mkow@invisiblethingslab.com>
Subject: Re: [PATCH] x86/sgx: Add overflow check in
 sgx_validate_offset_length()
Message-ID: <Yzy+jUeCXpYI6QvL@kernel.org>
References: <0d91ac79-6d84-abed-5821-4dbe59fa1a38@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d91ac79-6d84-abed-5821-4dbe59fa1a38@invisiblethingslab.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 12:59:03AM +0200, Borys wrote:
> sgx_validate_offset_length() function verifies "offset" and "length"
> arguments provided by userspace, but was missing an overflow check on
> their addition.
> This code was originally introduced in commit c6d26d370767 ("x86/sgx:
> Add SGX_IOC_ENCLAVE_ADD_PAGES") and later refactored in commit
> dda03e2c331b ("x86/sgx: Create utility to validate user provided offset
> and length").
> 
> Fixes: c6d26d370767 ("x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES")
> Signed-off-by: Borys Popławski <borysp@invisiblethingslab.com>
> ---
>  Applies on top of tip/x86/sgx ee56a283988d739c25d2d00ffb22707cb487ab47
> 
>  arch/x86/kernel/cpu/sgx/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index ebe79d60619f..da8b8ea6b063 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -356,6 +356,9 @@ static int sgx_validate_offset_length(struct sgx_encl *encl,
>  	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
>  		return -EINVAL;
>  
> +	if (offset + length < offset)
> +		return -EINVAL;
> +
>  	if (offset + length - PAGE_SIZE >= encl->size)
>  		return -EINVAL;
>  
> -- 
> 2.37.3
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BTW, needs:

Cc: stable@vger.kernel.org # v5.11+

BR, Jarkko
