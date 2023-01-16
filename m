Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8866BA54
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAPJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAPJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:28:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4F166E2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:28:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so66593867ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvuIIJoTaEmioZM0Oq5YMtye6VNYwwl3cY6WJRPbs+4=;
        b=Q3QEjzwaHrozikaD4TW4sHAF4Q4tnjBZNWSKpIL1yo2qR94movpmPQskX3okbmcOlt
         +pGwtKEtpc657RfY6FB3TcTiKSLeOZgH31+cOUGamtceXx9PQPBu+HpJSIg+emghQ5Vw
         u8lfksilBLNEyUTrfh0tFTe38z3mms0mcLv2YvrCUEQGAV7s3C/eXqxFwJVy8DeMT7Fz
         4TUhgoNNOwwWbyRkgYVMwGRlXdjeZdqicL+jkNfxvlXkMiHATsgnaucC/FNgV1HWHniv
         /yEBSpmHPP+QE9btpw+D4jjRjaVcyx1yijC5qWTxPrfstIx0UjeXWd0NL5G2HySkB6Kn
         5qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvuIIJoTaEmioZM0Oq5YMtye6VNYwwl3cY6WJRPbs+4=;
        b=C8WJqTEszPEZaMi5HM64qHPFQS3GmCkG8fHddVWbIdg3rn0NcwOmPJDkWCmy09T8vK
         1p1+IpYjWWQ/BCcXycnEPjwE7vuE4c5rIt73jZaLP7MLv8ZHgVwe5oQ8PjU6vu+34Fxs
         4Jf+5FZ9dQjrQHZImCRCQTmOBAKKlUAU/XqAJNvpSCbMRNplgrUWyuRLYaWm/5wuz9HE
         Doe1/I7dCxGEX/Q7Op/7yVRI9lEwAqNJQLu3V+QY5Mw8/QiZ01Z9AJ+fix9akOcH4Uqj
         QGQpUVgJzvkrKVvvYdrGoY9WUlf2Ag2rjFvwQGRxHAwJDubMU7BA1Ldvuv4meTVx2+GI
         h50Q==
X-Gm-Message-State: AFqh2koCijaiIBzL/0oyRzm3JAcfGkqRAPbOwJjU2N72Yug744IXjEEh
        4iznOVfPSJKz8YLDKGWbeVE=
X-Google-Smtp-Source: AMrXdXuSD2ff7nlH2klcdI2ucj+RI7kAI1rDPON9EtGWaC8eeKC+qZn8DbA/MVTIfiUTdMo6PyDHSg==
X-Received: by 2002:a17:906:2245:b0:844:436f:8c24 with SMTP id 5-20020a170906224500b00844436f8c24mr71366261ejr.10.1673861302873;
        Mon, 16 Jan 2023 01:28:22 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906288300b007ae693cd265sm11488238ejd.150.2023.01.16.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:28:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Jan 2023 10:28:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8UYtEepRT3xC8O/@gmail.com>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
 <Y8USikoCYTBl7VFr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8USikoCYTBl7VFr@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > Urgh, can we please make this a cpuidle governor thing or so? So that 
> > we don't need to invent new interfaces and such.
> 
> I think the desired property here would be to make this interface on top 
> of pretty much any governor. Ie. have a governor, but also a way to drop 
> any CPU into idle-poll, overriding that.

... with the goal of having the best governor for power efficiency by 
default - but also the ability to drop a handful of CPUs into the highest 
performance / lowest latency idle mode.

It's a special kind of nested policy, for workload exceptions.

Thanks,

	Ingo
