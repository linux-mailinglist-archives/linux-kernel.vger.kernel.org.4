Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E26932C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBKRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:07:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B02B1114E;
        Sat, 11 Feb 2023 09:07:09 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31BGwQTu025214;
        Sat, 11 Feb 2023 11:06:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aWsBvrmRXrrAQSl7t4LwL7zaKtBdqugkGyOWdPd24L4=;
 b=laJPKcShb4/NmvGCHz2pH7g4t+A/y1MthPxztUWUkknhwshkJuvy+JrqRDsaL3LBEGPI
 Mee2s/g2/qh+wLEdZSNC8apmqQ3Qs+vlGnRQMcenMXM1+oMXu6FO51QgrEs6WPBiSVzR
 eJb2L0Xbkod7oC++RJOtGBdVWQKN+rVl9aCVcJFkQe+BJc0GV49BWSci8fzOEBDm/+xx
 KAREmHUcPyAjUOkZhPeVIeyw6zh/6GMn23jXSOSYddyomvW+zvEDXVUmsby2q7mXPQat
 ELsZTMwpGGk5JrVpUXAlDoNDdZJWoyWavVUywlLXZ36SoskVgRAfUtj+8/Y9uyoR2ft7 ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3np8atrb4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 11:06:40 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Sat, 11 Feb
 2023 11:06:39 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Sat, 11 Feb 2023 11:06:39 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E022811AB;
        Sat, 11 Feb 2023 17:06:38 +0000 (UTC)
Date:   Sat, 11 Feb 2023 17:06:38 +0000
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
Message-ID: <20230211170638.GG68926@ediswmail.ad.cirrus.com>
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
 <20230210134341.GF68926@ediswmail.ad.cirrus.com>
 <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: uWKbibV57kTLk2ZW6T0h6bjtA0uYAsMn
X-Proofpoint-ORIG-GUID: uWKbibV57kTLk2ZW6T0h6bjtA0uYAsMn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 02:39:56PM +0000, Lucas Tanure wrote:
> On 10-02-2023 13:43, Charles Keepax wrote:
> >On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
> >>+	{CS35L41_MDSYNC_EN,        0x00001000},
> >David's internal patch appears to set 0x3000 on the active side,
> >not sure where that difference snuck in, or which is the correct
> >value. Your settings appear to make logical sense to me though, TX
> >on the active side, RX on the passive side.
> And as the patch sets TX and RX in the same chip I changed to follow
> the documentation.

Yeah I mean I suspect this is sensible, unless there is some
reason the controller side also needs to have RX enabled. Perhaps
for feedback or something from the passive side, but I imagine
this is just a typo in the original patch.

> >>+	/* BST_CTL_SEL = CLASSH */
> >>+	{CS35L41_BSTCVRT_VCTRL2,    0x00000001},
> >BST_CTL_SEL is in BSTCVRT_VCTRL1 (or BOOST_VOLTAGE_CFG, as it
> >is called in the datasheet, yay us for using the same names).
> >That does not mean this write is wrong, could just be the
> >comment, but what this does write is a bit odd so I would like
> >David to confirm this isn't some typo in his original patch.
> I can't find BOOST_VOLTAGE_CFG on my datasheet, but BST_CTL_SEL is
> at 0x00003804 ( BSTCVRT_VCTRL2 / VBST_CTL_2 ).
> This write here is to select the boost control source, which for the
> active should be "Class H tracking value".
> So I still think this is correct.

Yeah this one is a mistake on my part, I was reviewing some
patches on another amp just before I think I have looked at the
wrong datasheet here. You are correct those bits are infact
BST_CTL_SEL. So ignore this one.

> >>+		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
> >>+		regmap_read(regmap, CS35L41_GPIO_PAD_CONTROL, &pad_control);
> >>+
> >>+		pwr_ctrl3 &= ~CS35L41_SYNC_EN_MASK;
> >>+		pwr_ctrl1 = enable << CS35L41_GLOBAL_EN_SHIFT;
> >
> >Are you sure this is what you want? In the case of powering up,
> >the sequence would end up being:
> >
> >mdsync_down
> >  -> sets GLOBAL_EN on
> >mdsync_up
> >  -> sets GLOBAL_EN off
> >  -> sets GLOBAL_EN on
> >
> >Feels like mdsync_down should always turn global_enable off? But
> >again I don't know for sure. But then I guess why is there the
> >extra write to turn it off in mdsync_up?
> 
> For the disable case (DAPM turning everything off) SYNC and Global
> enable are off and the code hits
> 
> if (!enable)
> 	break;

Yes, so the disable flow makes perfect sense here it is the
enable flow that seemed odd.

> But for for enable case (DAPM turning everything On) the code
> continues enabling SYNC_EN, and turning off Global enable, as
> requested by
> "4.10.1 Multidevice Synchronization Enable" page 70.
> But as it is a enable path Global should be enabled again.
> 
> I can't see any sign of
> >GLOBAL_EN bouncing in David's internal patch.
> 
> Yes, but it is required by :
> "4.10.1 Multidevice Synchronization Enable" page 70.

Hmm... yes that does appear to suggest bouncing the global
enable. Kinda weird, I can't help but wonder if the turning
global enable off is actually needed, but I guess it does say
that so probably safest. It is also rather unclear on who that
sequence should be performed on it says:

"When powering up a second (and each subsequent) CS35L41B onto a
shared MDSYNC bus, the following protocol must
be followed"

But very unclear if that sequence should be followed on only the
new device, the master device, or on all devices. I will try to
find some time to chase some apps guys next week see if anyone
has any ideas.

Thanks,
Charles
