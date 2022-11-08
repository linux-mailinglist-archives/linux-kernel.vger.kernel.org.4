Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EDC6208E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKHFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHFVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:21:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F212AD1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:21:29 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A84SpMB019853;
        Tue, 8 Nov 2022 05:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DtrYK2cmbjkVOvbxELSYE9VaApE8vPH0GCi3/Qm+y7k=;
 b=ZETKkIfcJ3JwjPh0LmQbpCt87DBBmiYq4PviEsEm6pxmLaRQoNDA/L/fn4izSm/gpEP8
 02vD4GyaeGVaX9l2E+hEHYufLRgqBGsh85aneSaa2qKqchGMulcJHw+t9VGJNp0YNuC1
 okENi9iEEkOAyfU3BtBqZxEZax5z0DXBkHockblehwDy9+seKd1tO97s5FwM8kY/7Kkt
 zQezibrH59yribVSncifL3dMuoMHKmJzqYGEiri26YUiljXEiM3Ww0ElqTRD9mSddgAm
 uekhyAqJFe4C1GfcOr/U8LS5HYCh7bvUInCZG9nU1fiUYbuL9D8ZDAmzUExJfEyYjKj5 sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kq7g4hbn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:21:08 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85K1hb020128;
        Tue, 8 Nov 2022 05:21:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kngwkt51m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:21:08 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A85L7So021291;
        Tue, 8 Nov 2022 05:21:07 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 2A85L7wT021290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:21:07 +0000
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 21:21:03 -0800
Message-ID: <699a1ac8-75a4-c3ab-def9-3740c6a2fdb2@quicinc.com>
Date:   Tue, 8 Nov 2022 10:51:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <david@redhat.com>, <pasha.tatashin@soleen.com>,
        <shakeelb@google.com>, <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
 <66279414-6cc5-d4a4-176e-a75ba7d36037@suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <66279414-6cc5-d4a4-176e-a75ba7d36037@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aq6-ZBPgno688IJPPV1dse9Eg5M1-xE-
X-Proofpoint-GUID: aq6-ZBPgno688IJPPV1dse9Eg5M1-xE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=558 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 9:11 PM, Vlastimil Babka wrote:
> Hi, looks like this added a new warning to a previously clean "make W=1 mm/"
> build:
> mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not
> described in 'page_ext_put'
> 
> Can you fixup please?
Thanks Vlastimil for reporting this. Raised changes
@https://lore.kernel.org/all/1667884582-2465-1-git-send-email-quic_charante@quicinc.com/

Thanks,
Charan
