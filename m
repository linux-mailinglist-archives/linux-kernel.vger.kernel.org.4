Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B386C5888
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVVJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCVVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:09:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA521952
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:09:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so78430275edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679519352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8BrsbGRfzEHZsIUH0GK10LbjiOfd8SiNUhlgvn39PY=;
        b=ac3bF1i6lZ2yCIXThe9UBo5QzCMi1BKsuIrTTjlz7+6gBquYeUao4r2IhZSQBzOpTI
         MSCP3sBwIPBcmPuAoumPQZxlaPx/N3uTVMjdiDV/wy1Zq0Hk4i+O0ZPBEWBxtyMQzWdG
         AWDurTvA5r2Ralj4EdQkjC1akrpg+XcUONrH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679519352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8BrsbGRfzEHZsIUH0GK10LbjiOfd8SiNUhlgvn39PY=;
        b=q3adIVENI58FvJJhCSX0nzWlCPDgIGHt1qdCI57LwydTAg6MlBKHHXGfTR3xz8/55v
         4S3bgBoOFpWqErO7RjBGtYJRpQjnX54kroWVVJei7eC25JJh/hPSM8ThYJSUsKrKTF7T
         n0CJMFUgmJTcZjvLd7YYtjpKrnAUfmNpnf0/HOIWdJOFAIl25GiQDc3QabxHwtvJe7eK
         02DW/uih8wFqF3IJsqS3ydt4kStvw/JcfZKob7OnbiWXFLOdhnG4muRHVfcZWyIz6ziD
         kH7oONnSf9KFiqhvju9cudQ54tQa/JSp+9z/OKwZ2RnKHrJMNB690dvJpXy2lf/mhPbR
         1OIg==
X-Gm-Message-State: AO0yUKXk70lvmeX1qxcC518nVHv3OEAj6y6svVoASqodg4FzMeyIwadV
        29R83cTxpd8idQKtkR9P9s+MJ7oBAmn1e3ZLk8EDqw==
X-Google-Smtp-Source: AK7set+NslpFufjOWRCi5QYEiXzi+rKXTlroBB1TisV45zeeLDdmzzCckFv6uO1qBuD9gPC/5MbD2Q==
X-Received: by 2002:a17:906:604a:b0:8f1:949f:37b5 with SMTP id p10-20020a170906604a00b008f1949f37b5mr8791470ejj.32.1679519352204;
        Wed, 22 Mar 2023 14:09:12 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm7657237eju.118.2023.03.22.14.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:09:11 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id x3so78339720edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:09:11 -0700 (PDT)
X-Received: by 2002:a17:906:aac9:b0:927:912:6baf with SMTP id
 kt9-20020a170906aac900b0092709126bafmr3825562ejb.15.1679519351218; Wed, 22
 Mar 2023 14:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230322200309.1997651-1-sashal@kernel.org> <20230322200309.1997651-5-sashal@kernel.org>
In-Reply-To: <20230322200309.1997651-5-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2023 14:08:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ8r85GhA=n8=NJCXOnpJ5KNqitV2FK2YnK73+Z7tzUg@mail.gmail.com>
Message-ID: <CAHk-=whZ8r85GhA=n8=NJCXOnpJ5KNqitV2FK2YnK73+Z7tzUg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 5/9] sched_getaffinity: don't assume
 'cpumask_size()' is fully initialized
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yury Norov <yury.norov@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 1:09=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> The getaffinity() system call uses 'cpumask_size()' to decide how big
> the CPU mask is - so far so good.  It is indeed the allocation size of a
> cpumask. [...]

Same comment as about commit 8ca09d5fa354 - this is a fine cleanup /
fix and might be worth backporting just for that, but it didn't really
turn into an actual visible bug until commit 596ff4a09b89.

                Linus
