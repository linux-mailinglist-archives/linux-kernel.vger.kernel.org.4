Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99376911ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBIUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:09:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC730C4;
        Thu,  9 Feb 2023 12:09:47 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319K1lMe014350;
        Thu, 9 Feb 2023 20:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XGHbI4ra0FtneGPyfx5jeTG6NSLPIotF9rRhO6tyTiE=;
 b=ZS90CnmKHcX2Szr2iyBq4vLBLxdSyovUrw65rrkcypmr3G8AfUE/iw2rCkxfMVuklwr8
 x1RloEGV6ukvMY7h19dRqhwdOC6KkYKhl0ECGJhYIH1b/nTG0zOab+3KNxko47MxSqIf
 WELougxeGm2IDoMWQZRm7FdKbEn8156vW360HoUbkc5v+haxMHPFylW7Uh3dtDcwHypK
 GLD/Xa3khQvrXRmC5p3QaMw1Yrx0OqaZfkM0zMEAFRFlOkqGLNpMVAnIVxIDfpAjZqrh
 8Jx4UrVItaT4Bu6VBbObJgL4MgcD/o4ndrJvpgfyFJ1UxULrhlFY7BDwwVTj8DEQGJcN Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn7gr8c0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:09:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319K28xC016343;
        Thu, 9 Feb 2023 20:09:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn7gr8bxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:09:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319CkNfE023807;
        Thu, 9 Feb 2023 20:04:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06xmub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:04:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319K4Qke51380530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 20:04:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 283A420043;
        Thu,  9 Feb 2023 20:04:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E0620040;
        Thu,  9 Feb 2023 20:04:25 +0000 (GMT)
Received: from osiris (unknown [9.179.10.102])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Feb 2023 20:04:25 +0000 (GMT)
Date:   Thu, 9 Feb 2023 21:04:24 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+VRyAKnc6N+Vicv@osiris>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
 <Y+BPy3jFcHqOnWL0@x1n>
 <Y+BrJhxeJbAp49QE@casper.infradead.org>
 <Y+BxhuGUx1K+3XHb@xz-m1.local>
 <Y+CLpdnOGFg28uMJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+CLpdnOGFg28uMJ@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SN3n-Sj8UyAs9EywqmZbAifHCHDfdB2o
X-Proofpoint-ORIG-GUID: UKCCI8etZ5fGapHAmtaqPfeeaV5GiOYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=364 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 05:09:57AM +0000, Matthew Wilcox wrote:
> On Sun, Feb 05, 2023 at 10:18:30PM -0500, Peter Xu wrote:
> > On Mon, Feb 06, 2023 at 02:51:18AM +0000, Matthew Wilcox wrote:
> > > That wasn't what I meant.  I meant putting VM_FAULT_BADMAP and
> > > VM_FAULT_SIGSEGV in mm_types.h.  Not having "Here is a range of reserved
> > > arch private ones".
> > 
> > VM_FAULT_SIGSEGV is there already; I assume you meant adding them all
> > directly into vm_fault_reason.
> > 
> > Then I don't think it's a good idea..
> > 
> > Currently vm_fault_reason is a clear interface for handle_mm_fault() for
> > not only arch pffault handlers but also soft faults like GUP.
> > 
> > If handle_mm_fault() doesn't return VM_FAULT_BADMAP at all, I don't think
> > we should have it as public API at all.  When arch1 people reading the
> > VM_FAULT_ documents, it shouldn't care about some fault reason that only
> > happens with arch2.  Gup shouldn't care about it either.
> > 
> > Logically a new page fault handler should handle all the retval of
> > vm_fault_reason afaiu.  That shouldn't include e.g. VM_FAULT_BADMAP either.
> 
> Hmm, right.  Looking specifically at how s390 uses VM_FAULT_BADMAP,
> it just seems to be a badly structured fault.c.  Seems to me that
> do_fault_error() should take an extra si_code argument, and
> instead of returning VM_FAULT_BADACCESS / VM_FAULT_BADMAP from
> various functions, those functions should call do_fault_error()
> directly, passing it VM_FAULT_SIGSEGV and the appropriate si_code.
> 
> But this is all on the s390 people to fix; I don't want to break their
> arch by trying it myself.

Yes, will take a look at it. For now I will apply Peter's patch in order to
get rid of the collision.
