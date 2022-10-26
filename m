Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FF60E9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiJZTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiJZTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:52:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F91F63D6;
        Wed, 26 Oct 2022 12:52:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QJm37f027235;
        Wed, 26 Oct 2022 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OmBwWhQGh7YtiLbeVb/rH4Mt1uj9aXGUgjRU9w21yZw=;
 b=OEg9Y0UCfsYB8WpjchI/kBXFpOjxx+nkoo8YXUxa2feFkI2zYsiAeYbMqwX3EzEBh6pW
 pdAbj4o664iE2paGB/D3epkZM0DCRWBeadao3xLj/NWdJnttKJ2k7aEhcO2D42n2FuPR
 IVoX5vf/84BKRNOEitRnSxBlaNGFtSvf3EYQnRK7GZ/iMcedqHFRHrXSkXYcrkSdheXo
 vSttQbkyA7xWKywCJMQWHIjBz0RszOX1FGp8VSeIUKzn31TDAM1UaiV2MYWo8tNo+Ut+
 Iu26BmAGN8+yuyH6il8313t5F3TrNKj0lXG39j8XQ10CJ8tIi/s0An65kKrCxl9RJOgs 4Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvr3tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:52:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJqWNB026962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:52:32 GMT
Received: from hu-subbaram-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:52:31 -0700
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <robh+dt@kernel.org>, <sre@kernel.org>
Subject: [PATCH 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
Date:   Wed, 26 Oct 2022 12:52:26 -0700
Message-ID: <1666813946-21569-1-git-send-email-quic_subbaram@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220818031512.319310-3-bjorn.andersson@linaro.org>
References: <20220818031512.319310-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j6kq3teLL9aL6JIybqHYPH5sYIeWecHw
X-Proofpoint-GUID: j6kq3teLL9aL6JIybqHYPH5sYIeWecHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_08,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=661
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static struct pmic_glink *__pmic_glink;
> +static DEFINE_MUTEX(__pmic_glink_lock);

Having this global device and lock to update pmic_glink struct pointer
might not work well if there are multiple pmic_glink devices that
corresponds to multiple pmic_glink channels (or rpmsg devices). This
is fine for the primary pmic_glink channel that supports mission mode
clients. However, to support debugging, there could be a secondary
pmic_glink channel and some clients under it.

> +struct pmic_glink_client {
> +	struct list_head node;
> +
> +	struct pmic_glink *pmic;

It would be good to name this pointer as "pg" or something.
