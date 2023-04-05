Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DC6D74EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjDEHDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjDEHDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:03:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE6E4236;
        Wed,  5 Apr 2023 00:03:31 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335501AT015527;
        Wed, 5 Apr 2023 07:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=S0fOVQGa8HK2CQebgtyq+zFfh6JfAIWUBzURPHKnMKQ=;
 b=NP9o+jkXa0/CnwYR8Gk/PJL+QiEwjv/CqsBTyFvKMdSkgeRWwkv4SkRAk2gw0ZCvjmC+
 R5xamcR8zXKCAP2mjiL9fPXpJb5wWmTTzfZL0XXkN77PIZOEJmrcZU1fHRmYyNbKvppY
 ZBciQ8fhfa6kCMpw1oT96ODH2NHfNmKKtjoiyXhMbi7uh3bMVg8iUtyFZ4z/kvOSAImi
 L5EW6TAz88To0gKcpe7nVpqMIU+W5wGWsyNHOePxMAXLfWxYHMmcceP9YigTyIGldht2
 +/yseBWeMr2Dm7hvLeK5Sk1quPbJRbnP2uIo/TRhf4osn0CGDT8RLkoh0upMXSsBrZWz Qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prgvetyhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 07:02:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33572uE4011670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 07:02:56 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 00:02:52 -0700
Date:   Wed, 5 Apr 2023 12:32:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Ye Bin <yebin10@huawei.com>,
        Nikhil V <quic_nprakash@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Get test_resume hibernation mode working
 again
Message-ID: <20230405070248.GA721439@hu-pkondeti-hyd.qualcomm.com>
References: <20230405034502.583304-1-quic_pkondeti@quicinc.com>
 <ZCz8V1zwFtoTHCfK@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCz8V1zwFtoTHCfK@chenyu5-mobl1>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tNtCNJisWK7Anh5FBrCdCynfByOSVqtv
X-Proofpoint-GUID: tNtCNJisWK7Anh5FBrCdCynfByOSVqtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=708
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050064
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:43:03PM +0800, Chen Yu wrote:
> Hi Pavankumar,
> On 2023-04-05 at 09:15:02 +0530, Pavankumar Kondeti wrote:
> > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
> > swsusp_check()") changed the opening mode of the block device to
> > (FMODE_READ | FMODE_EXCL) during resume. This breaks the test_resume
> > hibernation mode as the block device is not available for exclusive
> > open. Because the block device is configured as swap during hibernation.
> > 
> > Fix this issue by opening the device in FMODE_READ only in test_resume
> > restore path. Cache the flags used in opening the block device so that
> > callers of swsusp_close() does not need to worry about test_resume vs
> > normal restore.
> > 
> > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >  kernel/power/hibernate.c | 21 +++++++++++-----
> >  kernel/power/power.h     |  4 +--
> >  kernel/power/swap.c      | 53 +++++++++++++++++++++++-----------------
> >  3 files changed, 48 insertions(+), 30 deletions(-)
> >
> Thanks for taking a look at this, would the following fix make sense?
> https://lore.kernel.org/lkml/20230401165540.322665-1-yu.c.chen@intel.com/
> 

Thanks Chenyu for pointing it out.

Yes, your patch works. It looks good also. I left a minor comment. You
can probably clarify what "safe" means there either by a comment or
changing the variable name. I also left an alternative approach, I initially
started with.

Thanks,
Pavan
