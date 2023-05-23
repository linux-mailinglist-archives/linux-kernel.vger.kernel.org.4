Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3470D0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEWBwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEWBv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:51:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82394CF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:51:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fb45a5258so491415366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684806715; x=1687398715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uHv101NdlG4/nBS5KPCZmbm0+kv1UCtmMJSQ4x9lik=;
        b=RZ3fUjRVOZUAHcPeP37SIFpXRWZEvJtrFD0DchC5bNxArSQFA43v6c9L3vwU3rovvE
         7Lzl4hYEqJEg/PGnhML5N9ypVYZ2ZvcJHTleVWFR++qlXY3mLC9IBHJ5oUvmBUcKxbNc
         jyi8mQxPtZe8gax7v4RAphHZg74ZKxaceIOaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806715; x=1687398715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uHv101NdlG4/nBS5KPCZmbm0+kv1UCtmMJSQ4x9lik=;
        b=RrYhwr7M/4Luayz9eKHCd8vnuSby4oL+9F/PaB9IVdVXG6PKCDfb2GXR5qtW4449zg
         GlhXfKSI4qso2ZZ0jPnnnpPuTPQb2LTRs+yRuovCkWzyXJKCBJI1GR9cOVawbB+ktWqf
         YqokAmNQ2It+PCSC5DAecdMQ1GPl7Yfsr4PpmFc58SfpH/+AdoDZ+kBkkh8T6/SLMXp4
         wbFpCd0PPBL3n7nTpN4XwTWo2As1H57WRO1fPIUZZFhu4TjwnLs7OgIpw0BGiKBM8TiI
         xHuU5yNHg+iwTvDlAbvMBJEPC5LrHuUrU4rLjuuIL0AaUuagcc4NXyNLyA5MY8EeWcp6
         Suow==
X-Gm-Message-State: AC+VfDz8KSrfkhEy5HCsEU0nrSo6Ko/xcYSqqXjCmemI61mCOcemlnsA
        aZ7itBFLduu6MegxKRnwlUGhk5sEq03cQGwrscxWIwXr
X-Google-Smtp-Source: ACHHUZ4FEu2y9w64KUPHe9MMkk6uEvqMWfaER7kHRxZTr0tmSVS6gMIBVKU412OqcTB1mv9fR0Bexw==
X-Received: by 2002:a17:907:7ea6:b0:94a:56ec:7f12 with SMTP id qb38-20020a1709077ea600b0094a56ec7f12mr13057200ejc.30.1684806714852;
        Mon, 22 May 2023 18:51:54 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id xa12-20020a170907b9cc00b0096637a19dccsm3809196ejc.210.2023.05.22.18.51.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 18:51:53 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-96f818c48fbso704017566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:51:53 -0700 (PDT)
X-Received: by 2002:a17:906:5d06:b0:96f:f809:1394 with SMTP id
 g6-20020a1709065d0600b0096ff8091394mr4605087ejt.53.1684806712643; Mon, 22 May
 2023 18:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
 <ZGf5rfESYhKYzPSY@slm.duckdns.org> <ZGgAKK-c_DZpvNJB@slm.duckdns.org>
In-Reply-To: <ZGgAKK-c_DZpvNJB@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 18:51:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com>
Message-ID: <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
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

On Fri, May 19, 2023 at 4:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Oh, a bit of addition.
>
> Once below saturation, latency and bw are mostly the two sides of the sam=
e
> coin but just to be sure, here are latency results.

Ok, looks good, consider me convinced.

I still would like to hear from the actual arm crowd that caused this
all and have those odd BIG.little cases.

            Linus
