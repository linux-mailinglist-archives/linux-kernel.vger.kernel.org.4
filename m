Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099065ADF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjABIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjABIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:17:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E31096
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:17:39 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3028DQTd001953;
        Mon, 2 Jan 2023 08:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=CnnKBTOrx893yNtBm6v7aNUWdAlqz/gSxaFOcZYtR5s=;
 b=tCfo+o8fBK1A5O/WPbzc2eGJzRK0g7VPA8bvACeweDvGMpiNeZMBHkxFUeeXHIFZ/4D5
 LHPa0eu4ejj1mMWTPvcQVmcSLzt5OKxOzpiljw1uBmpppBsvZ6TZA4qx+4tV73v/QQMw
 hnfQvzKhPtnajGnannd1astrTut7yzI38UumraOEmt05OnkgkHW6WbqkO3vWnHkQnAeF
 fNFSHP+yk68g/Zs7yMluLY15hiC3oj0yNEr5XtZfYdIKRiBIuRIYbkI2lYr8Mr8mJ052
 SgDQj7GqhQG1x3eLADmVIupA1MIDettUw59BRGQLbmvL242KJkx8tFNFLr7bmC/D5jd2 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxx6mc5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 08:17:09 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3028H9X2006743;
        Mon, 2 Jan 2023 08:17:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxx6mc4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 08:17:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 301LtOdK014123;
        Mon, 2 Jan 2023 08:17:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6hk9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 08:17:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3028H4xq48365886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 08:17:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 959D020049;
        Mon,  2 Jan 2023 08:17:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7106620043;
        Mon,  2 Jan 2023 08:17:04 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 08:17:04 +0000 (GMT)
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
        <20221227213530.GA6390@1wt.eu>
Date:   Mon, 02 Jan 2023 09:17:04 +0100
In-Reply-To: <20221227213530.GA6390@1wt.eu> (Willy Tarreau's message of "Tue,
        27 Dec 2022 22:35:30 +0100")
Message-ID: <yt9dilhpjqpr.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mcz5OGe7JopgnIX2g4n_Zz-bfPKfC2eV
X-Proofpoint-GUID: eBDv4SeuOGCpanI35jJFd3qCm_qc0qh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_03,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Willy Tarreau <w@1wt.eu> writes:

> On Fri, Dec 09, 2022 at 03:19:36PM +0100, Sven Schnelle wrote:
>> Use arch-x86_64 as a template. Not really different, but
>> we have our own mmap syscall which takes a structure instead
>> of discrete arguments.
> (...)
>
> This evening I downloaded an s390 toolchain from kernel.org's nolibc
> toolchains and expected to test the code under qemu, but I met two
> build errors.
>
> The first one is that __maybe_unused breaks the build below:
>
>> +static __maybe_unused
>> +void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>> +	       off_t offset)
>
> And indeed, __maybe_unused is not defined here in userland. The following
> patch allows to go further:
>
>   diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
>   index 34b744e2f7d6..effae6e3d9e2 100644
>   --- a/tools/include/nolibc/arch-s390.h
>   +++ b/tools/include/nolibc/arch-s390.h
>   @@ -194,7 +194,7 @@ struct s390_mmap_arg_struct {
>           unsigned long offset;
>    };
>    
>   -static __maybe_unused
>   +static __attribute__((unused))
>    void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>                  off_t offset)
>    {

Hrm, yes. I didn't thought about this macro not being present.

> But with this addressed, I'm facing this next error:
>
>   $ make nolibc-test LDFLAGS= ARCH=s390 CC=/f/tc/nolibc/gcc-12.2.0-nolibc/s390-linux/bin/s390-linux-gcc
>     MKDIR   sysroot/s390/include
>   make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
>   make[2]: Entering directory '/g/public/linux/master'
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[2]: Entering directory '/g/public/linux/master'
>     INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
>     CC      nolibc-test
>   /tmp/ccCzaBgD.s: Assembler messages:
>   /tmp/ccCzaBgD.s:9: Error: Unrecognized opcode: `lg'
>   /tmp/ccCzaBgD.s:12: Error: Unrecognized opcode: `lay'
>   /tmp/ccCzaBgD.s:15: Error: Unrecognized opcode: `lghi'
>   make: *** [Makefile:108: nolibc-test] Error 1
>
> Thus I'm wondering if specific options are required for the compiler
> (it's gcc 12.2.0 + binutils 2.39), if I'm not using the proper compiler,
> or if there's anything wrong in the asm code (e.g. maybe by accident you
> sent the patch from an earlier development branch), or anything else ?

Hmm, tried this on my x86 laptop, and it looks like there are two things
here:

The cross compiler needs -m64 to compile in 64bit mode. otherwise it
assumes 31bit mode, where both lg and lghi are not present. The other
thing is that lay was introduced with later generations of the
z/Architecture. The kernel compiles with z10 as minimum architecture, so
i'm leaning towards enforcing the same arch for nolibc. What do you think?
