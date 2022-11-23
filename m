Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650D36356F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiKWJhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiKWJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:36:37 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FEC4C3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:34:03 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN6wMto030293;
        Wed, 23 Nov 2022 03:33:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=m6sZqZu8DE0JOM+DEU5I47tkDmeAPj54tBuAsnifHLI=;
 b=B5MFmusVOSPUOipkGpbkzKYiDHNiX+J9kJGRbLEnHcuOSm005ElGIhlhKNVbDB4Sc0/V
 Nh1mBDjhB8VxK/Ga6hPPhZnOaDQ+CatBkCfCNKsDHH1fslge1fvrIax4d4c5sTvQ5cb/
 /L1Azm4IQUkLLAKFoxlgVopDxK0KAH0znpag/aO+fgPBCcpTsrUC5TezBl+9oudJTJ3d
 QSJS/JBxYCV7d90vzI03TcRty3C6GV88Hbh0mzIRPmukV+QBj3boUReVBVt3FXRViugz
 3o4wy47hsakqgvojHNWGe/UzX92iSQ/9OIFwtdJTnm+5Fgh353of3Vt4Ki1HuLTmim7D vQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6vp7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 03:33:47 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 03:33:45 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 03:33:45 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1A46F2BA;
        Wed, 23 Nov 2022 09:33:45 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:33:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     <broonie@kernel.org>, <tiwai@suse.de>,
        <alsa-devel@alsa-project.org>, <vinod.koul@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>, <vkoul@kernel.org>,
        <peter.ujfalusi@linux.intel.com>, <bard.liao@intel.com>
Subject: Re: [PATCH v2 2/2] soundwire: enable optional clock registers for
 SoundWire 1.2 devices
Message-ID: <20221123093345.GB105268@ediswmail.ad.cirrus.com>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118025807.534863-3-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: pfEt5VDAONvi441qWvEOxEi_eMzeJgPv
X-Proofpoint-GUID: pfEt5VDAONvi441qWvEOxEi_eMzeJgPv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:58:07AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The bus supports the mandatory clock registers for SDCA devices, these
> registers can also be optionally supported by SoundWire 1.2 devices
> that don't follow the SDCA class specification.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
