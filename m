Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B11606D71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJUCLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUCLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:11:52 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84E1EEA2D;
        Thu, 20 Oct 2022 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666318308;
        bh=YYLNRpLFjpOx3zPbx2dWD9ifcWMbbBXNZdhWZRlErMs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FCRNNf/SxQz2jg1jx9wfUn4kq/dv5zt3ogNg+jvjR7fS5A7T6AVrzviTCEDYrY5/b
         SJgfcXBIEmQ5L11Ay9HdYW93i85isJ+0SIeZdw02lZnI4dv3iUu30oGo21olvHTfcL
         J6IOMo7TSic7m5KnQ1U65cMtPwNtzwgqCozc3DPKYPIwsLSWRF7Mdi3NlFHxALjyp4
         kepwEM+z7d+b34Bvu1x0N0AgkijDlgmmPPPF9M7NDjQd0y4fGclhlA59mXCMxmAArT
         yaIAsNIQvGz5JiEVp251at8ZUA1GTHhI5inajwK24QP6h6qdFcTUo5geWRYKebeXBp
         jtMmYS/jv2s/g==
Received: from [10.1.0.216] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Mtnyr1BYXzVCZ;
        Thu, 20 Oct 2022 22:11:48 -0400 (EDT)
Message-ID: <7652446f-424f-35c1-6ebb-c8ffd8c99b1a@efficios.com>
Date:   Thu, 20 Oct 2022 22:11:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] rseq: Use pr_warn_once() when deprecated/unknown ABI
 flags are encountered
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220929141227.205343-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20220929141227.205343-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 10:12, Mathieu Desnoyers wrote:
> These commits use WARN_ON_ONCE() and kill the offending processes when
> deprecated and unknown flags are encountered:
> 
> commit c17a6ff93213 ("rseq: Kill process when unknown flags are encountered in ABI structures")
> commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags")
> 
> The WARN_ON_ONCE() triggered by userspace input prevents use of
> Syzkaller to fuzz the rseq system call.
> 
> Replace this WARN_ON_ONCE() by pr_warn_once() messages which contain
> actually useful information.

Hi Peter,

Should I resubmit this or can you simply pick up the Acked-by from Paul 
McKenney and Mark Rutland and route this through the tip tree ?

Thanks,

Mathieu

> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>   kernel/rseq.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index bda8175f8f99..d38ab944105d 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -171,12 +171,27 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
>   	return 0;
>   }
>   
> +static bool rseq_warn_flags(const char *str, u32 flags)
> +{
> +	u32 test_flags;
> +
> +	if (!flags)
> +		return false;
> +	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
> +	if (test_flags)
> +		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
> +	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
> +	if (test_flags)
> +		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
> +	return true;
> +}
> +
>   static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>   {
>   	u32 flags, event_mask;
>   	int ret;
>   
> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
> +	if (rseq_warn_flags("rseq_cs", cs_flags))
>   		return -EINVAL;
>   
>   	/* Get thread flags. */
> @@ -184,7 +199,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>   	if (ret)
>   		return ret;
>   
> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
> +	if (rseq_warn_flags("rseq", flags))
>   		return -EINVAL;
>   
>   	/*

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

