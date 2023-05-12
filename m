Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1D700CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjELQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:23:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FE64696
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:23:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76c657dab03so108123839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683908591; x=1686500591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jYqg+LEPkZJcqO4f+OyWQdzbx/fRQEMeMqiumF1ATe4=;
        b=d0YxE8gG19rt8aupPyzpePMzbrfs0j3JSKwCnEwZ+0jzbM6N362ddNV07rb2jW6q0N
         l/qrs9NyaeY1XFqibY0rvre2S46fPpJXPWqJkNosJrBiiC2sCGrRV3f/B2vltFaBlpD0
         Rd7BWrFfnms6Y9ULvhoUuIOEYEcIsZIk9P/Cqfsp6rWTqrkNLiubjf3rtit4DdlY73lu
         bcaqQDuaRovuwU/ak18JtOKdYh7o8g0ujv3FKootMv4iJ6x0TwXGzoHnRPYKe62YVScy
         BmLaDbITtdPKWM71OAadSgJ0e1z3LGgI45ymrG64pjQ76l3vIFEQWno9XJNcvINOlRLk
         r7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908591; x=1686500591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYqg+LEPkZJcqO4f+OyWQdzbx/fRQEMeMqiumF1ATe4=;
        b=XSq4WuKlxKyjTReBl1/2hNAB5lcqGEuT7Q4Lh9432xRp9jo1pR1j6q0Mm/w8WQySuz
         DpdUqLM/LqbK8+aFhHDRrMdQ+IM2srt1zKuIkf0HZCSOEZtW00BB5iAcE1dKgNLYKkdr
         UeiAQLud5nugRF+D/oAW7YmK9KLLusKFG4L9ShWjF+7jt+Ez/mVSisqpY7QcqW7wCre0
         1UcQOGFxAjDWhq59rmV1IrKgQMT/NQ5SuF7qrfng2mpwHLxIFLculnxSXJdKqpVVhAgg
         uRd143CBMryWYUxgxVO9p9ZP2JdHx0uasDOoI2TRNKBUK3NDN3qF6pwe1soF2JF0ls+e
         W+lQ==
X-Gm-Message-State: AC+VfDwU4lIuO9Xm6rio5YBMAw6nvLpWanbdHzXWqoCYZgo4VItC8Lu2
        aoiXK3w22VBdz+rQT8QsTn23zZFmFShDD3/ai/I8uw==
X-Google-Smtp-Source: ACHHUZ4fg7nl7btDf4GydpSsNRKgD8Bfj5CT+Heg0TucRO9A+aDjMqftnpZ42+BU65oCYNnrk9pU8EdtI5kKGbUGagI=
X-Received: by 2002:a6b:6513:0:b0:76c:76ea:3e8d with SMTP id
 z19-20020a6b6513000000b0076c76ea3e8dmr5441027iob.7.1683908591252; Fri, 12 May
 2023 09:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683892665.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1683892665.git.christophe.leroy@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Fri, 12 May 2023 18:22:32 +0200
Message-ID: <CANpmjNNLaA6TQnjwfhwd_=4o6S14vX5AAm4Az_bDaCb7zgNO_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Extend KCSAN to all powerpc
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, Rohan McLure <rmclure@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 12 May 2023 at 17:31, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This series enables KCSAN on all powerpc.
>
> To do this, a fix is required to KCSAN core.
>
> Once that fix is done, the stubs can also be removed from xtensa.
>
> It would be nice if patch 1 could go in v6.4 as a fix, then patches 2 and 3
> could be handled separately in each architecture in next cycle.
>
> Christophe Leroy (2):
>   kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
>   xtensa: Remove 64 bits atomic builtins stubs
>
> Rohan McLure (1):
>   powerpc/{32,book3e}: kcsan: Extend KCSAN Support

Acked-by: Marco Elver <elver@google.com>
