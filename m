Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36945EC891
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiI0Puz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiI0PuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:50:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019C57E3D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:48:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o7so6260827qkj.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=L/Cx30LwdeGwH3W6aHXw8Bw9EbfLM1qZnewfJ5ia/wM=;
        b=pcc7NnAS0iiC9f4tXmPT57c/Z/shRDZrq1Svp2G91KvHmU61Dk3aI6BUX8DbgrRkOH
         9tjBO2WeRDO0qAgmP2d9wr7CPcSd5FSIJCoiihjE8egR0elCLLEWnaPiH3X2a4GzUkDg
         E0+QzEEGAt54H6AunCpiZQd96zHDnT1Fh+bcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=L/Cx30LwdeGwH3W6aHXw8Bw9EbfLM1qZnewfJ5ia/wM=;
        b=WJzFQ9BjwL0EQBWBlF8Y4y6CwGdXRiwQ0Kqu19mDtxDlYr0p9e0t65Jtv9qOmF8Zv4
         OLNNAk0vR6ZFT3bo3KIlG4UkZ4z00+Ly/36yDUTi2KNemBdBXiJY51eT74VRkM3Eebnj
         97TDn8lIcrGkbmGkfn8VlvIEmPrKYbjZI2YxpEoTJm8BotgPQvkEcsfS7RvaiItflZ7J
         cOmIIUZPGxNzcyvbhxlZTvpZ4HvWxQLG0FVeC5auIrfVmlXYiJERiMCXAH0MX6CpbBfR
         gBFUO5kbIBpJdnoXKzs4TrERbUNqdNTotb2N0KNcl/e4GJYXksVhYKsmy6iHPOif02z9
         BJwg==
X-Gm-Message-State: ACrzQf3Cl5kmFMQQEAd+lz5OoLjVpxyHLXGQU+FMinVs2ZO/LzVspYI8
        TJcspkimhfHBcMvglR86D28fKQ==
X-Google-Smtp-Source: AMsMyM4vKTAVXz3cjctvNrWsWQ4VvP+R+ARZrz0Vr83n5M5+tZyXQ/laZb+siOPKlK74vTr3/UJYlw==
X-Received: by 2002:a05:620a:2a0b:b0:6ce:afaa:b87c with SMTP id o11-20020a05620a2a0b00b006ceafaab87cmr18246137qkp.665.1664293700434;
        Tue, 27 Sep 2022 08:48:20 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id y19-20020ac85253000000b0035d4344a389sm931305qtn.94.2022.09.27.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:48:20 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:48:19 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 03/23] sched/core: Initialize the class of a new task
Message-ID: <YzMbQ1fpU6uHKz8M@google.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-4-ricardo.neri-calderon@linux.intel.com>
 <YzG92YDyBK/0W+5u@google.com>
 <YzL053SxqWUimANi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzL053SxqWUimANi@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:04:39PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 26, 2022 at 02:57:29PM +0000, Joel Fernandes wrote:
> 
> > > +#ifdef CONFIG_SCHED_TASK_CLASSES
> > > +	p->class			= TASK_CLASS_UNCLASSIFIED;
> > > +#endif
> > 
> > I find the term 'class' very broad and unclear what kind of class (without
> > further reading). So I am worried about how this generic term usage plays
> > with Linux source code in the long-term (like what if someone else comes up
> > with a usage of term 'class' that is unrelated to IPC.)
> 
> However much I like making a pain for people using C++ to compile the
> kernel, I do think ipcc might be better here
> (instructions_per_cycle_class for those of the novel per identifier
> school of thought).

Yes, ipcc sounds fine to me.

> > To that end, I was wondering if it could be renamed to p->ipc_class, and
> > CONFIG_SCHED_TASK_IPC_CLASSES, or something.
> 
> Can we *please* shorten those thing instead of writing a novel?
> CONFIG_SCHED_IPC_CLASS works just as well, no? Or TASK_IPC, whatever.

CONFIG_SCHED_IPC_CLASS also sounds fine, or:

CONFIG_SCHED_IPC_CLASS_SHORTENED_VERSION_TO_NOT_ANNOY_PETER.


thanks,

 - Joel

