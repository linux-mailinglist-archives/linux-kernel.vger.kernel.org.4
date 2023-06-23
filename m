Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25973C08D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjFWUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjFWUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:40:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD226AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 13:39:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40079620a83so70541cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687552784; x=1690144784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPqWdPkJs/nUcSq4t/ysEiwjvip+vYkENRmC8Nd4fVc=;
        b=sWz5n6tK4xOCUrsaVvxIIoe9iKDtPXbUnViKV9bI83Gr2Kk0GG2IJldbvSpFxZqKl3
         45I3cnkI6UAi6qCvYXmqs1B4MMpK6fBaPe4b/VrbL1DHf6zpqWpZXl1Vjk9FQ8snqXOW
         yNTLbHaFLeD1z0agQFnZOz/lN5V0tHRG2CbCksqsPhOIZ4Z3AOYvn6Gmdnu9NOIWyq2Z
         1XPZS51Q6+iYL7rLIo4hh3xBYdcPz/ZpUD5LfIrf53TW2IRa8PjeLiDziw7YRmhmooeN
         aV9JyrSy/ST+5l1ZR0g4YeQH4Rv9oNeQoWwnoa8Uv7UXOsxXbFwkYW0MzU8K5f5gTbmt
         5PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552784; x=1690144784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPqWdPkJs/nUcSq4t/ysEiwjvip+vYkENRmC8Nd4fVc=;
        b=MMio292LCtKltYZeNYR3EqvTyuHHTdDL3WLumw23Rp/b5hwdyk8pgxemYMKVgF4GWc
         2vliuvhFIASiWd24ndFmFeUsYcd1mRTVEVcqqrd2cbQxDcD3YXxYRp/AbsrVx/8tSRP4
         d29WvQnK+aoGKsD69X9z8CYdDBdyjNpACE+M+Ux7nbehq6UzqGMOjmFhxJnRgc3/g3sW
         TCLmzo4H0I2bvrewu5yOf4N08EOud5mdMe+wVANEoCUwO0CjArROgx8/ATHMelHfy8Yl
         McQPis46nbm4qSBKGOGkPA8oI54EAaAwF+9vOAEb/fX+qWLH2jdAN0hmWxKyA2g8ycNI
         Hxuw==
X-Gm-Message-State: AC+VfDzwIIhigG9vk8RQrV44aqzQfH967RmpGmHXyvjPEoD+8Xu5TTS3
        Q4wJJJ0eGrl9meGHVfxvXgekOrnocMPg6kp4+8+h/Nzi8PzNEabOM31Ngw==
X-Google-Smtp-Source: ACHHUZ7BhsRpP0ZxbJV1Ob1pQJTPtBPEPQKVupWLukrcpuPRCLoL0XQfgfvatNlkSb4WcYoXIOwE5K+Rj/hJdi8hsWA=
X-Received: by 2002:ac8:5a4d:0:b0:3ed:86f6:6eab with SMTP id
 o13-20020ac85a4d000000b003ed86f66eabmr11972qta.14.1687552783963; Fri, 23 Jun
 2023 13:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230621023053.432374-1-yosryahmed@google.com>
In-Reply-To: <20230621023053.432374-1-yosryahmed@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 23 Jun 2023 14:39:07 -0600
Message-ID: <CAOUHufbb6aspJANQf7m2FYr6K6f-z04ii3SP5ZnQ0rLHL1ia2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memcg: rename and document global_reclaim()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 8:30=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Evidently, global_reclaim() can be a confusing name. Especially that it
> used to exist before with a subtly different definition (removed by
> commit b5ead35e7e1d ("mm: vmscan: naming fixes: global_reclaim() and
> sane_reclaim()"). It can be interpreted as non-cgroup reclaim, even
> though it returns true for cgroup reclaim on the root memcg
> (through memory.reclaim).
>
> Rename it to root_reclaim() in an attempt to make it less ambiguous, and
> add documentation to it as well as cgroup_reclaim.
>
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20230405200150.GA35884@cmpxchg.org/
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
