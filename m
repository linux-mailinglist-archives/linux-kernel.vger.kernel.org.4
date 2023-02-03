Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4868A302
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBCTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjBCTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:30:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B943AE874
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:29:50 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 78so4320141pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiYi+e4XxzwKkfP+625dtrtkvulooPOi47ioYJQguSQ=;
        b=i/JRIVMT3L4jruziwlgZDQtp06KELiW8cZNmsbjMUruOqn71+VzaGfSxBA4StTmITx
         Fb2BfoT87oR0lDxcUCk6r6rI7Ia84077mx93cIJLjsEBk3zCGt9DLyBkVMqqc0l/Tt/8
         UDxlVDay9bIBM70gfYGw27+H8XD9qhMtucw/VeOZmyIh5BYpkTc3vszfv6fJVEQVn5ZW
         paVxacSdLjc9na8kNe/tDR9vi4GmXsgYiFKr/KdD55ohgSAq8x9X0kWFlSWxlo9pkbP+
         Xgz8BxKZsG9TGFGiA7h5qIFC2k2+mznpftuGCGI3qbIL0IBUYZ8fzmZJcdLtYXWUXBD3
         nR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiYi+e4XxzwKkfP+625dtrtkvulooPOi47ioYJQguSQ=;
        b=15IKUhnQSMFbBFxgSqNrVcSDoJqCdc+hreC1IiF0fsbm6DiUhdwFi9p704YeTvDihH
         Qma67C7joWh8R/AEoucitKwMj3pAycUoTnuqEfv/9OrPNfw1gJO8Kl9hYXDHJJ2mB0W9
         nQBC62EaNwRYtJlDmI+Fr2rMab0jDZKywhlCKHQcaYKcSYDvR0vyeLsVthZLYBTRRFjb
         6EX1P8I/DmWV/bF0yAbWeU6cRKzMGUr72opEGAwXc0bLqCZB2A7Mb37PJ4r0YtsKDHVe
         y07uqp0la06crglSGMiqtcFzXaHvunswytn9bC3nImp2R+jVeiH3L7xSts5U0c8hhO13
         r9kg==
X-Gm-Message-State: AO0yUKW5I9kPcitWROwR9rhceK7H1iu6EjOrL/ucClQ+mFtwt7ZuaqU0
        xCIBJv28BTknWw/NLdo+MCQ=
X-Google-Smtp-Source: AK7set8wqbBXGXmYNvElKqE7GNexJlRkkEW4WX+K/l+hIY1ZVU3gL+ESTrqEoLlJrTzAwRAvcg22Bw==
X-Received: by 2002:a05:6a00:15cb:b0:590:7735:5384 with SMTP id o11-20020a056a0015cb00b0059077355384mr13128751pfu.23.1675452588804;
        Fri, 03 Feb 2023 11:29:48 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:35e])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a00078400b00593e84f2d08sm2199400pfu.52.2023.02.03.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:29:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 3 Feb 2023 09:29:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/5] workqueue: Warn when a new worker could not be created
Message-ID: <Y91gqnkZM67x76WC@slm.duckdns.org>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-3-pmladek@suse.com>
 <Y9xHnwG39IHN/BBu@slm.duckdns.org>
 <Y90V1E9KP785ALMs@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90V1E9KP785ALMs@alley>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:10:28PM +0100, Petr Mladek wrote:
> A solution would be to use a custom printk_ratelimited_wq() that would
> allow printing one message per 2 * wq_watchdog_thresh.
> Something like:
> 
> #define printk_ratelimited_wq(fmt, ...)					\
> ({									\
> 	static DEFINE_RATELIMIT_STATE(_rs, 60 * HZ, 1);			\
> 									\
> 	if (__ratelimit(&_rs))						\
> 		printk(fmt, ##__VA_ARGS__);				\
> })
> 
> I admit that it is much easier than __print_create_worker_failure().
> 
> The only problem might be that wq_watchdog_thresh might be modified
> at runtime. But it can be solved by sharing the same
> struct ratelimit_state rs in all printk_ratelimited_wq() calls
> and updating it together with wq_watchdog_thresh.
> 
> Would you prefer the custom printk_ratelimited_wq(), please?

Yeah, I think so.

Thanks.

-- 
tejun
