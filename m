Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1B629586
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKOKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiKOKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:14:58 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D917E2E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:14:52 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8Hj8c031896;
        Tue, 15 Nov 2022 04:14:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=s1Qw8uKWDXVG3mn+1lbe8MUKFNzigWkLGZ+Sj9Y4uZM=;
 b=lYybNmBawgPOfP+6sap0zx5MEO17FZkXuCwbrwZVOGB4toQ5igr+8ErNcMedw5MPI/mb
 tH3NXV0+f2qkRAYzb44RvGovqUT5QucJbzYcGsAx0ehfYnpSJyCn3pV8qDi0MHZzWGIW
 +SLEamTtBUVVQyNiM0ylCTXfHNXNR7C4hrReD/vUXLntIIh9nxCz4X1EsCDX1ikSCVnQ
 7G80ljdcAGj49a+EqVp54EobbBgI2QlvRmXIODbTXPRUXVNTatB26tNdPi0xYY+DDyLM
 KpqX60M5kqTWXJM6i1je7553cEeMobexE7gRANolU+12kTV5LTc5qTpRDC3VNoDkb5Wu xg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kv73yg398-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 04:14:43 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 15 Nov
 2022 04:14:41 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Tue, 15 Nov 2022 04:14:41 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6FEB5B12;
        Tue, 15 Nov 2022 10:14:41 +0000 (UTC)
Date:   Tue, 15 Nov 2022 10:14:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
Message-ID: <20221115101441.GL10437@ediswmail.ad.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
 <bbc432e7-c52f-7e35-03d1-401cb68501cb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bbc432e7-c52f-7e35-03d1-401cb68501cb@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: _R82frNhOQOY7HML5SsZmlzICTjlQfby
X-Proofpoint-GUID: _R82frNhOQOY7HML5SsZmlzICTjlQfby
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:14:19AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> On 11/14/22 04:29, Charles Keepax wrote:
> > It is rather inefficient to be constantly enabling/disabling the PM
> > runtime as we print out each individual register, switch to holding a PM
> > runtime reference across the whole register output.
> 
> the change is good, but technically the pm_runtime resume happens for
> the first read and suspend with a delay if use_autosuspend() is enabled,
> so presumably we'll see the same number of resume/suspend with the
> existing code and the suggested change.
> 
> Maybe update the commit message to mention that we constantly change
> reference counts, as you did in the next patch?

Yeah agree, I will respin the commit message.

Thanks,
Charles
