Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF59265C6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjACTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbjACTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:04:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4D12AFA;
        Tue,  3 Jan 2023 11:03:59 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IFEO6025375;
        Tue, 3 Jan 2023 19:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=74AI/ynE6YGffYmhdsZlb/SD/hZgGQK0DkgHQIeRABg=;
 b=N5l2QpQ/9eoFRqHaA+tkkCy93Rr1o01/gVuBQf0JpEiNthVmeFeprGWfzXu8ZlpeQYnT
 KMa7Fc+TnpI4I7fA8LZiZrA+/txAJZYEBJrH6OUd7maJcmg1fQuGhLD/D8zdmSUIhoUF
 wKFeagOSGI/VhH6SePmwfg2s9cR3BW73VflAjTNpRSGmRwuxdDnnxRVDsEvILpso43ZX
 WVaotSbERrf02aXCOCIwPHp1Pimu7Pfi3WW30y/vGRdM5rHERoNQUusZKu0meQwOufUS
 mbmtiqykSxod8oLWI/Wv6m4MOpazHcOcwRWHmxPukXk3PE067L4mrT+61Ne7uABUjWvH /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvf3am4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 19:03:29 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303IYupC003388;
        Tue, 3 Jan 2023 19:03:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvf3ak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 19:03:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303AGuqM017352;
        Tue, 3 Jan 2023 19:03:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6u3bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 19:03:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303J3O6b42467742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 19:03:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C60B420043;
        Tue,  3 Jan 2023 19:03:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32C0220040;
        Tue,  3 Jan 2023 19:03:24 +0000 (GMT)
Received: from osiris (unknown [9.171.65.115])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 19:03:24 +0000 (GMT)
Date:   Tue, 3 Jan 2023 20:03:20 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/5] selftests/nolibc: add s390 support
Message-ID: <Y7R7+BIEvFdxMJIu@osiris>
References: <20230103071957.222360-1-svens@linux.ibm.com>
 <20230103071957.222360-4-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103071957.222360-4-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rh_xE76xdcJyWjlZIFvAR_MVLEmgDkYo
X-Proofpoint-GUID: LBFaDc2BbovnaaxdhXWgjphnmmBK7p7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=788
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 08:19:55AM +0100, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  tools/testing/selftests/nolibc/Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
...
> -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
> +CFLAGS_s390 = -m64
> +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))

Since this adds support for architecture specific compile flags, you
might as well want to add -march=z10, since that's the minimum
architecture level for the kernel we support anyway.

That way you won't end up with problems like the lay instruction, and
could also use cghsi for zero comparison. Not that I'm proposing that
you should change the asm code again, it is fine as it is now.
