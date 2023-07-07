Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DE74B7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGGUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:20:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45126A6;
        Fri,  7 Jul 2023 13:19:50 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367KGFFM030554;
        Fri, 7 Jul 2023 20:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gFKGmEMS7UOM4+alXurC/O8sK3asvYK18nibq8FZEBA=;
 b=TdClrnAYsJo/vUSoZnBav6NnVxIw6aSAl5koBURezWefn/Pd/Jvkrj6HZscnbkHcSRa7
 opDz5U8Um9ws/HMkL+rjLAnO1/9iPYuiaTwhJioqpwUykwP1DL6xbmNYcZ06H8xsSGgy
 LE1jstq+wplcX4osTN+QIiaaqE29laEr7CAmXQiL0E9ImqDZbxS5V9//stuv0e4lZiXL
 s3pWdP7FMyydu8+8F9zlUS1+JH99yXLjdZmveO2GWWsoSLj9+OQN1139AxDbe4acgs28
 w0hliN7shrBT04rydeEHxVJKGfwJh6nZcocXfp7uK5E+XPFzMwOQ8kydAkfsMw5UiwiK 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpskj03u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 20:19:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367KGKvt030772;
        Fri, 7 Jul 2023 20:19:43 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpskj03tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 20:19:42 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367IcjrQ016311;
        Fri, 7 Jul 2023 20:19:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6yw48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 20:19:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367KJeJ160555566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 20:19:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 964B058055;
        Fri,  7 Jul 2023 20:19:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2FC958054;
        Fri,  7 Jul 2023 20:19:38 +0000 (GMT)
Received: from [9.171.14.249] (unknown [9.171.14.249])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 20:19:38 +0000 (GMT)
Message-ID: <93285ee9-cc63-ed74-f7e9-4ff0fb56e7c8@linux.ibm.com>
Date:   Fri, 7 Jul 2023 22:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net v2 0/3] s390/ism: Fixes to client handling
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230707105622.3332261-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vHUE4-o9y-3K2Z4kfiUTQ8Y9IbN2xps-
X-Proofpoint-ORIG-GUID: qGUuJ5sboWvfcW66HsXhLG3MT_4bFJze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=903
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.07.23 12:56, Niklas Schnelle wrote:
> Hi networking developers,
> 
> This is v2 of the patch previously titled "s390/ism: Detangle ISM client
> IRQ and event forwarding". As suggested by Paolo Abeni I split the patch
> up. While doing so I noticed another problem that was fixed by this patch
> concerning the way the workqueues access the client structs. This means the
> second patch turning the workqueues into simple direct calls also fixes
> a problem. Finally I split off a third patch just for fixing
> ism_unregister_client()s error path.
> 
> The code after these 3 patches is identical to the result of the v1 patch
> except that I also turned the dev_err() for still registered DMBs into
> a WARN().
> 
> Thanks,
> Niklas
> 
> Changes since v1:
> - Split into three patches (Paolo Abeni)
> - Turned the dev_err() in ism_unregsiter_client() on still registered DMBs
>    into a WARN() as it should only happen due to client bugs.
> 
> Niklas Schnelle (3):
>    s390/ism: Fix locking for forwarding of IRQs and events to clients
>    s390/ism: Fix and simplify add()/remove() callback handling
>    s390/ism: Do not unregister clients with registered DMBs
> 
>   drivers/s390/net/ism_drv.c | 153 ++++++++++++++++++-------------------
>   include/linux/ism.h        |   7 +-
>   2 files changed, 74 insertions(+), 86 deletions(-)
> 
> 
> base-commit: d528014517f2b0531862c02865b9d4c908019dc4


Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

