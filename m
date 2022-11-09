Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90536234E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKIUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKIUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:49:17 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9826AFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:49:16 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a27so11064189qtw.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv5zvrDMIjVJDZdCoLhQ5HOm0TuMGzwYNTnzMDBX7h4=;
        b=Qfeg8wV9yFrnUA09Qe5i4xmP6B4GfnyxmTQQ8nudUDGnUqLrv+UXqQ/KZQbabXKFcB
         OPFCoUXnuPC2rkcqRCIa2J4PIuNWEs5ZuG2uI8jLOfF1hF4m8cE7WQCsGLGHXRakOkYg
         O8UJdbZHCOcg1qsw6/OLcM/igMwW2imEu2o54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv5zvrDMIjVJDZdCoLhQ5HOm0TuMGzwYNTnzMDBX7h4=;
        b=a8V5K3abz+xRPvZVNjmIaOngl0CeFsTx+0PMnp4KYdpXnQhNQNDTz92Z7cA8YR8etf
         VLzSADOVRFyHQ1QpmSD2qJnWxq3riQO5jZd1QY1ILWFgp3oDL2bffvdYGlId4NRECpRU
         FFFf+HzpiI6aHCnCXezVbbM92wpfMsgsEUT1iPRQlzGgSnqyGpq/sJTt0G9TInLd2cfm
         H05C4ouVc7WLvUiaGWwNBgjSDQPrmJGEK4n64ZuizRkarOaahQtILXVtS4dkX4aNLofm
         +IH+N/CjVpYFv7dqTTpEISl+9MOkWFGO+DphWL89zL0XPLJGbMWhTAy2ysAcGpZPygk9
         Rs8w==
X-Gm-Message-State: ANoB5pnoi747Gckc/SBfmKEkTbrE+SYP5jzsVtQ1Axaw63qokiQKrdJj
        Z37mP4nbQ2kSAS2/vjC+7sWSlm0tC8EwFw==
X-Google-Smtp-Source: AA0mqf5EHxI9UoNimc91L0XB/SXTYWC30po7frejFOwNJrYe9tvq36yeratEdF7db8rfxDAzRdCsGg==
X-Received: by 2002:a05:622a:103:b0:3a5:8efc:7388 with SMTP id u3-20020a05622a010300b003a58efc7388mr13547404qtw.291.1668026955036;
        Wed, 09 Nov 2022 12:49:15 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id cc25-20020a05622a411900b0039a9b55b829sm10179114qtb.29.2022.11.09.12.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:49:12 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id r3so112908yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:49:12 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr56404285ybu.101.1668026951807; Wed, 09
 Nov 2022 12:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20221109203051.1835763-1-torvalds@linux-foundation.org> <20221109203051.1835763-4-torvalds@linux-foundation.org>
In-Reply-To: <20221109203051.1835763-4-torvalds@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 12:48:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
Message-ID: <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has
 been flushed
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bah, in carefully removing all the "let's send it as a reply to the
previous thread" command line flags, I cleverly also skipped adding a
cover letter, so this updated series got sent out without one.

I need more coffee.

But hey, it's not like the people cc'd haven't seen it before, and if
you want to see *all* the patches (I didn't want to patch-bomb people
with the prep-work), at least 'b4' is happy so you can get it all with
just

   b4 am 20221109203051.1835763-1-torvalds@linux-foundation.org

this time.

The main changes to the previously posted series are

 (a) try to  move the s390 changes to generic code

 (b) build-time checking for the value range of the flags passed to
encode_page()

 (c) added comments both to code and commit messages

I'm sure I messed something up in the process, not just the lack of
cover letter which has now turned into this "tail letter" instead.

                 Linus
