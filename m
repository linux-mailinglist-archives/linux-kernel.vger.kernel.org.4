Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D864736E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLHPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiLHPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:45:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2945FBAA;
        Thu,  8 Dec 2022 07:45:25 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8FZ2P2007934;
        Thu, 8 Dec 2022 15:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9tIMNg4Kaxo3cphCsyWsLxTChfZY31tW/lPAfaZnGxQ=;
 b=GYqgyNxfJb71CnhDM0qrB+j2jjTWJ2LB+Mibrz/vEaAt8S1KOEuqRjIdas1Lv0CdSYCn
 MYXNbDv+a5xSG4d845zj/pyI2BLChGUI0YAjOoeG7tRb/npeFo4fMULXDR4yRfZi7Tvk
 x3UaZTgtkgT7wRLui21h76k/qe+fcedYDEfSGVlg1J2DFZp6SM0vRhRLumSq8cyQ+nFe
 8VqMIvchbfPXAVMtlofA/1mCJ9TNsvbRnrhQ4ZqJNzZxSlywQ6EtDQ8N1dnkdZXodwl5
 HYVaAWuSWX9GJwsPSSI2kIDOvlguvu43ubGDSUcSWol+di064peV9jus2Wvc0qja92IS kA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbhwt1wmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 15:45:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B88a728027381;
        Thu, 8 Dec 2022 15:45:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3m9ks44nqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 15:45:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B8FjDuq45810016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Dec 2022 15:45:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE282004B;
        Thu,  8 Dec 2022 15:45:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 928D92004D;
        Thu,  8 Dec 2022 15:45:12 +0000 (GMT)
Received: from [9.179.2.221] (unknown [9.179.2.221])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Dec 2022 15:45:12 +0000 (GMT)
Message-ID: <cb69a093-942c-ea69-7fd8-b31626d2db91@linux.ibm.com>
Date:   Thu, 8 Dec 2022 16:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] s390/dasd: Fix potential memleak in dasd_eckd_init()
To:     Qiheng Lin <linqiheng@huawei.com>, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208133809.16796-1-linqiheng@huawei.com>
Content-Language: en-US
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20221208133809.16796-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: faAgQNRc6WKDgqJQjZAAzw6YQ6cooX-A
X-Proofpoint-ORIG-GUID: faAgQNRc6WKDgqJQjZAAzw6YQ6cooX-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_09,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=905 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080128
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.12.22 um 14:38 schrieb Qiheng Lin:
> `dasd_reserve_req` is allocated before `dasd_vol_info_req`, and it
> also needs to be freed before the error returns, just like the other
> cases in this function.
>
> Fixes: 9e12e54c7a8f ("s390/dasd: Handle out-of-space constraint")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>

Thanks, applied.


