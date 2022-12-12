Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675A64A6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiLLSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiLLSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:20:04 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84336DE95
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:20:01 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s9so9416020qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onP/KvRHakbT+PgkNr+XHNC9YqsG/EczL6JiFabOL0U=;
        b=JNuH2HF8bPkdPJns9Frb/3hAu3RMH8AcPZSEHf2cYAzl573JYWDHKuLTUN6kTk/bk2
         28tJ7PF1hgzIxkq2dZd60fbM0WqtEb/LZVKdYBwuPk+G9ixslL/tLfsqY4afPuSGZ2uB
         j9r6MScd1LukX820XYEHD2XbCUUdgvxVKO5PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onP/KvRHakbT+PgkNr+XHNC9YqsG/EczL6JiFabOL0U=;
        b=u+iMe2SnBNSm2aKxzS6WsamKZTkb6WkdLu970Tp899VHORWqXa4u5vDT64k7oNfjmT
         uIPdYdjBdkysSp2tI70NrbiGFLkoSsCqaxQvKrUyi1tuyoKOzw1TAByTL5gDeDoA2ah3
         VQzFDnfebkI4uCKjB9IfzQ+82SnrtRc8lcNGa8H+3FHehmixXI2mD8CJKwU9viORUJzj
         pH8ODs4jJa5I2P0NT+bA1zeEfH2u6cvR77h2DFkx/gacppywXlYOS3eEQwI7yutvZ0Jg
         VTVSN+qJf3N/I/GCU4eExXJcq8G7cB86IDRx0yZlD50FJWMOI6o9QRvK1uzZMeVy+QfB
         OYmg==
X-Gm-Message-State: ANoB5pk1FYf+oJOjt6CutZKMjszHgJCgafXJT1u+JO+QjwFLOuPQxFOz
        GQKG10NODK41r7+g0NxsUxmfhljr6ZYxGp8d
X-Google-Smtp-Source: AA0mqf6/AXyS0qzv1xuS6T7yovfd4J5AYy2OlkGqd49ko4M0wiB6di+6nYSuJK9wG50VEsT83dgo3A==
X-Received: by 2002:a05:622a:989:b0:3a8:1315:49b9 with SMTP id bw9-20020a05622a098900b003a8131549b9mr9662083qtb.31.1670869200180;
        Mon, 12 Dec 2022 10:20:00 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id bp19-20020a05622a1b9300b003a81029654csm3423885qtb.31.2022.12.12.10.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:19:59 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id i12so8780317qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:19:59 -0800 (PST)
X-Received: by 2002:a05:6214:390c:b0:4c7:7282:5817 with SMTP id
 nh12-20020a056214390c00b004c772825817mr14226201qvb.94.1670869199034; Mon, 12
 Dec 2022 10:19:59 -0800 (PST)
MIME-Version: 1.0
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com> <07ecf411-70a8-4c15-b3ba-378072c14a02@app.fastmail.com>
In-Reply-To: <07ecf411-70a8-4c15-b3ba-378072c14a02@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 10:19:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6u5hV6+O=C-UYkHZATN1b0kQYmoNaJ-EL8eQVBHQRjA@mail.gmail.com>
Message-ID: <CAHk-=wg6u5hV6+O=C-UYkHZATN1b0kQYmoNaJ-EL8eQVBHQRjA@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] SoC driver updates for 6.2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 9, 2022 at 9:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>                            While this remains
> Arm centric for the most part, the branch now also contains updates to
> risc-v and loongarch specific code in drivers/soc/.

Yeah, I'll continue to call your series "ARM SoC updates" for now,
even if they technically do contain some other architecture updates
too.

Maybe some day the other parts end up being noticeable enough that
I'll follow your lead and just call it "SoC".

              Linus
