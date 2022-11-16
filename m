Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DC62CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiKPWzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiKPWze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:55:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBE96B23E;
        Wed, 16 Nov 2022 14:55:31 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLJh6W029063;
        Wed, 16 Nov 2022 22:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=3yEu/KpX2Z69PcMkvPCwi808XfPo3JBnARa9aFt/nO0=;
 b=ivZb2fqs2uT86XjgZ1I0H5CEpAzd5LvRCCtgl4OfpM1YRQb7QWO583MKC5mzdNHk2/mS
 nPsGUvl4nFgPpbja46cBEfoY2BCzH1FsPsdS9wjGolohQ0HgFf1KhrRZIdzUTyMJz58e
 uS74HhZy2L5QCg0tzhqTEin1g4RST5LCy6fSff+QkTF9XlMe9TdfCCHBNcWM4nEz68tW
 ZRRTJGrLg1W0moupnYVGgJJ5WP48MQqeqn0mdAYFcTHQVzP4WsIge42JCDN+eo6m5bWe
 VtlR1pgkgSQLH6LhTWAlucEFGXVnd83bmoTjuSfM0r+++qlCJ0DTcbeRo7Gg7klkHorW dQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kw0f5s5wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 22:55:24 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AGMtKSV025948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 22:55:20 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 16 Nov
 2022 14:55:20 -0800
Date:   Wed, 16 Nov 2022 14:55:18 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <robimarko@gmail.com>, <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V4 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20221116225518.GA14011@quicinc.com>
References: <20221114082644.28739-1-quic_sibis@quicinc.com>
 <20221114082644.28739-3-quic_sibis@quicinc.com>
 <20221115053336.GA29781@quicinc.com>
 <1b462f1a-327b-4a8f-8de7-909dbad0ddf8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b462f1a-327b-4a8f-8de7-909dbad0ddf8@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SVM3yGXHAjs4FOV9cC5L2J3JSgeh1y2o
X-Proofpoint-GUID: SVM3yGXHAjs4FOV9cC5L2J3JSgeh1y2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=933
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16 2022 12:11, Sibi Sankar wrote:
> Hey Guru,
> 
> Thanks for taking time to review the series.
> 
> On 11/15/22 11:03, Guru Das Srinagesh wrote:
> >On Nov 14 2022 13:56, Sibi Sankar wrote:
> >
> >(snip)
> >
> >>+static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
> >>+{
> >>+	int ret;
> >>+	struct qcom_scm *scm = data;
> >>+	struct completion *wq_to_wake;
> >>+	u32 wq_ctx, flags, more_pending = 0;
> >>+
> >>+	do {
> >>+		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> >>+		if (ret) {
> >>+			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
> >>+			goto out;
> >>+		}
> >>+
> >>+		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> >>+		if (IS_ERR_OR_NULL(wq_to_wake)) {
> >>+			dev_err(scm->dev, "No waitqueue found for wq_ctx %d: %ld\n",
> >>+				wq_ctx, PTR_ERR(wq_to_wake));
> >>+			goto out;
> >>+		}
> >>+
> >>+		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
> >>+		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
> >>+			dev_err(scm->dev, "Invalid Flags found for wq_ctx: %u\n", flags);
> >>+			goto out;
> >>+		}
> >>+
> >>+		complete(wq_to_wake);
> >
> >Need to call complete() or complete_all() based on the flags.
> 
> with the current implementation we should get away with
> just complete for now but I can add them back in the way
> Bjorn wanted i.e. with the bool wake_all in the next
> re-spin.

Sounds good, let's consume the flags according to their intended purpose. 

Thank you.

Guru Das.
