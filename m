Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E73747B69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGECKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGECKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F410FE;
        Tue,  4 Jul 2023 19:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5BF61403;
        Wed,  5 Jul 2023 02:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D19C433C7;
        Wed,  5 Jul 2023 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688523001;
        bh=0RXVtrB0FoWlqLqj3GuhEFh6R++jmGgbW8HINllGCLs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AWcU1MY/jciOkKbUW/JRZsw5KyS6LeKrA+n7+Rx00yg2dG+WiCeWWW9e1hc/71tfx
         mBPikkYNoPJk/rk8+lHymdIdntDzO+a+a2eO+WOHg8amuVOV1+226aserM+xWUWj5A
         DzcsBp65+mzNJZX9tMGMDYumDKtfPGvjTO/xVCXmruTaArK4Az02J4byAB9860OLVE
         6Jd8/TdJz9DLx6im/khwNm9XeyiwlZNT6oRIJM5cvMo8GReR36++l+4OJvL7eJ5NT2
         WFTffhL162vEGWKaOkVmvlwkDETQfGmM3bQjUNKckjTNPs+SB6+BiShMpAkr61J5OX
         PCO3MBPj7bpfg==
Date:   Tue, 04 Jul 2023 19:09:59 -0700
From:   Kees Cook <kees@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Kees Cook <keescook@chromium.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
User-Agent: K-9 Mail for Android
In-Reply-To: <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr> <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook> <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net> <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net> <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr> <202307022230.6121D6896@keescook> <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr> <202307031149.823F9A3@keescook> <202307031606.3FD9D0D@keescook> <fbf4103b-6471-1f06-34a8-4aa227f5e091@alu.unizg.hr> <3CDD1188-7B2A-4D53-9B8F-C07BC39844E9@kernel.org> <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
Message-ID: <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 4, 2023 4:15:20 PM PDT, Mirsad Todorovac <mirsad=2Etodorovac@alu=2E=
unizg=2Ehr> wrote:
>On 7/4/23 23:36, Kees Cook wrote:
>> On July 4, 2023 10:20:11 AM PDT, Mirsad Todorovac <mirsad=2Etodorovac@a=
lu=2Eunizg=2Ehr> wrote:
>>> On 7/4/23 01:09, Kees Cook wrote:> On Mon, Jul 03, 2023 at 12:03:23PM =
-0700, Kees Cook wrote:
>>>>> Cool=2E xhci-hub is in your backtrace, and the above patch was made =
for
>>>>> something very similar (though, again, I don't see why you're gettin=
g a
>>>>> _crash_, it should _warn_ and continue normally)=2E And, actually, a=
lso
>>>>> include this patch:
>>>>> https://lore=2Ekernel=2Eorg/lkml/20230614181307=2Egonna=2E256-kees@k=
ernel=2Eorg/
>>>>=20
>>>> This is now in Linus's tree:
>>>> 09b69dd4378b ("usb: ch9: Replace 1-element array with flexible array"=
)
>>>>=20
>>>> Please also still try with the first patch I mentioned, which is very=
 similar:
>>>> https://lore=2Ekernel=2Eorg/lkml/20230629190900=2Enever=2E787-kees@ke=
rnel=2Eorg/
>>>=20
>>> Hi,
>>>=20
>>> I have finally built w both patches (and recommended PSTORE settings w=
ere
>>> default already)=2E
>>=20
>> Were you able to find the crashes saved by pstore?
>
>No, only lktdm and invalid opcode crashes =2E=2E=2E
>
>P=2ES=2E
>
>Actually, I have recovered some pstore records=2E Please find them in the=
 attachment:
>
>>> This second patch fixes the booting problem, but alas there is still a=
 problem -
>>=20
>> Ah! That's great! They're is still an unexpected crash source, but the =
trigger is fixed=2E
>
>Glad I could be of help=2E
>
>>> all Wayland and X11=2Eorg GUI applications fail to start, with errors =
like this one:
>>>=20
>>> Jul  4 19:09:07 defiant kernel: [   40=2E529719] invalid opcode: 0000 =
[#1] PREEMPT SMP NOPTI
>>=20
>> Hmm, is CONFIG_UBSAN_TRAP set?
>
>marvin@defiant:~/linux/kernel/linux_torvalds$ grep CONFIG_UBSAN_TRAP =2Ec=
onfig
>CONFIG_UBSAN_TRAP=3Dy

Ah-ha! Turn that off please=2E With it off you will get much more useful r=
eports from USBAN=2E

>marvin@defiant:~/linux/kernel/linux_torvalds$
>
>>> Jul  4 19:09:07 defiant kernel: [   40=2E529726] RIP: 0010:alloc_pid+0=
x46c/0x480
>>=20
>> Hmm, is this patch in your kernel?
>> https://git=2Ekernel=2Eorg/linus/b69f0aeb068980af983d399deafc7477cec8bc=
04
>
>No, it wasn't=2E I had only these:
>
>marvin@defiant:~/linux/kernel/linux_torvalds$ more =2E=2E/kees-[12]=2Epat=
ch
>::::::::::::::
>=2E=2E/kees-1=2Epatch
>::::::::::::::
>diff --git a/include/uapi/linux/usb/ch9=2Eh b/include/uapi/linux/usb/ch9=
=2Eh
>index b17e3a21b15f=2E=2E82ec6af71a1d 100644
>--- a/include/uapi/linux/usb/ch9=2Eh
>+++ b/include/uapi/linux/usb/ch9=2Eh
>@@ -376,7 +376,10 @@ struct usb_string_descriptor {
> 	__u8  bLength;
> 	__u8  bDescriptorType;
> -	__le16 wData[1];		/* UTF-16LE encoded */
>+	union {
>+		__le16 legacy_padding;
>+		__DECLARE_FLEX_ARRAY(__le16, wData);	/* UTF-16LE encoded */
>+	};
> } __attribute__ ((packed));
>  /* note that "string" zero is special, it holds language codes that
>::::::::::::::
>=2E=2E/kees-2=2Epatch
>::::::::::::::
>diff --git a/include/uapi/linux/usb/ch9=2Eh b/include/uapi/linux/usb/ch9=
=2Eh
>index b17e3a21b15f=2E=2E3ff98c7ba7e3 100644
>--- a/include/uapi/linux/usb/ch9=2Eh
>+++ b/include/uapi/linux/usb/ch9=2Eh
>@@ -981,7 +981,11 @@ struct usb_ssp_cap_descriptor {
> #define USB_SSP_MIN_RX_LANE_COUNT		(0xf << 8)
> #define USB_SSP_MIN_TX_LANE_COUNT		(0xf << 12)
> 	__le16 wReserved;
>-	__le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries *=
/
>+	union {
>+		__le32 legacy_padding;
>+		/* list of sublink speed attrib entries */
>+		__DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
>+	};
> #define USB_SSP_SUBLINK_SPEED_SSID	(0xf)		/* sublink speed ID */
> #define USB_SSP_SUBLINK_SPEED_LSE	(0x3 << 4)	/* Lanespeed exponent */
> #define USB_SSP_SUBLINK_SPEED_LSE_BPS		0
>marvin@defiant:~/linux/kernel/linux_torvalds$
>
>---------------------------------------------------------
>
>Now it works=2E Succeeded boot and running of X apps with the new git pul=
l
>torvalds tree and the kees-2=2Epatch=2E

Perfect! Okay, so it looks like all the issues are known and fixed=2E I'll=
 work with Greg to get the other ch9 patch landed=2E

>
>Praise God!
>
>This is the git log --oneline:
>
>d528014517f2 (HEAD, origin/master, origin/HEAD) Revert "=2Egitignore: ign=
ore *=2Ecover and *=2Embx"
>04f2933d375e Merge tag 'core_guards_for_6=2E5_rc1' of git://git=2Ekernel=
=2Eorg/pub/scm/linux/kernel/git/peterz/queue
>03275585cabd afs: Fix accidental truncation when storing data
>538140ca602b Merge tag 'ovl-update-6=2E5-2' of git://git=2Ekernel=2Eorg/p=
ub/scm/linux/kernel/git/overlayfs/vfs
>94c76955e86a Merge tag 'gfs2-v6=2E4-rc5-fixes' of git://git=2Ekernel=2Eor=
g/pub/scm/linux/kernel/git/gfs2/linux-gfs2
>ccf46d853183 Merge tag 'pm-6=2E5-rc1-2' of git://git=2Ekernel=2Eorg/pub/s=
cm/linux/kernel/git/rafael/linux-pm
>b869e9f49964 Merge tag 'clk-for-linus' of git://git=2Ekernel=2Eorg/pub/sc=
m/linux/kernel/git/clk/linux
>406fb9eb198a Merge tag 'firewire-6=2E5-rc1' of git://git=2Ekernel=2Eorg/p=
ub/scm/linux/kernel/git/ieee1394/linux1394
>f1962207150c module: fix init_module_from_file() error handling
>40c565a429d7 Merge branches 'pm-cpufreq' and 'pm-cpuidle'
>f679e89acdd3 clk: tegra: Avoid calling an uninitialized function
>
>So, the included patch is:
>
>marvin@defiant:~/linux/kernel/linux_torvalds$ git diff
>diff --git a/include/uapi/linux/usb/ch9=2Eh b/include/uapi/linux/usb/ch9=
=2Eh
>index 82ec6af71a1d=2E=2E62d318377379 100644
>--- a/include/uapi/linux/usb/ch9=2Eh
>+++ b/include/uapi/linux/usb/ch9=2Eh
>@@ -984,7 +984,11 @@ struct usb_ssp_cap_descriptor {
> #define USB_SSP_MIN_RX_LANE_COUNT              (0xf << 8)
> #define USB_SSP_MIN_TX_LANE_COUNT              (0xf << 12)
>        __le16 wReserved;
>-       __le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib ent=
ries */
>+       union {
>+               __le32 legacy_padding;
>+               /* list of sublink speed attrib entries */
>+               __DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
>+       };
> #define USB_SSP_SUBLINK_SPEED_SSID     (0xf)           /* sublink speed =
ID */
> #define USB_SSP_SUBLINK_SPEED_LSE      (0x3 << 4)      /* Lanespeed expo=
nent */
> #define USB_SSP_SUBLINK_SPEED_LSE_BPS          0
>marvin@defiant:~/linux/kernel/linux_torvalds$
>
>This means vanilla torvalds tree + https://lore=2Ekernel=2Eorg/lkml/20230=
629190900=2Enever=2E787-kees@kernel=2Eorg/
>works, but vanilla torvalds tree w/o patch still crashes=2E

Great, thanks again for testing it all!

-Keed

>
>I am still rather new to the utilisation of the PSTORE subsystem=2E
>
>Best regards,
>Mirsad Todorovac

--=20
Kees Cook
