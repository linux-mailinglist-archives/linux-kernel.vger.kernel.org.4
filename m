Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE5740F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF1Kum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:50:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:42122 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231442AbjF1Ku3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:50:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S6wAMu001665;
        Wed, 28 Jun 2023 10:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hZzS81ULesm4SQXOGJrB0LJ92KFZXTfL0rkUl0ZKncY=;
 b=ErAy+lsQdOInQcryVGpm22EOvyR0Sujcau5in//nESf44+czURH5rJ9Uqd4IZ153f35/
 GLyRewwUaURvQN+k50xr5nwIZekl9bLmQKKFLZrDpxeSkw78Jj8z3iT5phGnJFE2uCio
 oFKpH9lxN0zFYQKah2dz6pEWWiK3TWE9MB0xCuuV1cdbUndxkKcdCEdaePDW9hQrYjNQ
 p/G/3uluNkMEUdT4nYpKx5VJL2P2Z2q0sCxHojTHp7TJ7PmF0Ini5jYHJRU98P2Y+GU6
 /ofEb28ZmXwsBg0lGXw5YxAd8J0dU/09+0vD21r3rn2QRhm95XpjQ2wiBmqufX4R6vqT Lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg7x3sc4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:50:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SAoFZh009987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:50:19 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 03:50:12 -0700
Message-ID: <a80670c8-850c-e0f8-67d3-9d783a666076@quicinc.com>
Date:   Wed, 28 Jun 2023 16:20:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <minchan@kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_smanapra@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
 <20230627144639.GA52561@cmpxchg.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20230627144639.GA52561@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HqNwXIsGNUoP2kHcrabXvYsGhEXOVXsD
X-Proofpoint-GUID: HqNwXIsGNUoP2kHcrabXvYsGhEXOVXsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=405 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Johannes!!

On 6/27/2023 8:16 PM, Johannes Weiner wrote:
> Unless I'm missing something, this also includes inactive pages, which
> is undesirable. Shouldn't this be:
> 
> 		if (folio_test_active(folio))

My bad. Let me fix it.

> 			folio_set_workingset(folio);
