Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7A616B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiKBRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiKBRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:46:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE812ACD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:46:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f8so12250377qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njYRHOF8PBTOLR5X1IwiLISD8+wycAUFRyOLehmMkJc=;
        b=INH8sAb66bVfcoHPStGz2SdVBAzB6hdoGdL//UtvQE9vOiLzeirTWz7OGAcLeiCZdg
         YbbgF/mQWUv7cQoUqML8Lx2quVrDN9f2D183Pe1eEJuqu9n1gXCp93QjTfGDvqjOkTiF
         8wzwxGQGyDe+TiUhumc/0akfnkdmtM/eidS6hYy4YORaVu4ojYk3U4tQ1Q9m60wuU0N1
         OeRDqOSAGfBeCDOjcCfExKw/4UIvJtywIQZkjb+TUO/XpkHuWRXTFyTUOigQ5TWG5iZB
         axFaqWfJ32fkSW+ydAZCsWWDLxTgkickUvCfJhKdy9qEjy8Ty4M/vZ8tNVRspZM3V7uZ
         Qbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njYRHOF8PBTOLR5X1IwiLISD8+wycAUFRyOLehmMkJc=;
        b=gXjHk2jwh2C7kXKE35GOMtCRbQtPcobIW/EWKbTqRJUZ/ZFjkilYr9WRxoXyKpf7c/
         4duqqR87tHsKhpIQBWYRDePzad78vrreXJ8ce3Q2j1YBN2fAszGbnadXA3ib03MJH1f6
         wQ5H03FOMkeuJtHQnW7hx+Arq2wIeFYHSZweIRNVzwgNCexN3dpxN66gedpYPAAbejZC
         NwZCYb+L5BpIYaGTzsqRl3fV/D5zxOTItaidU/rXmuIp0VJ9orvemDMh+PAXRJ8X/tOs
         ruuva/NuxzeC3Wv6PFNRm050XM7RduTyPcPY1qwXEQZ1Mpof3sFvFqa2GrxrwB0aFbUb
         DT8g==
X-Gm-Message-State: ACrzQf0QTlknbHpX5tCo7fIrFEAZrKwgvnqNqQWsPO3YPrEOwPgRX2xy
        llreXPmtay7YUSdric24lBw3VpF6Zgk=
X-Google-Smtp-Source: AMsMyM5pT2XRn7fZYnwSWeaXYyp29ab20WRqnqEr7824A/FIUNktIagNP+r3ImOwFfhwY1pv+8p0ig==
X-Received: by 2002:a05:620a:12bc:b0:6fa:65d7:30d1 with SMTP id x28-20020a05620a12bc00b006fa65d730d1mr2213804qki.323.1667411216142;
        Wed, 02 Nov 2022 10:46:56 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05620a2ac400b006f9f714cb6asm8709968qkb.50.2022.11.02.10.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:46:55 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-367b8adf788so173197137b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:46:55 -0700 (PDT)
X-Received: by 2002:a81:6a46:0:b0:367:6708:9f1b with SMTP id
 f67-20020a816a46000000b0036767089f1bmr25315551ywc.56.1667411215348; Wed, 02
 Nov 2022 10:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk>
In-Reply-To: <20221030220203.31210-1-axboe@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 2 Nov 2022 13:46:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfj5jn8Wui+az2BrcpDFYF5m5ehwLiswwHMPJ2MK+S_Jw@mail.gmail.com>
Message-ID: <CA+FuTSfj5jn8Wui+az2BrcpDFYF5m5ehwLiswwHMPJ2MK+S_Jw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Add support for epoll min_wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 6:02 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hi,
>
> tldr - we saw a 6-7% CPU reduction with this patch. See patch 6 for
> full numbers.
>
> This adds support for EPOLL_CTL_MIN_WAIT, which allows setting a minimum
> time that epoll_wait() should wait for events on a given epoll context.
> Some justification and numbers are in patch 6, patches 1-5 are really
> just prep patches or cleanups.
>
> Sending this out to get some input on the API, basically. This is
> obviously a per-context type of operation in this patchset, which isn't
> necessarily ideal for any use case. Questions to be debated:
>
> 1) Would we want this to be available through epoll_wait() directly?
>    That would allow this to be done on a per-epoll_wait() basis, rather
>    than be tied to the specific context.
>
> 2) If the answer to #1 is yes, would we still want EPOLL_CTL_MIN_WAIT?
>
> I think there are pros and cons to both, and perhaps the answer to both is
> "yes". There are some benefits to doing this at epoll setup time, for
> example - it nicely isolates it to that part rather than needing to be
> done dynamically everytime epoll_wait() is called. This also helps the
> application code, as it can turn off any busy'ness tracking based on if
> the setup accepted EPOLL_CTL_MIN_WAIT or not.
>
> Anyway, tossing this out there as it yielded quite good results in some
> initial testing, we're running more of it. Sending out a v3 now since
> someone reported that nonblock issue which is annoying. Hoping to get some
> more discussion this time around, or at least some...

My main question is whether the cycle gains justify the code
complexity and runtime cost in all other epoll paths.

Syscall overhead is quite dependent on architecture and things like KPTI.

Indeed, I was also wondering whether an extra timeout arg to
epoll_wait would give the same feature with less side effects. Then no
need for that new ctrl API.
