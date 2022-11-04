Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60361A1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiKDULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKDULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:11:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22522C653
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:11:43 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id e15so3933352qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aykb0AfnpwXRSpQw90gCc1LVerApw/P9i4pLqF2zuuQ=;
        b=Xe7kti2HDVIeQ0SvOaUOKHrXDKoL1/xJosLh4TlW/ZWqCLHZUtRY5pQLh/SDC5k1//
         pP4RY+wG1fzBGIZEaaAOdOGi7l4euyrmmxw0ohyJY+iYZyJU14RcAtrP4GgGNoTUDAC/
         fMjn2/Cmew0Ec/TVKAe1Ir6WkR7cWSzTwkYxTZPHOzQqQ/Tf4cGB8nWPNXN/F9EJ/nj7
         CJFMv/dqFr8eHzlq+3AJqKALFi74B0HEt5YDM3DZp3zWpLuZAsZurvcJHAV38urfxlfy
         jB5ajEmlUS43GYhajTM7+Jm088xNJbzh+iTX0gR7G2VWzQTqX6CYsUjKvFqstkvWj5Dm
         6iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aykb0AfnpwXRSpQw90gCc1LVerApw/P9i4pLqF2zuuQ=;
        b=T2BfC3oyQstHTJgXKKMZNh0EdfpX60QtMDkcIpNLVt/YryytK9KTlZGB14vmvgGoOY
         WxlBD6lFa2VV4Z1lOYEQ0BMAp8nBUbudTqxa7ELJSxb6TekCrWyVTg4kxdE3P8Zy+9l9
         FGU04T/OR7dXaOTanhwuWGjHaPaxDkFh6x5lOm6gSFPtUMHTZdAye/hPIjAPdQ5FWtTF
         N7f6eY5AoHDSqSewL0A8nsdKrIj7j4wfGaGZZVS/sf75aQhn7R0m8dy1CHOMBXO4xcnw
         dUgXvwMYA7OzqkkUgUIJWNG9uOFsxhDojf/04wmCYR8Y9FKsyF/Gx3BmyFYnH0GpC04D
         S1Ew==
X-Gm-Message-State: ACrzQf2L/OqSziMjd8YxyGLUiy3P1r0/Smlx3Hi8ZYZlb2bndGDKxP+6
        pScF/3M+Veahq1MQE0XYJqi7+Q==
X-Google-Smtp-Source: AMsMyM7KVLKwglURf/ZlP8NccYUEegl+l6nh3ilO9amDi/wxctzEoj+fk9g+mHkcVvytLEi5L21Kvg==
X-Received: by 2002:ad4:5f4e:0:b0:4bb:a679:e27c with SMTP id p14-20020ad45f4e000000b004bba679e27cmr34670954qvg.90.1667592702999;
        Fri, 04 Nov 2022 13:11:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006eeb25369e9sm105842qkh.25.2022.11.04.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:11:42 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:11:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC][PATCH v3 31/33] timers: sched/psi: Use
 timer_shutdown_sync() before freeing timer
Message-ID: <Y2VyAZkTLj3kasA4@cmpxchg.org>
References: <20221104054053.431922658@goodmis.org>
 <20221104054917.543373979@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104054917.543373979@goodmis.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:41:24AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, timer_shutdown_sync() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
