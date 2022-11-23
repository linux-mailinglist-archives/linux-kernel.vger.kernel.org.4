Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10CC63572C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiKWJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiKWJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:38:23 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7E64570
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:36:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN7bePZ029400;
        Wed, 23 Nov 2022 03:35:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wHed+5qsoNRfgm5HzbV5rq5eqU2Eoij756sk0MFjYTc=;
 b=lMrWZLPDNBeOKrD9JKdE87iemvauRqrpbUbZsVfxThc2+2bdU2sVMDkmYSQ1Di9tYQ4i
 EPFHKea5tGRK9e3yJdv/Q9Z3lgIaR/GTmwFAYjrAimhB5QRbKf5da+UpJzvWswEEFcj7
 E+ynamyYDaRkR4ja5p4WofhRsY7q1JjTjaYh36nqNdmOdOF0K/Gv3KTHiOuBhXxp2qRG
 U8l1XCwOD8GQx7AiSHSHW13J/jDjlzALLaByAycm7glZvugxSmeHXo1bdsq/jZoY02Dr
 demBpFz0dZ8dJXCtGAfaGb5Kj99RjwdROrDiUFxU36WTL91SRqp9dELO0DkVsqsvEQGo jQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6vpa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 03:35:55 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 03:35:47 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 03:35:47 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EE11477;
        Wed, 23 Nov 2022 09:35:47 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:35:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: bus_type: Avoid lockdep assert in
 sdw_drv_probe()
Message-ID: <20221123093547.GC105268@ediswmail.ad.cirrus.com>
References: <20221121162453.1834170-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221121162453.1834170-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: iGXtesuZiytKFN4IDNvRloRAlC8H0Xi2
X-Proofpoint-GUID: iGXtesuZiytKFN4IDNvRloRAlC8H0Xi2
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 04:24:52PM +0000, Richard Fitzgerald wrote:
> Don't hold sdw_dev_lock while calling the peripheral driver
> probe() and remove() callbacks.
> 
> Holding sdw_dev_lock around the probe() and remove() calls
> causes a theoretical mutex inversion which lockdep will
> assert on. The peripheral driver probe will probably register
> a soundcard, which will take ALSA and ASoC locks. During
> normal operation a runtime resume suspend can be triggered
> while these locks are held and will then take sdw_dev_lock.
> 
> It's not necessary to hold sdw_dev_lock when calling the
> probe() and remove(), it is only used to prevent the bus core
> calling the driver callbacks if there isn't a driver or the
> driver is removing.
> 
> If sdw_dev_lock is held while setting and clearing the
> 'probed' flag this is sufficient to guarantee the safety of
> callback functions.
> 
> The potential race of a bus event happening while probe() is
> executing is the same as the existing race of the bus event
> handler taking the mutex first and processing the event
> before probe() can run. In both cases the event has already
> happened before the driver is probed and ready to accept
> callbacks.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
