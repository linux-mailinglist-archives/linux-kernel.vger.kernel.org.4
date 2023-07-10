Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC274CDA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGJGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGJGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A9B3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688971943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgIyGPKedjNAbujgxzWK+MFKFTpQuyqgmKG61/icdnk=;
        b=NVbFXJOkmZMLe4XRb8tclRxjDGi7owcAmzqil3QBrkxHDMuLqaDYI76YEn7FzIKxOYcEcI
        YtmvjrN2dauFleuoFZVyueeO49c3zPwc558knzVg3NLh9wiSY1WkTs/3fbeX4ra17en3tl
        TWbBoKVXW780PGwk9vRHLUrcq9lZbXY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-vD8e219tNNynfc7SFmycyw-1; Mon, 10 Jul 2023 02:52:19 -0400
X-MC-Unique: vD8e219tNNynfc7SFmycyw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-400a393268cso47207511cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971939; x=1691563939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgIyGPKedjNAbujgxzWK+MFKFTpQuyqgmKG61/icdnk=;
        b=BDWz601PcITjA77Tc8oXcEQKkCXqfukA+Y0r+cmXyOzDcTz8+FdsGgQRcJwgMa5OcK
         8hsr+9A3tO4m7RtqXvjvkSZQ7Drb/rUA/qEkjZJ4/cDgcfXpfCXAwEZnxKZSx7VxNa0F
         Wv+KmaQMjNsNaYuSTsXgpODkxkV+N8t0gS6aGWNAp98IAX5gHUX5eWoSmS5q3f9JEuaW
         aux5kkVdoBOsrNC5Ig48cwl3beJ8p3HUOA9lMYLKfMfkOMRaS7obZR+7SS56GswZcJ3/
         cBIb0uVa3VzYtFJbN5Yoz26LGsMmONwCH/b2GGP7OlbVaM/NeS4uSnHr8y+GFgwJ05DU
         iLQA==
X-Gm-Message-State: ABy/qLYgweDJRIAuYYK8WMk98XyPD38lCHoMLQVOQZjDeOWefQONW39y
        8HQV32+/J4WKt0W8nAo8CK4chUkrp4+ZdfRAAZoR2+UKIQj4qAkY1Qhf8px5cEOmEwMnesZyA9M
        rCxqmU0bXnwNOtc2I+OnK37l/
X-Received: by 2002:a05:622a:11d2:b0:403:b23f:9aab with SMTP id n18-20020a05622a11d200b00403b23f9aabmr831769qtk.7.1688971939435;
        Sun, 09 Jul 2023 23:52:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5fGALJRNqDYzHMXQQlvDkg1rUwU2ADAeTSZlV5gFgjFrU/Vz6shYiAfQjKDh7sEFY5wKYRA==
X-Received: by 2002:a05:622a:11d2:b0:403:b23f:9aab with SMTP id n18-20020a05622a11d200b00403b23f9aabmr831750qtk.7.1688971939209;
        Sun, 09 Jul 2023 23:52:19 -0700 (PDT)
Received: from [192.168.149.40] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id i23-20020ac87657000000b004036bcfb1b5sm4646972qtr.65.2023.07.09.23.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 23:52:18 -0700 (PDT)
Message-ID: <c4f3d532-289d-57eb-ac69-f8a503c11206@redhat.com>
Date:   Mon, 10 Jul 2023 08:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] x86/boot: add .sbat section to the bzImage
Content-Language: de-CH
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230623123622.4126234-1-eesposit@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230623123622.4126234-1-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23/06/2023 um 14:36 schrieb Emanuele Giuseppe Esposito:
> *Important*: this is just an RFC, as I am not expert in this area and
> I don't know what's the best way to achieve this.
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
>  arch/x86/boot/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9e38ffaadb5d..65ff6fcf5372 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -83,6 +83,8 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
>  
>  $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
>  	$(call if_changed,image)
> +	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" > linux.sbat;
> +	$(OBJCOPY) --set-section-alignment '.sbat=512' --add-section .sbat=linux.sbat $@;
>  	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
>  
>  OBJCOPYFLAGS_vmlinux.bin := -O binary -R .note -R .comment -S

ping?

