Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9230468EC51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjBHKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjBHKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:04:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB94535BB;
        Wed,  8 Feb 2023 02:04:03 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3187LPHk011275;
        Wed, 8 Feb 2023 04:03:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=orPW6Tl0jOf9S97zbcY2T9FCO8LqYdndxqeT8o3kDNM=;
 b=STUJB066a2wfI44JZ73/nECnTl+bwj87qsy1/uy2EXjJd5Q5ONMlLqjYphFt+kF2LHBL
 g3ELvrui8HRmbr9vp+Lh4i972hrQ8zySLJyUG9+g1kqDrzFn/AwCBv+hawNOixJ9M6Zy
 R79gk8BcVt193hl+WyzUHbBTmvWscWO974KHWznbJP5SRVduH2bYitQ09n2XZkYaxvxO
 2u8X0Ku1jhSuU22Obih6Mbw5e1Wniddqfe9GFWeozAdUae0pb78Gh6oV6hTOnpACF3jj
 8Ia9wDcYRM6SvatWPYZ2HDsLxu3x/xdCvcRLEfuQv9ZK3OIsrhTUx0lLtPZLbzEFbMWq GQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nhnn7wsp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 04:03:38 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 8 Feb
 2023 04:03:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 8 Feb 2023 04:03:36 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4267BB1A;
        Wed,  8 Feb 2023 10:03:36 +0000 (UTC)
Date:   Wed, 8 Feb 2023 10:03:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>
CC:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v2 2/5] ASoC: cs35l41: Refactor error release code
Message-ID: <20230208100336.GE36097@ediswmail.ad.cirrus.com>
References: <20230207162526.1024286-1-lucas.tanure@collabora.com>
 <20230207162526.1024286-3-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230207162526.1024286-3-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: TVxCZn1sGUXj3iK7Cs_MDYb5k1X8hZ9w
X-Proofpoint-ORIG-GUID: TVxCZn1sGUXj3iK7Cs_MDYb5k1X8hZ9w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:25:23PM +0000, Lucas Tanure wrote:
> Add cs35l41_error_release function to handle
> error release sequences.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
