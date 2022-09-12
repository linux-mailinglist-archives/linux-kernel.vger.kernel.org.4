Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F15B52A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 04:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILCX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 22:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiILCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 22:23:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9BA1EC7B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:23:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s10so8316701ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sQSPw2/Yv4uUp2AaAGOjeqmDAWsfMqITGNLo8334oeE=;
        b=VaKZg8t+l7Y5XlONXTGOuwmbf4afC1bwL9BOGvU8npmzhmzMHKlmim937SzLzi7f6+
         mwh8N0ZgY1vey5nXKOCE2NbUS0rU+aNwpfbpFie8oZZFblfgHHmVX9M8qur8aKnT7jh9
         /X8AVNFidSiEJh8u+DK92BrhbclID/LggJN3v9FITFQxHfGeeovBt9VSIQP9QH+iaFLc
         MyY1hyLvbq59wQzn4QbnCsvRucAnc54Bf8rp24SnqkMeQ8IP630JXu3MC/7rh5lmDCQY
         HDp29MGwQK4QbDCmqeSkT3uWianTiILJbqQ4plgyYF9fyOMxeqVaCZ7L6fjgqESTgpBM
         1f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sQSPw2/Yv4uUp2AaAGOjeqmDAWsfMqITGNLo8334oeE=;
        b=aNCpkUE9zfoVWRmL8smS0RHVj7XaG9K4Eriph8qy95GxuPPcJHzECEc56LZGBAqgau
         nvo07CDpTQLtWTq7+cpOdbwcTzRWRVPJ4DTzecDZJ+xV7R+weAhI3Vlt+yyMezlXd6OA
         KavZ0E/PicLx4WNy1RnyNrcyJpIcJzibsWAp3uil2lHO7OGpRTDPyGBtFd4mI16U10D0
         ml1+MC5aiIYmQcgQyssgfVPplqB+ZR7/Q69SqLMpQQ27ZetrG1PetB1VdWSezGvnIuir
         9wNpVk30Qe35aUicNQzd35hLSIV2cKZpXPmZjtoQtJApdrs2VQqEpDKlj2b9JK3HZE/7
         RyFw==
X-Gm-Message-State: ACgBeo2wZKMBCwvKrD9ID0Q4TRRfiJFxTbyPMxBUzRAUmRWBi3ijPj36
        9Eh8fB8J5gci6S5A4pnVkiS9BmeE9KBpCkTS/78=
X-Google-Smtp-Source: AA6agR52xr8rc8Et1DooZ9763Lw2DxwG9jieVV7VdxP5PcJbpYumqI6j+TBggJvoOrt0nc+fLsBO2c5KvN9lmmGGbag=
X-Received: by 2002:a2e:be8d:0:b0:26c:f4b:47a0 with SMTP id
 a13-20020a2ebe8d000000b0026c0f4b47a0mr131263ljr.92.1662949433420; Sun, 11 Sep
 2022 19:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com> <YxhrtC/Z6H5MqUgq@arm.com>
In-Reply-To: <YxhrtC/Z6H5MqUgq@arm.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 12 Sep 2022 10:23:25 +0800
Message-ID: <CAGWkznF_B10YkQ0jeS_O6z3bfeLk7aQZH6AVS9znFmJwa6spHQ@mail.gmail.com>
Subject: Re: [Resend RFC PATCH] mm: introduce __GFP_TRACKLEAK to track
 in-kernel allocation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 6:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Sep 02, 2022 at 06:59:07PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Kthread and drivers could fetch memory via alloc_pages directly which make them
> > hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> > kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.
>
> This may be helpful for debugging individual drivers but they could as
> well call kmemleak_alloc/free() directly and not bother with new GFP and
> page flags.
Sure, it could be done as you suggested. However, I would like to have
all memory related things wrapped together and leaving the user a
simple entrance. Besides, some drivers are designed in
Producer/Consumer mode where pages are got and freed by different
peers, which may lead to unpair kmemleak operation.
>
> I wonder whether we could go the other way around. Add a
> __GFP_NOLEAKTRACE (we have SLAB_NOLEAKTRACE for example) and pass it in
> the places where we don't want pages to be scanned/tracked: page cache
> pages (too many and they don't store pointers to other kernel objects),
> sl*b, CMA etc. allocations (basically in all places where you have
> kmemleak_alloc() calls, otherwise the pointers overlap and confuse
> kmemleak).
>
> --
> Catalin
