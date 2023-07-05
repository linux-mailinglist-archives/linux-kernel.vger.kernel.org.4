Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E49747C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGEFdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGEFdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:33:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46BE3;
        Tue,  4 Jul 2023 22:33:23 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655R9s6010520;
        Wed, 5 Jul 2023 05:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fMI+CGIPKH5SbOwUbji5gwSRrdN0l3dcn45P2g6P+iM=;
 b=cz3CLVNA2zDbZ7WRpSSSjeoKVWmelpkuHDQz9ULBJRHIMMWksFuLS8KZMVCR4Ewka7ao
 L5ed7b6EBJ46IDvpr7X1LEPQWIGzZi2CQsVu+5xGTyvdihCTYPzs5yAbB1nJEarK76bW
 evm+RGgyPE2E1+Q56vK3ozCT4k7fVqgpfR9ABqCkVqwoy3WIOmkLMst/g1qJg2OaT+n0
 4ZGKqTaCZaPHEhUi9+jWDmaRG4lorLeW5RMviBsXoJPwZP4v0PCU1xpopIpln1YvFsBo
 w/sViZv0wknQYpM+YORceKOGxCd1ITLyFEUTwoC8OA3hYmdp369nwawdsRrdS9MUnjg0 Ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cp809d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 05:33:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3655X1vM002420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 05:33:01 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 22:32:57 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V7 0/2] firmware: Add support for boot_stats
Date:   Wed, 5 Jul 2023 11:02:30 +0530
Message-ID: <cover.1688533340.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -NcZajytzaNAr-41PGjW7zBddm3IesMk
X-Proofpoint-ORIG-GUID: -NcZajytzaNAr-41PGjW7zBddm3IesMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=534
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm's proprietary Android boot-loaders capture boot time
stats, like the time when the bootloader started execution and at what
point the bootloader handed over control to the kernel etc. in the IMEM
region. This information is captured by the bootloader and populated on
the device tree properties "pre-abl-time" and "abl-time" which can be
be viewed from the user space like as follows:-

/sys/firmware/devicetree/base/bootstats # cat abl_time
17898

As a part of this patch series added the bindings for boot-stats which
was suggested in the v6 of the series. The link for the same is as
follows:-

https://lore.kernel.org/linux-arm-kernel/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/

Souradeep Chowdhury (2):
  dt-bindings: firmware: bootstats: Add the dtschema
  MAINTAINERS: Add the entry for boot_stats support

 .../bindings/firmware/qcom,bootstats.yaml     | 38 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml

--
2.17.1

