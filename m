Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9465AEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjABJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjABJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:33:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3138B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:33:50 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302861DO004535;
        Mon, 2 Jan 2023 09:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=2uLaxQ+WrPoqDFSbkZCdMa71Obu0srQTGUQ8NnptaNQ=;
 b=NiGsnTkwnKAd1N4nBUljTYDM5i0tYWAn6LO/zbADsAYOTW0kn6ZGFCNHZY2gngjqpeq3
 Whd9houH4eK53uIkMUBA/Xsguh2o9u/QGyKOKCO6uw8pT+ruEA7Qc/fO00Qgyc0errQO
 64krV86+2mniapd66xwftEFFo/xBIzNxpGD1BZArueDZjXGrOCHmE08vn7T59znuh1oT
 XowDD12cO/RcfMMOlDJqX7BPr7OXSOhSxXkNZlYgnovgMdRHAHT9pjr9kSTZyP6w9mlk
 rdqSml6ueMzhvubzC5j4WxzrmnjwMQ/Bt4zEjopwDkmFMhOpsER+JLXk1jDWTZ4Zsrfr 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxucwg6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 09:33:14 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3029SboM031751;
        Mon, 2 Jan 2023 09:33:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxucwg6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 09:33:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3020AtrT001428;
        Mon, 2 Jan 2023 09:33:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfa7va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 09:33:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3029X90D45023536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 09:33:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4737F2004B;
        Mon,  2 Jan 2023 09:33:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24BBC20043;
        Mon,  2 Jan 2023 09:33:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 09:33:09 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 2/5] nolibc: add support for s390
References: <20221209141939.3634586-1-svens@linux.ibm.com>
        <20221209141939.3634586-3-svens@linux.ibm.com>
        <20221227213530.GA6390@1wt.eu> <yt9dilhpjqpr.fsf@linux.ibm.com>
        <20230102084122.GB29287@1wt.eu>
Date:   Mon, 02 Jan 2023 10:33:08 +0100
In-Reply-To: <20230102084122.GB29287@1wt.eu> (Willy Tarreau's message of "Mon,
        2 Jan 2023 09:41:22 +0100")
Message-ID: <yt9dedsdjn6z.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WvhY0Wb5WIWa3dNCtcaWOh7K_twlUgn3
X-Proofpoint-ORIG-GUID: 0hkTxfQC_9yyEJ9l0OW8KjpLne274lSR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_05,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=799 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Mon, Jan 02, 2023 at 09:17:04AM +0100, Sven Schnelle wrote:
>> The kernel compiles with z10 as minimum architecture, so
>> i'm leaning towards enforcing the same arch for nolibc. What do you think?
>
> Sure, as long as this works for most users, that's likely fine.
> Alternately, are there equivalent sequences of instructions that achieve
> the same on older architectures, and would that be relevant ?

Well, it's only one instruction that needs to be changed - we could also
use aghi to do the same thing. Maybe that's better.

Also i will add -m64 to the testing Makefile, it shouldn't hurt.

> One future improvement I'll need will be to store the envp value into a
> global "environ" variable, and run over it to catch the pointer that
> follows the NULL and save it into the "_auxv" variable. I've done it for
> all other archs here already:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20221227-nolibc-weak-4
>
> I'll give it a try once I'm able to build and test your code, and may
> ask you for some help if I don't succeed in doing it. If you want to do
> it yourself, please have a look at the last commits adding environ and
> auxv to any arch of your choice, such as x86_64.

Ok, thanks for the Heads-Up. I'll take a look. I think i would send this
as a separate Patch, so we get the initial support done first if that's ok.
