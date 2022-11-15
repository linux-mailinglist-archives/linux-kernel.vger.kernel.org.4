Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAA6296C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiKOLHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiKOLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:06:40 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9527B2B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:05:36 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF7rHTp020835;
        Tue, 15 Nov 2022 05:05:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=2x2KTIo3F9QQ0/tOccOJnv6JdTKJV/3DthcEWssm0Ho=;
 b=L2d+s6PVoTVuroXBYRCmzkcJuZVgfyVLo9/UwQ4I/KwGp5dLmwp4FURSp4jd208/cX/v
 +oy0WYgtbLzff+Q91hIZLWl32jeXAkdIZofG6lWK6S2Z1hJue48tBKFDvr58Ul/oXcdo
 uhU2W1wquzHrKPCvMaUtKfJl6Mm+Op/FMidlaAR5I9rDdzWsdi30OdEbxEpkWenYb6Bz
 yQOhn8LPw5bHjuV1WRA+tRrFRZ7C6ox9X7K3XtMA72rNZqATlCC0kcKPNXiXVLPFfKxQ
 gaIG6mkfdVlfmUlp7Hf6TBRWIGp0iPW2R6lgbdhOT+z4rPmmgfhpoidTaTvpWx7irSXV rQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kv6s7r5rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 05:05:22 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 15 Nov
 2022 05:05:20 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Tue, 15 Nov 2022 05:05:20 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8179646B;
        Tue, 15 Nov 2022 11:05:20 +0000 (UTC)
Date:   Tue, 15 Nov 2022 11:05:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <sanyog.r.kale@intel.com>, <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 4/4] soundwire: stream: Move remaining register accesses
 over to no_pm
Message-ID: <20221115110520.GN10437@ediswmail.ad.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-5-ckeepax@opensource.cirrus.com>
 <9d701845-7ad1-046c-b7c2-dd2a131212c8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d701845-7ad1-046c-b7c2-dd2a131212c8@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 2S5Z971K2I_ceiIg4jLzNBFZ4UNi9K9B
X-Proofpoint-GUID: 2S5Z971K2I_ceiIg4jLzNBFZ4UNi9K9B
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:04:55AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> On 11/14/22 04:29, Charles Keepax wrote:
> > There is no need to play with the runtime reference everytime a register
> > is accessed. All the remaining "pm" style register accesses trace back
> > to 4 functions:
> > 
> > sdw_prepare_stream
> > sdw_deprepare_stream
> > sdw_enable_stream
> > sdw_disable_stream
> > 
> > Any sensible implementation will need to hold a runtime reference
> > across all those functions, it makes no sense to be allowing the
> > device/bus to suspend whilst streams are being prepared/enabled. And
> > certainly in the case of the all existing users, they all call these
> > functions from hw_params/prepare/trigger/hw_free callbacks in ALSA,
> > which will have already runtime resumed all the audio devices
> > associated during the open callback.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> I tend to agree with this one, and if this ever fails that would point
> to a miss at a higher-level we'd need to address.

Exactly my concern here is the core is trying to be helpful, but
really it is just going to be hiding bugs in the callers.

Thanks,
Charles
