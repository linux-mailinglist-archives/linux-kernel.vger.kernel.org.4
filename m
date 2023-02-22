Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CE69FD28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjBVUqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjBVUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:46:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED83BDA9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:46:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z42so1455839ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG5eBD4XraaP75E65+yBcF1mGRfsga5EQtdEEg2pZkI=;
        b=QJsKWAn8bp7uASYkpEYwUiB73aJ4Huerh2ClR1bdKBqNv99s4nR5EIHHmbVxSjDemP
         Ot7pro+g8ExJwab4YSDB9Bh6kksrtiSNBqSAobpcf6biuxw+/waRtj06Q7KKDNPk8eL1
         I7cA6JlP0xiUDNJgoptCwuqmeKAloMEhvHWZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG5eBD4XraaP75E65+yBcF1mGRfsga5EQtdEEg2pZkI=;
        b=e5hA8YfXLIHjsheH49NO6cUh/LKeM902sOXwm4XroiZvMoIwPbd1y8rrb6BfLkU8Tj
         vP2e4qZEBdb6GM6+JUdtkJoZvoE/jIbwumYtw3zll+pSqCvEdkjf5V56cehc86HcyTQd
         8xOJylsWDs3jnzZ28zP29wo00ayb6Awvmvh66SDtaJ0FCczKSOaCAkJxk3J4By3mPas9
         GX+G9mYv/OQM8Nr6J6qSrDDqJXtldCJXix2iZ3aHDPTKROqNqPchuXJhhaQYO8nkWWki
         1zZBlVwbr67L0gJwE9/MChIuEc/xlY+lCHNAtK7P9wejdsajWNE3ztms6SJLz6es7+SK
         HZsg==
X-Gm-Message-State: AO0yUKXP53U/3icY6VbH/LDko7uxJ010H+P5H33l0tfUE4rfNaUpqrlK
        YXLWeKRVg4iRTdDknzPUTg7WE9nyK21cAqh0TgWraw==
X-Google-Smtp-Source: AK7set/kcW/LLm6wA8/RfS4+XauBr/byLOgZu1tuKY/1+wdQrGZPO24t2c8VQydI01MQTnD8XTXg/nduAIEDYhPPYh8=
X-Received: by 2002:a05:651c:336:b0:294:764a:3318 with SMTP id
 b22-20020a05651c033600b00294764a3318mr3132908ljp.0.1677098800464; Wed, 22 Feb
 2023 12:46:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Feb 2023 15:46:39 -0500
MIME-Version: 1.0
In-Reply-To: <20230222191537.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid>
References: <20230222191537.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Feb 2023 15:46:39 -0500
Message-ID: <CAE-0n51P-nXPKmcN9K5RtdFJh5EQ3M_hm2LjBicfegWKUda2Dw@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Use ktime_get_boottime() to determine
 how long a regulator was off
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2023-02-22 11:15:46)
> For regulators with 'off-on-delay-us' the regulator framework currently
> uses ktime_get() to determine how long the regulator has been off
> before re-enabling it (after a delay if needed). A problem with using
> ktime_get() is that it doesn't account for the time the system is
> suspended. As a result a regulator with a longer 'off-on-delay' (e.g.
> 500ms) that was switched off during suspend might still incurr in a
> delay on resume before it is re-enabled, even though the regulator
> might have been off for hours. ktime_get_boottime() accounts for
> suspend time, use it instead of ktime_get().
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Is it fixing something in stable kernels? Should it be tagged for
stable?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
