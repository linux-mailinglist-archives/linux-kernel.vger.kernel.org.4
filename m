Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE865B548
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjABQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjABQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:45:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDBB7EB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:45:34 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302GInMk014129;
        Mon, 2 Jan 2023 16:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=aYkK432DaDF4bT6u3BpN5HMTQcbUfQyWQBwnkZAp7yE=;
 b=XobZ6N1dIq4qvHwXuGpfYXe+c70eKKDxyQ3lgsKfpeX6Beeoo7YDtJQAhQmf3ojgaWAt
 vCwhXuBtFY8azfs2+N8cEe1dWEskqmbDwqRlHCTwtTNmGTzztYrqVp8H1wyXGbspLq/a
 K/Itj0YS+I8SXnJnTwkjU74089OoWEaQ5tHd63Gd2xnn2c9Xg7ITsqtuizG7kCEumsf4
 dhYzAjGd40CnWMRZkUAtV98awT7unSnYptQeBy3xWNE5859h6SFguopozgy6L91BExMM
 7iZTK/uU1wOTOiyC4h+ylw5Vf4KvUueLyK6maAtDZ7YLc5ZeViYw2PcBrWOVSMFBqzxC BQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtaewbeke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 16:45:31 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 302GjUeP022928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 16:45:30 GMT
Received: from [10.216.36.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 08:45:29 -0800
Message-ID: <5bed08c5-8663-4e68-27b4-8b6d3957a880@quicinc.com>
Date:   Mon, 2 Jan 2023 22:14:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Query about IPI as NMI (pseudo-NMI) support patches
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fhT6XmDNr73rKpCnBY6D3-A3UUCoZBRQ
X-Proofpoint-GUID: fhT6XmDNr73rKpCnBY6D3-A3UUCoZBRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_10,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1031 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=671 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I was looking similar support mentioned in below patch series.

https://lore.kernel.org/lkml/CAFA6WYO0+LQ=mB1spCstt0cNZ0G+sZu_+Wrv6BKSeXqF5SRq4A@mail.gmail.com/#t

Wanted to check if there is chance of these patches to land in
mainline ?

Thanks,
-Mukesh
