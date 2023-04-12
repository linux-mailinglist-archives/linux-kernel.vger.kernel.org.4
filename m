Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536836DEAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDLEhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDLEg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:36:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4C2136;
        Tue, 11 Apr 2023 21:36:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C2ufrU020115;
        Wed, 12 Apr 2023 04:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Xk0khVy6a4qTeHDLGV91RRu5Ak5YDt5Eu2EBEvej6dM=;
 b=EqWx1QrKuSeZyEfS0nNbHhegW3hGzvavZRLB72Eq/9hQl4U70pkdpjl7jKxzxGAlbpFc
 KUzPvxfhDHYGwisVAjf1VvLxILMn0rpQ3Ab1W7ybMNLQfZT8wESAquVO6KCzbV0w0XR4
 l/t7m4XFot+xP7gtcTlvZGab0KPKqQZaUfGONZAPo7B788z7D8JYVh2vO0jhYW0pRC3T
 N/hWWJQEc3bDsZzAOOrb0LUnZfad5g2z5QQuYbxNikpKnyv7HMp6nf29/PCDjA0OczKY
 RLskrrOhB6z2kIzeg8nMMQTOmJ4tL2sx+350iHoq3Z2fl7Ny8odiP23vhnLTf7aaKWiZ bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwe5j8rss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 04:36:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33C4ai48001890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 04:36:44 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 11 Apr 2023 21:36:42 -0700
Date:   Wed, 12 Apr 2023 10:06:38 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix test_resume failure by openning swap device
 non-exclusively
Message-ID: <20230412043638.GB4099424@hu-pkondeti-hyd.qualcomm.com>
References: <cover.1681186310.git.yu.c.chen@intel.com>
 <20230411053050.GA4099424@hu-pkondeti-hyd.qualcomm.com>
 <ZDYF0xjpz7+b/Rmj@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDYF0xjpz7+b/Rmj@chenyu5-mobl1>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cOlUaYsqxGM_Sxp1zkcRQeTs8K0vA5ZY
X-Proofpoint-ORIG-GUID: cOlUaYsqxGM_Sxp1zkcRQeTs8K0vA5ZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 mlxlogscore=774
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:13:55AM +0800, Chen Yu wrote:
> On 2023-04-11 at 11:00:50 +0530, Pavan Kondeti wrote:
> > On Tue, Apr 11, 2023 at 08:18:43PM +0800, Chen Yu wrote:
> > > test_resume does not work in current kernel when using swapfile for hibernation.
> > > This is because the swap device should be openned non-exclusively in test_resume mode.
> > > 
> > > Patch 1 is a preparation for patch 2 and it turns snapshot_test into a global variable.
> > > Patch 2 opens swap device non-exclusively for test_resume mode, and exclusively for manual
> > > hibernation resume.
> > > 
> > > Change since v1:
> > > Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
> > > nor load_image_and_restore().
> > > 
> > > 
> > > Chen Yu (2):
> > >   PM: hibernate: Turn snapshot_test into global variable
> > >   PM: hibernate: Do not get block device exclusively in test_resume mode
> > > 
> > >  kernel/power/hibernate.c | 12 +++++++++---
> > >  kernel/power/power.h     |  1 +
> > >  kernel/power/swap.c      |  5 +++--
> > >  3 files changed, 13 insertions(+), 5 deletions(-)
> > > 
> > Looks good to me.
> > 
> > I have verified test_resume on QEMU arm64 and it worked fine with
> > these two patches included.
> >
> Thanks, can I add your Tested-by tag?
> 
Sure. Pls add 

Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Thanks,
Pavan
