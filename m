Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCCB6FE04C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjEJObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjEJObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:31:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452323C0B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:31:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so13576974a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683729073; x=1686321073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw1MLlzzJH/+STgxvKYi/t/faSj/QeBANMCtgkem3lM=;
        b=g+zH5fnw/H7+bg71JqmY1XT6HACMA8B7hk9/64yMwh8ocGg1RpDgnwtwQE2dQUOGYO
         16GNFtGL+vmQwQWJK8EQKgKYw330gpxqbpywwqfCCj9Bt/s2pm8iYTvA/mf+kfeHYEZY
         7/iC0jBVMpW7yAHgKjLCsU5b2SKMzfz/AaDFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729073; x=1686321073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw1MLlzzJH/+STgxvKYi/t/faSj/QeBANMCtgkem3lM=;
        b=XcnUrWybZBAPI6w05c8got4XAO+Pr8HfH7VVZpDEUAWubii3CX+NK9pHnd8WlJ7yg+
         EW2eZ5AxeYUmqFowPWO+8zAXVvlxFg8tJ0uqz+8CrNGttXpnEk3NjzdmU/kUniTuNGLb
         cXtMEqMMKAIamnEAAZ2BWI6uSudxz8l2T5e4DFL7cmIMKivV5803iMH4QbGnByKsdz3f
         5vEUM/tCBOuwViOygTyuucHjK7KPlXIIIYxoYgJnY/JhY+WL+maZjY1y/OacFYeRzmQi
         O3h+Xl18AFlaX/f/Fu2EHvqUQq5tVsHL3xaA8xeOo7HtzrXJy6evGSGJ/etivxy08Ed9
         V+DA==
X-Gm-Message-State: AC+VfDwm1Op+0iXkpfAimEB5N+o2eAekUCzEmsZlI8YEDKKHDuZfFab9
        iNvblzYE2XLeTdSRsxs+abNK3R4EZ20N5varkn3q+A==
X-Google-Smtp-Source: ACHHUZ6Fceu5xdoZxp5/uXwqZbSJ+cuIEkDh8tJ1WLEZryisxpZBTcJazCrSQLZfloyslQXv3RwJHg==
X-Received: by 2002:a05:6402:295:b0:50b:c6c9:2146 with SMTP id l21-20020a056402029500b0050bc6c92146mr12960129edv.24.1683729073416;
        Wed, 10 May 2023 07:31:13 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b00501d73cfc86sm1919937edp.9.2023.05.10.07.31.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:31:12 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9661047f8b8so925154066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:31:12 -0700 (PDT)
X-Received: by 2002:a17:907:31c4:b0:94e:8431:4767 with SMTP id
 xf4-20020a17090731c400b0094e84314767mr14327246ejb.38.1683729072247; Wed, 10
 May 2023 07:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230510030752.542340-1-tj@kernel.org> <20230510030752.542340-4-tj@kernel.org>
In-Reply-To: <20230510030752.542340-4-tj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 09:30:55 -0500
X-Gmail-Original-Message-ID: <CAHk-=wiu5vwNeiDbwueHtpnTp1Be7r3_ssG07Qsv2N=V9K454Q@mail.gmail.com>
Message-ID: <CAHk-=wiu5vwNeiDbwueHtpnTp1Be7r3_ssG07Qsv2N=V9K454Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] workqueue: Move worker_set/clr_flags() upwards
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 10:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> They're gonna be used wq_worker_stopping(). Move them upwards.

I got points deducted in fifth grade for using "gonna" instead of
"going to". Here I am, 40+ years later, and I still feel it.

Please use "going to". And add the missing "in" while at it.

             Linus "scarred for life" Torvalds
