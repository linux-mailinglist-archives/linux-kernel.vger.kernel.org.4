Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485FE625AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKKNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKNAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:00:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBC2E9FC;
        Fri, 11 Nov 2022 05:00:18 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABAb9V2005866;
        Fri, 11 Nov 2022 07:00:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/60KnAr5FUsJ8zQZvJ+hZGIs6XC9AeBNG9RBS6yfGWg=;
 b=WCHkpjpJnoqnfiNP/terOoASQ98PNJon0nbCrOLvU8XUg7XM//n0PXYPzLmKs0Mpwk27
 s3SmZzrU5lEp7IhYG2SJexDy+6GoIPA4Ogjw/r5Gs8bBnpenuNy4kvbC519uI/kQJ+B+
 ut0+7fck4Ph5oYJDR8twZQILQ573kNJcgDMHm3O1Qbtna+VoquXffOgfNLb2bgc6ni2t
 kM7vyljPbMHgLba4ugWqKshNzCtewT9t88S3/NPfVIZP1kiMUnWH1bFnixsuZQJtSHfQ
 UoKQHNjPv0Q2dCEs258NPa69RAG8wi1qfv++1bKixP14t7Yaw6nt/6tr1bcSCjXA9G/e uA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pgh6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 07:00:02 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 11 Nov
 2022 07:00:01 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Fri, 11 Nov 2022 07:00:01 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E97BE46B;
        Fri, 11 Nov 2022 13:00:00 +0000 (UTC)
Date:   Fri, 11 Nov 2022 13:00:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <tglx@linutronix.de>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <20221111130000.GI10437@ediswmail.ad.cirrus.com>
References: <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
 <87iljmve87.wl-maz@kernel.org>
 <Y21gwGDb5CFft0kp@sirena.org.uk>
 <87h6z5vs39.wl-maz@kernel.org>
 <20221111111611.GH10437@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221111111611.GH10437@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: FJ2KJtnO5BhYskYK5Gg9AMPrnOAunrsX
X-Proofpoint-GUID: FJ2KJtnO5BhYskYK5Gg9AMPrnOAunrsX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:16:11AM +0000, Charles Keepax wrote:
> On Fri, Nov 11, 2022 at 08:00:10AM +0000, Marc Zyngier wrote:
> > On Thu, 10 Nov 2022 20:36:16 +0000,
> > Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Nov 10, 2022 at 06:47:20PM +0000, Marc Zyngier wrote:
> The interrupt-parent points at who our IRQ is connected to, and
> we are an interrupt-controller so people can use our IRQs. I
> think it is not currently supported to have more than a single
> interrupt-parent for a device so with the current binding is it
> actually possible for the device to refer to its own IRQs in DT?
> 

I see there is actually interrupts-extended which would let us
refer to ourselves although its a little unclear to be if that
would actually work but might be worth a look.

Thanks,
Charles
