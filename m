Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA172D904
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbjFMFT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjFMFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:19:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC6E79
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:19:46 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D4o1gq004570;
        Tue, 13 Jun 2023 05:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=MrYXrxW8j1E1qxfXdt+55Beucp1/X5+Ov6Rjpc40ssY=;
 b=FyHIyvMfEpcp4X2tax318HlU3pMt56UAPwJYg+2w2rBjPFC8TbnDCS3MsIuq22gVT6af
 hnbdlbiJ9nM3bkgeeF0XRJzJKvAjl8Wc4YdtKtzUx7AjQHh4A8UV3oSLFVGtZ2kr/5qq
 O/AGvA8ET/5Rat+CDehU0X13Id40WVVx6UK7LBwORHwmjpm8U4lQqiWS3HSvash1eVNr
 iwiknV5+gdhSTEUmlVyxRibS6hxLDwza7pWvAylPerGi+gGbeZq8fiowpNzBhqvFs4U0
 zxx0GKEZbUMs3lCpKaomBQxNAPyPRri2wFLhHrXP8mUeIHw55Xng571HkdlCs011B9/E dw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6hs50mna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 05:19:19 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D4acjq009635;
        Tue, 13 Jun 2023 05:19:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r4gt51d94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 05:19:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35D5JE3Q36634884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 05:19:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E19E220043;
        Tue, 13 Jun 2023 05:19:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC9220040;
        Tue, 13 Jun 2023 05:19:14 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Jun 2023 05:19:14 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
Date:   Tue, 13 Jun 2023 07:19:14 +0200
In-Reply-To: <20230612123407.5ebcabdf@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 12 Jun 2023 12:34:07 -0400")
Message-ID: <yt9dy1koey7h.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r7tD4j2k0QkKgtzbM8rXuPZmm5m4yj-8
X-Proofpoint-ORIG-GUID: r7tD4j2k0QkKgtzbM8rXuPZmm5m4yj-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=860
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 12 Jun 2023 18:07:48 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> Noticed the following warning during boot:
>> 
>> [    2.316341] Testing tracer wakeup:
>> [    2.383512] ------------[ cut here ]------------
>> [    2.383517] memcpy: detected field-spanning write (size 104) of single field "&entry->caller" at kernel/trace/trace.c:3167 (size 64)
>> 
>> The reason seems to be that the maximum number of entries is calculated
>> from the size of the fstack->calls array which is 128. But later the same
>> size is used to memcpy() the entries to entry->callers, which has only
>> room for eight elements. Therefore use the minimum of both arrays as limit.
>> 
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  kernel/trace/trace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 64a4dde073ef..988d664c13ec 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -3146,7 +3146,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>>  	barrier();
>>  
>>  	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
>> -	size = ARRAY_SIZE(fstack->calls);
>> +	size = min(ARRAY_SIZE(entry->caller), ARRAY_SIZE(fstack->calls));
>
> No, this is not how it works, and this breaks the stack tracing code.
> [..]
> The old way use to just record the 8 entries, but that was not very useful
> in real world analysis. Your patch takes that away. Might as well just
> record directly into the ring buffer again like it use to.
>
> Yes the above may be special, but your patch breaks it.

Indeed, i'm feeling a bit stupid for sending that patch, should have
used my brain during reading the source. Thanks for the explanation.
