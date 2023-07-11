Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684474EAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGKJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjGKJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:39:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DFC1735
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:38:47 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9MbqF004488;
        Tue, 11 Jul 2023 09:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RQUYzWtDk+t8WoyHZeaFpgI9UITjO4qOa7OE8UZvWrQ=;
 b=n1l+7hFH2JKBxexGTXuc2+t7hXxdwCNWJ0r5VUXMamEyIDYiHZYoIGcBXikghQnty5AQ
 inNJYzSzw1/Bz/dmXTM47e5l//5jVochRUGfKgXFJM0lYq9xgrTXmurNNmEv1DaJEuF2
 AY/quWHmN59HU+81jPH6+HnBlJ99t6kwcrqkWaEim3wXOcbRvaJJA/H6AyIKGuVM/7xt
 t59PoIGQdEiTHv2zp+HoOVhAc7zs6g7mbNd2yPdfmZxG3YGDc6yRHu8YNBcf86+D+M4a
 /txSwAS9CZG2OyY7xn8elu5f4ABQdByveSOI9Lona8NyxddN8ssUvmNH4Pl478zokNnj TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs4cv0cn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:38:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B9NqRT009514;
        Tue, 11 Jul 2023 09:38:37 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs4cv0cmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:38:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36B4eu0t013369;
        Tue, 11 Jul 2023 09:33:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rpye599a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:33:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36B9XV798585948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 09:33:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A068200CD;
        Tue, 11 Jul 2023 09:33:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FC87200CF;
        Tue, 11 Jul 2023 09:33:29 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Jul 2023 09:33:29 +0000 (GMT)
Date:   Tue, 11 Jul 2023 15:03:22 +0530
From:   Gautam Menghani <gautam@linux.ibm.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
Message-ID: <ZK0h4jR/St1yrOLo@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20230630055628.17790-1-gautam@linux.ibm.com>
 <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRTDZMOsMMfPhUt4gp9wtrL09ncjzmVn
X-Proofpoint-ORIG-GUID: A-W74D55u-paQv7fWdrrZHMGA4cHDrk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 05:50:57PM +1000, Jordan Niethe wrote:
> 
> 
> On 30/6/23 3:56 pm, Gautam Menghani wrote:
> > Remove an unnecessary piece of code that does an endianness conversion but
> > does not use the result. The following warning was reported by Clang's
> > static analyzer:
> > 
> > arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> > 'server' is never read [deadcode.DeadStores]
> >          server = be16_to_cpu(oserver);
> > 
> > As the result of endianness conversion is never used, delete the line
> > and fix the warning.
> > 
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> 
> 'server' was used as a parameter to opal_get_xive() in commit 5c7c1e9444d8
> ("powerpc/powernv: Add OPAL ICS backend") when it was introduced. 'server'
> was also used in an error message for the call to opal_get_xive().
> 
> 'server' was always later set by a call to ics_opal_mangle_server() before
> being used.
> 
> Commit bf8e0f891a32 ("powerpc/powernv: Fix endian issues in OPAL ICS
> backend") used a new variable 'oserver' as the parameter to opal_get_xive()
> instead of 'server' for endian correctness. It also removed 'server' from
> the error message for the call to opal_get_xive().
> 
> It was commit bf8e0f891a32 that added the unnecessary conversion and never
> used the result.
> 
> Reviewed-by: Jordan Niethe <jniethe5@gmail.com>

Yes, thanks for the info Jordan. Just to add to this,
ics_opal_mangle_server() needs input in LE and the 'wanted_server' is
already LE as xics_get_irq_server() is returning result in LE. So the
line

`server = be16_to_cpu(oserver);'

is indeed not required.

Thanks,
Gautam

> 
> 
> > ---
> >   arch/powerpc/sysdev/xics/ics-opal.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
> > index 6cfbb4fac7fb..5fe73dabab79 100644
> > --- a/arch/powerpc/sysdev/xics/ics-opal.c
> > +++ b/arch/powerpc/sysdev/xics/ics-opal.c
> > @@ -111,7 +111,6 @@ static int ics_opal_set_affinity(struct irq_data *d,
> >   		       __func__, d->irq, hw_irq, rc);
> >   		return -1;
> >   	}
> > -	server = be16_to_cpu(oserver);
> >   	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
> >   	if (wanted_server < 0) {
> > 
