Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6D682B15
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAaLDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjAaLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:03:18 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBC3C12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:03:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V5icZS020816;
        Tue, 31 Jan 2023 05:03:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=9Je/JGcAqVqBec9JIWxD28hiF0b7sSvMarOTsZeOI0E=;
 b=n7rmD41S3zZpFYfvGkkgx1H/T5dDFxxUbAL/rrrpCyEq/g+IDjHga2tuLh24fkmI9jt6
 Qn1jiYykzUEEJkYFiF4MMLRUCXsL3o66tLzVafmYOfD4guASTTCeSRnB6kGilXx3rNwv
 nJtQ2QSOKLDjIK+eZcamAzTPbUyBE8+M1qcmXjtF2+wrvgGiZmHz+0lWySrhI56fOYBb
 uxjVzxbp1gDiIPiAhL64mW5WgxPKPav6eqh03nd0k+pSt/MIkROfOg/wI61/DP48xyOg
 fQ2bpFhJAc6ttc2jkO1yQ0MH6kY34tbOY5Ig/Zi2lCdy6SopqjvsdteGCplc81Wdd3fM xw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nd10t4x3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:03:09 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 31 Jan
 2023 05:03:08 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Tue, 31 Jan 2023 05:03:08 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2F96D2A1;
        Tue, 31 Jan 2023 11:03:08 +0000 (UTC)
Message-ID: <cb52e4cf-47d8-33be-f77d-fc2d0b868a5c@opensource.cirrus.com>
Date:   Tue, 31 Jan 2023 11:03:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 8/8] ASoC: cs42l42: Wait for debounce interval after
 resume
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-9-sbinding@opensource.cirrus.com>
 <1e5e1312-18f5-e70f-3237-c2ffc851eef7@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <1e5e1312-18f5-e70f-3237-c2ffc851eef7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rCa9VOVGCZsLmOQggf8O0Ayx6BVgYnZv
X-Proofpoint-ORIG-GUID: rCa9VOVGCZsLmOQggf8O0Ayx6BVgYnZv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 16:45, Pierre-Louis Bossart wrote:
> 
> 
> On 1/27/23 10:51, Stefan Binding wrote:
>> Since clock stop causes bus reset on Intel controllers, we need
> 
> nit-pick: It's more that the Intel controller has a power optimization
> where the context is lost when stopping the clock, which requires a bus
> reset and full re-enumeration/initialization when the clock resumes.
> 

Ok, it's true that clock stop doesn't _cause_ bus reset, bus reset is
necessary when exiting clock stop. We can re-word if you want us to
describe that accurately.

But from the codec driver's point of view, a clock stop causes a bus
reset.

> The rest of the patch is fine so
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
>> to wait for the debounce interval on resume, to ensure all the
>> interrupt status registers are set correctly.
>>
>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
