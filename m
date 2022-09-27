Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6225EC523
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiI0N5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiI0N5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392714C041;
        Tue, 27 Sep 2022 06:57:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RDMXAp029438;
        Tue, 27 Sep 2022 13:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YTNldlmgui/QlWqHWQNcU+pyYSg6pkhk49atqSSD1lo=;
 b=n88goIsASEoRHD/uNnyhOJK0er60k3Q3SM0dLftfFd5GznXw9GkPgWsLSbGJ8VxYbtQG
 +u1VnOgEkVi+6MwkVRqnTAM03oY/PtDKPHLD+I7tHubgC/T02ojO52ZIBLceJntVK/o9
 VMjfopVECbilW6cphEAvl9Qnj+gQHtB3VWbMSL6/DQeglEfT14+HgssSooz8hinjXYIj
 n5L6qIXklUkUb4BkYk8wuyioyfiSlk7SykxAPJw4nWtMy2Mo/V28VHAr2jxOGxrq++Y3
 SU/9tClWIX3Eaqujx17shVSnZFv6hFe0oCA0Zqv25GamWDzpkBUj6sZ8W7KVJwGXWZrP Mg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juw260t9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:57:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RDvDjc032324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:57:13 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 06:57:12 -0700
Message-ID: <6e5a8bb0-f659-fd6c-a45c-4bcfa537fc5b@quicinc.com>
Date:   Tue, 27 Sep 2022 07:57:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Use mhi_soc_reset() API in place of
 register write
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <mrana@quicinc.com>
References: <1664272126-82706-1-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1664272126-82706-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H38ixZaWndpGTN84bCpkPFmmbsYnYMk9
X-Proofpoint-ORIG-GUID: H38ixZaWndpGTN84bCpkPFmmbsYnYMk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=894 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270085
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2022 3:48 AM, Qiang Yu wrote:
> Currently, a direct register write is used when ramdump collection
> in panic path occurs. Replace that with new mhi_soc_reset() API
> such that a controller defined reset() function is exercised if
> one is present and the regular SOC reset is done if it is not.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
