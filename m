Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510BA6DF141
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDLJ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDLJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:58:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A36A57
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:58:19 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C9Kxe7023544;
        Wed, 12 Apr 2023 09:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gvTiANyY+7D45YVc9m0E9ZD8jOfzBtM5sDehKWkiKRY=;
 b=hFJyQMizwgC8h+shVllb5Wjt4vgk1bqfgtTBzbibjKhY3KC0tNPhnv7hks9h9JxxartO
 rYMwjlBAgiferMV5O/nt9gEUawrVLymU2cP70e5PZImXcgV/rNbREht96U6HIOHDeG6J
 hoMuR2xy6L8967ZIy/Bge1Y6YBR9NKfqRIhmlxG4Oe9egTp2xWFyEXOwGDeTKD3GUoUQ
 FMJ75S2uQeuRmJmm2hhkXRUcfHUgDZTkzawXlaCpWETBFTinipe2GXuN7d/mfv5vEKaL
 bI8tB+Axlo63+REGP2qh44/f8ZbAJOsmgrpi3XFcrAMNwg2UewgDuKFqyL5TOxSZ//pI Uw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwpwr152j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 09:58:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C9LaBX000902;
        Wed, 12 Apr 2023 09:58:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m2293e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 09:58:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C9w9fs25428554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 09:58:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB76E20040;
        Wed, 12 Apr 2023 09:58:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B93C20043;
        Wed, 12 Apr 2023 09:58:09 +0000 (GMT)
Received: from osiris (unknown [9.171.40.40])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 09:58:09 +0000 (GMT)
Date:   Wed, 12 Apr 2023 11:58:07 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] stackleak: allow to specify arch specific stackleak
 poison function
Message-ID: <ZDaAr0Tg5DPJM9BY@osiris>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
 <20230405130841.1350565-2-hca@linux.ibm.com>
 <ZDZz8QvPdpGJqMd6@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDZz8QvPdpGJqMd6@FVFF77S0Q05N>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VXwsbMVW5bIn8FVN_CNrls0KPIwz2qp8
X-Proofpoint-GUID: VXwsbMVW5bIn8FVN_CNrls0KPIwz2qp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=278
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:03:46AM +0100, Mark Rutland wrote:
> On Wed, Apr 05, 2023 at 03:08:40PM +0200, Heiko Carstens wrote:
> > Factor out the code that fills the stack with the stackleak poison value
> > in order to allow architectures to provide a faster implementation.
> > 
> > Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> As on patch 2, it might be nicer to have a noinstr-safe memset64() and use that
> directly, but I don't have strong feelings either way, and I'll defer to Kees's
> judgement:

Wouldn't that enforce that memset64() wouldn't be allowed to have an own
stackframe, since otherwise it would write poison values to it, since we
have

	if (on_task_stack)
		erase_high = current_stack_pointer;

in __stackleak_erase()?

That was actually my motiviation to make this s390 optimization an always
inline asm.

Besides that this wouldn't be a problem for at least s390, since memset64()
is an asm function which comes whithout the need for a stackframe, but on
the other hand this would add a quite subtle requirement to memset64(), if
I'm not mistaken.
