Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD27434D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjF3GQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF3GQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:16:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D80268A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:16:26 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U68YJs022599;
        Fri, 30 Jun 2023 06:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=88ZGGlb0nyAMUwqUkBwLgZcO3xXWxAPRD3Uppr7tWmQ=;
 b=s7TeTB9TbLqyzH39d6MLBB4WPUAoDFZ2ZQXmXFjg6k+ZVDB2elSw2fo8IgcYNwVcMILA
 sHs7GnoOPBjeqrB5an0xqNnd2XIxYREZdnyHGCD5w5Wdj2zaNe9C8E8VV8xGUmXPzTBf
 +7UV5ZAFmikMzR3ROupl/maDddmsh3luOemtGgnaH4vkWADg3ULN54IrPVy8+xlF6r76
 zOCQKDH3GkYatjT87Dy3Kye/kAc0laCqc6xwhKsVF8NkpPuYun9VzAh91L8CCQAeK78z
 MtOL/a3wICelihtmZuIsf356FnQ294Z7YsC5jxDeQQmVVzkImF8Orncwik8hTpZS3/l4 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhs8u0es1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 06:16:17 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U68cwi023055;
        Fri, 30 Jun 2023 06:16:16 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhs8u0er0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 06:16:16 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4nHkr022868;
        Fri, 30 Jun 2023 06:16:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr452wpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 06:16:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35U6GCXt39518530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 06:16:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A5B520043;
        Fri, 30 Jun 2023 06:16:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A458F20040;
        Fri, 30 Jun 2023 06:16:10 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 30 Jun 2023 06:16:10 +0000 (GMT)
Date:   Fri, 30 Jun 2023 11:46:08 +0530
From:   Gautam Menghani <gautam@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
Message-ID: <ZJ5zKJ2ZjHx6fsZk@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20230630061326.19288-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630061326.19288-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MEZJ3uFg3kLbaRJ8sqQGeh3soOd7FzwO
X-Proofpoint-ORIG-GUID: R_uv58tJswbed1RNJI6h2-Xeh1q5hc3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:43:26AM +0530, Gautam Menghani wrote:
> Remove an unnecessary piece of code that does an endianness conversion but
> does not use the result. The following warning was reported by Clang's
> static analyzer:
> 
> arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> 'server' is never read [deadcode.DeadStores]
>         server = be16_to_cpu(oserver);
> 
> As the result of endianness conversion is never used, delete the line
> and fix the warning.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/sysdev/xics/ics-opal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
> index 6cfbb4fac7fb..5fe73dabab79 100644
> --- a/arch/powerpc/sysdev/xics/ics-opal.c
> +++ b/arch/powerpc/sysdev/xics/ics-opal.c
> @@ -111,7 +111,6 @@ static int ics_opal_set_affinity(struct irq_data *d,
>  		       __func__, d->irq, hw_irq, rc);
>  		return -1;
>  	}
> -	server = be16_to_cpu(oserver);
>  
>  	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
>  	if (wanted_server < 0) {
> -- 
> 2.39.3
> 

I resent this patch by mistake, please ignore this. Apologies for the
trouble.
