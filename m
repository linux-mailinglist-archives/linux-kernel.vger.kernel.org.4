Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404525FC8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJLQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJLQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:12:52 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BCD8EC5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:12:44 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n83so19552821oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ye7cT/HQlpxKJ6m3avMn9jU5d/vCmwstsQKoi6uiyY8=;
        b=CXS/MTWMngkL/Tunul/2EXbcDQP0PEDhpeJ0WjBlLVFcgGjd/YZKk5FFzWZimoZp1v
         Hx2Qly2H0yOG83/ZwVOThknwvGVRoxx3v1f6PQLBEqOznMmxoDpRzQQhKmh/rnlkwnBT
         foebjFWdPN84d26hWagHrVJHZf18tr1xlUdSDTXImT0HCl1c3EWiaNJDJ2TMiyNZOUiA
         6j8SSPTV3sXREkXvIBMyBnRmQaiPeAr31dlRcK7Me7POZ2uU3V8THh6vX23PsXpGpDt/
         wqGkXt2ZQkp0t4spz4GfbV2RQfE2hXbMvNJgKAZWWCOBUAWnGjHS+yQO1bV6DIaDMf9Y
         WajQ==
X-Gm-Message-State: ACrzQf2S9X9mK6Jcufh+S1+1gGJfkgzEZfscCtsxnww8aYZ541NFGc/I
        pWGI8xAU44OIDRddcAogYS46vX+0I6kniAS0nJKxKlvQ
X-Google-Smtp-Source: AMsMyM5bNnPHBi9iM5KCM2Ep1rp4l9SeVY0Qr+Kc/k93OyN7ziaXyLyg/CHkTZKAYetA33OQwFWt8u9Gato7sUcvsNU=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr2551489oib.218.1665591163722; Wed, 12
 Oct 2022 09:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
 <20220901130959.1285717-3-kan.liang@linux.intel.com> <CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com>
 <Y0Z1Jr2jtrrAN5L+@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0Z1Jr2jtrrAN5L+@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:12:32 -0700
Message-ID: <CAM9d7chpXGm9vDf4qN0JQQWdgWDNR05vPuqnDo4=F2jWdo0S3A@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] perf/x86/intel/pebs: Fix PEBS timestamps overwritten
To:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Oct 12, 2022 at 1:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 11, 2022 at 11:20:54AM -0700, Namhyung Kim wrote:
>
> > One thing I noticed is that the system has a config option
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y.
>
> You can't build x86 without that.

Oh, I didn't know that..  so it's not a config problem.

Kan, could you check the following command?

  $ perf record -e cycles:upp dd if=/dev/zero of=/dev/null count=10000

Thanks,
Namhyung
