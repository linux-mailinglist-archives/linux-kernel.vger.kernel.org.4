Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17776BC3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCPCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPCVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:21:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7357093;
        Wed, 15 Mar 2023 19:21:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G24QnQ009636;
        Thu, 16 Mar 2023 02:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k0M+jgaRm8fiNJandj3KTGzc2R4sgbklH2+GpVT8zSU=;
 b=H2dEJ6tLYdIN3ralAhBV6nhx0pf+3jdNg1fClxVV0bFxAUXgCNUYay7W5oJREwzv0StC
 5qqwbcYLUUHjSEkTPhfXMt35qmE5O2M1XKHCvTTcv9o+x88gt3/DAkPMCzYDgl4bFIU1
 5CTtn7WrgQkasTzCeHTBB6Y4Cnw1cLl//mJAe/3yR5+TLqfCsZnDe8UQGbElchqDij04
 k5S634uRHgAUECYbwrtb5rYYSbIjrLOJFAq5UU+d2gk/ch/zjRohmtHKOZ6GcV+CS06C
 whVlF5rL+mMTyEOXL4CPcuTtOZUOZtrAs+6ukQiF5/bHPK5/2kdO9liCe7BYe645+SER 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbst901sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 02:21:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32G2LV0c027895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 02:21:31 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 19:21:30 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@chromium.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_vpolimer@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <marijn.suijten@somainline.org>
Subject: Re: (subset) [PATCH v4 1/4] drm/msm/dpu: clear DSPP reservations in rm release
Date:   Wed, 15 Mar 2023 19:21:21 -0700
Message-ID: <167893299308.2831.899170980846361042.b4-ty@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1676286704-818-2-git-send-email-quic_kalyant@quicinc.com>
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com> <1676286704-818-2-git-send-email-quic_kalyant@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wad776bkODmBBqORgHWrdmxRuv2jaWEl
X-Proofpoint-GUID: wad776bkODmBBqORgHWrdmxRuv2jaWEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_01,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=676 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 03:11:41 -0800, Kalyan Thota wrote:
> Clear DSPP reservations from the global state during
> rm release
> 
> 

Applied, thanks!

[1/4] drm/msm/dpu: clear DSPP reservations in rm release
      https://gitlab.freedesktop.org/drm/msm/-/commit/5ec498ba8655

Best regards,
-- 
Abhinav Kumar <quic_abhinavk@quicinc.com>
