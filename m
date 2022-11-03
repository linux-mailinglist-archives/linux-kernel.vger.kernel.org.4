Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E406176A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKCGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKCGM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:12:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814419284;
        Wed,  2 Nov 2022 23:12:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y72so1059898yby.13;
        Wed, 02 Nov 2022 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3JCTTpR+YKw4xAlcc1PtsGiUJQzVSedDDCEh2ZLNAU=;
        b=d7BbDkTJP702UtgEr8+TdiMNyVfcz+F93qK5Jx5Xp4KiXJHpq0t4fcmn99EecUjr1l
         rm7yOrZseXa/E4qhXTXPl2ABSYYGLxZbDTkUuS+K7HmuxuuXvm/2wXdUOg3vapAC7CLB
         B6p2fXVu81lb151gkqrvLrSQWP6heGl4RdYoqzyGAQtvKHccj5/eCOIiGDHuPbuLaZjd
         e6Vmj1WvCMw+4VncqzHo+ozG22yKkFZDfanN/Om8yzPhRmc0v4MyGtz14+KVq11xPOhQ
         SkkhCmnz+zDe3iyXzalUWWxsYuxaaAQY1EkDVEi26GEPqMAH37qB8/TPEFljOAPRpQD3
         i+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3JCTTpR+YKw4xAlcc1PtsGiUJQzVSedDDCEh2ZLNAU=;
        b=jBYryaIH/EUcaFuPOw6nvHwJXoiwRZh7UmF1l0sEh8CKjPCEQ9LgAg3dDLegw9mr33
         H3P3f0mw9iYf2Jh+Zw5ckTZxPd4IPTTgXjGx4dNL/wHXBKX3mZUbD7rUPNU+yRXptxx9
         FKys4jpqC/JSnzrQIDk157TBv+eYQZshbvwEw9OceOa/SmNAQqAjHgBGeoMX1RPI73HX
         86SLCReZsJmnk9I5BjEL6uGUB4q+457COgGAZgjcDKGwuixIo/Z25ffUBius2bfnmAEc
         gJtVCoXW5kMHozpBdn3toBLQLEdLJIr4q0872bjif5267OI9jE3ogFIFr6pha7kEjV3X
         aPcA==
X-Gm-Message-State: ACrzQf1xTCiSd5WS/NUpcbd9er/bPKrbB3+z9KnOA72u1YTZT49m3B8X
        Efvy1eFbcUUoAGkOB8jjzi6SM8NxMKCBJmgb7lg=
X-Google-Smtp-Source: AMsMyM4Ym/z1QT3ZBqBVhtxnudLo76bo1nE0VJsoDPQR4QVPXBXZeNduENCEqUEmeFK7em04gXtiQOon8APoS+niDn8=
X-Received: by 2002:a25:b215:0:b0:6cb:f84f:b1c5 with SMTP id
 i21-20020a25b215000000b006cbf84fb1c5mr28628411ybj.579.1667455974745; Wed, 02
 Nov 2022 23:12:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dennis Dai <dzy.0424thu@gmail.com>
Date:   Thu, 3 Nov 2022 14:12:43 +0800
Message-ID: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
Subject: rust nvme driver: potential sleep-in-atomic-context
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rust nvme driver [1] (which is still pending to be merged into
mainline [2]) has a potential sleep-in-atomic-context bug.

The potential buggy code is below

    // drivers/block/nvme.rs:192
    dev.queues.lock().io.try_reserve(nr_io_queues as _)?;
    // drivers/block/nvme.rs:227
    dev.queues.lock().io.try_push(io_queue.clone())?;

The queues field is wrapped in SpinLock, which means that we cannot
sleep (or indirectly call any function that may sleep) when the lock
is held.
However try_reserve function may indirectly call krealloc with a
sleepable flag GFP_KERNEL (that's default behaviour of the global rust
allocator).
The the case is similar for try_push.

I wonder if the bug could be confirmed.


[1] https://github.com/metaspace/rust-linux/commit/d88c3744d6cbdf11767e08bad56cbfb67c4c96d0
[2] https://lore.kernel.org/lkml/202210010816.1317F2C@keescook/
