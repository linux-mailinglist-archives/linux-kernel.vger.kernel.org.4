Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2223704AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjEPKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjEPKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:42:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80DBE;
        Tue, 16 May 2023 03:41:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G8VOmT026320;
        Tue, 16 May 2023 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=vAMh92l5h6Q7hcEh6WFWIgGftgCfxqWmMEVQrJ7Twmo=;
 b=GLaW26NG5Cj9mCLHLw9+IpvJmezaDN8LtyneTOQ9fOY33z71QwCmX3APWVoL2xdasX1h
 9dJGd4etzg4pdAU2aM8oQqU0W3KpmL/yqoffLhmSBUCn6zANCtCyFzV+kvHTQwKtKeOT
 8IZ4rwiLO1URvD940rPXeSGlhkju4vEjWSDD5OuvWeWAVACUNqxsNzf/jlaU84L9FhEn
 UllOpj0Jq12/6OZixxWy9B5Bt9JIyt6s9NC8saGsQTUCIXWGHPMydkynQFbk+H0vPZXq
 DoE00yt1TXPBa+1zK0uTspqYQwq8Vti/x8epmnwcgw4cLNqTVKVYCK/80lDvJO+Z4QPk TA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymv753-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 05:41:15 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 05:41:14 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 05:41:14 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2CC28B38;
        Tue, 16 May 2023 10:41:14 +0000 (UTC)
Date:   Tue, 16 May 2023 10:41:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>,
        <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <20230516104114.GU68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
 <20230515112554.GA10825@google.com>
 <86h6scmzf7.wl-maz@kernel.org>
 <20230516100936.GF10825@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230516100936.GF10825@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: gMHOED3BHFVkCy5V-NwvIXEY6a_cTz6p
X-Proofpoint-ORIG-GUID: gMHOED3BHFVkCy5V-NwvIXEY6a_cTz6p
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:09:36AM +0100, Lee Jones wrote:
> On Tue, 16 May 2023, Marc Zyngier wrote:
> > On Mon, 15 May 2023 12:25:54 +0100,
> > Lee Jones <lee@kernel.org> wrote:
> > > On Fri, 12 May 2023, Marc Zyngier wrote:
> > > > On Fri, 12 May 2023 16:39:33 +0100,
> > > > Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > > I'm not aware of another subsystem that deals with !IRQChip level IRQ
> > > controllers.  Where do simple or "second class" interrupt controllers
> > > go?
> > 
> > This isn't an interrupt controller. This is internal signalling, local
> > to a single component that has been artificially broken into discrete
> > bits, including an interrupt controller. The only *real* interrupts
> > here are the GPIOs.
> > 

I would question this statement a little, they are fixed function
IRQs sure but they are still real interrupts. These are lines which
receive a signal and on an edge they set a stick status bit, which
causes another signal to generate an edge, they have registers
which let you mask events, if it walks like a duck and all. The
only difference between this and a "real" interrupt is whether the
chip designer or the board designer was the person who decided
where the wire was connected.

> > I'm happy to see an interrupt controller for the GPIOs. But the rest
> > is just internal muck that doesn't really belong here. Where should it

Internal-ish, granted many of them are primarily useful to the
device itself. But it is very easy to construct situations where
say knowing the speaker thermals are high, or that a jack has
been inserted are useful outside of the CODEC driver itself.

> > go? Together with the rest of the stuff that manages the block as a
> > whole. Which looks like the MFD subsystem to me.
> 
> Very well.  Let's see this "muck" in a patch please!

Groovy I will do a re-spin moving the IRQ stuff to the MFD and
lets see where we get to.

Thank you all for your help in reviewing this so far.

Thanks,
Charles
