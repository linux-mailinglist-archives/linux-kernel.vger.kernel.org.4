Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239673355D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbjFPQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbjFPQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:02:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA344204;
        Fri, 16 Jun 2023 09:02:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GBVHcm018156;
        Fri, 16 Jun 2023 11:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aM4qTlg66psxyt7MvUaMTfjlMOxNt1M83BDXPCVlrdE=;
 b=Gh3KuXRDek8q+xUxmtZtD1eBuOoymuBv7/v6TC3Q3rw9DjPFyFWQfxvt14FXP35N7ocU
 IJzdxdCW/niSf4ilGW4rwaXVqv8impUnXd41HsmIyLPn5/O+qevvEWZma6Qc8YUbULUg
 +2zO0FYvO7g3USZ4F4bnEjct8yrT/3exot0scjSqDSHq6bBzS+1MugdrLA/3ZjZZq0XI
 /vKqk/l8UENa4vl3YPGB80AG19ukpvTAoAjkCO6jKUI2Sd6+N1p7Qo/jr6HRCPDduKMt
 ETh9dJ+cdkEROG/CtJ44Mn1KG+2wSP9c8CHiZnK8XeY39bJKr0VG82wZPKhjNYH8rmCS uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r4pk0ejjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 11:01:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 16 Jun
 2023 17:01:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 16 Jun 2023 17:01:56 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AEE3615A4;
        Fri, 16 Jun 2023 16:01:56 +0000 (UTC)
Date:   Fri, 16 Jun 2023 16:01:56 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <andy.shevchenko@gmail.com>
CC:     <broonie@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230616160156.GT68926@ediswmail.ad.cirrus.com>
References: <20230605125504.2570158-1-ckeepax@opensource.cirrus.com>
 <20230605125504.2570158-2-ckeepax@opensource.cirrus.com>
 <ZIuNXQIB3j6YjYa7@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIuNXQIB3j6YjYa7@surfacebook>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: g_ZbuS0378fNogebm1OeP16CyalPar6e
X-Proofpoint-GUID: g_ZbuS0378fNogebm1OeP16CyalPar6e
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

On Fri, Jun 16, 2023 at 01:14:53AM +0300, andy.shevchenko@gmail.com wrote:
> Mon, Jun 05, 2023 at 01:54:59PM +0100, Charles Keepax kirjoitti:
> > From: Lucas Tanure <tanureal@opensource.cirrus.com>
> > +	bus->irq_chip.name = dev_name(bus->dev);
> > +	bus->domain = irq_domain_add_linear(NULL, SDW_MAX_DEVICES, &sdw_domain_ops, bus);
> 
> I'm wondering why you are not using existing fwnode, if any
> (e.g. from parent device).

I think that is just an oversight, I will fixup for the next
version.

Thanks,
Charles
