Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5062301C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKIQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKIQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:25:27 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488819286
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:25:24 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDLMk024619;
        Wed, 9 Nov 2022 10:24:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=4LdghTqwuCMPOdU9Ut4ETkmJT6zVE1bHF4jdVG2J6p8=;
 b=HD5wmr87wcyfInGnCIRbw6/GHA355PIbu6DG//AUXQK33MInwvfY9G0OibcchpC8x4Hg
 fzgx/AAvFzf6NqN3yVvIXOSKjQHUKM/wkeJr5pQHpL9qtguXbGgo5Zdy4PoYs4eMAvyW
 GTN6JO5w5+pqAvoqEkRi/bd43hHX5/ZlniRVJAeFfmSj0nABTvhBZD7sSbWcN3mqxyBO
 3X0MYm9uW6ZGJ8qLgeSxll618SHDUp6R+oCv5z3hc20EwMLKCSyCGl+5GqpFkRW7/j1Y
 ZC95ytAUS8zDe5cnbzaOYzHnCE/0YwqZry98qDh+zngmoDfsDHdEDZ6o8aUuDMUB0fI8 0g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81nj0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:24:14 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:24:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:24:12 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ADF88B12;
        Wed,  9 Nov 2022 16:24:12 +0000 (UTC)
Date:   Wed, 9 Nov 2022 16:24:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Chancel Liu <chancel.liu@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <luca.ceresoli@bootlin.com>, <ojeda@kernel.org>,
        <cmo@melexis.com>, <u.kleine-koenig@pengutronix.de>,
        <xiaolei.wang@windriver.com>, <steve@sk2.org>,
        <chi.minghao@zte.com.cn>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8962: Wait for updated value of
 WM8962_CLOCKING1 register
Message-ID: <20221109162412.GG10437@ediswmail.ad.cirrus.com>
References: <20221109121354.123958-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109121354.123958-1-chancel.liu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: OB147xjjz1wIV99wseqVZ6HmdeMEacsz
X-Proofpoint-GUID: OB147xjjz1wIV99wseqVZ6HmdeMEacsz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:13:54PM +0800, Chancel Liu wrote:
> DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
> correct frequency of LRCLK and BCLK. Sometimes the read-only value
> can't be updated timely after enabling SYSCLK. This results in wrong
> calculation values. Delay is introduced here to wait for newest value
> from register. The time of the delay should be at least 500~1000us
> according to test.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
