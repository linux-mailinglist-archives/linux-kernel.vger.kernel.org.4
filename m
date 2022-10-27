Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1A610655
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiJ0XZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiJ0XY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:24:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097F3FF24
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:24:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v40-20020a056830092800b00661e37421c2so2094937ott.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BjtnyuNFjPKrTPvTw0RBOHXe9Mp5tQgSxI0MxRFJA8=;
        b=QygYh1wETfgRELUNyNIQRw2VVWsdANi6edAb9f4kfWsmwtSDgf74MUwAug0c8kvZ07
         fazyWZqed5d+iYmmmATMOOgYJByfoFEejPWkWmlOG7wp5cWOikqeE9wh0mBSilaVQaUS
         gp72sSCLF2wyTzuULuEi24OW5IXJxdHJ2ePStsjC9wakuvygd0Acd3l23INZYvAQXKyR
         ontw71Y/IRISKtLxX9zveyjh/W9TAFJj64cYPjUGzUyuv8WkYY95I/r6SmLiIbcW/h+f
         zGQumZsXU6zA6qDcw5opIexb506bn2bQaWipES+T9ap1p6/xhBrSL6tznZkyS2V1bfL7
         iuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BjtnyuNFjPKrTPvTw0RBOHXe9Mp5tQgSxI0MxRFJA8=;
        b=ylpTBvobFrzlVOzx+0rw135EpXsxjJRJDEQ1N7xZO9hOefPimZ6V7ta9t5DMjf5jhS
         s3ysv+bVCtZWXv5QwFpcfKz/m5K1Jj45Prd9y7iguIbNehlOOuBqBG/+HUCwQa4N7VJ7
         oEWvRxFWZzJ3qAvhHL96dzDqGrpqdT+2Mp/S+wEdi6eBaEmyl8kv/ohGEoAQLE+OXwpA
         4bRJi4DCSwz9D1BUP5aNj39SOSGEtncZA4X7/WRvrvwVy+/JPAxtVMW5hR6+/kfN4s9M
         Sf+1t6aybTODS4/l5ALlmKWgbXZqRln0GTxgIs2lkCvonG+XjAiNVQt+rvj2mJSzHdrP
         4Bbg==
X-Gm-Message-State: ACrzQf3JNW33RjaFmumeWTD93YukZd9vEAD1I7OC/bwn0/wMHU8JLblp
        IbPXQ486Zm7hbk0wL0SuZwM6jTYpPB4=
X-Google-Smtp-Source: AMsMyM60/lwkwiXocU9cytokruFipM+1LO/IMsfQKBhrYpS9ceJjD9FacPVFpdLf9CAAa0Aq0/CmyA==
X-Received: by 2002:a05:6830:4120:b0:661:a0a2:3f2e with SMTP id w32-20020a056830412000b00661a0a23f2emr25185709ott.127.1666913084696;
        Thu, 27 Oct 2022 16:24:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a9d620a000000b006690f65a830sm1036727otj.14.2022.10.27.16.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:24:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 16:24:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027232442.GA279073@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
 <20221027222404.GA3123386@roeck-us.net>
 <20221027185859.1087d3ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027185859.1087d3ca@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:58:59PM -0400, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 15:24:04 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
> > > 
> > > Back in April, I posted an RFC patch set to help mitigate a common issue
> > > where a timer gets armed just before it is freed, and when the timer
> > > goes off, it crashes in the timer code without any evidence of who the
> > > culprit was. I got side tracked and never finished up on that patch set.
> > > Since this type of crash is still our #1 crash we are seeing in the field,
> > > it has become a priority again to finish it.
> > > 
> > > This is v2 of that patch set. Thomas Gleixner posted an untested version
> > > that makes timer->function NULL as the flag that it is shutdown. I took that
> > > code, tested it (fixed it up), added more comments, and changed the
> > > name to del_timer_shutdown() as Linus had asked. I also converted it to use
> > > WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
> > >   
> > 
> > Here are various warnings and crashes. Complete logs are at
> > 
> > https://kerneltests.org/builders
> > 
> > in the "testing" column of the qemu test results.
> > 
> > This is with the published patch set plus the fixups in 
> > timer_fixup_init() and timer_fixup_free().
> > 
> > Guenter
> > 
> > ---
> > Block code:
> > 
> > WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0x66/0x7a
> > ODEBUG: free active (active state 0) object type: timer_list hint: blk_rq_timed_out_timer+0x0/0xc
> 
> This is probably just missing a switch to shutdown.
> 
Wild shot, and I don't really know what I am doing,
but I'll try

iff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..6c1cb4a219f0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -767,6 +767,8 @@ static void blk_release_queue(struct kobject *kobj)

        might_sleep();

+       del_timer_shutdown(&q->timeout);
+
        percpu_ref_exit(&q->q_usage_counter);

        if (q->poll_stat)

Guenter
