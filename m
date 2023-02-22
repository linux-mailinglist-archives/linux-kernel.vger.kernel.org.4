Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10F269F0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjBVJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjBVJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:08:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004E2364A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:08:36 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8fpLs028942;
        Wed, 22 Feb 2023 09:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rcjyfGKmpAKDOP7mXosqDu8uluZWDsTIettYsh8XREc=;
 b=NuposLuwy/+EbCZv5FjVWT4Mvnl0zjWdJHDAdtX50XQjPUcize6CDIrCrtd/JWAZjjPn
 5gALNjmXd2GMSxhlAjaFkIad6Zki3G/9izWTWdYAmyNxGyMVlJXO5ycP34kWkD665K1L
 naTtgA6dlY02hWPcxOJXnRzLY8dV297DJwM/b/Sybz8+8v0JXbkscDZ3CB26OLyWmY7a
 WHeFVRHPwDuXPygOVkEA0R8Dou5e1Gv3J0bVbBJdvZYJIyc/oC9z4POsSvcQ+YhHscOo
 T+8xzbFREMnzeL13pvu/rh+r7jNysKY289QUKCPVZ3vsIi7bKBIRBq2FfthwH4Uqr5bA 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwfrtrkna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:08:27 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M8tnD3019923;
        Wed, 22 Feb 2023 09:08:27 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwfrtrkmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:08:26 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCgmfl021022;
        Wed, 22 Feb 2023 09:03:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6bus4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:03:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M93Lrh15794928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 09:03:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D41CA2005A;
        Wed, 22 Feb 2023 09:03:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14DFA2004B;
        Wed, 22 Feb 2023 09:03:19 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Feb 2023 09:03:18 +0000 (GMT)
Date:   Wed, 22 Feb 2023 14:33:15 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/include/asm/barrier.h: redefine rmb and wmb
 to lwsync
Message-ID: <Y/XaUxqJ496aNVT8@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222090112.187583-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222090112.187583-1-kconsul@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Scvm_QIDFOU1mcbQIHPjxvLY0FDRK_MR
X-Proofpoint-GUID: KGRbCcD5NqC51KYpp4t099HFQoes8bSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=716 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, sent the wrong patch!
Please ignore this one.
Sending the v2 in another email.

On Wed, Feb 22, 2023 at 02:31:12PM +0530, Kautuk Consul wrote:
> A link from ibm.com states:
> "Ensures that all instructions preceding the call to __lwsync
>  complete before any subsequent store instructions can be executed
>  on the processor that executed the function. Also, it ensures that
>  all load instructions preceding the call to __lwsync complete before
>  any subsequent load instructions can be executed on the processor
>  that executed the function. This allows you to synchronize between
>  multiple processors with minimal performance impact, as __lwsync
>  does not wait for confirmation from each processor."
> 
> Thats why smp_rmb() and smp_wmb() are defined to lwsync.
> But this same understanding applies to parallel pipeline
> execution on each PowerPC processor.
> So, use the lwsync instruction for rmb() and wmb() on the PPC
> architectures that support it.
> 
> Also removed some useless spaces.
> 
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/barrier.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index e80b2c0e9315..553f5a5d20bd 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -41,11 +41,17 @@
> 
>  /* The sub-arch has lwsync */
>  #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> -#    define SMPWMB      LWSYNC
> +#undef rmb
> +#undef wmb
> +/* Redefine rmb() to lwsync. */
> +#define rmb()	({__asm__ __volatile__ ("lwsync" : : : "memory"); })
> +/* Redefine wmb() to lwsync. */
> +#define wmb()	({__asm__ __volatile__ ("lwsync" : : : "memory"); })
> +#define SMPWMB      LWSYNC
>  #elif defined(CONFIG_BOOKE)
> -#    define SMPWMB      mbar
> +#define SMPWMB      mbar
>  #else
> -#    define SMPWMB      eieio
> +#define SMPWMB      eieio
>  #endif
> 
>  /* clang defines this macro for a builtin, which will not work with runtime patching */
> -- 
> 2.31.1
> 
