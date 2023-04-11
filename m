Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151896DD1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDKFbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKFbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:31:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CF1BF7;
        Mon, 10 Apr 2023 22:31:07 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4AXWl008192;
        Tue, 11 Apr 2023 05:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Qh7i/6UPVa9oSp61OPGQ5X/b9iECb5umhdviZt8OscM=;
 b=RQbpHJ156GrJcEeejCfYCzWC21RIssj/rPa8+g82EPYplu+n7q3FONj/VKxXtaBV9kcA
 Zlrs4otQONO+OSoqHOw7k95EaPInMqJMs5n6aJc+Qp2oNwQX0aQQvwjagIm4KjoRuUrB
 mS7sa4Mis5WlBfX2K+YhpY9OuQ8Zm4hZfElENKrLA0f+XtYJd3NfQKPdlGdIvT3HY0QI
 1kbcaEwMfKfP6/LlpbS3GJ8rPKcO50jVzHSb43qnHU1lQnpI/wVisujr0jRpiwBerVdB
 XDqKMrK4LKw46V0JFsDa4/cW0Y7+P/n2brH1zltVaXV+5AhQ3aWKfXtpc0nX38MOJt6t Vg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvmb3hhq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 05:30:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33B5Uv42020828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 05:30:57 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 22:30:54 -0700
Date:   Tue, 11 Apr 2023 11:00:50 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix test_resume failure by openning swap device
 non-exclusively
Message-ID: <20230411053050.GA4099424@hu-pkondeti-hyd.qualcomm.com>
References: <cover.1681186310.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1681186310.git.yu.c.chen@intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IqrAYJ8pFJxLV_OXcWh9oDqdYd4e-3Gx
X-Proofpoint-ORIG-GUID: IqrAYJ8pFJxLV_OXcWh9oDqdYd4e-3Gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_02,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=828 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110050
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:18:43PM +0800, Chen Yu wrote:
> test_resume does not work in current kernel when using swapfile for hibernation.
> This is because the swap device should be openned non-exclusively in test_resume mode.
> 
> Patch 1 is a preparation for patch 2 and it turns snapshot_test into a global variable.
> Patch 2 opens swap device non-exclusively for test_resume mode, and exclusively for manual
> hibernation resume.
> 
> Change since v1:
> Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
> nor load_image_and_restore().
> 
> 
> Chen Yu (2):
>   PM: hibernate: Turn snapshot_test into global variable
>   PM: hibernate: Do not get block device exclusively in test_resume mode
> 
>  kernel/power/hibernate.c | 12 +++++++++---
>  kernel/power/power.h     |  1 +
>  kernel/power/swap.c      |  5 +++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
Looks good to me.

I have verified test_resume on QEMU arm64 and it worked fine with
these two patches included.

Thanks,
Pavan
