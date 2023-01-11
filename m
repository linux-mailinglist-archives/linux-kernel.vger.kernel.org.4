Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1F666111
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjAKQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbjAKQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:56:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A809140F9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:55:50 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a30so11855696pfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g38CsAU/rraiulX8j1T6gAfP3daDmv6bEkXvlrbY88U=;
        b=PusUF5wVgOYM9B4wpdwsB5gVA2kfUVXTcHhTZ9RhSRYnKmqlkHAHUfnl6JLeIPY6AJ
         FGnn5W0Ph1ptRixDrtSTLnVkOxLXKuFd9pP7SEsZT54vuay4Ze3rQRMjjSCr/C3K6c9w
         J7YQ9dZcIkFp2Whn8e/OqRyskALfX62bRX17p3DNk/EkTFFjsgy/fdPvzoKAi++HCF0o
         dOr+AVhCa0DPAanB6qXgqAMNgvj/Oe20VZKnAUn0gJL2rdXvtQT+52fU5CsePbfcGE6b
         wUMMFqh4+jWXc/Yqxw4n6jUQVPHnO1Gm6pGDNaL7vEdDYmkqKfOgF1TrW6y4Ho4/8pui
         Bccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g38CsAU/rraiulX8j1T6gAfP3daDmv6bEkXvlrbY88U=;
        b=tPcdGdgN14jd1KKo78XIHjIcxc5Lt8Tbq9q4behuvzmjUa1PGA5S3w0VIHXBwExUKB
         KSGQZ+WlhuQg2x5/R576qWMC2Wyl6grm11uWJKK9NPk0jarwKOPI0XMMVTuM8EE1AqNV
         lCKL3We2Sneq1B+7FZY44EIVm/yeJmwBSEaPbQV2ZINuWADdKulWhq3/63HHr0SQi8RJ
         b8vuRX4bLsoohlq3ni+ho8+sqeR6t3g0HK3uAWoGaeB/Ky+5FpJdEJw0A9TY9YJIwkPg
         yzGQXdSaHOd2/CPwrQsQsQWH5Ng5pe5QREzwtPzfSAi25QUz6KXqlTNeug575MQWYLoX
         OfKw==
X-Gm-Message-State: AFqh2kraVQMfgKa800orvc2ANZqOqeSFt1K9+S3QDFYKPnyMml/CC/rw
        +QPFHk1t8jr+RYs9WUoA1sOV/GhvoNk=
X-Google-Smtp-Source: AMrXdXucduxz7ilOymFuDquB2Qcq04Rm/1C4yrxIy7VremvAnJ58DQ+QN5hZdL91hLO9IJsYiLVxHw==
X-Received: by 2002:a62:19c3:0:b0:586:f44:47db with SMTP id 186-20020a6219c3000000b005860f4447dbmr17934254pfz.11.1673456149358;
        Wed, 11 Jan 2023 08:55:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g15-20020aa796af000000b00581d62be96dsm10193878pfk.197.2023.01.11.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:55:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Jan 2023 06:55:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v7 4/4] workqueue: Unbind kworkers before sending them to
 exit()
Message-ID: <Y77qEu1fQHMWr6F1@slm.duckdns.org>
References: <20230109133316.4026472-1-vschneid@redhat.com>
 <20230109133316.4026472-5-vschneid@redhat.com>
 <Y73KeZ3g0WdukMQo@slm.duckdns.org>
 <xhsmhv8ldck2a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv8ldck2a.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:49:49PM +0000, Valentin Schneider wrote:
> While we're here, for my own education I was trying to figure out in what
> scenarios we can hit this manager-already-active condition. When sending
> out v6 I had convinced myself it could happen during failed
> initialization of a new unbound pool, but having another look at it now I'm
> not so sure anymore.
> 
> The only scenario I can think of now is around maybe_create_worker()'s
> release of pool->lock, as that implies another worker can drain the
> pool->worklist and thus let pool->refcnt reach 0 while another worker is
> being the pool manager. Am I looking at the right thing?

To be frank, I'm not sure and can't remember why the code is like that off
the top of my head. It could well be that I was just habitually thinking
that MANAGER can be contended while in practice the scenario can never
happen in this particular case. I'll need to look harder at it but maybe we
can leave that to another day?

Thanks.

-- 
tejun
