Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28D74FCAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGLBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:22:33 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03695
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 36C1LPSM3000634
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 11 Jul 2023 18:21:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 36C1LPSM3000634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023061001; t=1689124889;
        bh=Q/kleWqkapvb6jIEkTnXqkEzyycVCUl2hOfAKKrz2yg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WLnhA3yTQLjIXGJ4rBSuohSA3ElMQF9pcR/AFZh7QZY1UKk0dvCO2m5WVVkhFt0k7
         EedfYIaMlaOEn7dTDOeJ2BMuMUZl900yBK1HBfTGwNdH8vYPBwWOv1m3WOos5zrp+Z
         OWORtS94GKqXM28WyCkUykHGIL7g7kKHvUJ1wC2EJ1RsxkhIX58PEQsHXdRgMTKOpC
         3UAWCtMUW3g9QER099Ym9r3GG3zT2IUHHKmotzTU9eqa5m4hZTrgpUCkoBGdOEzfOH
         rHpVEYWvnmdJlSJfhlRFPW3hjagjlzpveHTNq8Vi47JKzc8BJ9LNQdz8v6xX4foksn
         AeUzvA0yhYxpA==
Date:   Tue, 11 Jul 2023 18:21:24 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?ISO-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
User-Agent: K-9 Mail for Android
In-Reply-To: <20230711154449.1378385-1-eesposit@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
Message-ID: <7DF38657-99C7-4C88-8835-7EE28E82C829@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 11, 2023 8:44:49 AM PDT, Emanuele Giuseppe Esposito <eesposit@redha=
t=2Ecom> wrote:
>*Important*: this is just an RFC, as I am not expert in this area and
>I don't know what's the best way to achieve this=2E
>
>v2:
>* add standard "sbat,1,SBAT Version,=2E=2E=2E" header string
>
>The aim of this patch is to add a =2Esbat section to the linux binary
>(https://github=2Ecom/rhboot/shim/blob/main/SBAT=2Emd)=2E
>We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
>to revoke authorizations to specific signed PEs that were initially
>considered as trusted=2E The reason might be for example a security issue
>related to a specific linux release=2E
>
>A =2Esbat is simply a section containing a string with the component name
>and a version number=2E This version number is compared with the value in
>OVMF_VARS, and if it's less than the variable, the binary is not trusted,
>even if it is correctly signed=2E
>
>Right now an UKI is built with a =2Esbat section containing the
>systemd-stub sbat string (upstream + vendor), we would like to add
>also a per-component specific string (ie vmlinux has its own sbat,
>again upstream + vendor, each signed add-on its own and so on)=2E
>In this way, if a specific kernel version has an issue, we can revoke
>it without compromising all other UKIs that are using a different
>kernel with the same stub/initrd/something else=2E
>
>Issues with this patch:
>* the string is added in a file but it is never deleted
>* if the code is not modified but make is issued again, objcopy will
>  be called again and will fail because =2Esbat exists already, making
>  compilation fail
>* minor display issue: objcopy command is printed in the make logs
>
>Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat=2Ecom>
>---
> arch/x86/boot/Makefile | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>index 9e38ffaadb5d=2E=2E6982a50ba0c0 100644
>--- a/arch/x86/boot/Makefile
>+++ b/arch/x86/boot/Makefile
>@@ -83,6 +83,9 @@ cmd_image =3D $(obj)/tools/build $(obj)/setup=2Ebin $(o=
bj)/vmlinux=2Ebin \
>=20
> $(obj)/bzImage: $(obj)/setup=2Ebin $(obj)/vmlinux=2Ebin $(obj)/tools/bui=
ld FORCE
> 	$(call if_changed,image)
>+	@$(kecho) "sbat,1,SBAT Version,sbat,1,https://github=2Ecom/rhboot/shim/=
blob/main/SBAT=2Emd" > linux=2Esbat
>+	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://=
linux=2Eorg" >> linux=2Esbat;
>+	$(OBJCOPY) --set-section-alignment '=2Esbat=3D512' --add-section =2Esba=
t=3Dlinux=2Esbat $@;
> 	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat =
=2Eversion`)')'
>=20
> OBJCOPYFLAGS_vmlinux=2Ebin :=3D -O binary -R =2Enote -R =2Ecomment -S

Why is this a special section rather than in the kernel_info structure?
