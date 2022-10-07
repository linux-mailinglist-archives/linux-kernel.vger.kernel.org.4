Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A915F7B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJGQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:14:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985EB5F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:14:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so12380164eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwCgcEFb6EqweOCGJwFjwMplx0cMo00I0pQaRZheEns=;
        b=FLiXrIyCWCwIh4B7g6oOtQeS0K8OpzpCsj7kykdMijQaKSo6U6qLpZLv5183N831/Z
         o97aNMbep3GAWS0wQMhtu2BI/UprI8Vo9qxwerSYZzjU+70Vg+E+zm2cGRFWfJnCT1MQ
         5aZEVehO6KOzH2QLEs7DtmeWin72GDMaiqITZ/pYKvXswY5SDAFGcVvEW70xMD2HW0ES
         HGR6yqzTiZ2lIUSeizd2EAi08tYXTfHsd8SNe5IuUnBjLOzW8aWDOvIlbLTTx96M3KSq
         i8IH+LHnTANkheqM77lFKwPCgkuaD7wLDkZmrfuFw1oiGoNPcFNCd+r230YSNMSIYyP8
         Astw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwCgcEFb6EqweOCGJwFjwMplx0cMo00I0pQaRZheEns=;
        b=kR226x8W0NP+QnW7iMHx68C6oVFjk0c62hkHz91SvtdKhtb4pGnNT1ATVRTklaRY+v
         GUkvln1z5q/9VqKOfLPqr3TYb2JrfKqZ3OX1hBCpMo2wUtO7Ti56SWJ7aRUHv+uFiVap
         IyNoXVdC9R3bjWLIGXcrZwkQXzre1EJrNQEAmAT7phHdoCxIjpyLQq8uEi40jPm9ymnK
         wIbdvS7HZR89zHR/XY5oYBj/zokp7edD5HFIWK3tHoCNuPe6dq+pKNiPCYN6QF1l5ys7
         UGQsvi/JSKwV6Lu3/VOzW+FggANIWPecWxKqOzfJiNYI5lSsNSwtTM7TIXEMmAAnv6T0
         pMNQ==
X-Gm-Message-State: ACrzQf1xrCg1yzV+0X7ShZkt5PTrI5PpMjc/H98mT8x3lcI4bNEkGhBc
        kvk0gm8sUX+NcasXRaknp4hOhclSZyq1dw==
X-Google-Smtp-Source: AMsMyM4okfVRbMsO3Ymv4vwJs9wuatFTCbhTbraksBWWxhhaFX9/mcQHd/2T30xj00lGBinhZSBhTw==
X-Received: by 2002:a17:906:da86:b0:77a:52b3:da48 with SMTP id xh6-20020a170906da8600b0077a52b3da48mr4502878ejb.373.1665159274119;
        Fri, 07 Oct 2022 09:14:34 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:4e4:454c:b135:33f2])
        by smtp.gmail.com with ESMTPSA id pk18-20020a170906d7b200b00741383c1c5bsm1379772ejb.196.2022.10.07.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:14:33 -0700 (PDT)
Date:   Fri, 7 Oct 2022 18:14:27 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0BQYxewPB/6KWLz@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0AwaxcJNOWhMKXP@elver.google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
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

On Fri, Oct 07, 2022 at 03:58PM +0200, Marco Elver wrote:
> On Fri, Oct 07, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 07, 2022 at 11:37:34AM +0200, Marco Elver wrote:
> > 
> > > That worked. In addition I had to disable the ctx->task != current check
> > > if we're in task_work, because presumably the event might have already
> > > been disabled/moved??
> > 
> > Uhmmm... uhhh... damn. (wall-time was significantly longer)
> > 
> > Does this help?
> 
> No unfortunately - still see:
> 
> [   82.300827] ------------[ cut here ]------------
> [   82.301680] WARNING: CPU: 0 PID: 976 at kernel/events/core.c:6466 perf_sigtrap+0x60/0x70

Whenever the warning fires, I see that event->state is OFF.
