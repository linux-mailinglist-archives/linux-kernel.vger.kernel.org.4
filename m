Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F736C331A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCUNli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:41:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423B6A70;
        Tue, 21 Mar 2023 06:41:32 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LCvBYW005914;
        Tue, 21 Mar 2023 13:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aFr/E2BfAVYF/VpSXNgsbIX54SC1gXcp13vhvu8ZRcU=;
 b=XePJy6kzog7iLbOw86uwR0XF4CKwvFJwTcPIny7MkvpKdGIs/iX9lVdamclWSkDVu9Vq
 sth16GRQSDurVifyAORiJ+edf10BCGdWKiuIzqClurMbLig05XjTLiLX7e8B0U31Vbtv
 dkeM1yWg1i/zwDsmpL4cL0ooVDOxYSjUcyT5Tf5CibFIre+shmkRX4rpmaqkt/Jn1KTn
 aJ/Y+OEdDjIqMhjYHNOduWAsDrn3L8ynlQxQkCuZPySqn3kVspRArsn4s5zs5zWwL1C8
 ORqliZfpaaD2reXsj6qgfbStKE4A2pxIRJ5NACzUh1lLKE6nIFX6bH3VT2Uwh7BgSagi 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf7qns7vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32LCwCoA008957;
        Tue, 21 Mar 2023 13:41:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf7qns7v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32L9RLNK015046;
        Tue, 21 Mar 2023 13:41:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pd4jfcqhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LDfPUp65208738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:41:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CBFA20043;
        Tue, 21 Mar 2023 13:41:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D194A20040;
        Tue, 21 Mar 2023 13:41:24 +0000 (GMT)
Received: from osiris (unknown [9.152.212.90])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 13:41:24 +0000 (GMT)
Date:   Tue, 21 Mar 2023 14:41:24 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Lizhe <sensor1010@163.com>
Cc:     akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] s390/vfio-ap-drv: Remove redundant driver match
 function
Message-ID: <ZBm0BDdJr/s7GVTF@osiris>
References: <20230319041941.259830-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319041941.259830-1-sensor1010@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cNNSfWsMjyVffsA3Z48USOaK74xl_XfB
X-Proofpoint-ORIG-GUID: 3B-TALr-VURsZ5q3BhPYu8YHqzLFCpZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=715
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 12:19:41PM +0800, Lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().
> 
> Drop the matrix bus's match function that always returned 1 and so 
> implements the same behaviour as when there is no match function
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied.
