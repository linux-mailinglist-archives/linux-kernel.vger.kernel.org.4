Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44D69C731
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjBTJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjBTJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:02:15 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C756B16300
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:02:04 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230220090202euoutp01559bdaaaed1893536a0ce82f5c97d98a~FfNxTwg_x2520025200euoutp01C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:02:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230220090202euoutp01559bdaaaed1893536a0ce82f5c97d98a~FfNxTwg_x2520025200euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676883722;
        bh=to47rSbFD1h6QuwWeBY9Ghw1s2WR3QcW5M5Zg/7hvzM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=P6HF/ZnvHSP/d3GVRxwFvgAbHPadJLb9lWUC8z7aEHB1Zryglvhe4UdpxKQWR5Q9f
         aN4o84oOLY8sFwdHzuhYCvOIdGGhUSiyzNL+y+Fn+g+S1JmV6xSglzlGTNFaD9Eii9
         FO2MUbDe3Q7onMpkWH/iMbXpiScROeWqD0K1YlDo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230220090201eucas1p2556056f6bf916a8145893e0737328a4b~FfNw0rOfQ0505505055eucas1p2r;
        Mon, 20 Feb 2023 09:02:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.EA.61197.90733F36; Mon, 20
        Feb 2023 09:02:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220090200eucas1p1d53479c6b7e927ccd500778f3da5b1e2~FfNwXUBT93045230452eucas1p1N;
        Mon, 20 Feb 2023 09:02:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220090200eusmtrp2e1f700a331bfa9ac2244f11d5ed418ef~FfNwWg8HD2020820208eusmtrp2a;
        Mon, 20 Feb 2023 09:02:00 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-25-63f33709b4df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.A3.02722.80733F36; Mon, 20
        Feb 2023 09:02:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220090200eusmtip21336bd7cbbca3e5301b03263cdca17a1~FfNvhtI6Y1785817858eusmtip2e;
        Mon, 20 Feb 2023 09:02:00 +0000 (GMT)
Message-ID: <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
Date:   Mon, 20 Feb 2023 10:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87qc5p+TDabdk7DY1mFjMfXhEzaL
        s8sOslk8u7WXyaJ58Xo2ix3bRSy+Xelgsri8aw6bxZOFZ5gsHq4wsug69JfNYvmpHSwW+694
        OfB6bNu9jdVjzbw1jB7fvk5i8ZjdcJHFo63pJavHzll32T0WbCr12LSqk83j0OEORo/9c9ew
        e+z83sDu8XmTXABPFJdNSmpOZllqkb5dAlfGlSn7GQt+K1Ys+L2RsYHxrHQXIyeHhICJxP3d
        d5i6GLk4hARWMEpM2X2GEcL5wijxqGMSK4TzmVHi6LYn7DAta2cthqpazihxtuUEVP9HRomN
        h/eBVfEK2ElcWrMYzGYRUJWY92QjM0RcUOLkzCcsILaoQIrE6dV72EBsYYEkiR/7j7GC2MwC
        4hK3nsxnArFFBIok1je3sYAsYBZoYJZ43XQfrIhNwFCi620XWDOngI3EjqaHLBDN8hLNW2cz
        gzRICGznlOj4cQnqbheJS3MhNksICEu8Or4FKi4j8X/nfCaIhnZGiQW/70M5ExglGp7fYoSo
        spa4c+4X0DoOoBWaEut36UOEHSX2nHnADhKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRm
        HV8Ht/bghUvMExiVZiGFyywk/89C8s4shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBCbA0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4//N+ThbiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXAZPxghW7Qx8Df9YrGZ82mXfq5M/fXxv9mj+9s
        D7NUb5o3MUg2Ruyu1UzRtTdO76h32HZL6p7ESovexRG2BzhuFs/sPrOTv6DfvePF1IVuhT+k
        Dyoy39pj8eOP0Y0aCbbjfQVBBYd8Xq7dI9Y75+j/D+aTwtYZXLx9THGmsUEQO0vYg+RNxQ+P
        iDboRAo4dTwuYFpWElgSGtRvBzS9bt+Vy8pf2cP62dodBbZt+r58+QS/bPODdk1vRe0mmN3c
        Y7vqyvICq1MCWZ3Teb13p2dddZr6raz8F/eyX4wCGWHxXcXve6a5pz7aqOtTIP7eJfWXw65X
        fzpOWf876Pg39QZz+6XAprenvmsyKl910OdWYinOSDTUYi4qTgQAS/hrN+8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7oc5p+TDRpmmFhs67CxmPrwCZvF
        2WUH2Sye3drLZNG8eD2bxY7tIhbfrnQwWVzeNYfN4snCM0wWD1cYWXQd+stmsfzUDhaL/Ve8
        HHg9tu3exuqxZt4aRo9vXyexeMxuuMji0db0ktVj56y77B4LNpV6bFrVyeZx6HAHo8f+uWvY
        PXZ+b2D3+LxJLoAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS/jypT9jAW/FSsW/N7I2MB4VrqLkZNDQsBEYu2sxYxdjFwcQgJLGSUWHP7DDJGQ
        kTg5rYEVwhaW+HOtiw3EFhJ4zygxbVkxiM0rYCdxac1idhCbRUBVYt6TjcwQcUGJkzOfsIDY
        ogIpEp/vzQWrERZIkvix/xjYTGYBcYlbT+YzdTFycIgIFEmsO8wJcgOzQAOzxLLPf1kgDupn
        lDj2cAVYM5uAoUTXW4gjOAVsJHY0PWSBGGQm0bW1ixHClpdo3jqbeQKj0Cwkd8xCsm8WkpZZ
        SFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIz2bcd+bt7BOO/VR71DjEwcjIcYJTiY
        lUR4//N+ThbiTUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ+cB0k1cSb2hmYGpoYmZpYGppZqwk
        zutZ0JEoJJCeWJKanZpakFoE08fEwSnVwHTkaUUA85xvc37tFvNbImqwUiy54fipKkfvXmuD
        QMO93p23XpqkMPVcUXhTaKMc8m1Docc9j59yq99JJb0rzrhpu+d3ddXXAr5EvTOtk2NOHvvV
        elZ+TQfbciMOz8SVhxtYTnfdcX2mpbllqtua33N/9H7Ir7vQHeyQFbmxMG5ZYKry4rLDssqX
        bn5ulJNITL9yJkz2p1BEQKv/SYv97taisWGNSW+Z7DKFsp9K7mgN/nVNPC70R1T8keK2rYVd
        4efyJf4rJxy/+u5RyYwDV6+4pSRIPPH+VL2kdkV80bbSc7J7hdbejBdTnnVXoOJH6oaF5YFt
        GZcST//YWj1tI5OU60af/S9KIzPa51/lUmIpzkg01GIuKk4EADaH4ml/AwAA
X-CMS-MailID: 20230220090200eucas1p1d53479c6b7e927ccd500778f3da5b1e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230218083300eucas1p28c7c584877b8914a3b88904690be82f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230218083300eucas1p28c7c584877b8914a3b88904690be82f6
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
        <20230218083252.2044423-1-saravanak@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 18.02.2023 09:32, Saravana Kannan wrote:
> Hi Mark/Liam,
>
> This series is just an RFC to see if you agree with where this is going.
> Please point out bugs, but don't bother with a proper code review.
>
> The high level idea is to not reimplement what driver core can already
> handle for us and use it to do some of the work. Instead of trying to
> resolve supplies from all different code paths and bits and pieces of
> the tree, we just build it from the root to the leaves by using deferred
> probing to sequence things in the right order.
>
> The last patch is the main one. Rest of them are just setting up for it.
>
> I believe there's room for further simplification but this is what I
> could whip up as a quick first draft that shows the high level idea.
> I'll probably need some help with getting a better understanding of why
> things are done in a specific order in regulator_register() before I
> could attempt simplifying things further.
>
> Ideally, regulator_register() would just have DT parsing, init data
> struct sanity checks and adding the regulator device and then we move
> everything else to into the probe function that's guaranteed to run only
> after the supply has been resolved/ready to resolve.
>
> fw_devlink/device links should further optimize the flow and also allow
> us to simplify some of the guarantees and address some of the existing
> FIXMEs. But this patch series is NOT dependent on fw_devlink or device
> links.
>
> Any thoughts on where this is going?
>
> I've tested this on one hardware I have and it works and nothing is
> broken. But the regulator tree in my hardware isn't that complicated or
> deep. The regulators are also added mostly in the right order (due to
> existing fw_devlink). So if you agree with the idea, the next step is to
> ask people to give it a test.
>
> Also, it's based on driver-core-next since that's what I had synced up
> and had a working baseline. I'll rebase it on the regulator tree when I
> go from RFC -> PATCH.

I've applied this patchset on top of linux next-20230220 and gave it a 
try on my test farm, as it revealed a few issues related to regulator 
initialization in the past. It looks that handling of some corner cases 
is missing, because this patchset introduced a regression on Samsung 
Snow/Peach-Pit/Peach-Pi Chromebooks, as well as Hardkernel's Odroid-M1 
board. It looks that the issue is common - PHY devices don't probe 
properly. This is an output from Odroid-M1 board 
(arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):

# cat /sys/kernel/debug/devices_deferred 2>/dev/null
fd8c0000.usb    platform: wait for supplier host-port
fe830000.phy
fe8a0000.usb2phy        rockchip-usb2phy: failed to create phy
fe8b0000.usb2phy        rockchip-usb2phy: failed to create phy
3c0800000.pcie  rockchip-dw-pcie: failed to get vpcie3v3 regulator
fcc00000.usb    platform: wait for supplier otg-port
fd000000.usb    platform: wait for supplier host-port
fd800000.usb    platform: wait for supplier otg-port
fd840000.usb    platform: wait for supplier otg-port
fd880000.usb    platform: wait for supplier host-port
fe820000.phy

If you need any additional tests on the mentioned boards, let me know.


> Thanks,
> Saravana
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
>
> Saravana Kannan (4):
>    regulator: core: Add regulator devices to bus instead of class
>    regulator: core: Add sysfs class backward compatibility
>    regulator: core: Probe regulator devices
>    regulator: core: Move regulator supply resolving to the probe function
>
>   drivers/regulator/core.c         | 102 +++++++++++++++++++------------
>   drivers/regulator/internal.h     |   2 +-
>   drivers/regulator/of_regulator.c |   2 +-
>   3 files changed, 64 insertions(+), 42 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

