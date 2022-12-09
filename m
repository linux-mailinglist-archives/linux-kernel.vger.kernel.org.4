Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868A2648B50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLIXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:23:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827F29822
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:23:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x28so9307858lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+icRteLLplEp3Ek/NXtDd9Se354lCSj/qCUgEIA000k=;
        b=gAqZH17K6r2+VNZVHPk61uPPLKx4h3U28CM81aZWpAIWUmu8PiVAYYGJo/TNew5m1c
         UaLumuIOpDBpPu91/QWAnSz5Tf8lcWI1569hlbnXtxO1r4zBxWIUl9kJIlwuDnPSC9Or
         B5Y8rRhjWNs4jEn8TtjN93iqcYgr+lwi9gMFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+icRteLLplEp3Ek/NXtDd9Se354lCSj/qCUgEIA000k=;
        b=KvoKyn+CdHTMshIXSLW3EVhGFT1fvyawy8CZrrtNh+yGEpxBc4e6OpWaOcaS9fSapq
         twmiZnn+y+ruxO5rvrwn+Bnnm/nId0f/plNH3uCP9i7LmQUFkXJJz2S8Yx6mBPQqU9j9
         kAooMiALMxmDudRtEohwvX74BEUC7AVaSUFF8dhdRMrjzfQ8Oilm2guTeueoKAJ1vcV2
         zOy0/NV/Z5SGAstbFYkyj0KAvgAOzjVsXst9Nxrfmfe6cjC6C4a6rGh7qJzRncX7+DXX
         EXd2d2sQYTb1gcxs9PwqaU6jS8zJy7PisffeRr+mvMq38Gb9X18CbgCDmB7L1Tin+DuX
         2eDg==
X-Gm-Message-State: ANoB5plprzkPgPyIleUtQOJ+JhuFtOk8/QyNiyPccgt+Me4/A0c2Dg+K
        AhWnBY7F9TZdHwgyz2hNsOP4nX83SzH9qkoxLugLrw==
X-Google-Smtp-Source: AA0mqf6qdZxMmQuUzYi3g1p036fYDzU1mxpBVEonNWDL16/oHB1VOmEcCib4omGOHlK2nPv+IKw5U8c7BOgTaJk/ALg=
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id
 c8-20020a056512324800b004aa148d5168mr30344867lfr.561.1670628210994; Fri, 09
 Dec 2022 15:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org> <20221209163759.6s7pqf5wdvy32ywn@offworld>
 <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com> <20221209223232.2dqjeamad6nhlcmp@offworld>
In-Reply-To: <20221209223232.2dqjeamad6nhlcmp@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 23:23:19 +0000
Message-ID: <CAEXW_YTLuRU2fxnijoez8m8n50L-FcU46cOLUPgp15m0C8fdxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 10:56 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes wrote:
>
> >> >-               * Boost priority once every ~50k operations. When the
> >> >-               * task tries to take the lock, the rtmutex it will account
> >> >+               * Boost priority once every rt_boost_factor operations. When
> >> >+               * the task tries to take the lock, the rtmutex it will account
> >>
> >> Nit: maybe refer to it as 'rt_boost_factor'?
> >
> >Sorry, I did not follow. Refer to what?
>
> Just use single quotes to refer to the parameter.

Ah, got it. Will do (either next respin or Paul can do it) and thank you.


 - Joel
