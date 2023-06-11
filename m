Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35B72B05D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 07:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFKFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKFUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 01:20:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173E1A5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 22:20:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so120225ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686460833; x=1689052833;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUgicSpgGWXDXBfPFRis9dtwYsixGpNf+YC6HNmf0UM=;
        b=zp2Oc0dlY5xnfv6bHcL51n64cwkz3Dp/BKzlaLKx+ckmAdyGsykX690QU4O4UKet+v
         ySVWLb3kJprRnXh4gZiAA7nrRxqJW6KR1agnDnnE7ZRnICRuJMZG9GWqh10t5uBRBERe
         MaCD9/tf5OSvbvCbWXYkx3j0Agog7yzt1wrHWu5GmaXGZEFqttgQ5l5frAHmnx1qtfPL
         Rj+bGOU/EQT3FelIyDTr0dV5KibQYa1PLagZRayMjr6MVUiGtW4yqieiRz2euq5z2kps
         QdNmJCXYLrsfg3CW1DqtRu9IAbeslGpHGYq6sKIB/2i5HPpyipOovR6RSRS5ty6ohYrb
         PTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686460833; x=1689052833;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUgicSpgGWXDXBfPFRis9dtwYsixGpNf+YC6HNmf0UM=;
        b=HIR2VyCNMkVMON4/LrOtr2QCJayauUQjuVB97x2X8rwR7JNgOhSiJkiCooO336d9Jx
         +x03qMOB/+XfocHxB1/1JihsxbhGwvQzgVPv+rnHkBFKcNT/jRgUgnU/KH3PAzyn6GB5
         Jq8NXHQt6LbdK1H2DFkFKCXnlWiHGSkbIH+u+4qIzqnQd6DYzM7Rk7dvSbNbc0rUr/I4
         8DIspHYijD7NV7yGgyvUBFgi/hRFdUUZpBr7tWYf/ydKJCkgvOFGhgwjciXR22DqZLK2
         JXr1QyStWDNlCcU5mEu+bByFLym01hXckc6w5dD60WLmwyu9lq0QJL6wzZx9jXGgqcaq
         v7FQ==
X-Gm-Message-State: AC+VfDw6Dm42uW8AhljoJz70UnS2nWTpRBmxU3OPwFUwK7cCSpKb+jnk
        kkfJB4MN2h5pclNjygWRxjFbRA==
X-Google-Smtp-Source: ACHHUZ6azeSHec63qwQ9PcaW6U+9iFb+M+rl0PVV/wxXhXwaVN3t097pJqyIFFYrBWYFOwq4CtM3BQ==
X-Received: by 2002:a17:903:32ce:b0:1a8:96c:738 with SMTP id i14-20020a17090332ce00b001a8096c0738mr121658plr.2.1686460832805;
        Sat, 10 Jun 2023 22:20:32 -0700 (PDT)
Received: from [2620:0:1008:15:9d66:9274:d797:9fc7] ([2620:0:1008:15:9d66:9274:d797:9fc7])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b00547a122d3fcsm5305193pgj.71.2023.06.10.22.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 22:20:32 -0700 (PDT)
Date:   Sat, 10 Jun 2023 22:20:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Josh Triplett <josh@joshtriplett.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: hugetlb: Add Kconfig option to set default
 nr_overcommit_hugepages
In-Reply-To: <88fc41edeb5667534cde344c9220fcdfc00047b1.1686359973.git.josh@joshtriplett.org>
Message-ID: <71834e10-098c-7d15-b9d4-36d33a57499c@google.com>
References: <88fc41edeb5667534cde344c9220fcdfc00047b1.1686359973.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023, Josh Triplett wrote:

> The default kernel configuration does not allow any huge page allocation
> until after setting nr_hugepages or nr_overcommit_hugepages to a
> non-zero value; without setting those, mmap attempts with MAP_HUGETLB
> will always fail with -ENOMEM. nr_overcommit_hugepages allows userspace
> to attempt to allocate huge pages at runtime, succeeding if the kernel
> can find or assemble a free huge page.
> 
> Provide a Kconfig option to make nr_overcommit_hugepages default to
> unlimited, which permits userspace to always attempt huge page
> allocation on a best-effort basis. This makes it easier and more
> worthwhile for random applications and libraries to opportunistically
> attempt MAP_HUGETLB allocations without special configuration.
> 
> In particular, current versions of liburing with IORING_SETUP_NO_MMAP
> attempt to allocate the rings in a huge page. This seems likely to lead
> to more applications and libraries attempting to use huge pages.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Why not do this in an initscript?

Or, if absolutely necessary, a kernel command line parameter?

A Kconfig option to set a default value to be ULONG_MAX seems strange if 
you can just write the value to procfs.
