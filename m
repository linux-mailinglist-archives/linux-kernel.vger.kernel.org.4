Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4014473C437
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFWWmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjFWWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:42:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB54DC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98377c5d53eso125048766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687560124; x=1690152124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QcHhK4jpwXJft/HBulx5tPasW6Ux53Kat5uK7dahPQ=;
        b=DMF0LQqLHOJr+4VsKkSs9BiO4DKyllZx1uoH+khfK/52BM+al+f/ORDqL4m0714RBR
         IzmYd0V/Q2OMdpzxq12HN/XvYl4HSPAeeSW91iUkZly2N9Yhf/ZGo4s/f0uYB5fHDQ5Y
         KFgTEO4JPPagFbA1ehi/izyQWedtxf9pLN1h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560124; x=1690152124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QcHhK4jpwXJft/HBulx5tPasW6Ux53Kat5uK7dahPQ=;
        b=YLdOexKvTqKCpf8HGpq+XpQbqTUIxAT1f95E8zkdzMXSYPNTT7SQAkcy7tAvmtGaB7
         fZXvh79sKKtY2THKyaHFmiWzl2ChRJgRYsXY9zuI2/TDG8Q1slAOY6CDIf5MWcXkraGj
         J+bGDd0/933ZD1jLu2X/3hFwOf1whT32BxXu8erjp2L3W0/y0J+5YlpS6i+MlnWPBpHB
         hXjQ74hMThNNiepEqI5ZDHtTu1kIDCIYwRmaC865VTfsj1GhI18XE/tCC7ee1s4/qsww
         cfdgp6ibbKT1kMTgtqXAgJMqbi6ho7sk/J9T4ZAReURO6heLFrRAjbeAuhY9A3sc/2Oq
         3QsA==
X-Gm-Message-State: AC+VfDynIVGn1VVapCusYnkXY2Vula1Kwnpri2Of92rSQPSa3Gs1jJMq
        46DiUsSw3supPMpWsKk5nd5Np4U2yN5W2E5osmf41l/o
X-Google-Smtp-Source: ACHHUZ6DpamATC7S/r4HNqS6hWQ5+I8qIAWj0sl2/GyP+EoiOFWORCDl7Md0pKsGOO1pZVBo0dR6ig==
X-Received: by 2002:a17:907:7faa:b0:987:fe18:1c51 with SMTP id qk42-20020a1709077faa00b00987fe181c51mr18254210ejc.58.1687560124522;
        Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709064e5900b0098696189722sm145010ejw.192.2023.06.23.15.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d7d0dbec8so171108a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:42:03 -0700 (PDT)
X-Received: by 2002:aa7:d597:0:b0:51b:ecb7:23d2 with SMTP id
 r23-20020aa7d597000000b0051becb723d2mr3683631edq.18.1687560123663; Fri, 23
 Jun 2023 15:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <2730511.1687559668@warthog.procyon.org.uk>
In-Reply-To: <2730511.1687559668@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 15:41:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
Message-ID: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
Subject: Re: [PATCH] pipe: Make a partially-satisfied blocking read wait for more
To:     David Howells <dhowells@redhat.com>
Cc:     Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 15:34, David Howells <dhowells@redhat.com> wrote:
>
> Can you consider merging something like the attached patch?  Unfortunately,
> there are applications out there that depend on a read from pipe() waiting
> until the buffer is full under some circumstances.  Patch a28c8b9db8a1
> removed the conditionality on there being an attached writer.

This patch seems actively wrong, in that now it's possibly waiting for
data that won't come, even if it's nonblocking.

What are these alleged broken apps? That commit a28c8b9db8a1 ("pipe:
remove 'waiting_writers' merging logic") is 3+ years old, and we
haven't heard people complain about it.

POSIX guarantees PIPE_BUF data, but that's 4kB. Your made-up test-case
is not valid, and never has been.

Yes, we used to do that write merging for performance reasons to avoid
extra system calls. And yes, we'll maintain semantics if people
actually end up having broken apps that depend on them, but I want to
know *what* broken app depends on this before I re-instate the write
merging.

And if we do re-instate it, I'm afraid we will have to do so with that
whole "waiting_writers" logic, so that we don't have the "reader waits
for data that might not come".

Because that patch of yours seems really broken. Nobody has *ever*
said "a read() on a pipe will always satisfy the whole buffer". That's
just completely bogus.

So let's name and shame the code that actually depended on it. And
maybe we'll have to revert commit a28c8b9db8a1, but after three+ years
of nobody reporting it I'm not really super-convinced.

               Linus
