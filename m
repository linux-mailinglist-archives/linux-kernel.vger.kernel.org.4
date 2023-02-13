Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39236942C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBMKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjBMKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:22:53 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EE2739;
        Mon, 13 Feb 2023 02:22:51 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8cDgK018599;
        Mon, 13 Feb 2023 04:22:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=WmTxnrtas4FxyKYUXIiNzvVIg6UVb3xuByCPXTtKw/A=;
 b=QmKUCHgI48UwX0gnY7AxjGfWcIY+YVZjxECRnfjtV1keSNy6eHFEl//fIpIVK9TZfLDw
 4P0okHxiiM53hvW7WQjqISnHMZkO8T1HSq1Cx4wlNGuFqcJbAjcslKRcerp8ZJydKSBu
 ubNv40SqK+6oYP2CQManTYb+gZ90p5KLojBdp5GuRUCKFt6iUCwlb57SbsK9y9BLibS9
 TZqAmc8zNdzHuejRM3kreh+F9TZ3t1DvMGjITEQadAlGMZITLrVnPiZ0LOjGTsV+JCG9
 BW8w98TEmYHtWvCbDI0ZY4AawS6eCLFfn7P9/I9yWuXX1vhpm9E0n5TUhk7UOsylkCSH /g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3np8att3yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 04:22:23 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 04:22:21 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Mon, 13 Feb 2023 04:22:21 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC4C011AA;
        Mon, 13 Feb 2023 10:22:21 +0000 (UTC)
Date:   Mon, 13 Feb 2023 10:22:21 +0000
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
Subject: Re: [PATCH v5 3/4] ALSA: cs35l41: Add shared boost feature
Message-ID: <20230213102221.GH68926@ediswmail.ad.cirrus.com>
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
 <20230210134341.GF68926@ediswmail.ad.cirrus.com>
 <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
 <20230211170638.GG68926@ediswmail.ad.cirrus.com>
 <1e3ef067-9b39-dc19-5fbc-75436c67f206@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e3ef067-9b39-dc19-5fbc-75436c67f206@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: dlH4lLI6ybbsohT-AgI4bUsSjcs2XAVH
X-Proofpoint-ORIG-GUID: dlH4lLI6ybbsohT-AgI4bUsSjcs2XAVH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 09:28:39AM +0000, Lucas Tanure wrote:
> On 11-02-2023 17:06, Charles Keepax wrote:
> >On Fri, Feb 10, 2023 at 02:39:56PM +0000, Lucas Tanure wrote:
> >>On 10-02-2023 13:43, Charles Keepax wrote:
> >>>On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
> Ok, but the other side doesn't have both RX and TX enabled.
> If the active side needed RX to receive information for the other
> side, the passive one would need TX enabled too.
> So if a feedback is necessary, both channels on both sides would be
> enabled, not one channel in one side and both on the other.

A very good point :-)

> >"When powering up a second (and each subsequent) CS35L41B onto a
> >shared MDSYNC bus, the following protocol must
> >be followed"
> >
> >But very unclear if that sequence should be followed on only the
> >new device, the master device, or on all devices. I will try to
> >find some time to chase some apps guys next week see if anyone
> >has any ideas.
> I had long talks with apps guys on this when I was at Cirrus.
> And my understanding is:
> A new CS35L41 can misunderstand the information on MDSYNC bus if a
> communication is already in place, between another pair of CS35L41,
> so to avoid that, any CS35L41 being turn on in a already active
> MDSYNC bus, must execute those steps.

Ok so that implies we are ok, since that suggests we are
saying that only the new amp to the bus needs to execute the
sequence, not the amps already on the bus.

> We could move the active amp up in DAPM graph so its enabled before
> all passive ones, but we would still need to execute that for all
> passive amps. So there is not much point in that.

Agree, fine as is.

> 
> Here I can see that if I enable SYNC_EN during probe without clocks
> the device becomes unresponsive, at least with the current code.
> So following the datasheet and enabling SYNC_EN only after clocks
> seems to resolve Steam decks issue.
> 
> Questions I never got an answer from APPS guys:
> 
> - Can we enable SYNC_EN during probe if we know there is no playback
> happening, no clocks and Global enable off? Steam decks seem to
> answer no here. If yes, why having pm_runtime features makes the
> device become unresponsive?
> 
> - Can we leave SYNC_EN enabled during Global enable off and no clocks?

These two I think are not too much of a concern, turning sync on as
part of powering up the amps doesn't seem to be a big concern,
its not a lot of writes.

> - If SYNC_EN is enabled and we only set Global enable on after the
> PLL lock happened, do we still need to execute those steps? I mean,
> if the driver only deals with Global enable and leaves shared boost
> configured since boost, will MDSYNC bus work?

Yeah I think here it is also probably safer to just do it anyway.

I would still like David to do a quick review, unfortunately he
is off at the moment but should be back Monday next week. But
from my side I think this is probably all good:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
