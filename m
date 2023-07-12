Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F3750B12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGLObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjGLObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:31:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60519A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:31:22 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEI4gM029482;
        Wed, 12 Jul 2023 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=0qN++vhps9D5skRw+Cc5as9g/U/Qqcn/uH+KXdz/GVQ=;
 b=nIkV2VNC1mW4CJwNQMwuQnKK1J94whQsfeKo9MPbKqrXy3gXr/BR1+3sFweDlyf8AcsA
 OBPYZeFUUd72h0VknC1r9SsY5LhP4NFhH8UzTnq0J8E98Ef125/+lM84KZ2pAcBnmOu9
 5Ui6U6YPdgGEe7lynKCfD5J+5apPp/OLZ3AzOYTDk9IBDyao39FGH1fXM94nUXKHEKMd
 cBaNP+yEB9fFzTzVOUrvRu6DI/l6ETZpaXp6khyLhC9ZmNiLlVxKQosx6nykxLarrfRZ
 kY7tIIApuHOKhj2A5CVPgLb9HkuLMxA+RQSBMeGIqg+/ceHkB7/7E5+zT/Age5n/HGMZ ow== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rswp4rttp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:31:20 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CD4aBQ022897;
        Wed, 12 Jul 2023 14:31:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rpye51xw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:31:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CEVFdL65077622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 14:31:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3BEF20043;
        Wed, 12 Jul 2023 14:31:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FFA20040;
        Wed, 12 Jul 2023 14:31:15 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Jul 2023 14:31:15 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
        <yt9dttva8gxt.fsf@linux.ibm.com> <yt9dilap442k.fsf@linux.ibm.com>
        <20230712101434.4613b3ec@gandalf.local.home>
Date:   Wed, 12 Jul 2023 16:31:15 +0200
In-Reply-To: <20230712101434.4613b3ec@gandalf.local.home> (Steven Rostedt's
        message of "Wed, 12 Jul 2023 10:14:34 -0400")
Message-ID: <yt9d1qhdfbgs.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8ZT9y_7ALEkLt0YNj7x2bVMUVm73bxzI
X-Proofpoint-GUID: 8ZT9y_7ALEkLt0YNj7x2bVMUVm73bxzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_09,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 12 Jul 2023 16:06:27 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> > No, still getting the same warning:
>> >
>> > [    2.302776] memcpy: detected field-spanning write (size 104) of single field "stack" at kernel/trace/trace.c:3178 (size 64)  
>> 
>> BTW, i'm seeing the same error on x86 with current master when
>> CONFIG_FORTIFY_SOURCE=y and CONFIG_SCHED_TRACER=y:
>
> As I don't know how the fortifier works, nor what exactly it is checking,
> do you have any idea on how to quiet it?
>
> This is a false positive, as I described before.

The "problem" is that struct stack_entry is

struct stack_entry {
       int size;
       unsigned long caller[8];
};

So, as you explained, the ringbuffer code allocates some space after the
struct for additional entries:

struct stack_entry 1;
<additional space for 1>
struct stack_entry 2;
<additional space for 2>
...

But the struct member that is passed to memcpy still has the type
information 'caller is an array with 8 members of 8 bytes', so memcpy
fortify complains. I'm not sure whether we can blame the compiler or
the fortify code here.

One (ugly and whitespace damaged) workaround is:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35b11f5a9519..31acd8a6b97e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3170,7 +3170,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
                goto out;
        entry = ring_buffer_event_data(event);
 
-       memcpy(&entry->caller, fstack->calls, size);
+       void *p = entry + offsetof(struct stack_entry, caller);
+       memcpy(p, fstack->calls, size);
        entry->size = nr_entries;
 
        if (!call_filter_check_discard(call, entry, buffer, event))


So with that offsetof calculation the compiler doesn't know about the 8
entries * 8 bytes limitation. Adding Kees to the thread, maybe he knows
some way.
