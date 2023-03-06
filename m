Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A56ABA04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCFJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCFJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:36:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8FBDE3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:36:01 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3265VMOE000378;
        Mon, 6 Mar 2023 03:35:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=AVoa7prKja+G6h0Wnu0l9jqt2+WL1wtrX2iRfjCAD+4=;
 b=o3Dm5HXF9lJSpFa8tPiMeU0geOH3PahawQjtjsgLjcBAcsK+V4EQJAGP8VIt5MPMjdNY
 0BTjh6cr6bwfMAe2vf5SrNeSebSOdg8VdJ08jWTSwxgwPvAT5YU0Jag6DLHnM8VTmMt4
 somKJXTvzULmnXElIo0kt0XUivzO2A6SH7xuquAOHDmOdh/dnBFEF7rzHsqg/4WGD2zn
 o6sqTFCmxL0c7Vj7F6/1YmvZVcCEkuwH4Caj84ML0qSnWCDjrztqZxhrDQ9Pib853OZo
 PDuarwHUvKhb+PRqLPmwuzWGhTnBCdw46e6FDjvwNUDoT3Y1HAYi748dWhBqN90K5gEY UA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3p44972b9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 03:35:39 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 03:35:37 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 6 Mar 2023 03:35:37 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8CBF5475;
        Mon,  6 Mar 2023 09:35:37 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:35:37 +0000
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
Subject: Re: [PATCH v2 5/5] ASoC: cs35l45: Hibernation support
Message-ID: <20230306093537.GQ68926@ediswmail.ad.cirrus.com>
References: <20230303192151.2437221-1-vkarpovi@opensource.cirrus.com>
 <20230303192151.2437221-5-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303192151.2437221-5-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mi9dECTXyLkzWfg3ymR3pjWPMi52khpf
X-Proofpoint-ORIG-GUID: mi9dECTXyLkzWfg3ymR3pjWPMi52khpf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:21:51PM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
> 
> Adds support for a low-power Hibernation State.
> In this state, all register contents are lost, but the contents of
> RAM are retained. In the Hibernation State, only always-on digital
> functions to support wake-up are enabled.

Yeah perhaps clarify that this relates to the DSP, something like
"Add support for a low-power hibernation state for the DSP. In
this state the DSP RAM contents are maintained, such that
firmware does not need to be re-downloaded, but the rest of the
chip's register state is lost."

But rest of it looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
