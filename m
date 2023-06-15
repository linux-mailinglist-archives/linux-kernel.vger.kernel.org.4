Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF027319EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbjFON1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFON1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:27:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E602726
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:27:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q9n0Q-0006nm-HG; Thu, 15 Jun 2023 15:27:18 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q9n0N-0002KD-VC; Thu, 15 Jun 2023 15:27:15 +0200
Date:   Thu, 15 Jun 2023 15:27:15 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/25] Add perf support to the rockchip-dfi driver
Message-ID: <20230615132715.GF18491@pengutronix.de>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:40:34PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, May 24, 2023 at 10:31:28AM +0200, Sascha Hauer wrote:
> > This is v5 of the series adding perf support to the rockchip DFI driver.
> > 
> > A lot has changed in the perf driver since v4. First of all the review
> > feedback from Robin and Jonathan has been integrated. The perf driver
> > now not only supports monitoring the total DDR utilization, but also the
> > individual channels. I also reworked the way the raw 32bit counter
> > values are summed up to 64bit perf values, so hopefully the code is
> > easier to follow now.
> > 
> > lockdep found out that that locking in the perf driver was broken, so I
> > reworked that as well. None of the perf hooks allows locking with
> > mutexes or spinlocks, so in perf it's not possible to enable the DFI
> > controller when needed. Instead I now unconditionally enable the DFI
> > controller during probe when perf is enabled.
> > 
> > Furthermore the hrtimer I use for reading out the hardware counter
> > values before they overflow race with perf. Now a seqlock is used to
> > prevent that.
> > 
> > The RK3588 device tree changes for the DFI were not part of v4. As
> > Vincent Legoll showed interest in testing this series the necessary
> > device tree changes are now part of this series.
> 
> I tested the series on RK3588 EVB1. The read/write byts looks
> sensible. Sometimes cycles reads unrealistic values, though:
> 
>  Performance counter stats for 'system wide':
> 
> 18446744070475110400      rockchip_ddr/cycles/

This goes down to missing initialization of &dfi->last_perf_count, see
my other mail. Will fix this in the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
