Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C967A8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjAYCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:48:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F5305D4;
        Tue, 24 Jan 2023 18:48:01 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P25CfQ000921;
        Wed, 25 Jan 2023 02:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xcouaf8WF3bKdZYFqAH7FiBbZbwxJAqyIEnMuh21s7o=;
 b=MEtatucxswP3chHoB1y329bLD8EWnP2qrpsSY9L2eLKmHfpBG0suYquygzZx+nguc5/T
 jpvM6vQPtqTcf+i50aVhKp40gHf5vd0ViN5OIlN4qWRubPk6pIHBfLfm4NRViT5xlEND
 w+kvuxKzE+CHik0xUvcjnxWE3RfDiv9dM9f1Ya3bs/yEPjav9GOco4B5dAImmcXDbDFg
 VTvcmf/JJQbJ+RouxDzMmQ7L1O4D5tLvxlK8BCFe3Ql5X0JyZOejfISINGNG3SNV7cl9
 7rwRC7wXO+zHOMeq3rLD3n5XVXnU3TLyZNvsh8nUxJNrJVroyFX0xoAHRi6SiZnZEFkF 8Q== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg17ger-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 02:47:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30P1Xb6G010736;
        Wed, 25 Jan 2023 02:47:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n87p75mph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 02:47:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P2lktU11600598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 02:47:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176F558058;
        Wed, 25 Jan 2023 02:47:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9333D58056;
        Wed, 25 Jan 2023 02:47:44 +0000 (GMT)
Received: from sig-9-77-142-161.ibm.com (unknown [9.77.142.161])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 02:47:44 +0000 (GMT)
Message-ID: <adbb8d2f438f01f32d9e09b508cde31b3efdc3a4.camel@linux.ibm.com>
Subject: Re: [PATCH v4 24/24] integrity/powerpc: Support loading keys from
 pseries secvar
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        mpe@ellerman.id.au, gjoyce@linux.ibm.com, sudhakar@linux.ibm.com,
        bgray@linux.ibm.com, erichte@linux.ibm.com, joel@jms.id.au
Date:   Tue, 24 Jan 2023 21:47:44 -0500
In-Reply-To: <71b48934e26a991eaf62c9869a8dfee769e0799d.camel@russell.cc>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-25-ajd@linux.ibm.com>
         <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
         <71b48934e26a991eaf62c9869a8dfee769e0799d.camel@russell.cc>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dtJwXYAFt2-I7yskS6p4JbtAx62PVEPv
X-Proofpoint-GUID: dtJwXYAFt2-I7yskS6p4JbtAx62PVEPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-25 at 13:23 +1100, Russell Currey wrote:
> On Tue, 2023-01-24 at 10:14 -0500, Mimi Zohar wrote:
> > On Fri, 2023-01-20 at 18:43 +1100, Andrew Donnellan wrote:
> > > From: Russell Currey <ruscur@russell.cc>
> > > 
> > > The secvar object format is only in the device tree under powernv.
> > > We now have an API call to retrieve it in a generic way, so we
> > > should
> > > use that instead of having to handle the DT here.
> > > 
> > > Add support for pseries secvar, with the "ibm,plpks-sb-v1" format.
> > > The object format is expected to be the same, so there shouldn't be
> > > any
> > > functional differences between objects retrieved from powernv and
> > > pseries.
> > > 
> > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> > > 
> > > ---
> > > 
> > > v3: New patch
> > > 
> > > v4: Pass format buffer size (stefanb, npiggin)
> > > ---
> > >  .../integrity/platform_certs/load_powerpc.c     | 17 ++++++++++---
> > > ----
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/security/integrity/platform_certs/load_powerpc.c
> > > b/security/integrity/platform_certs/load_powerpc.c
> > > index dee51606d5f4..d4ce91bf3fec 100644
> > > --- a/security/integrity/platform_certs/load_powerpc.c
> > > +++ b/security/integrity/platform_certs/load_powerpc.c
> > > @@ -10,7 +10,6 @@
> > >  #include <linux/cred.h>
> > >  #include <linux/err.h>
> > >  #include <linux/slab.h>
> > > -#include <linux/of.h>
> > >  #include <asm/secure_boot.h>
> > >  #include <asm/secvar.h>
> > >  #include "keyring_handler.h"
> > > @@ -59,16 +58,22 @@ static int __init load_powerpc_certs(void)
> > >         void *db = NULL, *dbx = NULL;
> > >         u64 dbsize = 0, dbxsize = 0;
> > >         int rc = 0;
> > > -       struct device_node *node;
> > > +       ssize_t len;
> > > +       char buf[32];
> > >  
> > >         if (!secvar_ops)
> > >                 return -ENODEV;
> > >  
> > > -       /* The following only applies for the edk2-compat backend.
> > > */
> > > -       node = of_find_compatible_node(NULL, NULL, "ibm,edk2-
> > > compat-v1");
> > > -       if (!node)
> > > +       len = secvar_ops->format(buf, 32);
> > 
> > "powerpc/secvar: Handle format string in the consumer"  defines
> > opal_secvar_format() for the object format "ibm,secvar-backend". 
> > Here
> > shouldn't it being returning the format for "ibm,edk2-compat-v1"?
> > 
> 
> They end up with the same value.  The DT structure on powernv looks
> like this:
> 
> /proc/device-tree/ibm,opal/secvar:
> name             "secvar"
> compatible       "ibm,secvar-backend"
> 		 "ibm,edk2-compat-v1"
> format           "ibm,edk2-compat-v1"
> max-var-key-len  00000000 00000400
> phandle          0000805a (32858)
> max-var-size     00000000 00002000
> 
> The existing code is checking for a node compatible with "ibm,edk2-
> compat-v1", which would match the node above.  opal_secvar_format()
> checks for a node compatible with "ibm,secvar-backend" (again, matching
> above) and then returns the contents of the "format" string, which is
> "ibm,edk2-compat-v1".
> 
> Ultimately it's two different ways of doing the same thing, but this
> way load_powerpc_certs() doesn't have to interact with the device tree.

Agreed.  Thank you for the explanation.  To simplify review, I suggest
either adding this explanation in the patch description or stage the
change by replacing the existing "ibm,edk2-compat-v1" usage first.

thanks,

Mimi

> 
> 
> > Mimi
> > 
> > > +       if (len <= 0)
> > >                 return -ENODEV;
> > >  
> > > +       // Check for known secure boot implementations from OPAL or
> > > PLPKS
> > > +       if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-
> > > sb-v1", buf)) {
> > > +               pr_err("Unsupported secvar implementation \"%s\",
> > > not loading certs\n", buf);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > >         /*
> > >          * Get db, and dbx. They might not exist, so it isn't an
> > > error if we
> > >          * can't get them.
> > > @@ -103,8 +108,6 @@ static int __init load_powerpc_certs(void)
> > >                 kfree(dbx);
> > >         }
> > >  
> > > -       of_node_put(node);
> > > -
> > >         return rc;
> > >  }
> > >  late_initcall(load_powerpc_certs);
> > 
> > 
> 


