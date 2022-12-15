Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6999D64D95E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLOKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLOKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:15:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3AA27154
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:15:02 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFA8v1K008119;
        Thu, 15 Dec 2022 04:13:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Un3qCBxpCzido0mQnarkArNgTyyWKhnUSal2XP1EUNo=;
 b=lzzDYrDuG05Zvlx77Kxo+7HMLjQt1P/bb6ZJ7UWrKgDb52nfK1qhs3m7tfiLrj05UEW9
 3O38UpM9A15DMsZBB9ep5NK4mIMFhMYDNpVN8BinGJxwc7+z56IpAx3AJO6LTPQF/ILK
 Traf9uRmhG2/cuz7dwfdlRZ6G1NsLXX9+X01lP7WPyn6fvpLEeNw2a5nl1GS+bdW30Ts
 Y4Qu+kn/snemPnGxc67Knjsd5KcvQYYAGo02w4ji8st72QdrqEgj0AEaS7387MZX2/ki
 2uhjU4KProe2/m+xgpzbnoZfgOV4ZDoPakBLmDCoKAHeGzYPxVA9CblU3pgo4iBlAiIE xA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3mf6rw9fne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 04:13:56 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 15 Dec
 2022 04:13:53 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 15 Dec 2022 04:13:53 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2F6011CB;
        Thu, 15 Dec 2022 10:13:53 +0000 (UTC)
Date:   Thu, 15 Dec 2022 10:13:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <20221215101353.GA36097@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221215093615.3794156-1-lukma@denx.de>
 <20221215093615.3794156-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221215093615.3794156-2-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: tpQK4WjaN9ppPmobgYMS1GO9dUJSfxvG
X-Proofpoint-ORIG-GUID: tpQK4WjaN9ppPmobgYMS1GO9dUJSfxvG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:36:14AM +0100, Lukasz Majewski wrote:
> This patch enables support for internal wm8940's PLL and proper
> divider to set proper value for 256x fs clock.
> 
> This approach is more flexible and replaces hardcoded clock
> values and makes the codec work with the simple-card driver.
> Card drivers calling set_pll() and set_clkdiv() directly are
> unaffected.
> 
> For the reference - code in this commit is based on:
> "ASoC: wm8974: configure pll and mclk divider automatically"
> (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).

Minor nit this doesn't quite match the commit <12-chars of SHA>
("<description>") format in Submitting-patches.rst.

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

But the patch looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
