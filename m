Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A9643CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiLFFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFFi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2EE22534
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670305045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCpQoYaQ/Ha08fQwDldZIJmIopiT9lmDYnqu+ZkZwm8=;
        b=bseQoy3H3wdTKOkdrTTOuTkyP6/DcqvI6D1uf0VTs4bhcFJScieTKZSS3b5rgOdWsbZmUK
        VBy24Uuw18448bYSVTfQN3KYXY8MjvPigVWljmRiKXughnk5xTbxPJIAG2/O2EAhX6GmZl
        e5V95J5CxPu0JtBGY1+CjBRitkymscs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-AYJ6Xl1BNoafmEcCFHLafw-1; Tue, 06 Dec 2022 00:37:23 -0500
X-MC-Unique: AYJ6Xl1BNoafmEcCFHLafw-1
Received: by mail-qv1-f70.google.com with SMTP id nt2-20020a0562143c0200b004c74f7ec3afso16495419qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 21:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCpQoYaQ/Ha08fQwDldZIJmIopiT9lmDYnqu+ZkZwm8=;
        b=GNcdBzquf6svbaqyMuglKi3fpcc6WEtQUrSmDxNiLB2GqC3LMg80P3oEaL2vkJYjZa
         lvYnBSWyDXv9206G0nLZ6pODd5CnKRfrKrScSpWU3TiUqCHuDDF2crFmTToR7qtA1Ih0
         pk67hiuYJ/n9VWxHx/78d2Ldxex3bPrnKdPamQJ+K9676r+ooWICeY3A1RYw1XP71g4G
         QoR+xXF/9d/GeOHUIMb8iM0qvrOD8BT0oARi7uj2aeuy9CFSy/YavYr4QabMSjsylLXt
         dPtpRLD2ya28vQC673ddd/cngLuY3HD3YrNkwZOuPTscc+8NYKYRYB1nK3/CYY1QwRhQ
         P8xQ==
X-Gm-Message-State: ANoB5pmdVph0MlcuZyem3Aok8LDIjwaaKV03gEdYNjzPyLk+SIw7pGsn
        wI+AlKkiapX82a6oMTroVGZvI0VW/9BvX0k7sBYXWzuii+hTxh949mCVui1viBGRd9NY+zU7HSW
        Bzj1qm1ZHImH2Ze/YggNZxHma
X-Received: by 2002:a05:620a:2728:b0:6fa:1d3b:fa74 with SMTP id b40-20020a05620a272800b006fa1d3bfa74mr75522874qkp.123.1670305042980;
        Mon, 05 Dec 2022 21:37:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aD1MhwUe0pMh0RGdRRsCbd8zoLd0vIAkPSgLCTOFX8XeHvRDflB9csTbfjT7H0DY5n9Fsqw==
X-Received: by 2002:a05:620a:2728:b0:6fa:1d3b:fa74 with SMTP id b40-20020a05620a272800b006fa1d3bfa74mr75522869qkp.123.1670305042768;
        Mon, 05 Dec 2022 21:37:22 -0800 (PST)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id o13-20020ac85a4d000000b003a68fe872a5sm2057132qta.96.2022.12.05.21.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 21:37:22 -0800 (PST)
Message-ID: <88901065-469f-0988-f56b-c84d1fabbe8a@redhat.com>
Date:   Tue, 6 Dec 2022 00:37:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH next v2] kbuild: add ability to make source rpm buildable
 using koji
Content-Language: en-US
To:     linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, dzickus@redhat.com, ihuguet@redhat.com,
        ivecera@redhat.com, jtornosm@redhat.com, kheib@redhat.com,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 09:48, Jonathan Toppins wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Changes:
> - added new target 'srcrpm-pkg' to generate source rpm
> - added required build tools to spec file
> - removed locally compiled host tools to force their re-compile
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> Acked-by: Íñigo Huguet <ihuguet@redhat.com>
> Tested-by: Ivan Vecera <ivecera@redhat.com>
> ---
> 
> Notes:
>      v2:
>       * updated UTS_MACHINE to be $(UTS_MACHINE)-linux
>         suggested by Masahiro Yamada

Quick ping, wanted to make sure I didn't miss any requests. Looking at 
patchwork there appear to be no replies to this version. Would it be 
reasonable to assume this version will be accepted and make it into the 
next kernel?

> 
>   scripts/Makefile.package | 10 ++++++++++
>   scripts/package/mkspec   |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 8bbcced67c22..1290f1c631fb 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -62,6 +62,16 @@ rpm-pkg:
>   	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
>   	--define='_smp_mflags %{nil}'
>   
> +# srcrpm-pkg
> +# ---------------------------------------------------------------------------
> +PHONY += srcrpm-pkg
> +srcrpm-pkg:
> +	$(MAKE) clean
> +	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
> +	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
> +	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ts $(KERNELPATH).tar.gz \
> +	--define='_smp_mflags %{nil}' --define='_srcrpmdir $(srctree)'
> +
>   # binrpm-pkg
>   # ---------------------------------------------------------------------------
>   PHONY += binrpm-pkg
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 70392fd2fd29..dda00a948a01 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -33,6 +33,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>   --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
>   --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
>   
> +test -n "$LOCALVERSION" && MAKE="$MAKE LOCALVERSION=$LOCALVERSION"
> +
>   # We can label the here-doc lines for conditional output to the spec file
>   #
>   # Labels:
> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>   	URL: https://www.kernel.org
>   $S	Source: kernel-$__KERNELRELEASE.tar.gz
>   	Provides: $PROVIDES
> +$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> +$S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
> +
>   	# $UTS_MACHINE as a fallback of _arch in case
>   	# /usr/lib/rpm/platform/*/macros was not included.
>   	%define _arch %{?_arch:$UTS_MACHINE}
> @@ -80,6 +85,8 @@ $S$M	against the $__KERNELRELEASE kernel package.
>   $S$M
>   $S	%prep
>   $S	%setup -q
> +$S	rm -f scripts/basic/fixdep scripts/kconfig/conf
> +$S	rm -f tools/objtool/{fixdep,objtool}
>   $S
>   $S	%build
>   $S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}

