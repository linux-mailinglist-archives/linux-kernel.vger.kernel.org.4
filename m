Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE8669B69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAMPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAMPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:06:04 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923304087C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:58:05 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i188so22435638vsi.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJFnJAjSryrsGgZ4bIAcXrY8zxvzQv8QRwubWN7VyfM=;
        b=HXxMYdw91/PPKvHdKyeFs483SByGpSDIJQNLBUVcbvaRARuhkWyTUKvtxhVNkt9K+A
         DRwFfi4a+eTjONYBABiQGfcfBLkQg1DO3xN1CmwLToFtVfyPUpB+NdC0mUdoO+pYyaQw
         EHTLxmhNhddn6CeFuQ+2T7xRyJ0qsZgdgLmqHKLOYfBjUiItVycsaladU56nvyZopwaQ
         0ZAGN/R7zu2XlVIzTRg4NZ/RHPbJT4nkWW6zohJI72uv1D0+wP+8lHHbiSC/aGzu2VSh
         KUeIPjr4W6vc7l8Bvo/Cwc28bF7EN7hZpxdp47dJVBJu6Lt7pg6KtUUSZB3/ydNK71kF
         pcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJFnJAjSryrsGgZ4bIAcXrY8zxvzQv8QRwubWN7VyfM=;
        b=y61Ha6PxPkl2AW3LmL7sepibODbIqBS+J7JoMfdpZu6fJBZRERxBE2kI0i2ha51Tya
         m3G4dnsorUf7T3WKC6hISd6XOk7QUOZRQS6iGPOQ7k2ZmPTcCbwWc8QSvKs5nkq1b771
         70AIJ1fzGlAU2wUsJk26zY+HZZcwrNBJ1Rywm7na3Szfjakf40oZebN4Sli/A132MNmF
         O6alZHWfmymtUknSbcZVp7FSopB/h8Z7/GIE3kvqXQlOlndPvWVRh1ojMvbp1vOFf9Qv
         ilSBGcRfnYNi2Q0x0/Du325+7ylyDQi66D9MZfBNVpbQoPvhLp9GFn8cvXMEXf6BB3PY
         orsA==
X-Gm-Message-State: AFqh2kp6g+26IC0vq1H8NHzfyeupVzLv2tfYcWEtPAE4DvqajnDr2lGw
        qWDNzenHewvsv91X22S3Kdjy0sNGIXvcrHKDHebLNA==
X-Google-Smtp-Source: AMrXdXsrYcvBKd8kReohy6kxecZZofb4MQ6F08XRIamuUCo6MPIsF4AYF31zTs0EGcVk85aiICba24ccE85QX0o1aJw=
X-Received: by 2002:a05:6102:11f8:b0:3ce:9523:2bdc with SMTP id
 e24-20020a05610211f800b003ce95232bdcmr7769907vsg.14.1673621884609; Fri, 13
 Jan 2023 06:58:04 -0800 (PST)
MIME-Version: 1.0
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
In-Reply-To: <Y8Fq5m0CLfcFLCOY@zn.tnic>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 Jan 2023 15:57:28 +0100
Message-ID: <CAG_fn=WE4_DVyxjjq6YW-_bZm6JXE3smy_qw9VTZh9wgV+Gj4g@mail.gmail.com>
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 3:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> Lemme CC the stackdepot.c commit signers re the below splat.
>
> Lemme know if you need more info.

The kernel commit and config would help.
Is this somehow related to SLUB_TINY? Perhaps stack depot is just
trying to allocate way more memory than allowed?
(I see that Memory: below shows a lot of free pages, but am not sure
how it works with SLUB_TINY).

> Thx.
>
> ...
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] Memory: 15612528K/16165300K available (12288K kernel code, 116072K rwdata, 5024K rodata, 2412K init, 3822
