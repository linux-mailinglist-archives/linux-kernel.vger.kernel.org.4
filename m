Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E4649045
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLJSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLJSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:55:08 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F21789C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:55:07 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e18so5433938qvs.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=BzvvoS4YZaiHtVtTnrMPkORr9QN1kyuo5edsRj1EnzCjtxaavYwgd1MdZhbSrsmMz/
         pQLt+8DKvwX5PRNY3AkuVsEXWG3TG9LNQME3xhKH5umXkHq8wRVg5p7P0UkLsc4gLlOz
         C1Wz8XlCiVSbwQEORsXQiY6twwLuti4patvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=uClPRnjWWp+GcGAn5POL7v5wC2wMNKX0lA2Z7PA45vYnzee5yRCW1uOhPZf/JiPoRY
         HiPVsME22NkP/oNAqkymU9PIFVhHR/OwhtPlRfzKmYrk9u6TSgOYgG8ypQiP9qh8+0fS
         FWiFyHnRnFwhe7nydG1um0dhcaz2wG2UhL3Abw5CD2Y3zU3AxiL5nzW5+bLX6o+324U6
         BQOWOQkPtnzuL2DiPN/8uG5m1tWekd/vpY6H3zPVvpUPUak/hRRCi7XpwYNPm0s48ayX
         ZSR2Sm3sLuc/z5V/tsM9WBS2wzvPbrR3QDVcIsgheUIAVGjbLXbReBOWPB3PYdMCMu9x
         tLXQ==
X-Gm-Message-State: ANoB5pmu64GQ5wWZeCIRS/6XiMMskawnA7d3r1jF02mUP6/zTUnao3JX
        wdj8P2OSG82K7zyfPz8GMAmljOz4PZESZSzN
X-Google-Smtp-Source: AA0mqf5RwZaKgXTO3ILO6IkmxvnkL0Py0UsyoFJPPgcreyYft7ZpC6fJOScjl40yOJnJnb+1Y2SqbQ==
X-Received: by 2002:a05:6214:380e:b0:4c7:6cd5:a65 with SMTP id ns14-20020a056214380e00b004c76cd50a65mr17594652qvb.51.1670698506251;
        Sat, 10 Dec 2022 10:55:06 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a0c4700b006fc8fc061f7sm2561993qki.129.2022.12.10.10.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:55:05 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id e18so5433878qvs.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:55:04 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr68313518qvj.130.1670698504390; Sat, 10
 Dec 2022 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 10:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Subject: Re: [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak on
 add_disk() failures
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org
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

On Sat, Dec 10, 2022 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> I'm posting two patches for the iolatency memory leak issue after add_disk()
> failure. This one is the immediate fix and should be really safe. However,
> any change has risks and given that the bug being address is not critical at
> all, I still think it'd make sense to route it through 6.2-rc1 rather than
> applying directly to master for 6.1 release. So, it's tagged for the 6.2
> merge window.

Ack. I'm archiving these patches, and expect I'll be getting them the
usual ways (ie pull request).

If people expect something else (like me applying them during the
merge window as patches), holler.

            Linus
