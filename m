Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D4676894
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAUTor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:44:45 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539141BADB
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:44:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fd15so6791820qtb.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wm9ahWozNRIfaLVLWYiXHQvmnl2IvBDsysjsc+WJQjQ=;
        b=IQMz/2j+KF5OnHbv7DfggLA+aIo59zACuXNlEs65wsHK5S6basHLBYQhw0kOAn7Rsh
         4nQ1VjfqUPCBTerulaHgPjDW6LRov5fyFXcm6OqeAosTlHlhHJsLppnfu+Boz3oRoubO
         pz0rWDQ/nrqcSqGea0crmj5KPc1JW/ZjAUVWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm9ahWozNRIfaLVLWYiXHQvmnl2IvBDsysjsc+WJQjQ=;
        b=piOEz0ubkUvIRtvaSslvygMSTByLfuwNu5D4Xx1HeG6C4qYuh8PQz8P30w1KYq74ga
         fkst7rcU09PTwFNhxwluiHdDS7CW5O7d4D0XyYL9tAvHcT3tMAl47ES8LppTDb3QTdJU
         PBjFLEchcvMb+Vww1hPDmd4f2/xtIrc4NnOqtQmaV6YNp466Qe8f9p2CLiqpvoX+Jl7t
         9ve5LqAUvI3cEPMZGKv1dZxH7/vZUjsTJXUHLrtYP0RiJ94tgYH2ZnKg5E7Mq/ZBSjpb
         AJgOgZanFjjTavkwOp7t82tV461/nphCuZD4QlVgJFVQG7ePkGkz+TVGil4aGWxQPoOa
         WDrg==
X-Gm-Message-State: AFqh2koa6/YhXaNXzYUD0jZc34PNoFanMLlvbMRvAwOoX9B0l1n/+npo
        WsGQdKyKb+U87gzQUp+nwcXnHzvvYsGOtNwW
X-Google-Smtp-Source: AMrXdXsXRUUe7DlOAmTHNoRDWAWVRH9zgXt2+8A3uY/6g6dX8zS6L4iFrOxexiDwBeyjh2rcZ7v1Zg==
X-Received: by 2002:a05:622a:5917:b0:3a8:175a:fd48 with SMTP id ga23-20020a05622a591700b003a8175afd48mr29279541qtb.64.1674330283304;
        Sat, 21 Jan 2023 11:44:43 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id b2-20020ac84f02000000b003b635009149sm8521600qte.72.2023.01.21.11.44.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 11:44:42 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id d13so4531021qkk.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:44:42 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr1010910qkl.697.1674330282464; Sat, 21
 Jan 2023 11:44:42 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003a5c4905ef1044d6@google.com> <000000000000107e1b05f2c19aa5@google.com>
In-Reply-To: <000000000000107e1b05f2c19aa5@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Jan 2023 11:44:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0=KdGcRGn4tMASp0ZMJH215Dw+5cFZgKZ=+ry5Kh7Rg@mail.gmail.com>
Message-ID: <CAHk-=wh0=KdGcRGn4tMASp0ZMJH215Dw+5cFZgKZ=+ry5Kh7Rg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in get_vaddr_frames
To:     syzbot <syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com>
Cc:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com,
        tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:03 AM syzbot
<syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 6647e76ab623b2b3fb2efe03a86e9c9046c52c33
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Dec 1 00:10:52 2022 +0000
>
>     v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails

Yeah, that warning is kind of expected.

> Reported-by: syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com
> Fixes: 6647e76ab623 ("v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails")

Is there a way to tell syzbot to ignore one particular warning?

Because we could certainly turn it into a pr_warn_once(), but
honestly, if a real use case sees this, I'd rather have the bigger
splat for a while yet.

Then we can remove it entirely (maybe in six months or something?)

                Linus
