Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1E736E81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjFTORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjFTORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:17:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5591;
        Tue, 20 Jun 2023 07:17:48 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBLueM020164;
        Tue, 20 Jun 2023 14:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EF/KLh/vr02DqncFcz84OcH5fXVmt70cnGcVY1/nMns=;
 b=b4eirrkBUDknc7I74lTDAMrGqG9fD2ieOURAz3F/gj/5AvWfe4PfokOFyI1yLzWCkmP3
 TKnYVUwRVMtuOGsdU4YY2YKYuno+Zu7ZEI2VMXhwQWjkeMFoFFZ2rcFjuhCLW1gHZz9C
 KjAPjIWLs9/7xI/rbNB02oiZ1gtocuQ8CP/n7KSE80lBAOLu3g3YYQKOh18KV9c06RKt
 4txM1IHMOC9aa3MmOthrZyvG/DgUDQHNSKm+tSrrqqg0TUPp2B4Pp3+kDfGmE+XpjZOi
 /SF3Ivg/QPIh3YHcbIrAQ6SzjPvWCz14KMQgX2tOMZkXzedKj/A5j9ICh5+pq/dfAMVT /Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rarx8tb2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 14:17:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KEHWpv010964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 14:17:32 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 07:17:31 -0700
Message-ID: <01ec9084-a3c4-82c6-90ae-1460b8b284b1@quicinc.com>
Date:   Tue, 20 Jun 2023 08:17:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/qaic: Call DRM helper function to destroy prime GEM
Content-Language: en-US
To:     <quic_carlv@quicinc.com>, <quic_pkanojiy@quicinc.com>,
        <christian.koenig@amd.com>, <sukrut.bellary@linux.com>,
        <sumit.semwal@linaro.org>
CC:     <ogabbay@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>
References: <20230614161528.11710-1-quic_jhugo@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230614161528.11710-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0XT9GN57nPD0HgguXT1khJ8iYVG-0oEk
X-Proofpoint-ORIG-GUID: 0XT9GN57nPD0HgguXT1khJ8iYVG-0oEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=851 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200129
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2023 10:15 AM, Jeffrey Hugo wrote:
> From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> 
> smatch warning:
> 	drivers/accel/qaic/qaic_data.c:620 qaic_free_object() error:
> 		dereferencing freed memory 'obj->import_attach'
> 
> obj->import_attach is detached and freed using dma_buf_detach().
> But used after free to decrease the dmabuf ref count using
> dma_buf_put().
> 
> drm_prime_gem_destroy() handles this issue and performs the proper clean
> up instead of open coding it in the driver.
> 
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Reported-by: Sukrut Bellary <sukrut.bellary@linux.com>
> Closes: https://lore.kernel.org/all/20230610021200.377452-1-sukrut.bellary@linux.com/
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Pushed to drm-misc-fixes

-Jeff
