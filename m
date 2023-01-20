Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28566757BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjATOpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjATOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:44 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3934ABB96;
        Fri, 20 Jan 2023 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xr9Bk8WWnK9zJMqPrV6WPb/9VZSO5pw+Ilr2i4XPMyk=; b=zFFpOZ4uABIws+AzS7llHzXNAK
        V9rCbxn7jokshAdhssegaTjM4WhIANIplGLciidLoC1TshxwcINpA3t1kpKVJS+QElvLCtVgZu0Ml
        +79ELeB2WzLLyD8EccDsWZf0XaUPN3o5VO0No5Hg/P1Pklvt1E/F+bBbzVK5P50VDLPk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41482 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pIscn-0005Bb-NK; Fri, 20 Jan 2023 09:44:14 -0500
Date:   Fri, 20 Jan 2023 09:44:13 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Philipp Rosenberger <p.rosenberger@kunbus.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230120094413.9efcbd1d31fd63620eb7722e@hugovil.com>
In-Reply-To: <8044fb10-519e-c8ac-7c0d-50bd8b6a1224@kunbus.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-13-hugo@hugovil.com>
        <72514fec-12e2-5b51-261d-9e171b46f5bb@kunbus.com>
        <20230119124853.9193fd073b8a95b45e20f41c@hugovil.com>
        <8044fb10-519e-c8ac-7c0d-50bd8b6a1224@kunbus.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 12/14] rtc: pcf2127: support generic watchdog timing
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 09:06:31 +0100
Philipp Rosenberger <p.rosenberger@kunbus.com> wrote:

> On 19.01.23 18:48, Hugo Villeneuve wrote:
> > On Wed, 18 Jan 2023 14:23:14 +0100
> > Philipp Rosenberger <p.rosenberger@kunbus.com> wrote:
> > 
> > Hi Philipp,
> > you are right that the value store/computed inside the structure wdd (struct watchdog_device) should be in seconds, according to the header file documentation in watchdog.h.
> > 
> > However, in the PCF2127 datasheet, the value n that is stored in the PCF2127_REG_WD_VAL register does not represent a value in seconds, but a counter value. It is given by this equation:
> > 
> >      n = source_clock_frequency x timer_period_in_seconds
> > 
> > For the PCF2127, since the clock used is 1Hz, it works as the previous equation can be simplified as:
> > 
> >      n = timer_period_in_seconds
> > 
> > However, if the source clock is different than 1Hz, it would no longer work. Also, since the PCF2131 uses a default clock of 1/4 Hz, it also would not work.
> > 
> > That is the reason why I modified the watchdog timer value (n) computation to take the clock into account. I then use the desired timeout in seconds given by  PCF2127_WD_VAL_DEFAULT to compute the counter value (n).
> > 
> > So what I am proposing to do is to store the PCF2127_WD_VAL_DEFAULT value in wdd->timeout, as before, but convert it to a counter value in pcf2127_wdt_active_ping(). Or to only compute it once, I could define a new variable and compute/set it in pcf2127_watchdog_init().
> > 
> > Hugo.
> > 
> 
> Hi Hugo,
> 
> with some small changes to your code I was able to get the behavior 
> right. But with this the timeout get converted from seconds to the 
> counter register format on every ping.
> 
> Just add WD_COUNTER(wdd->timeout, pcf2127->cfg->wdd_clock_hz_x1000) to 
> the regmap_write() in pcf2127_wdt_ping(). Then in 
> pcf2127_watchdog_init() just do:
> 
> pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
> 
> Best regards,
> Philipp

Hi Philipp,
in the end this is exactly what I did. I will send an updated patch series once I have adressed the other comments.

Hugo.


> > 
> >> On 15.12.22 16:02, Hugo Villeneuve wrote:
> >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>>
> >>> Introduce in the configuration structure two new values to hold the
> >>> watchdog clock source and the min_hw_heartbeat_ms value.
> >>>
> >>> The minimum and maximum timeout values are automatically computed from
> >>> the watchdog clock source value for each variant.
> >>>
> >>> The PCF2131 has no 1Hz watchdog clock source, as is the case for
> >>> PCF2127/29.
> >>>
> >>> The next best choice is using a 1/4Hz clock, giving a watchdog timeout
> >>> range between 4 and 1016s. By using the same register configuration as
> >>> for the PCF2127/29, the 1/4Hz clock source is selected.
> >>>
> >>> Note: the PCF2127 datasheet gives a min/max range between 1 and 255s,
> >>> but it should be between 2 and 254s, because the watchdog is triggered
> >>> when the timer value reaches 1, not 0.
> >>>
> >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>> ---
> >>>    drivers/rtc/rtc-pcf2127.c | 56 +++++++++++++++++++++++++++++++++------
> >>>    1 file changed, 48 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> >>> index 11fbdab6bf01..3fd2fee4978b 100644
> >>> --- a/drivers/rtc/rtc-pcf2127.c
> >>> +++ b/drivers/rtc/rtc-pcf2127.c
> >>> @@ -157,9 +157,29 @@
> >>>
> >>>    /* Watchdog timer value constants */
> >>>    #define PCF2127_WD_VAL_STOP               0
> >>> -#define PCF2127_WD_VAL_MIN         2
> >>> -#define PCF2127_WD_VAL_MAX         255
> >>> -#define PCF2127_WD_VAL_DEFAULT             60
> >>> +#define PCF2127_WD_VAL_DEFAULT             60 /* In seconds. */
> >>> +/* PCF2127/29 watchdog timer value constants */
> >>> +#define PCF2127_WD_CLOCK_HZ_X1000  1000 /* 1Hz */
> >>> +#define PCF2127_WD_MIN_HW_HEARTBEAT_MS     500
> >>> +/* PCF2131 watchdog timer value constants */
> >>> +#define PCF2131_WD_CLOCK_HZ_X1000  250  /* 1/4Hz */
> >>> +#define PCF2131_WD_MIN_HW_HEARTBEAT_MS     4000
> >>> +/*
> >>> + * Compute watchdog period, t, in seconds, from the WATCHDG_TIM_VAL register
> >>> + * value, n, and the clock frequency, f, in Hz.
> >>> + *
> >>> + * The PCF2127/29 datasheet gives t as:
> >>> + *   t = n / f
> >>> + * The PCF2131 datasheet gives t as:
> >>> + *   t = (n - 1) / f
> >>> + * For both variants, the watchdog is triggered when the WATCHDG_TIM_VAL reaches
> >>> + * the value 1, and not zero. Consequently, the equation from the PCF2131
> >>> + * datasheet seems to be the correct one for both variants.
> >>> + */
> >>> +#define WD_PERIOD_S(_n_, _f1000_) ((1000 * ((_n_) - 1)) / (_f1000_))
> >>> +
> >>> +/* Compute value of WATCHDG_TIM_VAL to obtain period t, in seconds. */
> >>> +#define WD_COUNTER(_t_, _f1000_) ((((_t_) * (_f1000_)) / 1000) + 1)
> >>>
> >>>    /* Mask for currently enabled interrupts */
> >>>    #define PCF2127_CTRL1_IRQ_MASK (PCF2127_BIT_CTRL1_TSF1)
> >>> @@ -202,6 +222,11 @@ struct pcf21xx_config {
> >>>      u8 reg_wd_val; /* Watchdog value register. */
> >>>      u8 reg_clkout; /* Clkout register. */
> >>>      u8 reg_reset;  /* Reset register if available. */
> >>> +
> >>> +   /* Watchdog configuration. */
> >>> +   int wdd_clock_hz_x1000; /* Value in Hz multiplicated by 1000 */
> >>> +   int wdd_min_hw_heartbeat_ms;
> >>> +
> >>>      unsigned int ts_count;
> >>>      struct pcf21xx_ts_config ts[4];
> >>>      struct attribute_group attribute_group;
> >>> @@ -496,10 +521,19 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
> >>>      pcf2127->wdd.parent = dev;
> >>>      pcf2127->wdd.info = &pcf2127_wdt_info;
> >>>      pcf2127->wdd.ops = &pcf2127_watchdog_ops;
> >>> -   pcf2127->wdd.min_timeout = PCF2127_WD_VAL_MIN;
> >>> -   pcf2127->wdd.max_timeout = PCF2127_WD_VAL_MAX;
> >>> -   pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
> >>> -   pcf2127->wdd.min_hw_heartbeat_ms = 500;
> >>> +
> >>> +   pcf2127->wdd.min_timeout =
> >>> +           WD_PERIOD_S(2, pcf2127->cfg->wdd_clock_hz_x1000);
> >>> +   pcf2127->wdd.max_timeout =
> >>> +           WD_PERIOD_S(255, pcf2127->cfg->wdd_clock_hz_x1000);
> >>> +   pcf2127->wdd.timeout = WD_COUNTER(PCF2127_WD_VAL_DEFAULT,
> >>> +                                     pcf2127->cfg->wdd_clock_hz_x1000);
> >>> +
> >>> +   dev_dbg(dev, "%s min = %ds\n", __func__, pcf2127->wdd.min_timeout);
> >>> +   dev_dbg(dev, "%s max = %ds\n", __func__, pcf2127->wdd.max_timeout);
> >>> +   dev_dbg(dev, "%s def = %d\n", __func__, pcf2127->wdd.timeout);
> >>> +
> >>> +   pcf2127->wdd.min_hw_heartbeat_ms = pcf2127->cfg->wdd_min_hw_heartbeat_ms;
> >>>      pcf2127->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> >>>
> >>>      watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
> >>> @@ -926,6 +960,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >>>              .reg_wd_ctl = PCF2127_REG_WD_CTL,
> >>>              .reg_wd_val = PCF2127_REG_WD_VAL,
> >>>              .reg_clkout = PCF2127_REG_CLKOUT,
> >>> +           .wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
> >>> +           .wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
> >>>              .ts_count = 1,
> >>>              .ts[0] = {
> >>>                      .regs_base = PCF2127_REG_TS1_BASE,
> >>> @@ -951,6 +987,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >>>              .reg_wd_ctl = PCF2127_REG_WD_CTL,
> >>>              .reg_wd_val = PCF2127_REG_WD_VAL,
> >>>              .reg_clkout = PCF2127_REG_CLKOUT,
> >>> +           .wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
> >>> +           .wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
> >>>              .ts_count = 1,
> >>>              .ts[0] = {
> >>>                      .regs_base = PCF2127_REG_TS1_BASE,
> >>> @@ -977,6 +1015,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >>>              .reg_wd_val = PCF2131_REG_WD_VAL,
> >>>              .reg_clkout = PCF2131_REG_CLKOUT,
> >>>              .reg_reset  = PCF2131_REG_SR_RESET,
> >>> +           .wdd_clock_hz_x1000 = PCF2131_WD_CLOCK_HZ_X1000,
> >>> +           .wdd_min_hw_heartbeat_ms = PCF2131_WD_MIN_HW_HEARTBEAT_MS,
> >>>              .ts_count = 4,
> >>>              .ts[0] = {
> >>>                      .regs_base = PCF2131_REG_TS1_BASE,
> >>> @@ -1215,7 +1255,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >>>
> >>>      /*
> >>>       * Watchdog timer enabled and reset pin /RST activated when timed out.
> >>> -    * Select 1Hz clock source for watchdog timer.
> >>> +    * Select 1Hz clock source for watchdog timer (1/4Hz for PCF2131).
> >>>       * Note: Countdown timer disabled and not available.
> >>>       * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
> >>>       * of register watchdg_tim_ctl. The bit[6] is labeled
> >>
> > 
> > 
> > --
> > Hugo Villeneuve <hugo@hugovil.com>
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
