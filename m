Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097B660DAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiJZGCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiJZGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:01:47 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852D2BE06;
        Tue, 25 Oct 2022 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666764105; x=1698300105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmD0kxt0R4vUUSaUB+bUhlFkoSbFxMeO9O8HddzYL1Y=;
  b=X1rW6M5c+x67gIOQavoceUMFlZoVEiEdq6rtwSeM/XVaGojJspGj4N07
   KmnLX8yagKSewZOWTHjMdNEFseBk/Xm0FinWEFlOb8jyz+xIsGtGxzU25
   s+wVfbPcDDcdxzz4imt4NQqIrg79QTGosuqjMft1bqTK+XDGI1+AIFaMp
   RH9yk3KTRJwQ7u2cvzN3pmGQb9CpN0qtxRXfVhSIcUoxyEPiOb9nIhUU6
   FKI+evsze5GPbofeoSr1U7vK90kyH2/WOdf29vC8Ztv3htZGWhntYx3hW
   CKow7JtcDE714MqE4usL+a0JjmS94UhBE+v9f731GYhi0O48Aj/MkdPZY
   w==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="26973016"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Oct 2022 08:01:43 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Oct 2022 08:01:43 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Oct 2022 08:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666764103; x=1698300103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmD0kxt0R4vUUSaUB+bUhlFkoSbFxMeO9O8HddzYL1Y=;
  b=TzmdZSgIPfOeQuO/SZqfLWNI/h7Ti6dHSu4W/HoptizZ7B0yGLX3lKhu
   nUrJneTU/kST3pO7BFfBQvpU3CbGyu8v+1DDu8UHimj1u3ZSMB5RybVDl
   gcFHZZ+8Ep3fwalPw7UTsXi23GbecI2hb432yLgdpCPEN58IQ13uFPG6O
   qvMiiv5hbdA5/JDb4qkseUK8dEhp22Ochg1KQ/BDXaaE2Vc/DSFvKx6km
   qocLSACtK5uoKtec6xtcqu1kcua+TNY8G4x98R3UrLexp/ddnMm1yeCG9
   WKlcMao/0dR9uvQeLk+P2/zYNqOlrLcQ6KvDoUP/tKYVDoKFULQXL07Ig
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="26973015"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Oct 2022 08:01:42 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A0287280056;
        Wed, 26 Oct 2022 08:01:42 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Date:   Wed, 26 Oct 2022 08:01:38 +0200
Message-ID: <2201746.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <56af1cc3-c10e-5694-d25f-252304732568@norik.com>
References: <20221025072533.2980154-1-andrej.picej@norik.com> <13126397.uLZWGnKmhe@steina-w> <56af1cc3-c10e-5694-d25f-252304732568@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrej,

Am Dienstag, 25. Oktober 2022, 13:21:18 CEST schrieb Andrej Picej:
> Hi Alexander,
> 
> On 25. 10. 22 11:38, Alexander Stein wrote:
> > Am Dienstag, 25. Oktober 2022, 09:25:31 CEST schrieb Andrej Picej:
> >> Putting device into the "Suspend-To-Idle" mode causes watchdog to
> >> trigger and reset the board after set watchdog timeout period elapses.
> >> 
> >> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
> >> watchdog in WAIT mode. This is done by setting WDW bit in WCR
> >> (Watchdog Control Register) Watchdog operation is restored after exiting
> >> WAIT mode as expected. WAIT mode coresponds with Linux's
> >> "Suspend-To-Idle".
> >> 
> >> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> >> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >> ---
> >> 
> >> Changes in v2:
> >>   - validate the property with compatible string, as this functionality
> >>   
> >>     is not supported by all devices.
> >> 
> >> ---
> >> 
> >>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 37 insertions(+)
> >> 
> >> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> >> index d0c5d47ddede..dd9866c6f1e5 100644
> >> --- a/drivers/watchdog/imx2_wdt.c
> >> +++ b/drivers/watchdog/imx2_wdt.c
> >> @@ -35,6 +35,7 @@
> >> 
> >>   #define IMX2_WDT_WCR		0x00		/* Control
> > 
> > Register */
> > 
> >>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* ->
> > 
> > Watchdog Timeout Field */
> > 
> >> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable
> > 
> > for WAIT */
> > 
> >>   #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset
> > 
> > WDOG_B */
> > 
> >>   #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset
> > 
> > Signal */
> > 
> >>   #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable
> > 
> > */
> > 
> >> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
> >> 
> >>   	bool ext_reset;
> >>   	bool clk_is_on;
> >>   	bool no_ping;
> >> 
> >> +	bool sleep_wait;
> >> +};
> >> +
> >> +static const char * const wdw_boards[] __initconst = {
> >> +	"fsl,imx25-wdt",
> >> +	"fsl,imx35-wdt",
> >> +	"fsl,imx50-wdt",
> >> +	"fsl,imx51-wdt",
> >> +	"fsl,imx53-wdt",
> >> +	"fsl,imx6q-wdt",
> >> +	"fsl,imx6sl-wdt",
> >> +	"fsl,imx6sll-wdt",
> >> +	"fsl,imx6sx-wdt",
> >> +	"fsl,imx6ul-wdt",
> >> +	"fsl,imx7d-wdt",
> >> +	"fsl,imx8mm-wdt",
> >> +	"fsl,imx8mn-wdt",
> >> +	"fsl,imx8mp-wdt",
> >> +	"fsl,imx8mq-wdt",
> >> +	"fsl,vf610-wdt",
> >> +	NULL
> >> 
> >>   };
> > 
> > So the models listed in
> > Documentation/devicetree/bindings/watchdog/fsl-imx-
> > wdt.yaml not supporting this feature are
> > * fsl,imx21-wdt
> > * fsl,imx27-wdt
> > * fsl,imx31-wdt
> > * fsl,ls1012a-wdt
> > * fsl,ls1043a-wdt
> > ?
> 
> yes, you are correct.
> 
> > But all models are listed as compatible to fsl,imx21-wdt. So there is
> > something wrong here. IMHO this sounds like the compatible list has to be
> > split and updated. Depending on that this feature can be detected.
> > Maintaining another list seems error prone to me.
> 
> So basically the compatible lists would be split into two groups, one
> for the devices which support this WDW bit and the rest which don't
> support this?

This was my idea, so only one set has to be maintained.

> You got a point here, but...this means that every processors
> device-tree, which has two compatible strings (with "fsl,imx21-wdt")
> should be updated, right? That sounds like quite a lot of changes, which
> I'd like to avoid if possible.

Well, the compatible list right now doesn't reflect the hardware features/
compatibility correctly, so IMHO it should be fixed.
But apparently Krzysztof is okay having the special property only applicable 
for a specific set of devices. But in this case you will have to maintain two 
sets of device models (bindings + driver) to which WDW applies/does not apply 
to.

Best regards,
Alexander

> Best regards,
> Andrej
> 
> > Best regards,
> > Alexander
> > 
> >>   static bool nowayout = WATCHDOG_NOWAYOUT;
> >> 
> >> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct
> >> watchdog_device *wdog)
> >> 
> >>   	/* Suspend timer in low power mode, write once-only */
> >>   	val |= IMX2_WDT_WCR_WDZST;
> >> 
> >> +	/* Suspend timer in low power WAIT mode, write once-only */
> >> +	if (wdev->sleep_wait)
> >> +		val |= IMX2_WDT_WCR_WDW;
> >> 
> >>   	/* Strip the old watchdog Time-Out value */
> >>   	val &= ~IMX2_WDT_WCR_WT;
> >>   	/* Generate internal chip-level reset if WDOG times out */
> >> 
> >> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct
> >> platform_device *pdev)
> >> 
> >>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
> >>   	
> >>   						"fsl,ext-
> > 
> > reset-output");
> > 
> >> +
> >> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
> >> +		if (of_device_compatible_match(dev->of_node,
> > 
> > wdw_boards))
> > 
> >> +			wdev->sleep_wait = 1;
> >> +		else {
> >> +			dev_warn(dev, "Warning: Suspending watchdog
> > 
> > during " \
> > 
> >> +				"WAIT mode is not supported for
> > 
> > this device.\n");
> > 
> >> +			wdev->sleep_wait = 0;
> >> +		}
> >> +	else
> >> +		wdev->sleep_wait = 0;
> >> +
> >> 
> >>   	/*
> >>   	
> >>   	 * The i.MX7D doesn't support low power mode, so we need to ping
> > 
> > the
> > 
> >> watchdog * during suspend.




