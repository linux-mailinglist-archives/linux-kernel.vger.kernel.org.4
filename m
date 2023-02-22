Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718069EF26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjBVHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBVHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:15:38 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF43668A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:15:31 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230222071529euoutp0102b07a20bdfd0d2c1485b6fdab0b3b6a~GFDULtyXc2431624316euoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:15:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230222071529euoutp0102b07a20bdfd0d2c1485b6fdab0b3b6a~GFDULtyXc2431624316euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677050129;
        bh=WTGMV+A/23f8XTHJrNZNyDtOu72BjYAlxpAIQ+ynJW4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=G+yvKMfx3XduFq5VfoivMLv3Qg1ci404NdlOzX+KZIMeL4hP2s9w7XpavgHVPWKeU
         eh09762CUc5DAQeSab3Hb7UiBuaEwMrkqE12jpLhbOv0vg0sVJZRTFq6PzR8PVZsKh
         +NcumVcxNUVIM+XYxNixmyhq+7bGX7X3S5Jcxbek=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230222071529eucas1p18c24285a195fa5eda4af5bc7802a4579~GFDT6XSp50604506045eucas1p13;
        Wed, 22 Feb 2023 07:15:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.82.01471.011C5F36; Wed, 22
        Feb 2023 07:15:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230222071528eucas1p275940cbf54ec0d50d747823a052f649d~GFDTiFdrk0477804778eucas1p2m;
        Wed, 22 Feb 2023 07:15:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230222071528eusmtrp17545f2e19a6749b918b15e6f782c7b0b~GFDThSKvZ1061010610eusmtrp1X;
        Wed, 22 Feb 2023 07:15:28 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-6d-63f5c110584d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.B9.02722.011C5F36; Wed, 22
        Feb 2023 07:15:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230222071527eusmtip1e4b2d81f1bf5c8da2a614f1a72a075ff~GFDS0EGid2513425134eusmtip19;
        Wed, 22 Feb 2023 07:15:27 +0000 (GMT)
Message-ID: <868085b4-427a-e785-e4eb-942da53a2537@samsung.com>
Date:   Wed, 22 Feb 2023 08:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7oCB78mG7xabG6xrcPGYurDJ2wW
        Z5cdZLN4dmsvk0Xz4vVsFju2i1h8u9LBZHF51xw2iycLzzBZPFxhZNF16C+bxfJTO1gs9l/x
        cuD12LZ7G6vHmnlrGD2+fZ3E4jG74SKLR1vTS1aPnbPusnss2FTqsWlVJ5vHocMdjB77565h
        99j5vYHd4/MmuQCeKC6blNSczLLUIn27BK6MxfO2MRcsT6vYuHEiYwPj47AuRk4OCQETiV93
        t7B2MXJxCAmsYJT4eKGFDcL5wijxr2EXO4TzmVFizb9XTF2MHGAtk7vrIOLLGSUW3pjECOF8
        ZJQ49fgNI8hcXgE7iXtXNrCB2CwCqhJd3z8zQcQFJU7OfMICYosKpEicXr0HrEZYIEnix/5j
        rCA2s4C4xK0n88HqRQS0JDZde8wCsoBZ4ASzxJ6/V5lBEmwChhJdb7vAmjkFAiX6Fk5jg2iW
        l2jeOpsZ4rntnBI9EzggbBeJ50/vQMWFJV4d38IOYctInJ7cA7ZAQqCdUWLB7/tMEM4ERomG
        57cYIaqsJe6c+8UG8j+zgKbE+l36EGFHiT1nHrBDgoVP4sZbQYgb+CQmbZvODBHmlehoE4Ko
        VpOYdXwd3NqDFy4xT2BUmoUULLOQvD8LyTezEPYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqX
        rpecn7uJEZj8Tv87/mkH49xXH/UOMTJxMB5ilOBgVhLh/c/7OVmINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDU9XXS6I3TtRwimqYZH2a6GWp/6ybQeNv
        FfP3z6XzPFZNfH3G9pZUes1ZaXsnz6jI56seWQibr5FwaJ2k6yfJ3bs2LyO/XORt+Jm/yvx6
        009J/d5Qz2avHTjrgeuFwtPMDLPWHmxJqOvinb2Ip+r/6bfn7t+uTNdnOnBekc1PSOzOkhpR
        Dgu15ulvfv3/xLbO6nWJPkOQNcvCRdZKvO+m3r3hkLb1fIhBZB/XNb9bj6x2mU3pDZnSdlcx
        2ez1pkNOCQcrWNdrbG/PnvWW/6vVc8Wzpj/tNlv/F7YuCyqdYL/1mx2P/PfXiU4bcni/MTsL
        M3hcrbvX8uggt7H/ubshnpUWSZPkZ18J6z9+WiZIiaU4I9FQi7moOBEAwgOj2u0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7oCB78mG7xbJGexrcPGYurDJ2wW
        Z5cdZLN4dmsvk0Xz4vVsFju2i1h8u9LBZHF51xw2iycLzzBZPFxhZNF16C+bxfJTO1gs9l/x
        cuD12LZ7G6vHmnlrGD2+fZ3E4jG74SKLR1vTS1aPnbPusnss2FTqsWlVJ5vHocMdjB77565h
        99j5vYHd4/MmuQCeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2MxfO2MRcsT6vYuHEiYwPj47AuRg4OCQETicnddV2MXBxCAksZJXqvHWbqYuQE
        istInJzWwAphC0v8udbFBlH0nlHixvsrYAleATuJe1c2sIHYLAKqEl3fPzNBxAUlTs58wgJi
        iwqkSHy+N5cdxBYWSJL4sf8YWC+zgLjErSfzwepFBLQkNl17zAKygFngBLPEw9dPWCC2dTNJ
        3Ju9EayKTcBQouttF9g2ToFAib6F09ggJplJdG3tYoSw5SWat85mnsAoNAvJIbOQLJyFpGUW
        kpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuN927Gfm3cwznv1Ue8QIxMH4yFGCQ5m
        JRHe/7yfk4V4UxIrq1KL8uOLSnNSiw8xmgJDYyKzlGhyPjDh5JXEG5oZmBqamFkamFqaGSuJ
        83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MLFpmu7Zw8tmv3LarIecLV0CifsYj990WVBinr0u
        bWp1cgxX5o/L26X6qlf43mrhNFbVcexkKarj3nzB9E2Dy56bBWZCDQetFE7c/aqQ9ORkRuzu
        BZJlM0/33jTdv/nAHvE1qSvyuIv7jiqWTPOd0zj1XQH7rO2SR+Z2JRo4lrHM+T73hX7kCpeq
        Zp319Yu6XbRCrc5s3OYTbrhmR8y9F4U//uUsaJBWd7hfsW3Flr7tTAqX+DIe2P7zEMj7/OIQ
        l+QzRw+rowvsNV2OsTXIaz1/I3/39oUa43uH7h4XZN+iUfZmW9Cihrln86M40jqqk52bM9kW
        Gt+u/MIsLe7D2Bnf6OGyLMtv0Tn1zRELlFiKMxINtZiLihMBpGFoRoADAAA=
X-CMS-MailID: 20230222071528eucas1p275940cbf54ec0d50d747823a052f649d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230218083300eucas1p28c7c584877b8914a3b88904690be82f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230218083300eucas1p28c7c584877b8914a3b88904690be82f6
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
        <20230218083252.2044423-1-saravanak@google.com>
        <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
        <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2023 23:36, Saravana Kannan wrote:
> On Mon, Feb 20, 2023 at 1:02 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 18.02.2023 09:32, Saravana Kannan wrote:
>>> This series is just an RFC to see if you agree with where this is going.
>>> Please point out bugs, but don't bother with a proper code review.
>>>
>>> The high level idea is to not reimplement what driver core can already
>>> handle for us and use it to do some of the work. Instead of trying to
>>> resolve supplies from all different code paths and bits and pieces of
>>> the tree, we just build it from the root to the leaves by using deferred
>>> probing to sequence things in the right order.
>>>
>>> The last patch is the main one. Rest of them are just setting up for it.
>>>
>>> I believe there's room for further simplification but this is what I
>>> could whip up as a quick first draft that shows the high level idea.
>>> I'll probably need some help with getting a better understanding of why
>>> things are done in a specific order in regulator_register() before I
>>> could attempt simplifying things further.
>>>
>>> Ideally, regulator_register() would just have DT parsing, init data
>>> struct sanity checks and adding the regulator device and then we move
>>> everything else to into the probe function that's guaranteed to run only
>>> after the supply has been resolved/ready to resolve.
>>>
>>> fw_devlink/device links should further optimize the flow and also allow
>>> us to simplify some of the guarantees and address some of the existing
>>> FIXMEs. But this patch series is NOT dependent on fw_devlink or device
>>> links.
>>>
>>> Any thoughts on where this is going?
>>>
>>> I've tested this on one hardware I have and it works and nothing is
>>> broken. But the regulator tree in my hardware isn't that complicated or
>>> deep. The regulators are also added mostly in the right order (due to
>>> existing fw_devlink). So if you agree with the idea, the next step is to
>>> ask people to give it a test.
>>>
>>> Also, it's based on driver-core-next since that's what I had synced up
>>> and had a working baseline. I'll rebase it on the regulator tree when I
>>> go from RFC -> PATCH.
>> I've applied this patchset on top of linux next-20230220 and gave it a
>> try on my test farm, as it revealed a few issues related to regulator
>> initialization in the past. It looks that handling of some corner cases
>> is missing, because this patchset introduced a regression on Samsung
>> Snow/Peach-Pit/Peach-Pi Chromebooks, as well as Hardkernel's Odroid-M1
>> board. It looks that the issue is common - PHY devices don't probe
>> properly. This is an output from Odroid-M1 board
>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):
>>
>> # cat /sys/kernel/debug/devices_deferred 2>/dev/null
>> fd8c0000.usb    platform: wait for supplier host-port
>> fe830000.phy
>> fe8a0000.usb2phy        rockchip-usb2phy: failed to create phy
>> fe8b0000.usb2phy        rockchip-usb2phy: failed to create phy
>> 3c0800000.pcie  rockchip-dw-pcie: failed to get vpcie3v3 regulator
>> fcc00000.usb    platform: wait for supplier otg-port
>> fd000000.usb    platform: wait for supplier host-port
>> fd800000.usb    platform: wait for supplier otg-port
>> fd840000.usb    platform: wait for supplier otg-port
>> fd880000.usb    platform: wait for supplier host-port
>> fe820000.phy
>>
>> If you need any additional tests on the mentioned boards, let me know.
> Thanks for testing it Marek! I don't want people to spend more time
> testing this before I hear Mark/Liam's thoughts. So, let's hold off
> for now.
>
> I took a peek at the dts and the logs above. If you go into
> /sys/bus/regulator/devices/, I'd expect all of them to have probed
> (they'll have a "driver" symlink in their folder). Or at least the
> regulator tree used by the phys.

Nope, something is wrong there with those PHY regulators:

# cd /sys/bus/regulator/devices

# ls -l regulator.4
lrwxrwxrwx 1 root root 0 Feb 14  2019 regulator.4 -> 
../../../devices/platform/vcc5v0-usb-host-regulator/regulator.4

# ls -l regulator.4/driver
ls: cannot access 'regulator.4/driver': No such file or directory

# ls -l regulator.4/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:06 consumer:platform:fe820000.phy 
-> 
../../virtual/devlink/platform:vcc5v0-usb-host-regulator--platform:fe820000.phy
lrwxrwxrwx 1 root root    0 Feb 22 07:06 
consumer:platform:fe8a0000.usb2phy -> 
../../virtual/devlink/platform:vcc5v0-usb-host-regulator--platform:fe8a0000.usb2phy
lrwxrwxrwx 1 root root    0 Feb 22 07:06 
consumer:platform:fe8b0000.usb2phy -> 
../../virtual/devlink/platform:vcc5v0-usb-host-regulator--platform:fe8b0000.usb2phy
lrwxrwxrwx 1 root root    0 Feb 22 07:06 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:06 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:06 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:06 of_node -> 
../../../firmware/devicetree/base/vcc5v0-usb-host-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:06 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.4
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
lrwxrwxrwx 1 root root    0 Feb 22 07:06 supplier:platform:fdd60000.gpio 
-> 
../../virtual/devlink/platform:fdd60000.gpio--platform:vcc5v0-usb-host-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:06 supplier:platform:pinctrl -> 
../../virtual/devlink/platform:pinctrl--platform:vcc5v0-usb-host-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:06 
supplier:platform:vcc5v0-sys-regulator -> 
../../virtual/devlink/platform:vcc5v0-sys-regulator--platform:vcc5v0-usb-host-regulator
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent

# ls -l regulator.5
lrwxrwxrwx 1 root root 0 Feb 14  2019 regulator.5 -> 
../../../devices/platform/vcc5v0-usb-otg-regulator/regulator.5

# ls -l regulator.5/driver
ls: cannot access 'regulator.5/driver': No such file or directory

# ls -l regulator.5/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:09 consumer:platform:fe830000.phy 
-> 
../../virtual/devlink/platform:vcc5v0-usb-otg-regulator--platform:fe830000.phy
lrwxrwxrwx 1 root root    0 Feb 22 07:09 
consumer:platform:fe8a0000.usb2phy -> 
../../virtual/devlink/platform:vcc5v0-usb-otg-regulator--platform:fe8a0000.usb2phy
lrwxrwxrwx 1 root root    0 Feb 22 07:07 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:09 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:09 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:09 of_node -> 
../../../firmware/devicetree/base/vcc5v0-usb-otg-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:09 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.5
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
lrwxrwxrwx 1 root root    0 Feb 22 07:09 supplier:platform:fdd60000.gpio 
-> 
../../virtual/devlink/platform:fdd60000.gpio--platform:vcc5v0-usb-otg-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:09 supplier:platform:pinctrl -> 
../../virtual/devlink/platform:pinctrl--platform:vcc5v0-usb-otg-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:09 
supplier:platform:vcc5v0-sys-regulator -> 
../../virtual/devlink/platform:vcc5v0-sys-regulator--platform:vcc5v0-usb-otg-regulator
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent

# ls -l regulator.23
lrwxrwxrwx 1 root root 0 Feb 14  2019 regulator.23 -> 
../../../devices/platform/vcc3v3-pcie-regulator/regulator.23

# ls -l regulator.23/driver
ls: cannot access 'regulator.23/driver': No such file or directory

# ls -l regulator.23/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:10 
consumer:platform:3c0800000.pcie -> 
../../virtual/devlink/platform:vcc3v3-pcie-regulator--platform:3c0800000.pcie
lrwxrwxrwx 1 root root    0 Feb 22 07:07 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:10 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:10 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:10 of_node -> 
../../../firmware/devicetree/base/vcc3v3-pcie-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:10 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.23
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
lrwxrwxrwx 1 root root    0 Feb 22 07:10 supplier:platform:fe770000.gpio 
-> 
../../virtual/devlink/platform:fe770000.gpio--platform:vcc3v3-pcie-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:10 supplier:platform:pinctrl -> 
../../virtual/devlink/platform:pinctrl--platform:vcc3v3-pcie-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:10 
supplier:platform:vcc3v3-sys-regulator -> 
../../virtual/devlink/platform:vcc3v3-sys-regulator--platform:vcc3v3-pcie-regulator
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent


However other fixed regulator devices have been probed properly:

# ls -l regulator.3/driver
lrwxrwxrwx 1 root root 0 Feb 22 07:10 regulator.3/driver -> 
../../../../bus/regulator/drivers/regulator_drv
# ls -l regulator.3/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:10 
consumer:platform:vcc5v0-usb-host-regulator -> 
../../virtual/devlink/platform:vcc5v0-sys-regulator--platform:vcc5v0-usb-host-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:10 
consumer:platform:vcc5v0-usb-otg-regulator -> 
../../virtual/devlink/platform:vcc5v0-sys-regulator--platform:vcc5v0-usb-otg-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:10 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:10 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:10 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:10 of_node -> 
../../../firmware/devicetree/base/vcc5v0-sys-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:10 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.3
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
lrwxrwxrwx 1 root root    0 Feb 22 07:10 
supplier:platform:dc-12v-regulator -> 
../../virtual/devlink/platform:dc-12v-regulator--platform:vcc5v0-sys-regulator
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent

# ls -l regulator.2/driver
lrwxrwxrwx 1 root root 0 Feb 22 07:13 regulator.2/driver -> 
../../../../bus/regulator/drivers/regulator_drv
# ls -l regulator.2/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:13 consumer:i2c:3-001c -> 
../../virtual/devlink/platform:vcc3v3-sys-regulator--i2c:3-001c
lrwxrwxrwx 1 root root    0 Feb 22 07:13 consumer:i2c:3-0020 -> 
../../virtual/devlink/platform:vcc3v3-sys-regulator--i2c:3-0020
lrwxrwxrwx 1 root root    0 Feb 22 07:13 
consumer:platform:fe2a0000.ethernet -> 
../../virtual/devlink/platform:vcc3v3-sys-regulator--platform:fe2a0000.ethernet
lrwxrwxrwx 1 root root    0 Feb 22 07:13 
consumer:platform:vcc3v3-pcie-regulator -> 
../../virtual/devlink/platform:vcc3v3-sys-regulator--platform:vcc3v3-pcie-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:13 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:13 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:13 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:13 of_node -> 
../../../firmware/devicetree/base/vcc3v3-sys-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:13 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.2
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
lrwxrwxrwx 1 root root    0 Feb 22 07:13 
supplier:platform:dc-12v-regulator -> 
../../virtual/devlink/platform:dc-12v-regulator--platform:vcc3v3-sys-regulator
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent

# ls -l regulator.1/driver
lrwxrwxrwx 1 root root 0 Feb 22 07:14 regulator.1/driver -> 
../../../../bus/regulator/drivers/regulator_drv
# ls -l regulator.1/..
total 0
lrwxrwxrwx 1 root root    0 Feb 22 07:14 
consumer:platform:vcc3v3-sys-regulator -> 
../../virtual/devlink/platform:dc-12v-regulator--platform:vcc3v3-sys-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:14 
consumer:platform:vcc5v0-sys-regulator -> 
../../virtual/devlink/platform:dc-12v-regulator--platform:vcc5v0-sys-regulator
lrwxrwxrwx 1 root root    0 Feb 22 07:14 driver -> 
../../../bus/platform/drivers/reg-fixed-voltage
-rw-r--r-- 1 root root 4096 Feb 22 07:14 driver_override
-r--r--r-- 1 root root 4096 Feb 22 07:14 modalias
lrwxrwxrwx 1 root root    0 Feb 22 07:14 of_node -> 
../../../firmware/devicetree/base/dc-12v-regulator
drwxr-xr-x 2 root root    0 Feb 22 07:14 power
drwxr-xr-x 3 root root    0 Feb 14  2019 regulator.1
lrwxrwxrwx 1 root root    0 Feb 14  2019 subsystem -> ../../../bus/platform
-rw-r--r-- 1 root root 4096 Feb 14  2019 uevent


I hope the above logs will help identifying the issue.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

