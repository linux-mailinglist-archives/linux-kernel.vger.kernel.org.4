Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188866AB9A5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCFJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:22:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB623103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:22:40 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3265HHFB032633;
        Mon, 6 Mar 2023 03:22:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=25P+xMRcCTAydVHeS++PJrEDucjELxBxfa6hv3Q1AUY=;
 b=AmM18T6lclpx16HfEhzJpEAIxTCdH85rOOgKPm7WPsaBn+UWcFK9yvfi9lcnci9ArUDf
 h2fRU7aReer5YktEZVqYEkik2acraU/P7YINVntLmaJCd+IBx0pHfMLg7s9sA5z7nUJb
 fsGZqvMO0sB2RUIoe+S+/dt+H/6oAjy4y+6S1LlPIfk7OtE++EiiOXL4+S3ZJqDZ0zCO
 Bod6a3/BGsDalRGQQyMLy9jI4lFA1icvo1+vYcVa9zefD/5FobGu1kC342q30NJN//5v
 CNFDK/EqbRAIrp7sCqQMAZU/wENCt83LNmE3PeHlj7FfYf2EOUCkt5G1qYK4U1wKj1pV ng== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3p439tabsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 03:22:30 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 03:22:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 6 Mar 2023 03:22:28 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 615EA458;
        Mon,  6 Mar 2023 09:22:28 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:22:28 +0000
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
Subject: Re: [PATCH v2 3/5] ASoC: cs35l45: IRQ support
Message-ID: <20230306092228.GO68926@ediswmail.ad.cirrus.com>
References: <20230303192151.2437221-1-vkarpovi@opensource.cirrus.com>
 <20230303192151.2437221-3-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303192151.2437221-3-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ujTC8BSxs-GuqPhhpwTt-ckuaWD3Pbnz
X-Proofpoint-ORIG-GUID: ujTC8BSxs-GuqPhhpwTt-ckuaWD3Pbnz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:21:49PM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
> 
> Adds IRQ handlers
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
