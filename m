Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414E659B93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiL3TOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3TOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:14:05 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA921BE88
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:14:04 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BUJDYOu1374083
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 30 Dec 2022 11:13:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BUJDYOu1374083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672427615;
        bh=F103lIyQ9HX4e4YADpdbkcMaF5Kx4eLLs91AFAzCwso=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=K8NMsfzGoSb1SBtWMNz3ggVlUOJRELCkRnUKzt6hw56EVmc4jFFV3+KRPutfMwvTk
         SdNMQ3OcZB8rU4Z/qdRN05To4PkZq5gGj4siHqlXnQCAE7gI2si76k9PVt0XRUuzEc
         AYe8HHshNVSquk5Go2lfyG8XSixPYCGjv4/pXvWm1FOU+yiVThTTGejW/+9OxiGFWi
         vCxxi4fWir2OJLP0A3XVM1Lbf4xit5k9XKVmJ5/bJfe57CnCpzuax4dzrhs7JvLZf+
         soJWFlzkEqLz6c320Ylrcq7tfLeDntJnzMd3YvTDwRyK6P/rMC+Omx52vYpzJBxW5r
         lpUhynDeGeSpw==
Date:   Fri, 30 Dec 2022 11:13:32 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_qemu=5D_x86=3A_don=27t_let_decomp?= =?US-ASCII?Q?ressed_kernel_image_clobber_setup=5Fdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y68K4mPuz6edQkCX@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com> <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org> <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com> <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com> <AF921575-0968-434A-8B46-095B78C209C1@zytor.com> <Y68K4mPuz6edQkCX@zx2c4.com>
Message-ID: <6C1D0560-6D77-4733-9B8D-5184935AEC62@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2022 7:59:30 AM PST, "Jason A=2E Donenfeld" <Jason@zx2c4=2E=
com> wrote:
>Hi,
>
>On Wed, Dec 28, 2022 at 11:31:34PM -0800, H=2E Peter Anvin wrote:
>> On December 28, 2022 6:31:07 PM PST, "Jason A=2E Donenfeld" <Jason@zx2c=
4=2Ecom> wrote:
>> >Hi,
>> >
>> >Read this message in a fixed width text editor with a lot of columns=
=2E
>> >
>> >On Wed, Dec 28, 2022 at 03:58:12PM -0800, H=2E Peter Anvin wrote:
>> >> Glad you asked=2E
>> >>=20
>> >> So the kernel load addresses are parameterized in the kernel image
>> >> setup header=2E One of the things that are so parameterized are the =
size
>> >> and possible realignment of the kernel image in memory=2E
>> >>=20
>> >> I'm very confused where you are getting the 64 MB number from=2E The=
re
>> >> should not be any such limitation=2E
>> >
>> >Currently, QEMU appends it to the kernel image, not to the initramfs a=
s
>> >you suggest below=2E So, that winds up looking, currently, like:
>> >
>> >          kernel image            setup_data
>> >   |--------------------------||----------------|
>> >0x100000                  0x100000+l1     0x100000+l1+l2
>> >
>> >The problem is that this decompresses to 0x1000000 (one more zero)=2E =
So
>> >if l1 is > (0x1000000-0x100000), then this winds up looking like:
>> >
>> >          kernel image            setup_data
>> >   |--------------------------||----------------|
>> >0x100000                  0x100000+l1     0x100000+l1+l2
>> >
>> >                                 d e c o m p r e s s e d   k e r n e l
>> >		     |-------------------------------------------------------------|
>> >                0x1000000                                             =
        0x1000000+l3=20
>> >
>> >The decompressed kernel seemingly overwriting the compressed kernel
>> >image isn't a problem, because that gets relocated to a higher address
>> >early on in the boot process=2E setup_data, however, stays in the same
>> >place, since those links are self referential and nothing fixes them u=
p=2E
>> >So the decompressed kernel clobbers it=2E
>> >
>> >The solution in this commit adds a bunch of padding between the kernel
>> >image and setup_data to avoid this=2E That looks like this:
>> >
>> >          kernel image                            padding             =
                  setup_data
>> >   |--------------------------||--------------------------------------=
-------------||----------------|
>> >0x100000                  0x100000+l1                                 =
        0x1000000+l3      0x1000000+l3+l2
>> >
>> >                                 d e c o m p r e s s e d   k e r n e l
>> >		     |-------------------------------------------------------------|
>> >                0x1000000                                             =
        0x1000000+l3=20
>> >
>> >This way, the decompressed kernel doesn't clobber setup_data=2E
>> >
>> >The problem is that if 0x1000000+l3-0x100000 is around 62 megabytes,
>> >then the bootloader crashes when trying to dereference setup_data's
>> >->len param at the end of initialize_identity_maps() in ident_map_64=
=2Ec=2E
>> >I don't know why it does this=2E If I could remove the 62 megabyte
>> >restriction, then I could keep with this technique and all would be
>> >well=2E
>> >
>> >> In general, setup_data should be able to go anywhere the initrd can
>> >> go, and so is subject to the same address cap (896 MB for old kernel=
s,
>> >> 4 GB on newer ones; this address too is enumerated in the header=2E)
>> >
>> >It would be theoretically possible to attach it to the initrd image
>> >instead of to the kernel image=2E As a last resort, I guess I can look
>> >into doing that=2E However, that's going to require some serious rewor=
k
>> >and plumbing of a lot of different components=2E So if I can make it w=
ork
>> >as is, that'd be ideal=2E However, I need to figure out this weird 62 =
meg
>> >limitation=2E
>> >
>> >Any ideas on that?
>> >
>> >Jason
>>=20
>> As far as a crash=2E=2E=2E that sounds like a big and a pretty serious =
one at that=2E
>>=20
>> Could you let me know what kernel you are using and how *exactly* you a=
re booting it?
>
>I'll attach a =2Econfig file=2E Apply the patch at the top of this thread=
 to
>qemu, except make one modification:
>
>diff --git a/hw/i386/x86=2Ec b/hw/i386/x86=2Ec
>index 628fd2b2e9=2E=2Ea61ee23e13 100644
>--- a/hw/i386/x86=2Ec
>+++ b/hw/i386/x86=2Ec
>@@ -1097,7 +1097,7 @@ void x86_load_linux(X86MachineState *x86ms,
>=20
>             /* The early stage can't address past around 64 MB from the =
original
>              * mapping, so just give up in that case=2E */
>-            if (padded_size < 62 * 1024 * 1024)
>+            if (true || padded_size < 62 * 1024 * 1024)
>                 kernel_size =3D padded_size;
>             else {
>                 fprintf(stderr, "qemu: Kernel image too large to hold se=
tup_data\n");
>
>Then build qemu=2E Run it with `-kernel bzImage`, based on the kernel
>built with the =2Econfig I attached=2E
>
>You'll see that the CPU triple faults when hitting this line:
>
>        sd =3D (struct setup_data *)boot_params->hdr=2Esetup_data;
>        while (sd) {
>                unsigned long sd_addr =3D (unsigned long)sd;
>
>                kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + =
sd->len);  <----
>                sd =3D (struct setup_data *)sd->next;
>        }
>
>, because it dereferences *sd=2E This does not happen if the decompressed
>size of the kernel is < 62 megs=2E
>
>So that's the "big and pretty serious" bug that might be worthy of
>investigation=2E
>
>Jason

No kidding=2E Dereferencing data *before you map it* is generally frowned =
upon=2E

This needs to be split into to making calls=2E

*Facepalm*
