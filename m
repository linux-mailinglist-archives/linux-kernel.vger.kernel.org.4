Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6E73273D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjFPGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjFPGU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:20:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7972269D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:20:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666779dcc8aso485871b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686896455; x=1689488455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jT5QJMHUlKyOi0ccezfwrtf5oaRbI1qxEANvrycJT+E=;
        b=AzXs/l5asQk/BullAh/Lyuva2zkfgzHlfR8TTF8OwZCq44joG3RcFFZlNe1iJZCSSF
         aedI5SLk+p2XWh4UEKBGrvog8j+AGezFjdgIvS3qJlOinTTjd8vqmEE7QPkSIid4D4C4
         IMeSgRutMcL08902HDvgOo6/aU3Al158EhcgUlYLP6LkFaQQmkDqH1CSt//0/PrpNzOh
         oRuihxeS0K2nzE4Dij2H03itPP4i5ybWqFsqOMLHbzQvLId5fHyywRdijPPIh8UUINEC
         AvlXLsK0tJLkcFaVBfLqTf/W2x2TETMmp8RS0VVCy4YoapdsoOibnfNyAgSelvSCkHN5
         gfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686896455; x=1689488455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT5QJMHUlKyOi0ccezfwrtf5oaRbI1qxEANvrycJT+E=;
        b=KY0Niq8zXvZyDZ+7/AdXREnQpzk/ckVdY74U1uxki8N0Gwlp56iZbx329EZfjOyH8g
         1qEzZKOHce5qlZBEc/L/edb8MB3sr2I8PUdPDtA3CVkN+09QcV1nG5DYck0wCbMdX7JL
         uOchYjr5aLHFdXVGA2AxwZtMEVQR15Vp5u5JBDmBsPPWPUmChriRazL7E3R22rhPPgMp
         /Tm03oUYPtMz2lugJj0jMC2DluzuxOdpmStofTDn7p0/YuU8ULuu3/+WWwxZa1kQI12r
         PfPljvaDpitkiAdueDngWplutPVFCz9rrWav1RLx8aD5z4JzjU1uWJ0Y5EFKU38zmT2Q
         VnSA==
X-Gm-Message-State: AC+VfDyIlCMoMuWWNzqBGQjnNFlX+s6GOoZVQm8pwNP2GiGyUKAQTv0o
        l83vChtrtThkQ/AROciX0bwYOQ==
X-Google-Smtp-Source: ACHHUZ5qq6stex9qWvMjJHuCyLv5KnNj9STgCB64id8p2WAJxx+1Fi5yN8JaFku201SQwfcVrBukSQ==
X-Received: by 2002:a05:6a00:2d84:b0:650:d9c:cfca with SMTP id fb4-20020a056a002d8400b006500d9ccfcamr1673553pfb.5.1686896455214;
        Thu, 15 Jun 2023 23:20:55 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79245000000b0065a1b05193asm11302090pfp.185.2023.06.15.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:20:54 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:50:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Simplify the over-designed pstate <-> level
 dance
Message-ID: <20230616062052.orvudxqfwirv3eqj@vireshk-i7>
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
 <af0fd0fd64f33809875335a9cc2761085c3bd66f.1686739018.git.viresh.kumar@linaro.org>
 <CAPDyKFpA2+-aCYGfRQa3PokuYLTCKHufxSUXpktap43aoRu4NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpA2+-aCYGfRQa3PokuYLTCKHufxSUXpktap43aoRu4NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-23, 14:37, Ulf Hansson wrote:
> On Wed, 14 Jun 2023 at 12:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > While adding support for "performance states" in the OPP and genpd core,
> > it was decided to set the `pstate` field via genpd's
> > pm_genpd_opp_to_performance_state() helper, to allow platforms to set
> > `pstate` even if they don't have a corresponding `level` field in the DT
> > OPP tables (More details are present in commit 6e41766a6a50 ("PM /
> > Domain: Implement of_genpd_opp_to_performance_state()")).
> >
> > Revisiting that five years later clearly suggests that it was
> > over-designed as all current users are eventually using the `level`
> > value only.
> >
> > The previous commit already added necessary checks to make sure pstate
> > is only used for genpd tables. Lets now simplify this a little, and use
> > `level` directly and remove `pstate` field altogether.
> >
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Again, thanks for improving this code!
> 
> Only a minor thing below and after that, feel free to add:

Done.

-- 
viresh
