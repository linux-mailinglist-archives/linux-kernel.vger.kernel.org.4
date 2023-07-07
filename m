Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF06574B7EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGGUfw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:35:49 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C901999;
        Fri,  7 Jul 2023 13:35:49 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so25313465e9.3;
        Fri, 07 Jul 2023 13:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762147; x=1691354147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFLlbncbDGoOETctLEQrtIND4I37P9UjBrA4MOx2xRM=;
        b=GK/TOADLqp3sn+np9saRJrPL/ATNsXNC2/+G5xnrfeQGeeYkVJAazXyAIFgvvTedRh
         jSlqmHf6XeFz2+HRwWY6VfnNefuT9HJUaRVaKKauYsP3f/4JzK1I/U9ucHsFVCB7siZM
         jVBuZ7vGEaGJpZPEUMzbXcpKHPsKooEUbmbKfXbSO62Fe04ZyrGuzxF159+5LxOT+OdN
         ye/rQcLjoZBOAlID+g6lWQ5p39jGT0rbyH5YeHaUz8OeML55vXcbLfdFqaG/k+dFkXfA
         dyH+uaHgkl0007POxJVQjcWdSiId06mdtcB41HSunTQ5ctNi0oSJ2Z6rcfs/KN5HavTx
         2gMQ==
X-Gm-Message-State: ABy/qLYY/bW1Ux5qp5QOesIdhFAKOjpl4hJYGcIfRmXkLJt/tpJ2Dg+d
        WyA+OVwx4mw9skpvVRKw9wzYDxBtAi2gmmDk9iI=
X-Google-Smtp-Source: APBJJlFnv+s7VZHXyISMymcWkvTx/cTOeiC35JUxH9PrOCv5GWTJkHpMf7y0srF9/s0zHmf+M66ckwNydBDSGfREvI0=
X-Received: by 2002:a1c:4b16:0:b0:3fb:db66:8332 with SMTP id
 y22-20020a1c4b16000000b003fbdb668332mr4641555wma.40.1688762147081; Fri, 07
 Jul 2023 13:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230704181516.3293665-1-namhyung@kernel.org> <20230705083833.GE462772@hirez.programming.kicks-ass.net>
 <CAM9d7cidyAD67Qr_bVW4EEm0+_87qv8O0JVmO9dmr6La9PRLSQ@mail.gmail.com> <20230706072905.GE2833176@hirez.programming.kicks-ass.net>
In-Reply-To: <20230706072905.GE2833176@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 7 Jul 2023 13:35:34 -0700
Message-ID: <CAM9d7ciTa-Xxi+xiqe+GSYOQQr1fxs69B=pH0VAo5bWEqyFLDg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Fix lockdep warning in for_each_sibling_event()
 on SPR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 05, 2023 at 08:11:53AM -0700, Namhyung Kim wrote:
> > Yep, looks good.  Do you want me to resend?
>
> Nah, I've got it. Thanks!

Thanks Peter!
