Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8B695141
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBMUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBMUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:01:10 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1C2D7E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:01:09 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u76so2007454ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3rqNrOGG3NE7KVABcOh1L3XSdKBmVXLQ3MKHWAA7VE=;
        b=P+S3IG8GveYuXnlbC4C6v2XEkz8JPEMhQ4X23a1GroUzDyFz2S9xGk+SD5H3SD+H4Q
         y5Fw4J1GzqLVIMh2hoGN6+alZzrbIHntHzWcXDkRdXcGgJI90QMN89TvWy16baFJEzuB
         5XumGcCCsed1iwVovmimvTVe7i5CPFA2oLqy2NbOoE7NtNR7jsLm3T/+X2t6QBirxB+H
         0f1zOrxi6b1Jy4YadKvLMPLJXRoOL8/A8VynhmqLyhRYfbN0djpi7511drq1Ad4/B3D9
         Bp+TZs37tmCx4v20VNVoFXaI8CFot7ZtjCrwPQzawo5A7PMICGNJyMaNE3lBBtnTmsFQ
         l+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3rqNrOGG3NE7KVABcOh1L3XSdKBmVXLQ3MKHWAA7VE=;
        b=YicswCfYVPOiuLUwGKsfLMs6uuOh66SKMRwzxI7bF9l/nRAuQ+3YAV0P6/Az4dMj9l
         Fhg/dxB/XStT+HjczaXFMcs+VDvIfXWRui+witLkXSP+2cB8/ik0fUWt4P3Rq4YHShvy
         CYyy1jhiLhfmvc8baTEDScqDjYgcIH630pLlrJyJqBoZWSGPGHUzV+Vj4zvo5TzAPVBy
         wDnlfTHUKvfasE603yKJt/nLreIHRsiOtApBNkocGzTuzE78TU8bsMXGZ62t0EwdwM8o
         qPTZdl4Kb8GbrAXoT19P0mI3i/fbglWnaKtDEffRFSDBdi/vpLHzKeCYnNWXr8b2LWNk
         dglg==
X-Gm-Message-State: AO0yUKUAsAISG8vzvlxfi8uhcVwU4bOMdx1dgudKF0d4JlLpWjLFZWMd
        EAQg9kAXGNBfcP4mLotRRaS00S4Lnz6ARJe6WTdFkNvkBjeoOMrdvA==
X-Google-Smtp-Source: AK7set9cujURK2755Vgmgt5hgB2/P1gAmfwKPBZDeDmoigDY+9bUaEr5mkJ71jp4aPSZxwxkRv+fxnJKNXTd3pOcnvE=
X-Received: by 2002:a5b:907:0:b0:872:7569:80c9 with SMTP id
 a7-20020a5b0907000000b00872756980c9mr13440ybq.112.1676318468190; Mon, 13 Feb
 2023 12:01:08 -0800 (PST)
MIME-Version: 1.0
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
In-Reply-To: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Feb 2023 12:00:56 -0800
Message-ID: <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
Subject: Re: [Question] softlockup in run_timer_softirq
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        peterz@infradead.org, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 1:51 AM liujian (CE) <liujian56@huawei.com> wrote:
>
> During the syz test, we encountered many problems with various timer handler
> functions softlockup.
>
> We analyze __run_timers() and find the following problem.
>
> In the while loop of __run_timers(), because there are too many timers or
> improper timer handler functions, if the processing time of the expired
> timers is always greater than the time wheel's next_expiry, the function
> will loop infinitely.
>
> The following extreme test case can be used to reproduce the problem.
> An extreme test case[1] is constructed to reproduce the problem.

Thanks for reporting and sending out this data:

First, any chance you might submit this as a in-kernel-stress test?
Maybe utilizing the kernel/torture.c framework?

(Though the test may need to occasionally take a break so the system
can eventually catch up)

> Is this a problem or an unreasonable use?
>
> Can we limit the running time of __run_timers() [2]?
>
> Does anyone have a good idea to solve this problem?

So your patch reminds me of Peter's softirq_needs_break() logic:
  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=core/softirq

Maybe it could extend that series for the timer softirq as well?

thanks
-john
