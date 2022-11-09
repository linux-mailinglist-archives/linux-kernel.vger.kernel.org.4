Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46C62215B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiKIB3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKIB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:29:44 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34E6069F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:29:43 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id z192so19464908yba.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 17:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xSzaACOb1rwQG4fKaTmc7pDLx0utTnGcocppF91jws=;
        b=KaBITggZy7+sGhC3P1msQLgaDlMQqtRzlGI+ihyjWaeNTS6+Z8AZ9E/0446HhAUi9J
         e3rTmG8mVBy01HzY7VbY8FWIc/a+Qobkx/qIJpoRCyqABVAQ1Evu6iYEM8t/jqX4pTYC
         Js/76CLUK6RDoGRy5C9EqAYcEdO2pf4nMemS6jPKOC0uGEWankjCUp+58KaJ6XzYGvF1
         //iyaFfwmzamu7Vgz/x1uk/zuaClFbYquUUNwE1Tr4Pwp7smEuPGDKhH3Ua8E4gg5l3x
         D143M/mCExJnP0lVmCV7ahjz/7Tes42TtQ2Brd6FaoRtJbRhZk4Q0WI+m5YAI4QYjQmm
         UTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xSzaACOb1rwQG4fKaTmc7pDLx0utTnGcocppF91jws=;
        b=A16RZkwjntxl27uQkfykZnF/b5Wl1hVmAtj4s/qh2M+IIyj1slO2TolsjG3r+h1Ogp
         6LUUaTcSI5wMcAz3XTYG7PvG+VG3ZGdwio71cHVhFdzUHlq2FBZSPxWX3FiWrMleReHu
         pmH8DP9APgoAnMWVWO570ZnfGi+puNROD7ZO5aQWLldMLRG6sfSE5fgYUH7kHeB9yBLs
         GpGNc17MBC6Lo5m7gqakwY33mdSvGC3XRBjG4q2R5+0ria9txvIv7sr2aaJkcnuHRfzA
         J3RaO8YejgN82cgBdGA+rMTWXNVyBPh1oRdFUs1nIQp+4JL4NDXp8Or6cYUfC4TcmmHi
         2ExA==
X-Gm-Message-State: ACrzQf20tetzBFqBJkMNZeWRdFkgxB97iCgLeXAU5wdU1Uoa/8QsJHF7
        c8E8HpGAs6Qw9Fk9xXW0YvGVohhEMcEuSdjQFPGL2eJxydg=
X-Google-Smtp-Source: AMsMyM7eaRPXAjjLtpasWTqL7DCn75qIeLcTRV98vi3hHN9x8VLh4Egu8EN5RjWmrvDp3xWAMDStzaii8yVyf4DQXOU=
X-Received: by 2002:a25:190b:0:b0:6c4:ee7:5ab5 with SMTP id
 11-20020a25190b000000b006c40ee75ab5mr56407741ybz.245.1667957382601; Tue, 08
 Nov 2022 17:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20221109012011.881058-1-shakeelb@google.com> <20221108172603.8d547faa8f0cf0c340fd7150@linux-foundation.org>
In-Reply-To: <20221108172603.8d547faa8f0cf0c340fd7150@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Nov 2022 17:29:31 -0800
Message-ID: <CALvZod7XREiFFgqb8KAMOzpPjozsu90p9Oz+tAVuBPGVs4=mvA@mail.gmail.com>
Subject: Re: [PATCH v2] percpu_counter: add percpu_counter_sum_all interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
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

On Tue, Nov 8, 2022 at 5:26 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  9 Nov 2022 01:20:11 +0000 Shakeel Butt <shakeelb@google.com> wrote:
>
> > However there is a small race window between the online CPUs traversal
> > of percpu_counter_sum and the CPU offline callback. The offline callback
> > has to traverse all the percpu_counters on the system to flush the CPU
> > local data which can be a lot. During that time, the CPU which is going
> > offline has already been published as offline to all the readers. So, as
> > the offline callback is running, percpu_counter_sum can be called for
> > one counter which has some state on the CPU going offline. Since
> > percpu_counter_sum only traverses online CPUs, it will skip that
> > specific CPU and the offline callback might not have flushed the state
> > for that specific percpu_counter on that offlined CPU.
>
> LGTM.
>
> What are the user-visible effects of this bug?  Should we cc:stable?  If
> so, can you identify a suitable Fixes:?
>

The patch which exposed this is still in mm-unstable (converting rss
stats in mm_struct into percpu_counter) and other percpu_counter users
don't really need this new interface. So, there is no need for a
cc:stable.

thanks,
Shakeel
