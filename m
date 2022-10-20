Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118976056AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJTFRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJTFRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:17:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD7F17C541;
        Wed, 19 Oct 2022 22:17:02 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K57qHS005263;
        Thu, 20 Oct 2022 05:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mAgQ5fC4sKpQ3PvxLcsGXTrIfrhjVMDrWRX9tOmZF6I=;
 b=puEaCzteE8wpU73EkQgNFMQUyxVppPU4kzJJCPoHqY8sBQO8mnJUm1y/Gk19FgylMPCV
 U1/kNUFJqUKy1D7nE4JeKj0A+B179H3TgbxxqIaY63sF8pe5ilywXBhEgzb0GXB2MnPp
 gmlEtog7CP59u8xZlN1sg45QNxukQ32KwwXH4yq5Rd84sLT/g6DWR+Se/cklo7pZJucf
 XeSkmvoAnMzM5A8UREExOm+vYjawCSl6ec2lRGvrRjkwPONNjzRcBroEn9IUupa2Qe6U
 CRsiuoxZXsMpC9fPm24xICi4UKJ3eQ1SVuFWV6utwofUlZ+QVwiixAZQK9xAeAxm7+59 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kavjv52xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 05:16:51 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29K58f1j009219;
        Thu, 20 Oct 2022 05:16:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kavjv52wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 05:16:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K55SWF032014;
        Thu, 20 Oct 2022 05:16:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg9876n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 05:16:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K5BhTs50331938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 05:11:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E9C24C046;
        Thu, 20 Oct 2022 05:16:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7BBB4C040;
        Thu, 20 Oct 2022 05:16:44 +0000 (GMT)
Received: from [9.171.43.76] (unknown [9.171.43.76])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 05:16:44 +0000 (GMT)
Message-ID: <b74752cc-5833-c1b5-3697-262c523e794b@linux.ibm.com>
Date:   Thu, 20 Oct 2022 07:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 rcu 08/11] arch/s390: Add
 ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
 <20221019225846.2501109-8-paulmck@kernel.org>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20221019225846.2501109-8-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JLD47XnEjZuXK5fP6AH8MFxtxqmnzhJ8
X-Proofpoint-ORIG-GUID: lKMJ8UibkdU9hWACLHOimuOXOdYYZxRb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.10.22 um 00:58 schrieb Paul E. McKenney:
> The s390 architecture uses either a cmpxchg loop (old systems)
> or the laa add-to-memory instruction (new systems) to implement
> this_cpu_add(), both of which are NMI safe.  This means that the old
> and more-efficient srcu_read_lock() may be used in NMI context, without
> the need for srcu_read_lock_nmisafe().  Therefore, add the new Kconfig
> option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/arm64/Kconfig, which will
						s390 ?
> cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving the current
> srcu_read_lock() behavior.
> 
> Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> 
> Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: <linux-s390@vger.kernel.org>
> ---
>   arch/s390/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 318fce77601d3..0acdfda332908 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -73,6 +73,7 @@ config S390
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_MEM_ENCRYPT
> +	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_SCALED_CPUTIME
>   	select ARCH_HAS_SET_MEMORY
