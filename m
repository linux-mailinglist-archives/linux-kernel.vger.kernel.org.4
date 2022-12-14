Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B164C9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiLNNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiLNNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:11:13 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CB201B7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:11:06 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEAosGP030155;
        Wed, 14 Dec 2022 07:10:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=uqTM1X1FgdfVNHTySLwZxLVD1Clcyid2R85NS87Xe08=;
 b=OnEhJX3LRlKcfOVP9tmTc8nhffaYoPXsU5e9ykqT72GXzu7qsy2ojgMIxQAwMQII2r2w
 iPz+2n4jbbr1hOJeMwftf3Ik4xs25iyE+C6B/hJ2fmNcpLdVfA9ukb4omyG4jjV1iKMg
 XQvmh0/2XDbrQKRkERoLaOl/ob90KwdeiMext1H1Bpp2nj422t7um9IVGMxVE/wht9Ht
 4dAPzA7O26bZUZf3WacQFacKEJnXMMHzJnJU+yhHgI5GJg6Svn/Ho/RqZ+vUReaJhEMw
 jAD7SmEpfAHs1FOtPRsqTaWHD+ddc+Xm4f/+PKhD9+2aS/GJX+jjGRnUhfAq53ah6dp5 jA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3mf6rh8dhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 07:10:16 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 14 Dec
 2022 07:10:14 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Wed, 14 Dec 2022 07:10:14 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D61711CB;
        Wed, 14 Dec 2022 13:10:14 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:10:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ASoC: wm8940: Read chip ID when wm8940 codec probing
Message-ID: <20221214131014.GO105268@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221214123743.3713843-5-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214123743.3713843-5-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: cMSJ_BuhSNqGoxW1BWcSdrrFv3uT8ncy
X-Proofpoint-GUID: cMSJ_BuhSNqGoxW1BWcSdrrFv3uT8ncy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:37:43PM +0100, Lukasz Majewski wrote:
> The wm8940 provides the chip ID information via I2C. In this
> patch this information is read and if not matching expected
> value, the probe function is aborted.
> 
> This prevents from using (i.e. inserting) other wm89* modules
> which use the sam I2C bus address.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
