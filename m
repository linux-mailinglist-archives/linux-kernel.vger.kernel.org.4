Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8D74B223
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGGNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGGNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:46:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFCC1FE8;
        Fri,  7 Jul 2023 06:46:40 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367DfolE012826;
        Fri, 7 Jul 2023 13:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6I12xcufEdLuKyeJ2OYFjCJ5nrGxlGbQ67pr37xmxj8=;
 b=lNPsX8KWONtaRKvdbq3HTJyLl8yOIQgAge2lkXvGXFKuttib4sm3ezXJObb2M7kTNIbF
 5zO0bqndcg9OqE9QGYv14x4ufS33oqvigg6Sc4Zzp2p035hc85D7fkTjSw5Mk2TzaeN3
 7x2bKYjqeVgBHqikGxXkhFGG0YQ9/KiLjCm2F+oWXQI4YPV5xR6hJxy0t3ZGM+qOoI2T
 uHlnneImRI7uoyuAxM0wvkuqnyuLoey2L3AmcyhYNdZ4xlxgRR3lTWMkTsljoSIahBrh
 Pzy02sN+Aut4qo8oL6iVfefNB4habWtMsVxp15shnNW8BznpNPqre7MJxc0p3geeS/8b BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpktdr5kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:46:37 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367DgOY9015910;
        Fri, 7 Jul 2023 13:46:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpktdr5jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:46:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3673V2eb029350;
        Fri, 7 Jul 2023 13:46:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4v1eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:46:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367DkVtD41222574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 13:46:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D022004B;
        Fri,  7 Jul 2023 13:46:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34BD20043;
        Fri,  7 Jul 2023 13:46:30 +0000 (GMT)
Received: from [9.171.43.196] (unknown [9.171.43.196])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 13:46:30 +0000 (GMT)
Message-ID: <b0f92d34-3149-2d0e-cf91-5f58beca854b@linux.ibm.com>
Date:   Fri, 7 Jul 2023 15:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net v2 0/3] s390/ism: Fixes to client handling
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230707105622.3332261-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l2R_mG1by1mTmhiiMd-dyb9oeT2VIyUN
X-Proofpoint-ORIG-GUID: gT2-gJ0KHb2SMEqAtzhQ-Xgbrf1xSJza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=807 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070125
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
>   into a WARN() as it should only happen due to client bugs.
> 
> Niklas Schnelle (3):
>   s390/ism: Fix locking for forwarding of IRQs and events to clients
>   s390/ism: Fix and simplify add()/remove() callback handling
>   s390/ism: Do not unregister clients with registered DMBs
> 
>  drivers/s390/net/ism_drv.c | 153 ++++++++++++++++++-------------------
>  include/linux/ism.h        |   7 +-
>  2 files changed, 74 insertions(+), 86 deletions(-)
> 
> 
> base-commit: d528014517f2b0531862c02865b9d4c908019dc4

For the series: 
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

