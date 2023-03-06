Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82F6AB9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCFJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCFJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:27:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D947B227A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:27:05 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3266sjZ2003171;
        Mon, 6 Mar 2023 03:26:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ijoY0cAbKV1Yi6yBy5gj8C+z3x9rq5z5KsnmtjtmXUE=;
 b=DpUW7tkBAyuVbuCN6NZciQlN/dUM10aE/Ei98jWy7AdpheJVZ1NtnQDr/fk2aAIfqYFQ
 qinypZuQaU7a7uspV7yspS/Xa8ULkH6KYsucuPmMnL+ZSJ9ikuACsStDAguU5m90BxtK
 LtazGLwOGvZVG/IiF4yNwgjzUtdGlyXitLa/YWQ6nCtVBJhcwwfI5uAjh2BzlkggOBET
 tejFfcPLXJlR06LUAu/Q3y8YFcDTXYu5LTPqXgUuHJov/bBVowKp0JLIBLcnXouwLRMi
 btDcw6xypNuHJ56A0gJ6DFNolqCik6PEwcaGAcC/m+XvFqxcVJcAqZ+yzRVl9sFKsZez lA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3p439tabwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 03:26:53 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 03:26:52 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 6 Mar 2023 03:26:52 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 18BCD11D3;
        Mon,  6 Mar 2023 09:26:52 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:26:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: Re: [PATCH v2 4/5] ASoC: cs35l45: DSP Support
Message-ID: <20230306092652.GP68926@ediswmail.ad.cirrus.com>
References: <20230303192151.2437221-1-vkarpovi@opensource.cirrus.com>
 <20230303192151.2437221-4-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303192151.2437221-4-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: u6TL_NqWZk8T0ATfLPsOJ8WtEENrHZ7l
X-Proofpoint-ORIG-GUID: u6TL_NqWZk8T0ATfLPsOJ8WtEENrHZ7l
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:21:50PM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
> 
> The CS35L45 digital core incorporates one programmable DSP block,
> capable of running a wide range of audio enhancement and speaker
> and battery protection functions.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---
> +#define CS35L45_DAC_MUX_ROUTE(name) \
> +	{ name" Source", "ASP_RX1",	"ASP_RX1" }, \
> +	{ name" Source", "ASP_RX2",	"ASP_RX2" }, \
> +	{ name" Source", "DSP_TX1",	"DSP1" }, \
> +	{ name" Source", "DSP_TX2",	"DSP1" }
> +
> +

Minor nit, double blank line here.

But otherwise looks pretty good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
