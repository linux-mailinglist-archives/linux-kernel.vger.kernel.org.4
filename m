Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38046917EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBJFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBJFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:16:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57360E7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:16:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p26so12797119ejx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AzscG052nU7edeh7dwTYC41mb6Aa4soKDmyuGWgVTA=;
        b=rgfOLRi/jWcSsBdaMfq26LxkTPxWkbcER/YpQ5lKVSuc/+LUCDKbl8J62Zd4DEiUqR
         yjgGH6O30bmqo6bT2ReZsuOiTt3c15V2UKTAszoO9IUt12O0l/5U7uwe22iCujiC2LIA
         qfIlFACa/Dd38E4ChPBvMTCF9sZCKsIqWgX++U/C4QhFnywrJEZ1g89jvGMK1Jnvv4A4
         2lzG6ic/Fj/Z2RW0bxNLL6TRkeivPRSoNnE2BkbkF5QMsEXwGU/3f4Ghz1uGCOQr9OS0
         TGFRHt3epwzZ2QVYfKnDH97HK7LYz3uSD5LKkCYV3NwY4LRGL+2l9hKaD1hqE9QQoQWt
         WTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AzscG052nU7edeh7dwTYC41mb6Aa4soKDmyuGWgVTA=;
        b=aK05UfjXshYqKxwo2bpnnPRcscvaeebemHIDzPMA74rjelXC72zqXETmBBvwcDbC9q
         dKQsR1wlgxMLGIKaVMK/xq4zsTc9iVvu4S4mbAMOASqVUNWbupFrcohCVu/GjqjhfaNP
         XTn8lfKlQPGVSrL6tpad8q/Zp0fBgAMDoBBp0Y0nQ9IDtqnoRlxuWsJNx8pF4wWuq/DI
         xdmCBzKwLSu6n+mTSJQpmfERojbFlA0waa6H15RcSrVbhCXzSagdAtX/5WcXnQtJSfPz
         h9TX8MYjfagp1QioKs30cksCg7EQZwTCpX3Z+ZejoxwR5O02uqGkl+yEww7OccKidaFO
         lGFQ==
X-Gm-Message-State: AO0yUKU6aTb9WHjvTafKuIq/bbxgBOu5oPdOgJcoJRHlK6jgbnrJ+8YR
        IRG2yAK6pJMZ9vv/CwYfGG/Fceou6JAE6J+Y2KvSCQ==
X-Google-Smtp-Source: AK7set9UR07cb3ro7iznmr9sptnXV7T2xULn4gSqAWaM3C0Oc0IhlfyySo+cCwyIMeBQwv0+TxPFBE/hHziM2afgtqs=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr3040573ejc.220.1676006194641; Thu, 09
 Feb 2023 21:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org> <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com> <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com> <Y+XIR64RyVv0EfTx@google.com>
In-Reply-To: <Y+XIR64RyVv0EfTx@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Feb 2023 21:15:58 -0800
Message-ID: <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness grouping
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, Feb 9, 2023 at 8:30 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/02/09 20:25), Yosry Ahmed wrote:
> > > On (23/02/07 10:47), Sergey Senozhatsky wrote:
> [..]
> > > Forgot to mention, I was also thinking about extending zsmalloc stats
> > > file and providing values for each fullness group per class, as opposed
> > > to current ALMOST_EMPTY and ALMOST_FULL stats, which don't tell much.
> >
> > Makes sense.
> >
> > >
> > > I can get rid of static const arrays and pass "begin / end" group IDs to
> > > functions that iterate fullness lists and pick the first head page, but
> > > I think that enum values will stay.
> >
> > Do they have to stay for a technical reason or just to make reviews simpler?
>
> We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
> zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
> show class's fullness stats.

If we use #define FULLNESS_GROUPS 10 for example, we can break down
struct zs_size_stat from a single array to two arrays, one of the for
fullness groups and the other one for the rest of the stats (e.g.
OBJ_USED). We can have different helpers to update each, the former
taking in a fullness value (0 to FULLNESS_GROUPS-1), and the latter an
enum. WDYT?
