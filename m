Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6735E69E075
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjBUMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjBUMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78777E055
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676982702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wq62qNX/4EoNyLjueY5GhZ1LsRP2u6tFFFJV8ojE60g=;
        b=crpIbDdr24pGcmQnW+A9EQxXPZHnM/SUy7ov61lIXxmQ2vqY3VeS7WCpYcdPbqZYY6x6J9
        kAGrORDqd2LMV0buewYxsp6+nnaPISPQE9zlGczQDW9xm2CZOXt+1gggaH2xMnkaKwk2O8
        mEx/WrIUNcOIc/XvmOy3gOUzsLUzzww=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-RrViQ5i7OHqTo6adslsFUQ-1; Tue, 21 Feb 2023 07:31:41 -0500
X-MC-Unique: RrViQ5i7OHqTo6adslsFUQ-1
Received: by mail-ed1-f70.google.com with SMTP id ck7-20020a0564021c0700b004a25d8d7593so5211122edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wq62qNX/4EoNyLjueY5GhZ1LsRP2u6tFFFJV8ojE60g=;
        b=KObQa3LRVU2/MoCWUPq7sa1h9qvfJdW0TmrBuJiEFegNuXsC6fFakbA10zfJ+vY4us
         PGAqskdbHkuDaiCAarjjQgq4qBv1UFSF9bqdc4tpQ8iLRYTw6bXdR5fCZuZ6/XDVOAd7
         pa2w4DA5Z7sRSatBEUJD5NlsIUQVVysq9zz90ry5UIESHwjICIDTlyT6Um47BUDAiYF1
         BJamD3Lpu6fOONWNz81XbvhgWpyOxqggd4UjyGfyLci55NOZZSHxZ3oMte4Ishou8nMb
         yVwjR8TYCRI5/vip0jSChCrZSD+OhR9kG5WK+z3754U4FKYNGfR4jbaILXj+7vhnGWaa
         T75w==
X-Gm-Message-State: AO0yUKUuix8vR4nrosQms51MXK+epcrodxTyFKSPR5L3yGmJrLIme3KS
        Hsp0sWav9kInaiaOAKZA+c/w0dFKw1EXBab0labLWjn7JoFLG5NxKSqNY6ae4GoxTLkIehR9pNc
        TpfdE8peehUACqnQLkHyYs9Oz
X-Received: by 2002:a05:6402:105a:b0:4ac:c84b:1ddd with SMTP id e26-20020a056402105a00b004acc84b1dddmr3103520edu.32.1676982700190;
        Tue, 21 Feb 2023 04:31:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+QhtI6CAuIjQ35FSPPVSACfb3JJ15cfth7p3oTDx/SOXnShQrvz8MEtr/JrD/VAwQGcEkNIA==
X-Received: by 2002:a05:6402:105a:b0:4ac:c84b:1ddd with SMTP id e26-20020a056402105a00b004acc84b1dddmr3103501edu.32.1676982699878;
        Tue, 21 Feb 2023 04:31:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ee37-20020a056402292500b004af58e57db5sm450783edb.5.2023.02.21.04.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 04:31:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------i9GnlXUL3bOi7jPlNfpdKXnJ"
Message-ID: <60dad2c6-9f37-86af-5f37-aa5d45c33afa@redhat.com>
Date:   Tue, 21 Feb 2023 13:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Content-Language: en-US, nl
To:     Aditya Garg <gargaditya08@live.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------i9GnlXUL3bOi7jPlNfpdKXnJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/21/23 10:24, Aditya Garg wrote:
> 
>> On 18-Feb-2023, at 6:50 PM, Orlando Chamberlain <orlandoch.dev@gmail.com> wrote:
>> ﻿Hi All,
>> This patch series adds support for the MMIO based gmux present on these
>> Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3, MacBookPro16,1,
>> MacBookPro16,4 (although amdgpu isn't working on MacBookPro16,4 [1]).
>>
> 
> Could be an upstream bug, but I’ve noticed that after using these patches, if I add `acpi_backlight=video` in the command line, it still uses `gmux_backlight`
> 
> Hans, any ideas why?

Currently the backlight registration in apple-gmux.c is unconditional
(if a GMUX is detected).

I have attached a patch to make it honor the acpi_backlight=xxx
kernel commandline option like most other x86/ACPI backlight drivers
do, please give this a test.

Regards,

Hans


> 
>> Changes from v2[2]:
>>
>> - Add "," to last item in apple_gmux_type enum
>> - Don't not clear interrupts when status is 0
>> - Don't check if we failed to make debugfs folder
>> - Check for fake mmio gmux
>>
>> # 1:
>>
>> has a slight change in how the switch state is read: instead of checking
>> for x == 2, check !(x & 1)
>>
>> # 2:
>>
>> implements a system to support more than 2 gmux types
>>
>> # 3:
>>
>> start using the gmux's GMSP acpi method when handling interrupts on MMIO
>> gmux's. This is needed for the MMIO gmux's to clear interrupts.
>>
>> # 4:
>>
>> Adds support for the MMIO based gmux on T2 macs.
>>
>> # 5:
>>
>> Add a debugfs interface to apple-gmux so data from ports can be read
>> and written to from userspace.
>>
>> This can be used for more easily researching what unknown ports do,
>> and switching gpus when vga_switcheroo isn't ready (e.g. when one gpu
>> is bound to vfio-pci and in use by a Windows VM, I can use this to
>> switch my internal display between Linux and Windows easily).
>>
>> # Issues:
>>
>> 1. Switching gpus at runtime has the same issue as indexed gmux's: the
>> inactive gpu can't probe the DDC lines for eDP [3]
>>
>> 2. iMacPro1,1, iMac20,1 and iMac20,2 all seem to have a gmux in their
>> acpi tables, but they shouldn't. A check that hopefully will detect this
>> is used, but it's untested as I don't have any of those computers.
>>
>> 3. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
>> told on the MacBookPro15,1 it works sometimes, and adding delays helps,
>> but on my MacBookPro16,1 I haven't been able to get it to work at all:
>>
>> amdgpu: switched off
>> amdgpu: switched on
>> amdgpu 0000:03:00.0:
>>    Unable to change power state from D3hot to D0, device inaccessible
>> amdgpu 0000:03:00.0:
>>    Unable to change power state from D3cold to D0, device inaccessible
>> [drm] PCIE GART of 512M enabled (table at 0x00000080FEE00000).
>> [drm] PSP is resuming...
>> [drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
>> [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
>> [drm:amdgpu_device_fw_loading [amdgpu]]
>>    *ERROR* resume of IP block <psp> failed -62
>> amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
>> snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
>> snd_hda_intel 0000:03:00.1:
>>    Unable to change power state from D3cold to D0, device inaccessible
>> snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535
>> snd_hda_codec_hdmi hdaudioC0D0: Unable to sync register 0x2f0d00. -5
>>
>> There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls when
>> changing the amdgpu's power state, but we don't use them and that could be
>> a cause. Additionally unlike previous generation Macbooks which work
>> better, on MacBookPro16,1 the gpu is located behind 2 pci bridges:
>>
>> 01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
>>    Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
>> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
>>    Navi 10 XL Downstream Port of PCI Express Switch
>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>>    Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
>> 03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
>>    Navi 10 HDMI Audio
>>
>> Upon attempting to power on the gpu with vga_switcheroo, all these
>> devices except 01:00.0 have their config space filled with 1s.
>> Rescanning pci makes the config space of all the devices go back to
>> normal, however amdgpu still fails to resume with the same logs as
>> above.
>>
>> [1]: https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
>> [2]: https://lore.kernel.org/platform-driver-x86/20230216122342.5918-1-orlandoch.dev@gmail.com/
>> [3]: https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
>> [4]: https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
>> [5]: https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/
>>
>> Orlando Chamberlain (5):
>>  apple-gmux: use first bit to check switch state
>>  apple-gmux: refactor gmux types
>>  apple-gmux: Use GMSP acpi method for interrupt clear
>>  apple-gmux: support MMIO gmux on T2 Macs
>>  apple-gmux: add debugfs interface
>>
>> drivers/platform/x86/apple-gmux.c | 349 ++++++++++++++++++++++++++----
>> include/linux/apple-gmux.h        |  70 ++++--
>> 2 files changed, 357 insertions(+), 62 deletions(-)
>>
>> -- 
>> 2.39.1

--------------i9GnlXUL3bOi7jPlNfpdKXnJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-apple-gmux-Add-acpi_video_get_backlight.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-apple-gmux-Add-acpi_video_get_backlight.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5NzIyOGIxMDdmZTA3NWI5NGM1OWE1YjY4MTgzZTAwZmU3MzY3ZDE1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDIxIEZlYiAyMDIzIDEzOjI2OjE5ICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OiBhcHBsZS1nbXV4OiBBZGQgYWNwaV92aWRlb19nZXRfYmFj
a2xpZ2h0X3R5cGUoKQogY2hlY2sKCk1ha2UgYXBwbGUtZ211eCBiYWNrbGlnaHQgcmVnaXN0
cmF0aW9uIGhvbm9yIHRoZSBhY3BpX2JhY2tsaWdodD0uLi4Ka2VybmVsIGNvbW1hbmRsaW5l
IG9wdGlvbiB3aGljaCBpcyB1c2VkIHRvIHNlbGVjdCB0aGUgYmFja2xpZ2h0CmNvbnRyb2wg
bWV0aG9kIG9uIHg4Ni9BQ1BJIGRldmljZXMuCgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvcGxhdGZvcm0veDg2L2Fw
cGxlLWdtdXguYyB8IDU5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hcHBsZS1nbXV4LmMgYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9hcHBsZS1nbXV4LmMKaW5kZXggOTMzM2Y4MmNmYThhLi4yNDZjYWFhYjI3YWEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FwcGxlLWdtdXguYworKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9hcHBsZS1nbXV4LmMKQEAgLTIxLDYgKzIxLDcgQEAKICNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgogI2luY2x1
ZGUgPGxpbnV4L3ZnYV9zd2l0Y2hlcm9vLmg+CisjaW5jbHVkZSA8YWNwaS92aWRlby5oPgog
I2luY2x1ZGUgPGFzbS9pby5oPgogCiAvKioKQEAgLTU2Miw2ICs1NjMsNyBAQCBzdGF0aWMg
aW50IGdtdXhfcHJvYmUoc3RydWN0IHBucF9kZXYgKnBucCwgY29uc3Qgc3RydWN0IHBucF9k
ZXZpY2VfaWQgKmlkKQogCXN0cnVjdCBiYWNrbGlnaHRfcHJvcGVydGllcyBwcm9wczsKIAlz
dHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqYmRldjsKIAl1OCB2ZXJfbWFqb3IsIHZlcl9taW5v
ciwgdmVyX3JlbGVhc2U7CisJYm9vbCByZWdpc3Rlcl9iZGV2ID0gdHJ1ZTsKIAlpbnQgcmV0
ID0gLUVOWElPOwogCWFjcGlfc3RhdHVzIHN0YXR1czsKIAl1bnNpZ25lZCBsb25nIGxvbmcg
Z3BlOwpAQCAtNjEwLDMzICs2MTIsMzggQEAgc3RhdGljIGludCBnbXV4X3Byb2JlKHN0cnVj
dCBwbnBfZGV2ICpwbnAsIGNvbnN0IHN0cnVjdCBwbnBfZGV2aWNlX2lkICppZCkKIAlwcm9w
cy50eXBlID0gQkFDS0xJR0hUX1BMQVRGT1JNOwogCXByb3BzLm1heF9icmlnaHRuZXNzID0g
Z211eF9yZWFkMzIoZ211eF9kYXRhLCBHTVVYX1BPUlRfTUFYX0JSSUdIVE5FU1MpOwogCi0J
LyoKLQkgKiBDdXJyZW50bHkgaXQncyBhc3N1bWVkIHRoYXQgdGhlIG1heGltdW0gYnJpZ2h0
bmVzcyBpcyBsZXNzIHRoYW4KLQkgKiAyXjI0IGZvciBjb21wYXRpYmlsaXR5IHdpdGggb2xk
IGdtdXggdmVyc2lvbnMuIENhcCB0aGUgbWF4Ci0JICogYnJpZ2h0bmVzcyBhdCB0aGlzIHZh
bHVlLCBidXQgcHJpbnQgYSB3YXJuaW5nIGlmIHRoZSBoYXJkd2FyZQotCSAqIHJlcG9ydHMg
c29tZXRoaW5nIGhpZ2hlciBzbyB0aGF0IGl0IGNhbiBiZSBmaXhlZC4KLQkgKi8KLQlpZiAo
V0FSTl9PTihwcm9wcy5tYXhfYnJpZ2h0bmVzcyA+IEdNVVhfTUFYX0JSSUdIVE5FU1MpKQot
CQlwcm9wcy5tYXhfYnJpZ2h0bmVzcyA9IEdNVVhfTUFYX0JSSUdIVE5FU1M7Ci0KLQliZGV2
ID0gYmFja2xpZ2h0X2RldmljZV9yZWdpc3RlcigiZ211eF9iYWNrbGlnaHQiLCAmcG5wLT5k
ZXYsCi0JCQkJCSBnbXV4X2RhdGEsICZnbXV4X2JsX29wcywgJnByb3BzKTsKLQlpZiAoSVNf
RVJSKGJkZXYpKSB7Ci0JCXJldCA9IFBUUl9FUlIoYmRldik7Ci0JCWdvdG8gZXJyX3JlbGVh
c2U7Ci0JfQotCi0JZ211eF9kYXRhLT5iZGV2ID0gYmRldjsKLQliZGV2LT5wcm9wcy5icmln
aHRuZXNzID0gZ211eF9nZXRfYnJpZ2h0bmVzcyhiZGV2KTsKLQliYWNrbGlnaHRfdXBkYXRl
X3N0YXR1cyhiZGV2KTsKKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX0FDUElfVklERU8pCisJ
cmVnaXN0ZXJfYmRldiA9IGFjcGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKCkgPT0gYWNw
aV9iYWNrbGlnaHRfYXBwbGVfZ211eDsKKyNlbmRpZgorCWlmIChyZWdpc3Rlcl9iZGV2KSB7
CisJCS8qCisJCSAqIEN1cnJlbnRseSBpdCdzIGFzc3VtZWQgdGhhdCB0aGUgbWF4aW11bSBi
cmlnaHRuZXNzIGlzIGxlc3MgdGhhbgorCQkgKiAyXjI0IGZvciBjb21wYXRpYmlsaXR5IHdp
dGggb2xkIGdtdXggdmVyc2lvbnMuIENhcCB0aGUgbWF4CisJCSAqIGJyaWdodG5lc3MgYXQg
dGhpcyB2YWx1ZSwgYnV0IHByaW50IGEgd2FybmluZyBpZiB0aGUgaGFyZHdhcmUKKwkJICog
cmVwb3J0cyBzb21ldGhpbmcgaGlnaGVyIHNvIHRoYXQgaXQgY2FuIGJlIGZpeGVkLgorCQkg
Ki8KKwkJaWYgKFdBUk5fT04ocHJvcHMubWF4X2JyaWdodG5lc3MgPiBHTVVYX01BWF9CUklH
SFRORVNTKSkKKwkJCXByb3BzLm1heF9icmlnaHRuZXNzID0gR01VWF9NQVhfQlJJR0hUTkVT
UzsKKworCQliZGV2ID0gYmFja2xpZ2h0X2RldmljZV9yZWdpc3RlcigiZ211eF9iYWNrbGln
aHQiLCAmcG5wLT5kZXYsCisJCQkJCQkgZ211eF9kYXRhLCAmZ211eF9ibF9vcHMsICZwcm9w
cyk7CisJCWlmIChJU19FUlIoYmRldikpIHsKKwkJCXJldCA9IFBUUl9FUlIoYmRldik7CisJ
CQlnb3RvIGVycl9yZWxlYXNlOworCQl9CiAKLQkvKgotCSAqIFRoZSBiYWNrbGlnaHQgc2l0
dWF0aW9uIG9uIE1hY3MgaXMgY29tcGxpY2F0ZWQuIElmIHRoZSBnbXV4IGlzCi0JICogcHJl
c2VudCBpdCdzIHRoZSBiZXN0IGNob2ljZSwgYmVjYXVzZSBpdCBhbHdheXMgd29ya3MgZm9y
Ci0JICogYmFja2xpZ2h0IGNvbnRyb2wgYW5kIHN1cHBvcnRzIG1vcmUgbGV2ZWxzIHRoYW4g
b3RoZXIgb3B0aW9ucy4KLQkgKiBEaXNhYmxlIHRoZSBvdGhlciBiYWNrbGlnaHQgY2hvaWNl
cy4KLQkgKi8KLQlhcHBsZV9ibF91bnJlZ2lzdGVyKCk7CisJCWdtdXhfZGF0YS0+YmRldiA9
IGJkZXY7CisJCWJkZXYtPnByb3BzLmJyaWdodG5lc3MgPSBnbXV4X2dldF9icmlnaHRuZXNz
KGJkZXYpOworCQliYWNrbGlnaHRfdXBkYXRlX3N0YXR1cyhiZGV2KTsKKworCQkvKgorCQkg
KiBUaGUgYmFja2xpZ2h0IHNpdHVhdGlvbiBvbiBNYWNzIGlzIGNvbXBsaWNhdGVkLiBJZiB0
aGUgZ211eCBpcworCQkgKiBwcmVzZW50IGl0J3MgdGhlIGJlc3QgY2hvaWNlLCBiZWNhdXNl
IGl0IGFsd2F5cyB3b3JrcyBmb3IKKwkJICogYmFja2xpZ2h0IGNvbnRyb2wgYW5kIHN1cHBv
cnRzIG1vcmUgbGV2ZWxzIHRoYW4gb3RoZXIgb3B0aW9ucy4KKwkJICogRGlzYWJsZSB0aGUg
b3RoZXIgYmFja2xpZ2h0IGNob2ljZXMuCisJCSAqLworCQlhcHBsZV9ibF91bnJlZ2lzdGVy
KCk7CisJfQogCiAJZ211eF9kYXRhLT5wb3dlcl9zdGF0ZSA9IFZHQV9TV0lUQ0hFUk9PX09O
OwogCi0tIAoyLjM5LjEKCg==

--------------i9GnlXUL3bOi7jPlNfpdKXnJ--

