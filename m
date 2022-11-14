Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213C6281E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiKNOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiKNOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:03:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E3281;
        Mon, 14 Nov 2022 06:03:55 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE6ooPs022105;
        Mon, 14 Nov 2022 08:03:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=t583yCUxBfzf1Dg5jBjgR4aUpBmZowQJ0TdvL+MzYNo=;
 b=I+e8itw5KiLzfoEDbUppm2NpOirg8ySGHk+uD4i6gPxYe/49AaYEwzaptY9r/niJ4ZoW
 BNdRn4H6K4HQaFzj5pX9jTewdFxC8CjrcAvXWSf/tVEWdryExdYsu1BWxVmAvBMxTfgc
 aoPmhOVvvEXbBEKRYG4M/m3E6WgzzLs/VrGiSX8sPBAyADTLWyMd0KONUXL+LC6aAePg
 703MFWueCzDsOExkeK7xGEcngkArBnTHfeLgB56NmR1o1gMxSi3ETp/F5YQXCUzkx6+K
 5//IaI51GQgDhMxsMiVgAo9Fx1O+pE2VMxTfPyQLMRj/UVEVUhA1/whK0GHrPXzUrZum IQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kt9s6t7ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:03:45 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 14 Nov
 2022 08:03:43 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Mon, 14 Nov 2022 08:03:43 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 745CF477;
        Mon, 14 Nov 2022 14:03:43 +0000 (UTC)
Date:   Mon, 14 Nov 2022 14:03:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
CC:     <sre@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-usb@vger.kernel.org>,
        <tony@atomide.com>
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
Message-ID: <20221114140343.GK10437@ediswmail.ad.cirrus.com>
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: cmKzLE6Lfegq3NqPQ0SSq_Ydm77YE3Lh
X-Proofpoint-ORIG-GUID: cmKzLE6Lfegq3NqPQ0SSq_Ydm77YE3Lh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
> usb_phy::notifier is already used by various PHY drivers (including
> phy_generic) to report VBUS status changes and its usage conflicts with
> charger current limit changes reporting.
> 
> Fix that by introducing a second notifier that is dedicated to usb charger
> notifications. Add usb_charger_XXX_notifier functions. Fix charger drivers
> that currently (ab)use usb_XXX_notifier() to use the new API.
> 
> Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/power/supply/wm831x_power.c   |  7 ++++---

For the changes to wm831x looks fine to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
