Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF272516B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbjFGBPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjFGBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:15:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA092;
        Tue,  6 Jun 2023 18:15:50 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3570l0Io027460;
        Wed, 7 Jun 2023 01:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/Rth1cf7f+VKMc6Ja0hfE3TOoTNMHCjb3sNHoK8EcuM=;
 b=UIOqis854vQBY9EMedBjcUMdIoXm8rsNrDgc78gOKE39SJO1NJHZ5mUI158Aqo6NxJyc
 naBIHthuPv4vHXvFtlcGO24Sxe14ZYK9PYcDr+hk8cV2x5Zuziz75i/6doKWdzuGGHpw
 XrK9/8SSajgOW7Ip5NiONdCWbc3fQ/a9+kl4U8HncfzfoSwWL6+uE8U9IwieU2Gg7Xwc
 B7nFeNRHQRhx5XLj9O5cZ8ClOcdt1QFaeMOJASONbfI9zzoMefDNqt47GwuEN9PXJ7Rg
 tV+9PfeYWkz7N3JTbLeB4o+54VWzWQlu+1A8zfwZa0baWyJOJHlLBlpH8XwJmOpIKjNq ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7k0k7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 01:15:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3571FhhT017678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 01:15:43 GMT
Received: from [10.216.46.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 18:15:39 -0700
Message-ID: <f40157df-8792-fc28-55eb-56dadf46b382@quicinc.com>
Date:   Wed, 7 Jun 2023 06:44:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/2] spi-geni-qcom: Add new interfaces and utilise them
 to do map/unmap in framework for SE DMA
Content-Language: en-CA
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>, <quic_ptalari@quicinc.com>
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
 <bffedd6c-acc2-4c89-9e4d-82aa70249b57@sirena.org.uk>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <bffedd6c-acc2-4c89-9e4d-82aa70249b57@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GZWKrXuSEDiDptvdtTwJ6N73bTI1344g
X-Proofpoint-GUID: GZWKrXuSEDiDptvdtTwJ6N73bTI1344g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_17,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=814 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070009
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2023 11:19 PM, Mark Brown wrote:
> On Wed, May 17, 2023 at 05:48:12PM +0530, Vijaya Krishna Nivarthi wrote:
>> A "known issue" during implementation of SE DMA for spi geni driver was
>> that it does DMA map/unmap internally instead of in spi framework.
>> Current patches remove this hiccup and also clean up code a bit.
> Given Konrad's review I'll go ahead and apply these on a branch
> (assuming my CI is happy), if there's a need to merge them into the qcom
> tree I can sign a pull request (or revert the commits).  Hopefully
> that's OK with everyone.


Sounds ok to me given Bjorn seems not available until 9th.

Thank you everyone for review and time.

-Vijay/


