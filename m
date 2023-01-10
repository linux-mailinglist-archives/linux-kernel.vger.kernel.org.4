Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F2664420
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbjAJPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbjAJPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:06:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418295DE75
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:06:33 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEHK03012649;
        Tue, 10 Jan 2023 15:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=r9Ocyd6KC6+Trd8uIRQw20BN7wCdJ+8MQwsMOpaaRck=;
 b=qFSLTprkbDZl4VKQvOqWtJzq4JjGIlkCQhRaENYb5F+LP0iRa0cqb3zFAuqG5WfRRx3i
 /QnjpbaM1e5APhSXCLm1LBSk42a28olOruwxm+UKjwQcKYSMEtH8F9xHEmvH5rfDRfAB
 KV0rvMzHBpJs9rYO0RgAcxHVcplNl5QT3XHx+y2Ie1My9XfyXyq6AqRwb4L29TXHVBWa
 TKi50KquMMnJk7E3ezZ0QBnG4xRiOyCeQMaPKnF8TjH9rTlaA0uGeKRtdhHpn9+cpVcw
 AEXg340VFsUwAk+DAzrKwYRpeXqrIjHaFhWErU4Q52hx1N+cQoN//1rb3UvQZU3BWFAV KQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n188dv95m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:06:20 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30A8SJwX024865;
        Tue, 10 Jan 2023 15:06:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3my0c6bkxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:06:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AF6FeS40763902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:06:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E203A20049;
        Tue, 10 Jan 2023 15:06:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B334620040;
        Tue, 10 Jan 2023 15:06:15 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Jan 2023 15:06:15 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] mm.h: Fix "mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
References: <20230109205300.955019-1-Liam.Howlett@oracle.com>
        <20230109151512.6d06b1d73895414885a698d7@linux-foundation.org>
        <20230110141421.o23coymw44jga4z7@revolver>
Date:   Tue, 10 Jan 2023 16:06:15 +0100
In-Reply-To: <20230110141421.o23coymw44jga4z7@revolver> (Liam Howlett's
        message of "Tue, 10 Jan 2023 14:14:29 +0000")
Message-ID: <yt9dlemaa0pk.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C7qeABTXVpAaPgCVaGDFgcR-Nk9FOh00
X-Proofpoint-GUID: C7qeABTXVpAaPgCVaGDFgcR-Nk9FOh00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=946 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> * Andrew Morton <akpm@linux-foundation.org> [230109 18:15]:
>> On Mon, 9 Jan 2023 20:53:22 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>>=20
>> > The extern definition of __split_vma() was removed too early.  Re-add =
it
>> > and remove it once the users are all converted.
>>=20
>> I think I sorted this out.
>>=20
>> __split_vma() can be made static to mmap.c?
>
> Ah, I don't think so?  SeongJae reported an issue that I caused by
> dropping this definition from the header before mm/madvise.c was updated
> to use the alternative.  I think it needs to be in the header and so it
> should just probably be there until the function is dropped entirely
> later in the series.

FWIW, i encountered that issue while bisecting another maple tree issue
with next-20230110:

linux/mm/madvise.c: In function =E2=80=98madvise_update_vma=E2=80=99:
linux/mm/madvise.c:165:25: error: implicit declaration of function =E2=80=
=98__split_vma=E2=80=99; did you mean =E2=80=98split_vma=E2=80=99? [-Werror=
=3Dimplicit-function-declaration]
  165 |                 error =3D __split_vma(mm, vma, start, 1);
      |                         ^~~~~~~~~~~
      |                         split_vma
cc1: some warnings being treated as errors
make[3]: *** [linux/scripts/Makefile.build:252: mm/madvise.o] Error 1
make[2]: *** [linux/scripts/Makefile.build:504: mm] Error 2
make[1]: *** [linux/Makefile:2008: .] Error 2

Can we instead fix the original patch instead, so bisect works, or is
it too late?
