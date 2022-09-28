Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59A5ED979
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiI1Jwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiI1JwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:52:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4BEA74E9;
        Wed, 28 Sep 2022 02:52:22 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S81Gup018918;
        Wed, 28 Sep 2022 09:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=u+IAU1I5EWQVsXbd/vLEYMrAO0IB/qt/OWrRKE9lRsg=;
 b=Y9XNnQiyx0stccq6s66aNEUjwPiu1WfZcsZ08dOzfaAmybKLmM66lyLUMnOGl6tgzf71
 b8ds0eYJ5NYw+Sf/BHzTGBlrZmG+XRbvqiq6zp7v+7HMdguwmQbIkrE6rFzCeHCkNO8U
 cm9GbvevlmNhwBvwe7ayIBjmMSrV4hyve+cGAvcOybURNDYExmfnIaq/qQfJhnWu8aZj
 ymX1I3f1L1W6vzIgsoZ0v6ghQfpWhHPy1meBrzw2Wy9xZ+YFDMUbfMKdfaERS21VoJBS
 7L8JwKwHgFo6HJ0irm9hAD3B7+xq71eKkxM1pxleOWm9sJrLXXMX0l07L3SNQ5Tq4hGv hA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvjd0uuhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 09:52:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28S9pXJ8028631;
        Wed, 28 Sep 2022 09:51:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j51qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 09:51:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28S9pvun60228066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 09:51:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C85511C050;
        Wed, 28 Sep 2022 09:51:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6151111C04A;
        Wed, 28 Sep 2022 09:51:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Sep 2022 09:51:56 +0000 (GMT)
Received: from intelligence.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B2A466016C;
        Wed, 28 Sep 2022 19:51:33 +1000 (AEST)
Message-ID: <2cc0121f92a7aa86f2bc9c58f180dc9f37e7989a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/pseries: block untrusted device tree
 changes when locked down
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmorris@namei.org, mpe@ellerman.id.au, paul@paul-moore.com,
        serge@hallyn.com, gcwilson@linux.ibm.com, nayna@linux.ibm.com
Date:   Wed, 28 Sep 2022 19:51:31 +1000
In-Reply-To: <20220926131643.146502-2-nathanl@linux.ibm.com>
References: <20220926131643.146502-1-nathanl@linux.ibm.com>
         <20220926131643.146502-2-nathanl@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YlZ7y0Q6VJB1_2FLzx8c0XLaJgR-JRGK
X-Proofpoint-GUID: YlZ7y0Q6VJB1_2FLzx8c0XLaJgR-JRGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_03,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 08:16 -0500, Nathan Lynch wrote:
> The /proc/powerpc/ofdt interface allows the root user to freely alter
> the in-kernel device tree, enabling arbitrary physical address writes
> via drivers that could bind to malicious device nodes, thus making it
> possible to disable lockdown.
> 
> Historically this interface has been used on the pseries platform to
> facilitate the runtime addition and removal of processor, memory, and
> device resources (aka Dynamic Logical Partitioning or DLPAR). Years
> ago, the processor and memory use cases were migrated to designs that
> happen to be lockdown-friendly: device tree updates are communicated
> directly to the kernel from firmware without passing through
> untrusted
> user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
> remains the sole legitimate user of /proc/powerpc/ofdt, but it is
> already broken in lockdown since it uses /dev/mem to allocate
> argument
> buffers for the rtas syscall. So only illegitimate uses of the
> interface should see a behavior change when running on a locked down
> kernel.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Seems sensible to me.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
>  include/linux/security.h                  | 1 +
>  security/security.c                       | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/reconfig.c
> b/arch/powerpc/platforms/pseries/reconfig.c
> index cad7a0c93117..599bd2c78514 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/notifier.h>
>  #include <linux/proc_fs.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  
> @@ -361,6 +362,10 @@ static ssize_t ofdt_write(struct file *file,
> const char __user *buf, size_t coun
>         char *kbuf;
>         char *tmp;
>  
> +       rv = security_locked_down(LOCKDOWN_DEVICE_TREE);
> +       if (rv)
> +               return rv;
> +
>         kbuf = memdup_user_nul(buf, count);
>         if (IS_ERR(kbuf))
>                 return PTR_ERR(kbuf);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..39e7c0e403d9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -114,6 +114,7 @@ enum lockdown_reason {
>         LOCKDOWN_IOPORT,
>         LOCKDOWN_MSR,
>         LOCKDOWN_ACPI_TABLES,
> +       LOCKDOWN_DEVICE_TREE,
>         LOCKDOWN_PCMCIA_CIS,
>         LOCKDOWN_TIOCSSERIAL,
>         LOCKDOWN_MODULE_PARAMETERS,
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..51bf66d4f472 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -52,6 +52,7 @@ const char *const
> lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_IOPORT] = "raw io port access",
>         [LOCKDOWN_MSR] = "raw MSR access",
>         [LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
> +       [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
>         [LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>         [LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>         [LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",

-- 
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

