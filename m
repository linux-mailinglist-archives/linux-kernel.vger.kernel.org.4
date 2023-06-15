Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DE73204A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjFOTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:17:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384E2949;
        Thu, 15 Jun 2023 12:17:16 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 759EC6606F6E;
        Thu, 15 Jun 2023 20:17:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686856634;
        bh=9cTy5OERyS6fSukY4Y7e/rJNoBkgA7xxcx6sGhsLmvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLORdI1jvMSd1l9WTLUIXNOfllE+7dt7phxDZ4YMYAAkCgDXB5RDYvTymg2KYXPQK
         JA95UWbC6wUGDyYQ/K0rFepR1V6jHIBuCzJUkn3bMhDwSLlAuk3CUluFaYfQmCT+UB
         In3zvXANJWAXNCmwm+9meZM+pxge9KPKpLDTU343P37pj47P0vKtgV7AfpYIGzaFhm
         FjXLUZER/Xxd+KFTWsyC6KV7cQfpWchW+cdfcPXiWEHhjWSQaoyyMCLhonvJE3MsnI
         XkZl4XSwOC+40bozt9+EYB0ST/qA7f48WN8G95pF+evobp2swipBXCWazZpyyx9vSx
         vMwGmsfZjq0CQ==
Date:   Thu, 15 Jun 2023 15:17:07 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Message-ID: <2206a438-8187-4b17-a96c-3affc9552c05@notapiano>
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
 <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
 <59c7c90c-50f2-5a77-af12-b266c6e6e0b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c7c90c-50f2-5a77-af12-b266c6e6e0b1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:39:27AM +0200, Daniel Lezcano wrote:
> On 01/06/2023 19:09, Nícolas F. R. A. Prado wrote:
> > On Wed, May 31, 2023 at 12:49:43PM +0800, Chen-Yu Tsai wrote:
> > > On Wed, May 31, 2023 at 3:51 AM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
> > > > 
> > > > From: Balsam CHIHI <bchihi@baylibre.com>
> > > > 
> > > > Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
> > > > Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> > > > and update the documentation that describes the Calibration Data Offsets.
> > > > 
> > > > Changelog:
> > > >      v4 :
> > > >          - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
> > > >            room for SVS support, pointed out by
> > > >            AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > 
> > > >      v3 :
> > > >          - Rebased :
> > > >              base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
> > > >          - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
> > > >            Use filtered mode to make sure threshold interrupts are triggered,
> > > 
> > > I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
> > > fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a couple
> > > of the LVTS sensors would be N/A. Not sure if this is related to this change.
> > 
> > Yes, it is. Filtered mode has some delay associated with reading, meaning most
> > of the time the value isn't ready, while immediate mode is, well, pretty much
> > immediate and the read always succeeds.
> > 
> > For temperature monitoring, filtered mode should be used. It supports triggering
> > interrupts when crossing the thresholds. Immediate mode is meant for one-off
> > readings of the temperature. This is why I suggested using filtered mode.
> > 
> > As far as the thermal framework goes, it's ok that filtered mode doesn't always
> > return a value, as it will keep the old one. But of course, having the
> > temperature readout always work would be a desired improvement.
> > 
> > As for ways to achieve that, I think the intended way would be to enable the
> > interrupts that signal data ready on filtered mode (bits 19, 20, 21, 28), read
> > the temperature and cache it so it is always available when the get_temp()
> > callback is called. The issue with this is that it would cause *a lot* of
> > interrupts, which doesn't seem worth it.
> > 
> > Another option that comes to mind would be to enable immediate mode only during
> > the get_temp() callback, to immediately read a value, and return to filtered
> > mode at the end. That might work, but I haven't tried yet.
> 
> Why not understand why the filtered mode is unable to return temperature
> values most of the time?
> 
> I tried with the filtered mode and I can see 90% of the time it is not
> possible to read the temperature.
> 
> IIUC there are timings which can be setup, may be understand how to set them
> up in order to read the temperature correctly?
> 
> Caching values, switching the mode or whatever is hackish :/

So this is what I've found after some more testing.

With the current settings, using filtered mode, only about 30% of the
measurement reads return valid results:
rate: 29%   (success: 293, fail: 707)

While, as observed, in immediate mode, the reads always succeed:
rate: 100%   (success: 1000, fail: 0)

Changing the configurations so that the measurements take less time improve the
rate (and analogously increasing the time worsens the rate). That is, with
PERIOD_UNIT = 0, GROUP_INTERVAL = 0, FILTER_INTERVAL = 0, SENSOR_INTERVAL = 0,
HW_FILTER = 0 (ie single sample) the rate is much improved:
rate: 91%   (success: 918, fail: 82)

Though note that even though we're sampling as fast as possible and sampling
only once each time, so supposedly what immediate mode does, it's still not at
100% like in immediate mode.

Enabling the sensor 0 filter IRQ (bit 19) I've observed that it is triggered
about every 3500us (on the controller with all four sensors) with the current
settings, but after changing those timing registers, it happens every 344us.
With that in mind, in addition to those timing changes, if we also read the
register more than once with a timeout longer than that 344, that is,

rc = readl_poll_timeout(msr, value, value & BIT(16), 240, 400);

it's enough to get
rate: 100%   (success: 1000, fail: 0)
and even better:
rate: 100%   (success: 10000, fail: 0)

So it's still not exactly clear what's the relation of the VALID bit with the
timings in the hardware, but this at least gives us a way to get valid reads
without sacrificing interrupts.

Meanwhile, I've also tried reading the measurement during handling of the sensor
0 filter IRQ (bit 19), and while it definitely works much better than the
current 30%, giving a rate of 92%, it's still not 100%, which is intriguing
given this IRQ is supposed to signal the data is ready... I thought this might
be caused by timing issues, but increasing the timing of the measurements (by
setting PERIOD_UNIT = 120), lowered the rate to 84%.
Simply enabling this interrupt (and not reading the data in the IRQ), gives a
drastically worse rate:
rate: 3%   (success: 32, fail: 968)
Which I understand to mean that whenever the IRQ is cleared, the hardware
invalidates the previous measurement. So this IRQ is definitely related to the
VALID bit, but it also is unexpectedly influenced by the timings.

The VALID bit is also updated when read, and it tends to take the same time
between IRQs to be reset, so my understanding is that on every IRQ the VALID
bit is re-set to 1, and reading it clears it. But this does not explain why with
smaller intervals a single read has more chance of succeeding.

At this point, though, I feel like if it is possible to guarantee that readings
in filtered mode will always be valid, it must be some hidden setting in
LVTS_CONFIG. But with what we have access to, the best we can hope for is to
make the invalid reads extremely unlikely, which is what shrinking the intervals
and polling the register as shown above gives us, so it's what I suggest us to
do.

Thanks,
Nícolas
