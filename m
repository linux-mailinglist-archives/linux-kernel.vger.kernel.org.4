Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0717476EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGDQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGDQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:40:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79DE10EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:40:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso6806650a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688488806; x=1691080806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HXb9doCia3kdxcU1SlSJEDVl+bmephTF+BvWe4qZAlU=;
        b=NADTMbWIZB9MtAAJVDVeOzPZDmHED94IqgHird+7dj8aIcn4jQO0N4U9VxtXAPd6Sv
         KhuGkDla/vuo2/CNa82xjgSnwInTpyaseCJv5G9jyvfE2XVt00eVWCc7H8+v0Y0csKoX
         lZU/D4pr7U5K9ENgerf3/UELcZT+OfJg6KEjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488806; x=1691080806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXb9doCia3kdxcU1SlSJEDVl+bmephTF+BvWe4qZAlU=;
        b=Ytsag7nfmZOR2A7ebWRrUugJFAfmq5N5CmAuKm8mgJY4HbP8oD6s1wbGNBuqxEHVU/
         bIlYAQw/qRBxmJ1rAJ87guZdKEXUL4jETdJAqvBgi6GbUwQ9CRxJnJgh1O6tYayRYECt
         eEmn10P6hLN9xLxAj0sGFJdeKGt0YMBx12yHqTfn16nL/ZcvE7xNbH9MLxPA2eAT4DU4
         zH9pT1JHGX4VOxb8d2wEmvQA5G8TzUk1Ub4Z7khbvlZXUkt+HTt4D0sVoDS6VI2Fzp1v
         TAqjmCWwf0oNqY6Ln3x3o2QCV8h2TzJJpkhZwiyRVI2p7Q7cbqszNSoVt+M6ygMXfjSQ
         28Vw==
X-Gm-Message-State: ABy/qLZW71/pSzCb2D5TwlRhUu+oxkQy08Z4JfX3Kcem5d1lPTfAYEqQ
        C9KyersPnXcgtfywpZWSfDeg17wNaIKiuEMIonlejYuv
X-Google-Smtp-Source: APBJJlFqkmaiJshCS8UOKhnx0wErCZN1/KiedZEtR+Nb8bc3DfhkAO/m0yxIZfh497uakeZTYpW8Fg==
X-Received: by 2002:a17:906:85d3:b0:992:d337:6e44 with SMTP id i19-20020a17090685d300b00992d3376e44mr10215902ejy.58.1688488805976;
        Tue, 04 Jul 2023 09:40:05 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id hk18-20020a170906c9d200b0099290e2c163sm8144083ejb.204.2023.07.04.09.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 09:40:05 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so6802057a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:40:05 -0700 (PDT)
X-Received: by 2002:aa7:df17:0:b0:51d:d568:fa4e with SMTP id
 c23-20020aa7df17000000b0051dd568fa4emr9181443edy.41.1688488805133; Tue, 04
 Jul 2023 09:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b73abf05ffa60902@google.com> <20230704092451.72974b7a62ae08d48c077e10@linux-foundation.org>
In-Reply-To: <20230704092451.72974b7a62ae08d48c077e10@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 09:39:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzthQy42SzYb1Bs_6tGyss5=SoiOppSE6onjUWDwA=aw@mail.gmail.com>
Message-ID: <CAHk-=whzthQy42SzYb1Bs_6tGyss5=SoiOppSE6onjUWDwA=aw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in __gup_longterm_locked
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+6cf44e127903fdf9d929@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

On Tue, 4 Jul 2023 at 09:24, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Thanks.  This is the temporary warning which was added by Linus's
> a425ac5365f6cb3cc4 ("gup: add warning if some caller would seem to want
> stack expansion").

Yes, and the randomizer system calls aren't very interesting for that warning.

I don't have any good idea for how to distinguish "this is a
randomizer that is just doing crazy things by its very nature and is
passing in nonsensical system call arguments" from "this is a real
application that is doing crazy things that we will sadly have to try
to be backwards compatible with".

And at the same time, I _really_ don't want that warning to then
perhaps hide some *other* more real warning from the test automation.

End result: I'd love for that warning to trigger on real applications
(including ones run by any cloud test infrastructure, although I doubt
that infrastructure necessarily runs very interesting loads), but not
on things like syzbot and trinity that just randomize system calls.

Does anybody have any ideas how to tell them apart? Maybe syzbot
already sets some flag for this purpose that I just haven't thought
of?

                 Linus
