Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9973A6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFVQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjFVQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:57:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5568E6E;
        Thu, 22 Jun 2023 09:56:58 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGrixm020621;
        Thu, 22 Jun 2023 16:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=30CuW3ZgEVztMDgij9LMuw3lRA7uKf6/5k59P62PgV4=;
 b=nYrdMh0OeXmAflZmUK+0K2A8hmCcSXBN0CcbYA2/sJnmGUoWqPyUT6jJgqaAdJ81A+bq
 +/stutJ5hx5wWqxrdSYRPSGz/auhz88sqsvVo2jlXpYSLhxC6tWCAOHUm3YRgdwvlego
 +Lg/WrnyRvYaUXReXYpFmTgNq8v9SGl2hXl/oLeIkBp1i7AuEkqqeAc1D0R6xSyCho6l
 LYU16gSGL1/ynKJQv6k8HOedpqN8vf3X5wonb/MhoeQMuO1VlVUNdAD6zlou/H+MGYrC
 YblCK1mxnlxe3qyO4tR8B8eNN0wVTZuyA5lqVQyJEgcdRMMPpIq3//3GVORxt0Yi2Gmi 0g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rct7n82t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 16:56:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M2S8KE008089;
        Thu, 22 Jun 2023 16:56:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f53mfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 16:56:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MGumX744499266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 16:56:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8DB22004D;
        Thu, 22 Jun 2023 16:56:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37E1720040;
        Thu, 22 Jun 2023 16:56:48 +0000 (GMT)
Received: from osiris (unknown [9.171.73.252])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Jun 2023 16:56:48 +0000 (GMT)
Date:   Thu, 22 Jun 2023 18:56:46 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/decompresser: fix misaligned symbol build error
Message-ID: <ZJR9Tnmooclgvt6H@osiris>
References: <20230622125508.1068457-1-hca@linux.ibm.com>
 <20230622143538.GA1138962@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622143538.GA1138962@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NCQB8hQs6WbhLWdaz3oy7VAcmhodLET6
X-Proofpoint-ORIG-GUID: NCQB8hQs6WbhLWdaz3oy7VAcmhodLET6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:35:38PM +0000, Nathan Chancellor wrote:
> On Thu, Jun 22, 2023 at 02:55:08PM +0200, Heiko Carstens wrote:
> > Nathan Chancellor reported a kernel build error on Fedora 39:
> > 
> > $ clang --version | head -1
> > clang version 16.0.5 (Fedora 16.0.5-1.fc39)
> > 
> > $ s390x-linux-gnu-ld --version | head -1
> > GNU ld version 2.40-1.fc39
> > 
> > $ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- olddefconfig all
> > s390x-linux-gnu-ld: arch/s390/boot/startup.o(.text+0x5b4): misaligned symbol `_decompressor_end' (0x35b0f) for relocation R_390_PC32DBL
> > make[3]: *** [.../arch/s390/boot/Makefile:78: arch/s390/boot/vmlinux] Error 1
> > 
> > It turned out that the problem with misaligned symbols on s390 was fixed
> > with commit 80ddf5ce1c92 ("s390: always build relocatable kernel") for the
> > kernel image, but did not take into account that the decompressor uses its
> > own set of CFLAGS, which come without -fPIE.
> > 
> > Add the -fPIE flag also to the decompresser CFLAGS to fix this.
> > 
> 
> I think this should also have:
> 
> Reported-by: CKI <cki-project@redhat.com>
> Link: https://lore.kernel.org/32935.123062114500601371@us-mta-9.us.mimecast.lan/
> 
> I technically just forwarded the report and did a little extra testing.

Ok, added.

> Thanks for the quick patch, this fixes the error and I did a simple boot
> test in QEMU with the resulting kernel, which showed no issues.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

And this as well. :) Thanks a lot!
