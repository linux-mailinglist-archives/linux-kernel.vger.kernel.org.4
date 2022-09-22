Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18245E60C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiIVLTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiIVLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:19:16 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C7DED5D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1663845554;
        bh=flyR88Jrejjr4Zl6iHpQU5Bfe821fViP66EMnFD03eo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LzCfWXjfo+UUaLw6k8hFnsABgrQhNI3Cd8VL3M+rl1LBp3UwgjXbpOquHLmyWgGBC
         ZCBhIptwfmdqF99srcVL+qKO+deY6SeIevw+5SaX1GC/W6ptKbMVVo3YivJnQeoG8w
         vEWFp4HF4mKzg7OnsJx8kw6rj4bhGeHZdfSYEjM8=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7791C66887;
        Thu, 22 Sep 2022 07:19:12 -0400 (EDT)
Message-ID: <5e12ab67701adf81834dfb88fc3cb6fdf55f676d.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Thu, 22 Sep 2022 19:19:10 +0800
In-Reply-To: <750719dc-d481-6eba-05c6-50cfdceb871b@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
         <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
         <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
         <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
         <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
         <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
         <0b2d115c42ff6cb9b8c65d852ec2f0746ca6e8d9.camel@xry111.site>
         <d852f590-95b4-3fd1-924a-68c0a6bb1b1b@loongson.cn>
         <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
         <a218373f773ef193903daa528291ec8bb384ddd2.camel@xry111.site>
         <83a7aad8-125b-29b5-715d-0061ce1b0647@loongson.cn>
         <011b5d39-e0cb-69cc-66fd-ed46afe7695e@loongson.cn>
         <750719dc-d481-6eba-05c6-50cfdceb871b@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 16:01 +0800, Youling Tang wrote:
> After adding KBUILD_CFLAGS_KERNEL +=3D -mdirect-extern-access, the
> kernel
> will not generate .got, .plt and .got.plt sections (in the new
> toolchain), we should unexpectedly detect that the kernel has these
> sections, maybe add similar patch [1] to detect, x86_64 has the same
> operation.
>=20
> But when adding LDFLAGS_vmlinux +=3D -pie (or -shared), there will be
> .got, .plt and .got.plt sections generated, I don't know how the
> toolchain handles it :(?

Hi Youling,

I've pulled your code and make some adjustments for it:

https://github.com/xry111/linux/commits/xry111/la-dev/pie

One adjustment is for FDT removal, another uses a static-PIE style
LDFLAGS as the kernel is more "similar" to a static PIE than a shared
library. In userspace, a static PIE is linked with [1]:

 -static -pie --no-dynamic-linker -z text

[1]: https://gcc.gnu.org/r13-2728

But we have to use "-z notext" for vmlinux. I'm not an expert on kernel
hacking, and I guess it's because the kernel doesn't really care the RWX
permission of itself (I heard this during some discussion about a W/X
page warning added in Binutils-2.39 which is triggered for vmlinux).

With "-static -pie --no-dynamic-linker -z notext" (and GCC trunk &
Binutils trunk), .plt and .got.plt are gone.

.got is still there but it only contains one entry (8 bytes).  AFAIK
this entry (`_GLOBAL_OFFSET_TABLE_[0]`) is set to the link-time address
of _DYNAMIC for a userspace static PIE [2], but vmlinux does not need it
at all.  We can tell the linker to discard it IIUC.

[2]:
https://maskray.me/blog/2021-08-29-all-about-global-offset-table#global_off=
set_table_0

I've boot the kernel successfully and it seems KASLR is in-effect:

$ sudo cat /proc/kallsyms | grep ' _printk$'
90000000023b28f4 T _printk
$ grep ' _printk$' /boot/System.map-6.0.0-rc6-pie+=20
90000000009828f4 T _printk

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
