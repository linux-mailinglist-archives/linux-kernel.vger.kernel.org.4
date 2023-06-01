Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCF719D32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjFANTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFANTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:19:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781D97
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:19:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351CcLTS017367;
        Thu, 1 Jun 2023 13:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T0Eoky1lbNQcAa9Gx3toJXuqNq+fNeKJF5cXn77jxgo=;
 b=PfHpuSqwmDF53VSIZVtfXYKymZq2OWyULIreut2m0j5pUKha+mZimrf2Db4wfMuEjknQ
 TuwthPLYUj0nBdku/YEfsGYQTYjsrQuw4brGRs7TgaQTSNewfS5PNA0R780Iv8NnOoVA
 3u5zrXHkUNjkEKUwpHnjINcFwTZdBrclaZkxBXuL5Qg8cHUkeqpytL9Slm5pHANtbeTS
 zoluwYD5JZXB6uH6680k2eHJ2ktIcUnTcikYWgKguuzjwNPI1tqfRnuavqynpbZdZ724
 TX46zSbHbvJO4m+zOC6yGpwpjciPbwFBnv7oib6yfsEMaGahpDGxrd8pWEoFdRSjzSzH hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr8358-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:19:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351DJ3PP030653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 13:19:03 GMT
Received: from [10.50.22.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 06:19:01 -0700
Message-ID: <bad9f1e3-bbf5-7fa6-946c-55bccb70ec65@quicinc.com>
Date:   Thu, 1 Jun 2023 18:48:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531150449.56311ca2ea6184b413517672@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20230531150449.56311ca2ea6184b413517672@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f0wxzNPNp5cnsjtEH1oQWGXQUBzfFWU9
X-Proofpoint-ORIG-GUID: f0wxzNPNp5cnsjtEH1oQWGXQUBzfFWU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=918 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010117
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew!!

On 6/1/2023 3:34 AM, Andrew Morton wrote:
>> This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
>> mounted on zram which has 2GB of backingdev. The test case involved
>> launching some memory hungry apps in an order and do the proactive
>> reclaim for the app that went to background using madvise(MADV_PAGEOUT).
>> We are seeing ~40% less total values of psi mem some and full when this
>> patch is combined with [1].
> Does this accounting inaccuracy have any perceptible runtime effects?
> 
With the testcase mentioned, we are able to achieve better app
concurrency(It is a measure on Android of how many apps that can survive
by not getting killed by lmkd(which relies on PSI events to take the
decissions) by the end of the testcase).

The total memsome and memfull psi events(measured in usec) are as below:
mem PSI	  	 w/o patch	with patch
some		61255313	21867736
full		31353138	15391454

Thanks,
Charan
> 
