Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E162E3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiKQSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiKQSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:19:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB32C13A;
        Thu, 17 Nov 2022 10:19:39 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHDL5p011515;
        Thu, 17 Nov 2022 18:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PnCHO8g/GAQ/rf4fFCGrPAgXoqy0R+mFNfmTOXAovDM=;
 b=oX+gdjyTpN6rkOiSFyFJPg5syMQCqf3QZic6D8wv/IX9kPtJw9FlJ8MEaytc6HfGshEG
 XmdnSKv2mBcZnAFVGK8Sqqgh8If6ZmezQo0CuAOt9DlCeN4teirK+x8DPTq2HScz/rfP
 xxEyBdqMjIA3Hu3FlLP5Y4v7OqOJ5b6J7Kf1V0qUj0jhyeJ+tIGV+C50fSeXM9Xql0Rk
 QIApta7A/x2bVnl1VfxAH90/P32HWre1SZkbCQEvz5N54PTXHVI5sz0Uoun68Qtc8wPW
 4Q5R2syQAWan1yvRmA/AFcFFUE87RrrlYtxYVhG2H6IqjIzFvl1BzCjvP0E6NGe2JLkt wQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kws5q9j90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:19:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHI6mN6008712;
        Thu, 17 Nov 2022 18:19:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjfvxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:19:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHIJXSk62259656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:19:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1EE152050;
        Thu, 17 Nov 2022 18:19:33 +0000 (GMT)
Received: from osiris (unknown [9.145.178.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 84B2B5204E;
        Thu, 17 Nov 2022 18:19:33 +0000 (GMT)
Date:   Thu, 17 Nov 2022 19:19:32 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: cmpxchg: Make loop condition for 1,2 byte cases
 precise
Message-ID: <Y3Z7NA7eGV2SiRAb@osiris>
References: <Y2zhNhFjIJPKJao8@osiris>
 <20221116144711.3811011-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116144711.3811011-1-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fxd4wSsq4xG7WBaBBx5LWT4agSTjMHe6
X-Proofpoint-GUID: Fxd4wSsq4xG7WBaBBx5LWT4agSTjMHe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=711 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:47:11PM +0100, Janis Schoetterl-Glausch wrote:
> The cmpxchg implementation for 1 and 2 bytes consists of a 4 byte
> cmpxchg loop. Currently, the decision to retry is imprecise, looping if
> bits outside the target byte(s) change instead of retrying until the
> target byte(s) differ from the old value.
> E.g. if an attempt to exchange (prev_left_0 old_bytes prev_right_0) is
> made and it fails because the word at the address is
> (prev_left_1 x prev_right_1) where both x != old_bytes and one of the
> prev_*_1 values differs from the respective prev_*_0 value, the cmpxchg
> is retried, even if by a semantic equivalent to a normal cmpxchg, the
> exchange would fail.
> Instead exit the loop if x != old_bytes and retry otherwise.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Unfortunately the diff got blown up quite a bit, even tho the asm
> changes are not that complex. This is mostly because of in arguments
> becoming (in)out arguments.
> 
> I don't think all the '&' constraints are necessary, but I don't see how
> they could affect code generation.

For cmpxchg() it wouldn't make any difference. For cmpxchg_user_key()
it might lead to a small improvement, since the register that is
allocated for the key variable might be reused. But I haven't looked
into that in detail. None of the early clobbers is necessary anymore
after your changes, but let's leave it as it is.

> I don't see why we would need the memory clobber, however.

The memory clobber (aka memory barrier) is necessary because it may be
used to implement e.g. some custom locking. For that it is required
the compiler does reorder read or write accesses behind/before the
inline assembly.

> I tested the cmpxchg_user_key changes via the kvm memop selftest that is
> part of the KVM cmpxchg memop series.
> I looked for an existing way to test the cmpxchg changes, but didn't
> find anything.

Yeah, guess having a test for this would be a nice to have :)

>  arch/s390/include/asm/cmpxchg.h | 60 ++++++++++++++-----------
>  arch/s390/include/asm/uaccess.h | 80 ++++++++++++++++++---------------
>  2 files changed, 78 insertions(+), 62 deletions(-)

The patch looks good - applied to the wip/cmpxchg_user_key branch.
