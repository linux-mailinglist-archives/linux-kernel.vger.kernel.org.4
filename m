Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312A700B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbjELPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:13:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8E49DB;
        Fri, 12 May 2023 08:13:16 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFClVd018626;
        Fri, 12 May 2023 15:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jYjLHOyidruJVPLBKCVwpVwwJfRW6Zshw0l/IrFdXdA=;
 b=l4vxTEV1pzEAm6Z5rs8CMEKQIzqvYvL18NyfGrL6VbAuIUBZSlCYo0p/IqVE23lCyRAn
 HpMogTq/9DP+E5C2NXGjvLAQG9Bel4glTScZ9LnOfK+YOloiX5ZUkc/a74a36FFDpGeU
 Oe0ZtBlWeioIoE4EumPTH9pHkS8HoNB+D5HNnvZryXQ3jB45V/ZFgq1mUFMsQ9xYHxtv
 ZE69J2od5sYK54vBMDlACpf2Q6Ec3SqsAreC+518gzQf11+SAvoJYAh+KFwfLE+CM5KS
 WLqgO6yl+ZflEB/g3hf5a/UXGdEwq36aKg8UnZH0NwJjEdkk2jNoSfgQfEgCUqmBbcxV Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhqnsrj6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 15:13:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CFD906019723;
        Fri, 12 May 2023 15:13:09 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhqnsrhfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 15:13:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6cZkm026743;
        Fri, 12 May 2023 15:08:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qf7dg20rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 15:08:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34CF8Jxj10945236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:08:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45F720043;
        Fri, 12 May 2023 15:08:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EC5D20049;
        Fri, 12 May 2023 15:08:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 15:08:19 +0000 (GMT)
Date:   Fri, 12 May 2023 17:08:18 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/Kconfig: remove obsolete configs SCHED_{BOOK,DRAWER}
Message-ID: <ZF5WYk/21SXbBHkw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230508040916.16733-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508040916.16733-1-lukas.bulwahn@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: woZXe1Iz4fGaQsvFZIsEYccUoTz8Uv06
X-Proofpoint-GUID: JWGkyKryfcliegf-1lVOHLWtmNAjM0OO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:09:16AM +0200, Lukas Bulwahn wrote:
> Commit f1045056c726 ("topology/sysfs: rework book and drawer topology
> ifdefery") activates the book and drawer topology, previously activated by
> CONFIG_SCHED_{BOOK,DRAWER}, dependent on the existence of certain macro
> definitions. Hence, since then, CONFIG_SCHED_{BOOK,DRAWER} have no effect
> and any further purpose.
> 
> Remove the obsolete configs SCHED_{BOOK,DRAWER}.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/s390/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 548b5b587003..1627c7f841d3 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -468,19 +468,11 @@ config SCHED_SMT
>  config SCHED_MC
>  	def_bool n
>  
> -config SCHED_BOOK
> -	def_bool n
> -
> -config SCHED_DRAWER
> -	def_bool n
> -
>  config SCHED_TOPOLOGY
>  	def_bool y
>  	prompt "Topology scheduler support"
>  	select SCHED_SMT
>  	select SCHED_MC
> -	select SCHED_BOOK
> -	select SCHED_DRAWER
>  	help
>  	  Topology scheduler support improves the CPU scheduler's decision
>  	  making when dealing with machines that have multi-threading,

Applied, thanks!
