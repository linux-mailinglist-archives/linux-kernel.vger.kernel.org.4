Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFE6FF614
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjEKPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEKPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:34:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FC559F;
        Thu, 11 May 2023 08:34:51 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BEXimc009368;
        Thu, 11 May 2023 15:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mvWpFNBqIZ3K+SPGiMWgBjURs/bSbyQGKKt/UcYADzY=;
 b=MpDy02Q6mEEkoKRsZSv5TGHEe12Dk5PgKmXpKljSye7wA5Q5UVN7D60AqquJmFxTRPqQ
 kd0ejdU1n0JAAYwVOoZzqAKd7W6x4iy1h9uhY8a2odMnGo9JttKIYWd1pZqT7kHWvX+N
 TJfJzhkllb4elkavIDPgZOsU9nNdhP8tKmqcrZvIn+DTgO9GE7rFeGRwz2MGrFjQsZU2
 TbxK6+22BLc0MRbmtEyOHND4YOE+5UfydKvcoZdu7qsowNh9XGQeUVoxyu48jLSBeYxv
 mQgHGzXjqSAJBob/74TW9P1XzZGt0pmwd95PEgBERQtraB2BAaIsn7G6ktcuNt8qHf2v hA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh27tr5u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 15:34:43 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BFYgH7026650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 15:34:42 GMT
Received: from [10.110.38.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 11 May
 2023 08:34:42 -0700
Message-ID: <a144e830-acf8-55c6-c323-d049095e9fac@quicinc.com>
Date:   Thu, 11 May 2023 08:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] accel/qaic: silence some uninitialized variable warnings
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC:     Oded Gabbay <ogabbay@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <d11ee378-7b06-4b5e-b56f-d66174be1ab3@kili.mountain>
Content-Language: en-US
From:   Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <d11ee378-7b06-4b5e-b56f-d66174be1ab3@kili.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yLaaiaKONj9PnGubx_VSs_GiiEp7rKF7
X-Proofpoint-GUID: yLaaiaKONj9PnGubx_VSs_GiiEp7rKF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=636 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110134
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2023 3:41 AM, Dan Carpenter wrote:
> Smatch complains that these are not initialized if get_cntl_version()
> fails but we still print them in the debug message.  Not the end of
> the world, but true enough.  Let's just initialize them to a dummy value
> to make the checker happy.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
