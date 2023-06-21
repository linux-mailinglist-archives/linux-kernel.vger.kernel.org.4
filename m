Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF89739062
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFUTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjFUTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:47:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD92E65;
        Wed, 21 Jun 2023 12:47:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHtOGe012790;
        Wed, 21 Jun 2023 19:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OFGD4SZxrzEluRY8oJdSUhAqbDTKEdcNke7nRn5nSmM=;
 b=CQKQCHvP0yh0jMdce7Y2prxmRwTjqIpq9njQxr4ZhYTiWYQzTCOcNJhRSq8eod4b0XIo
 Uou6CnhbVw5oWMKvxYfhka3A4nWze6AgZ/osf9xZ7l7XI3gVaIiyZ/6IhvYp6RptLZQ2
 1lrhycfERp/fMEseN9nqPjrh9/4v65OgZUXoTT94/UT9rFOZSHU4nHAQfs8Ni3xBPKlY
 zILuviqVKFwCS2F05wwAXIhIY1ZA4KUCQIQgUaiMfARFkbDq5ps5IecByw0u8RmfMgO7
 YgJWgu4mZdepNl8jAls5GTCpz1hIMMjaMz0LH2lPa6xkxRsDRIPXKYV53uTXIc0zVVmT Ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc0sk12yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:46:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LJk8oa013311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:46:08 GMT
Received: from [10.110.82.3] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 12:46:08 -0700
Message-ID: <ae1a7788-acdd-8964-1450-61a741386fbd@quicinc.com>
Date:   Wed, 21 Jun 2023 12:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/2] Avoid re-initializing XHCI HC during removal
Content-Language: en-US
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20230531222719.14143-1-quic_wcheng@quicinc.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230531222719.14143-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: daCzUhdQs493v4UjSuO9XsIRn9i2CHR5
X-Proofpoint-ORIG-GUID: daCzUhdQs493v4UjSuO9XsIRn9i2CHR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=398 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210164
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping to see if there are any review feedback/concerns with this 
series?

Thanks
Wesley Cheng

On 5/31/2023 3:27 PM, Wesley Cheng wrote:
> There is an extra amount of overhead being adding to XHCI HCD removal
> cases when the HCD needs to undergo a runtime resume.  The xhc_reinit
> logic will attempt to restart the HC if there is a HCE observed during
> resume.  However, in the removal case, this is not required as the
> XHCI stop/halt will execute the same operations.  In addition, it isn't
> needed that the HC be placed back into the running state if it is being
> removed.
> 
> Changes in v3:
> - Update xhci-plat to set the removal flag before issuing the runtime PM
> get
> 
> Changes in v2:
> - Fixed spacing issue
> 
> Wesley Cheng (2):
>    usb: host: xhci: Do not re-initialize the XHCI HC if being removed
>    usb: host: xhci-plat: Set XHCI_STATE_REMOVING before resuming XHCI HC
> 
>   drivers/usb/host/xhci-plat.c | 2 +-
>   drivers/usb/host/xhci.c      | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
