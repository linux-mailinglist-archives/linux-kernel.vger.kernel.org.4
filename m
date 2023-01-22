Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD86771CB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAVTSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:18:17 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389814E96
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:18:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d16so8190843qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMi5cwx+cuHLMcTtoOxFI0oclaxImm0+s+XfYyjkeoA=;
        b=Bp9RENQ8zHgKuj9u4YKL4QldSznJ/HWt/kX1f9R/Zym68wO1GD9Piyxd+b+TpO//pr
         d+QAq4jC2+iaAiqhwxQK6uoPDapzbqkXYDP1LwOwcEHKkjTxGYZBvyrgLiYh9ZxTlepV
         WiAUNuz7/gXQ1ALOWdCgpVlRS20DBXc9XwRNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMi5cwx+cuHLMcTtoOxFI0oclaxImm0+s+XfYyjkeoA=;
        b=dpu9WnDjg5ZDSvuh/jyMAxikD7ZZ2fp0EJqbM0Qtx/7u44uelPljWjVtuVKyJR6NVs
         HRhwrot0GTTn34g8yRiDkdnrkMyCZmtEKZ4gG29JYk0e5xbvnJnd1HGFXVIEyIedJ3Jq
         eX2d+qWNrVrOy0nccbwpDEDRMk3s82UTSGJlgtW9uTJvZG0Ul2jJOD3Z0qhRcOdXBlMD
         2kE5SLnMgcpr2wEuXJj/XmLMlNS/UlzwkFY9wtzH4EYsvRa3vxjSwVRfD9TPfcPW0R1F
         Z9eyNY/wabUJ+DYpWlvJFLz+CZ10GIzCXQglAPUcH+SWavnPMPxl1KTXgmZwoT5G44y+
         Xf9g==
X-Gm-Message-State: AFqh2kp6Wf+tEnR8n67QEZ15/3An5Wo4YlwPWqOkYjYe0LZFF8u08Bv9
        4pGwQhRusUezNpSznrVlq4cz9IQip/Gp7rI/
X-Google-Smtp-Source: AMrXdXs1AIH7GSISAyjgoRusl30aBemI0nUe/9EMxmmgNbuWbNn+KjSDRoQsBhXpxQnznRyX2AMrAg==
X-Received: by 2002:ac8:44b7:0:b0:3b6:3b18:50e6 with SMTP id a23-20020ac844b7000000b003b63b1850e6mr29525348qto.65.1674415095493;
        Sun, 22 Jan 2023 11:18:15 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b007023fc46b64sm7896152qkj.113.2023.01.22.11.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 11:18:15 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id i28so5373943qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:18:14 -0800 (PST)
X-Received: by 2002:a37:45d3:0:b0:706:96dd:8d4a with SMTP id
 s202-20020a3745d3000000b0070696dd8d4amr1061783qka.336.1674415094596; Sun, 22
 Jan 2023 11:18:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
 <8ec65f01-89fe-bd6f-a2c2-f4dfc0555cc2@leemhuis.info>
In-Reply-To: <8ec65f01-89fe-bd6f-a2c2-f4dfc0555cc2@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jan 2023 11:17:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkzFgUsU+M55xSzG3hzYajDOqXFzDwnoyRzwKDbEmzag@mail.gmail.com>
Message-ID: <CAHk-=wgkzFgUsU+M55xSzG3hzYajDOqXFzDwnoyRzwKDbEmzag@mail.gmail.com>
Subject: Re: Linux 6.2-rc5
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 5:49 AM Linux kernel regression tracking
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> Huh, a -rc on Saturday evening? That's unusual.

Heh. It's my wedding anniversary today.. Not that I won't sit in front
of the computer anyway, but I didn't want to have anything actually
pending.

> But nevertheless there is one thing I want to bring up, even if -rc5 is
> already out: Vlastimil asked me explicitly to highlight ```Revert
> "mm/compaction: fix set skip in fast_find_migrateblock"```[1] in my
> weekly report[2], as me would prefer if that patch could head to
> mainline and especially stable rather sooner than later.

Ok, I assume I'll get it from Andrew one of these days. Thanks for the heads-up.

I'm going to do an rc8 regardless, so we're not quite at the end of
the release yet.

                 Linus
