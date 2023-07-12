Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC92750A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGLOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:06:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6446CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:06:34 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CDq7P6028986;
        Wed, 12 Jul 2023 14:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=gyAL9nlaqhz+X7lvGILGhuNuDghkcTVPCsCPPH0r43M=;
 b=IIGOjwMncnR2mc9CV1qYGe6pCtgzpyJ9eOOvHQDXCp1NcJBnsycbycTY5bCfX4IATjmF
 4U/+XqKgqqYCu+KhhhaZaNz5QS0MsjDhjN3RM3HCTDHSyeMoQFzDX7xSeSaIsunSTmCu
 pvDvYUnFRY6jEP/F/qCxsdb6e4a9hZK/EYaXAAsMWIgcKQvE5a57nylyRNI5UOknsi9Z
 rc484Hl+WnZ/HtNsYe3k98ydrmWrKH3bf1ZhGgl/1QDapcED9fASXHKLJrmKTvob4gMR
 hkxiCmlmsxA64WxAtbUMhrvfOYkJaYfyrwCcvGd7XaHGeIp1n8H9ta04JWZ7kL5VUODb DA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsweh0aky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:06:32 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CCZIMG005900;
        Wed, 12 Jul 2023 14:06:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rpye59xjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:06:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CE6SZI58786208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 14:06:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5422004D;
        Wed, 12 Jul 2023 14:06:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9E3920040;
        Wed, 12 Jul 2023 14:06:27 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Jul 2023 14:06:27 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
        <yt9dttva8gxt.fsf@linux.ibm.com>
Date:   Wed, 12 Jul 2023 16:06:27 +0200
In-Reply-To: <yt9dttva8gxt.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Wed, 14 Jun 2023 12:41:02 +0200")
Message-ID: <yt9dilap442k.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RvdxYV9PFKA5_XpuakRtznswAUQlwkD1
X-Proofpoint-ORIG-GUID: RvdxYV9PFKA5_XpuakRtznswAUQlwkD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_09,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=632 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120126
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

Sven Schnelle <svens@linux.ibm.com> writes:

> Steven Rostedt <rostedt@goodmis.org> writes:
>
>> On Tue, 13 Jun 2023 07:19:14 +0200
>> Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>>> > Yes the above may be special, but your patch breaks it.  
>>> 
>>> Indeed, i'm feeling a bit stupid for sending that patch, should have
>>> used my brain during reading the source. Thanks for the explanation.
>>
>> Does this quiet the fortifier?
>> [..]
>
> No, still getting the same warning:
>
> [    2.302776] memcpy: detected field-spanning write (size 104) of single field "stack" at kernel/trace/trace.c:3178 (size 64)

BTW, i'm seeing the same error on x86 with current master when
CONFIG_FORTIFY_SOURCE=y and CONFIG_SCHED_TRACER=y:

[    3.089395] Testing tracer wakeup: 
[    3.205602] ------------[ cut here ]------------
[    3.205958] memcpy: detected field-spanning write (size 112) of single field "&entry->caller" at kernel/trace/trace.c:3173 (size 64)
[    3.205958] WARNING: CPU: 1 PID: 0 at kernel/trace/trace.c:3173 __ftrace_trace_stack+0x1d1/0x1e0
[    3.205958] Modules linked in:
[    3.205958] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc1-00012-g77341f6d2110-dirty #50
[    3.205958] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[    3.205958] RIP: 0010:__ftrace_trace_stack+0x1d1/0x1e0
[    3.205958] Code: ff ff ff b9 40 00 00 00 4c 89 f6 48 c7 c2 d8 d3 9a 82 48 c7 c7 e8 82 99 82 48 89 44 24 08 c6 05 9d 8c 30 02 01 e8 0f 88 ed ff <0f> 0b 48 8b 44 24 08 e9 f4 fe ff ff 0f 1f 00 90 90 90 90 90 90 90
[    3.205958] RSP: 0000:ffffc90000100ee0 EFLAGS: 00010086
[    3.205958] RAX: 0000000000000000 RBX: ffff8881003db034 RCX: c0000000ffffdfff
[    3.205958] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
[    3.205958] RBP: ffff8881003db03c R08: 0000000000000000 R09: ffffc90000100d88
[    3.205958] R10: 0000000000000003 R11: ffffffff83343008 R12: ffff88810007a100
[    3.205958] R13: 000000000000000e R14: 0000000000000070 R15: 0000000000000070
[    3.205958] FS:  0000000000000000(0000) GS:ffff88817bc40000(0000) knlGS:0000000000000000
[    3.205958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.205958] CR2: 0000000000000000 CR3: 000000000322e000 CR4: 00000000000006e0
[    3.205958] Call Trace:
[    3.205958]  <IRQ>
[    3.205958]  ? __ftrace_trace_stack+0x1d1/0x1e0
[    3.205958]  ? __warn+0x81/0x130
[    3.205958]  ? __ftrace_trace_stack+0x1d1/0x1e0
[    3.205958]  ? report_bug+0x171/0x1a0
[    3.205958]  ? handle_bug+0x3a/0x70
[    3.205958]  ? exc_invalid_op+0x17/0x70
[    3.205958]  ? asm_exc_invalid_op+0x1a/0x20
[    3.205958]  ? __ftrace_trace_stack+0x1d1/0x1e0
[    3.205958]  probe_wakeup+0x28e/0x340
[    3.205958]  ttwu_do_activate.isra.0+0x132/0x190
[    3.205958]  sched_ttwu_pending+0x97/0x110
[    3.205958]  __flush_smp_call_function_queue+0x131/0x400
[    3.205958]  __sysvec_call_function_single+0x2d/0xd0
[    3.205958]  sysvec_call_function_single+0x65/0x80
[    3.205958]  </IRQ>
[    3.205958]  <TASK>
[    3.205958]  asm_sysvec_call_function_single+0x1a/0x20
[    3.205958] RIP: 0010:default_idle+0xf/0x20
[    3.205958] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 43 5f 31 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
