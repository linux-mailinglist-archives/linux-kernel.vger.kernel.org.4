Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBA86E6ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjDRRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C37ED3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:25:48 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IGrY4Y014149;
        Tue, 18 Apr 2023 17:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=vdoH0xI9moVJ18M3ElgIPUjofAUGNGZMp834ePtAdLk=;
 b=jtqpme91r+SYPo1/H86DsIBNOP/lqnHFaQFzI/99XY9UbPftuWUNzpj9I5z5jlCD3n4s
 Jqe/jY9pfqnLFdfJ7ZR/bdgpLUV4N0ZvjJh3aXZvthDBZ1+jqcurFb8Usj0ixuIcl9t7
 FFFB5h49D1CcgY0DJJAXP2hUgLmXPBnzeXLzDNJxYEBtyYLWSP5+T+IMZF02Vj8a9Nxh
 CzakJtRZjNftjMTMpMYIAm2XUXfox2inGkC0EGe7t1Lwc8fUllI1I8cC87nLXTjILM6D
 LCSpgEGRlK1xlxf9T/0TEFAnUECOcxHpQrNB35nVYWzDLUpztcgHQwlLiz70CXbFHVuY 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pm1jctw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:25:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33IGhq8G003233;
        Tue, 18 Apr 2023 17:25:34 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pm1jcsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:25:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I60wsI015916;
        Tue, 18 Apr 2023 17:25:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pyk6fj6s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:25:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IHPRfI37093744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:25:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C4C2004B;
        Tue, 18 Apr 2023 17:25:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4489820043;
        Tue, 18 Apr 2023 17:25:26 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue, 18 Apr 2023 17:25:26 +0000 (GMT)
Date:   Tue, 18 Apr 2023 22:55:25 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] pseries/smp: export the smt level in the SYS FS.
Message-ID: <20230418172525.GK1005120@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
 <20230331153905.31698-2-ldufour@linux.ibm.com>
 <87ttxjaonc.fsf@mpe.ellerman.id.au>
 <0e668a82-3a3e-798a-8707-1a9b622b23b6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0e668a82-3a3e-798a-8707-1a9b622b23b6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F61CGiDnGSZzrAgeKEtUlsW5cI7A7pfL
X-Proofpoint-ORIG-GUID: H7lmZzvkuhTKSv4pZdyZ1OLP6YXdo6ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Laurent Dufour <ldufour@linux.ibm.com> [2023-04-13 17:38:51]:

> On 13/04/2023 15:37:59, Michael Ellerman wrote:
> > Hi Laurent,
> > 
> > Laurent Dufour <ldufour@linux.ibm.com> writes:
> >> There is no SMT level recorded in the kernel neither in user space.
> >> Indeed there is no real constraint about that and mixed SMT levels are
> >> allowed and system is working fine this way.
> >>
> >> However when new CPU are added, the kernel is onlining all the threads
> >> which is leading to mixed SMT levels and confuse end user a bit.
> >>
> >> To prevent this exports a SMT level from the kernel so user space
> >> application like the energy daemon, could read it to adjust their settings.
> >> There is no action unless recording the value when a SMT value is written
> >> into the new sysfs entry. User space applications like ppc64_cpu should
> >> update the sysfs when changing the SMT level to keep the system consistent.
> >>
> >> Suggested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> >> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/pseries.h |  3 ++
> >>  arch/powerpc/platforms/pseries/smp.c     | 39 ++++++++++++++++++++++++
> >>  2 files changed, 42 insertions(+)
> > 
> > There is a generic sysfs interface for smt in /sys/devices/system/cpu/smt
> > 
> > I think we should be enabling that on powerpc and then adapting it to
> > our needs, rather than adding a pseries specific file.
> 
> Thanks Michael, I was not aware of this sysfs interface.
> 
> > Currently the generic code is only aware of SMT on/off, so it would need
> > to be taught about SMT4 and 8 at least.
> 
> Do you think we should limit our support to SMT4 and SMT8 only?

smt2 is also a valid already supported configuration and we are evaluating 
smt6 mode based on some inputs from ISV teams. 

So I believe having a value for all modes would be good. 

> 
> > There are already hooks in the generic code to check the SMT level when
> > bringing CPUs up, see cpu_smt_allowed(), they may work for the pseries
> > hotplug case too, though maybe we need some additional logic.
> > 
> > Wiring up the basic support is pretty straight forward, something like
> > the diff below.
> 

-- 
Thanks and Regards
Srikar Dronamraju
