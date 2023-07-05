Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60033747C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGEFTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEFTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:19:11 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271EA10E3;
        Tue,  4 Jul 2023 22:19:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1E9AC6015F;
        Wed,  5 Jul 2023 07:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688534344; bh=W5HHE66j8JjO3Vjt/85PqRFWEYxPbj4ZWKprM2uuQ/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tWc7F1Ne70O3cvAxW2WSFoPbEVKaktt4iyfg2GDA3bJLIHhmE1sNY06pku+pvrF3j
         LdGisS1qkveC++Fve+anbtSKAB314LHf6ofe0yAnFWNIxAQh2pOKavC9txVlqvh8oJ
         exue1gTCD2cBUGymFHgpOR1xNZbLQv1O1QBLoijPMKGqtv53zd3+7lPu3OHVCjjy9l
         WMfueHAV90OpMBpZ62TOQnNWqmlV5juZ7mAUGYU216F7yVgwtagu7lLc/zT0vr9ySb
         QwVzTQ08SWR27EyTMvBmbHLoHsuqdVDy/OIWCdjLOCVG/9OdqYjbsPqFF7+qkLrWhM
         v6skDviYWHeNQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bIJzYYxmmDFK; Wed,  5 Jul 2023 07:19:01 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 1F8D86015E;
        Wed,  5 Jul 2023 07:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688534341; bh=W5HHE66j8JjO3Vjt/85PqRFWEYxPbj4ZWKprM2uuQ/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F94G5lA6c73gao2qzrolwRBrSesWhLVhcQt+A6hvZvElXhHsWFv7hMTIEBtzA339O
         lkCRciAi7zzMcYbuwafKrx9S+MCKBmvPRzNWpl1Dn4hEIZVKcQoOTUvWZAugcbAke0
         RB56DCCjG2nuicNaehTzE1sTtbb7wlonj9ZiDn5iAz6EKFXLhUtWqfTAXAoLHBnT7J
         klCcfW9Pvn6T8T0xxKTgtfs/VmCMpN2Psqe46IfqdeBLd8VEfh2OY9Nw3rA5I+uqhD
         fWEZs1eiWQXNaP9HoZAhkalNLmKFddB/LTXG8E7DNDileYdsb7i8nGT8kbrtyFuioK
         YkizzKUqSpL3w==
Message-ID: <07629c94-0205-df11-3eec-e99781e3fcfe@alu.unizg.hr>
Date:   Wed, 5 Jul 2023 07:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
 <202307031149.823F9A3@keescook> <202307031606.3FD9D0D@keescook>
 <fbf4103b-6471-1f06-34a8-4aa227f5e091@alu.unizg.hr>
 <3CDD1188-7B2A-4D53-9B8F-C07BC39844E9@kernel.org>
 <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
 <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 04:09, Kees Cook wrote:
> On July 4, 2023 4:15:20 PM PDT, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
>> On 7/4/23 23:36, Kees Cook wrote:
>>> On July 4, 2023 10:20:11 AM PDT, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
>>>> On 7/4/23 01:09, Kees Cook wrote:> On Mon, Jul 03, 2023 at 12:03:23PM -0700, Kees Cook wrote:
>>>>>> Cool. xhci-hub is in your backtrace, and the above patch was made for
>>>>>> something very similar (though, again, I don't see why you're getting a
>>>>>> _crash_, it should _warn_ and continue normally). And, actually, also
>>>>>> include this patch:
>>>>>> https://lore.kernel.org/lkml/20230614181307.gonna.256-kees@kernel.org/
>>>>>
>>>>> This is now in Linus's tree:
>>>>> 09b69dd4378b ("usb: ch9: Replace 1-element array with flexible array")
>>>>>
>>>>> Please also still try with the first patch I mentioned, which is very similar:
>>>>> https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/
>>>>
>>>> Hi,
>>>>
>>>> I have finally built w both patches (and recommended PSTORE settings were
>>>> default already).
>>>
>>> Were you able to find the crashes saved by pstore?
>>
>> No, only lktdm and invalid opcode crashes ...
>>
>> P.S.
>>
>> Actually, I have recovered some pstore records. Please find them in the attachment:
>>
>>>> This second patch fixes the booting problem, but alas there is still a problem -
>>>
>>> Ah! That's great! They're is still an unexpected crash source, but the trigger is fixed.
>>
>> Glad I could be of help.
>>
>>>> all Wayland and X11.org GUI applications fail to start, with errors like this one:
>>>>
>>>> Jul  4 19:09:07 defiant kernel: [   40.529719] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>
>>> Hmm, is CONFIG_UBSAN_TRAP set?
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep CONFIG_UBSAN_TRAP .config
>> CONFIG_UBSAN_TRAP=y
> Ah-ha! Turn that off please. With it off you will get much more useful reports from USBAN.

Will do that. Thanks for the hint.

>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>>>> Jul  4 19:09:07 defiant kernel: [   40.529726] RIP: 0010:alloc_pid+0x46c/0x480
>>>
>>> Hmm, is this patch in your kernel?
>>> https://git.kernel.org/linus/b69f0aeb068980af983d399deafc7477cec8bc04
>>
>> No, it wasn't. I had only these:
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ more ../kees-[12].patch
>> ::::::::::::::
>> ../kees-1.patch
>> ::::::::::::::
>> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
>> index b17e3a21b15f..82ec6af71a1d 100644
>> --- a/include/uapi/linux/usb/ch9.h
>> +++ b/include/uapi/linux/usb/ch9.h
>> @@ -376,7 +376,10 @@ struct usb_string_descriptor {
>> 	__u8  bLength;
>> 	__u8  bDescriptorType;
>> -	__le16 wData[1];		/* UTF-16LE encoded */
>> +	union {
>> +		__le16 legacy_padding;
>> +		__DECLARE_FLEX_ARRAY(__le16, wData);	/* UTF-16LE encoded */
>> +	};
>> } __attribute__ ((packed));
>>   /* note that "string" zero is special, it holds language codes that
>> ::::::::::::::
>> ../kees-2.patch
>> ::::::::::::::
>> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
>> index b17e3a21b15f..3ff98c7ba7e3 100644
>> --- a/include/uapi/linux/usb/ch9.h
>> +++ b/include/uapi/linux/usb/ch9.h
>> @@ -981,7 +981,11 @@ struct usb_ssp_cap_descriptor {
>> #define USB_SSP_MIN_RX_LANE_COUNT		(0xf << 8)
>> #define USB_SSP_MIN_TX_LANE_COUNT		(0xf << 12)
>> 	__le16 wReserved;
>> -	__le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */
>> +	union {
>> +		__le32 legacy_padding;
>> +		/* list of sublink speed attrib entries */
>> +		__DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
>> +	};
>> #define USB_SSP_SUBLINK_SPEED_SSID	(0xf)		/* sublink speed ID */
>> #define USB_SSP_SUBLINK_SPEED_LSE	(0x3 << 4)	/* Lanespeed exponent */
>> #define USB_SSP_SUBLINK_SPEED_LSE_BPS		0
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> ---------------------------------------------------------
>>
>> Now it works. Succeeded boot and running of X apps with the new git pull
>> torvalds tree and the kees-2.patch.
> 
> Perfect! Okay, so it looks like all the issues are known and fixed. I'll work with Greg to get the other ch9 patch landed.

Yes, maybe it should be tested more widely first. It was an unobvious bug and
I couldn't see what went wrong ...

>> Praise God!
>>
>> This is the git log --oneline:
>>
>> d528014517f2 (HEAD, origin/master, origin/HEAD) Revert ".gitignore: ignore *.cover and *.mbx"
>> 04f2933d375e Merge tag 'core_guards_for_6.5_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue
>> 03275585cabd afs: Fix accidental truncation when storing data
>> 538140ca602b Merge tag 'ovl-update-6.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
>> 94c76955e86a Merge tag 'gfs2-v6.4-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
>> ccf46d853183 Merge tag 'pm-6.5-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> b869e9f49964 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
>> 406fb9eb198a Merge tag 'firewire-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394
>> f1962207150c module: fix init_module_from_file() error handling
>> 40c565a429d7 Merge branches 'pm-cpufreq' and 'pm-cpuidle'
>> f679e89acdd3 clk: tegra: Avoid calling an uninitialized function
>>
>> So, the included patch is:
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ git diff
>> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
>> index 82ec6af71a1d..62d318377379 100644
>> --- a/include/uapi/linux/usb/ch9.h
>> +++ b/include/uapi/linux/usb/ch9.h
>> @@ -984,7 +984,11 @@ struct usb_ssp_cap_descriptor {
>> #define USB_SSP_MIN_RX_LANE_COUNT              (0xf << 8)
>> #define USB_SSP_MIN_TX_LANE_COUNT              (0xf << 12)
>>         __le16 wReserved;
>> -       __le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */
>> +       union {
>> +               __le32 legacy_padding;
>> +               /* list of sublink speed attrib entries */
>> +               __DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
>> +       };
>> #define USB_SSP_SUBLINK_SPEED_SSID     (0xf)           /* sublink speed ID */
>> #define USB_SSP_SUBLINK_SPEED_LSE      (0x3 << 4)      /* Lanespeed exponent */
>> #define USB_SSP_SUBLINK_SPEED_LSE_BPS          0
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> This means vanilla torvalds tree + https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/
>> works, but vanilla torvalds tree w/o patch still crashes.
> 
> Great, thanks again for testing it all!

No at all, I'm glad I could be of assistance.

Best regards,
Mirsad Todorovac

> -Keed
> 
>>
>> I am still rather new to the utilisation of the PSTORE subsystem.
>>
>> Best regards,
>> Mirsad Todorovac
> 
