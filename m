Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7559750B14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjGLOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGLOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:32:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B2DFB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:32:11 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEH6V5002753;
        Wed, 12 Jul 2023 14:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=yGwM2rdpDP9tzfPzKMoWWdYJTnVokAF6g9Z7mFwK+00=;
 b=U7vEwP49IeQ+TNqFmFc36hKZA3WpgXAWMylt7803WBHHsmYk8u+/b0rjg7/HdVP7vXIE
 pqIFNtsvcVndMzlU4Zz3sP36srRkHJKItJPhjOHGTJGpuIt+U6+bwPz8dbG3lwJ5Hz7w
 ds50ohRbmBxwrjALhV6OKdcgNXO3K0pKWh0qk2O8UjEm8Ij/dxPZBg78Ipxd4H52JRd4
 5xdAHLzRI7+dQyTWRyhVtAEFX6gBLRjv9fnIVAHHDrpULPKbtqiXH47+rI26gv56ky0E
 TmyK91i8vfLychA2kw6m1GPKqs1gvlwwVPS2RcRPremYfQfaryuoPXLo/a4ls0OezlBv 1Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rswt38m10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:32:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C21QjP011130;
        Wed, 12 Jul 2023 14:32:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye5aphr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:32:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CEW5sD24314478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 14:32:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05ED2004B;
        Wed, 12 Jul 2023 14:32:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C927D20043;
        Wed, 12 Jul 2023 14:32:04 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Jul 2023 14:32:04 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
        <yt9dttva8gxt.fsf@linux.ibm.com> <yt9dilap442k.fsf@linux.ibm.com>
        <20230712101434.4613b3ec@gandalf.local.home>
        <20230712102621.4c588de9@gandalf.local.home>
Date:   Wed, 12 Jul 2023 16:32:04 +0200
In-Reply-To: <20230712102621.4c588de9@gandalf.local.home> (Steven Rostedt's
        message of "Wed, 12 Jul 2023 10:26:21 -0400")
Message-ID: <yt9dwmz5dwuz.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _yR29c0e9sJOxiIdr0UaKyYKkLuZS6MM
X-Proofpoint-ORIG-GUID: _yR29c0e9sJOxiIdr0UaKyYKkLuZS6MM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_09,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120131
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

>> As I don't know how the fortifier works, nor what exactly it is checking,
>> do you have any idea on how to quiet it?
>> 
>> This is a false positive, as I described before.
>
>
> Hmm, maybe this would work?
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4529e264cb86..20122eeccf97 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	struct ftrace_stack *fstack;
>  	struct stack_entry *entry;
>  	int stackidx;
> +	void *ptr;
>  
>  	/*
>  	 * Add one, for this function and the call to save_stack_trace()
> @@ -3161,9 +3162,25 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  				    trace_ctx);
>  	if (!event)
>  		goto out;
> -	entry = ring_buffer_event_data(event);
> +	ptr = ring_buffer_event_data(event);
> +	entry = ptr;
> +
> +	/*
> +	 * For backward compatibility reasons, the entry->caller is an
> +	 * array of 8 slots to store the stack. This is also exported
> +	 * to user space. The amount allocated on the ring buffer actually
> +	 * holds enough for the stack specified by nr_entries. This will
> +	 * go into the location of entry->caller. Due to string fortifiers
> +	 * checking the size of the destination of memcpy() it triggers
> +	 * when it detects that size is greater than 8. To hide this from
> +	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
> +	 *
> +	 * The below is really just:
> +	 *   memcpy(&entry->caller, fstack->calls, size);
> +	 */
> +	ptr += offsetof(typeof(*entry), caller);
> +	memcpy(ptr, fstack->calls, size);
>  
> -	memcpy(&entry->caller, fstack->calls, size);
>  	entry->size = nr_entries;
>  
>  	if (!call_filter_check_discard(call, entry, buffer, event))
>
>

I just sent about the same thing without the nice comment. So yes, this
works. :-)
