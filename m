Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD33750CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjGLPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FE1BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7342F61873
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57921C433C7;
        Wed, 12 Jul 2023 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689176760;
        bh=VHFJLLY2tiHdpg6U8Yj5DS99OIzdiNoLkdg0LzRTC1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVbiiLS7NqLNMDhlGkJaRSDdflmfKiip72CeUlV0kp3SRvPXvJ9BYNcPy3ztfxhb8
         f+VqkHJ6h3Wf2vJZ34r5yG0j6vgIDyC5fuNm9KaimiH5qMOW5KdIJ84LfrkrCepjg9
         9aDVNw+PSH5pjuuDtaSgbJPeDIvo7O86B+kwxzmQ=
Date:   Wed, 12 Jul 2023 17:45:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <2023071237-private-overhang-7f86@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711154449.1378385-1-eesposit@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> *Important*: this is just an RFC, as I am not expert in this area and
> I don't know what's the best way to achieve this.
> 
> v2:
> * add standard "sbat,1,SBAT Version,..." header string
> 
> The aim of this patch is to add a .sbat section to the linux binary
> (https://github.com/rhboot/shim/blob/main/SBAT.md).
> We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> to revoke authorizations to specific signed PEs that were initially
> considered as trusted. The reason might be for example a security issue
> related to a specific linux release.
> 
> A .sbat is simply a section containing a string with the component name
> and a version number. This version number is compared with the value in
> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> even if it is correctly signed.
> 
> Right now an UKI is built with a .sbat section containing the
> systemd-stub sbat string (upstream + vendor), we would like to add
> also a per-component specific string (ie vmlinux has its own sbat,
> again upstream + vendor, each signed add-on its own and so on).
> In this way, if a specific kernel version has an issue, we can revoke
> it without compromising all other UKIs that are using a different
> kernel with the same stub/initrd/something else.
> 
> Issues with this patch:
> * the string is added in a file but it is never deleted
> * if the code is not modified but make is issued again, objcopy will
>   be called again and will fail because .sbat exists already, making
>   compilation fail
> * minor display issue: objcopy command is printed in the make logs
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/x86/boot/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9e38ffaadb5d..6982a50ba0c0 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -83,6 +83,9 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
>  
>  $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
>  	$(call if_changed,image)
> +	@$(kecho) "sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md" > linux.sbat
> +	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" >> linux.sbat;

Who controls "linux.org"?  Why are you thinking they have anything to do
with kernel development?

This shows a huge lack of understanding of loads of things, please go
get other experienced Red Hat developers to sign off on the next version
of your patch before you ask the community to review it.

As is, this is not going to go far.

thanks,

greg k-h
