Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D467100C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:31:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00CB3ABB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:31:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so49668285lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhRBeoyn3GoghkRjGPZF5wNb7tvJxMQhOaGu8IpZg9k=;
        b=bLDN9+tPrF5x97fl6Yq8tCC80B51eRMH5XqquHxKnzfeQtkjzruvuhoBhuFTYjCbVu
         cwGt2NjdlrFCqRMBrvRkYDTZhC5kxwm1En8046Rd8BFZ0qCAtfVF7OVTj/AHI2qOXcNZ
         xYiKo9L7qvmJbt0PqKfhXuuhg7b/wBRW8RRdj803Sg4W7+7zm4HuHgqVW15zP4Cx7YVe
         YLu40s8XI2Gm6NHFLJ6xf27jfWDA8DVN0NcQovbkghulvzBtO2iUdr6P9blE3mWdPrLX
         CtZSetwwfWZ8dcMp8ZC8A9l9f1JzG9sNs6qJt1ScNt7LomA4oetRAbGg7KyRZ9RMpIAJ
         +EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhRBeoyn3GoghkRjGPZF5wNb7tvJxMQhOaGu8IpZg9k=;
        b=2kBqMG7c24KmsDPIlmPss5aYWA0DHmMpm8kYP6ZtudqzTQVrEAc4W6dwoJz0h6Ojq7
         lx3O91b62l9r0u1cuNDYH/Sjnkn2xBB8sMb8AAnFR5RDPgfyxWDZwnTFLyVDd8dzdY89
         rvxhmVjwSjIwQIXgn+2lb0rA3ovVEdRhmD145qorEzlgpI2rTDvSbDrrjwlVLfSkBcgM
         fnb4ac3ZjjQu85+Gd30w9C7Wp8+iT7oQ47FMABNCz9ZitOAA9JRA6sxy3YLHxoCBDQ2O
         l1cI7DKSJ7MLzvrUudTLBiQO2NMVlBGrHsrZsx3Cv7nJ8mdD5kT9ZsNa8Ooxoz3bsEot
         LpAw==
X-Gm-Message-State: AFqh2krtbu1APEh+iXBLQctzlpAY1BZF4KOfaZqlHPpJmHW/xzygyMzu
        mXEWjLP3vrZgXu+tl4+Yy74SpqfzXHwHbHZvG6ToS59f7HU=
X-Google-Smtp-Source: AMrXdXspiPYI2UfbTR5PS9lOWBsSQ2JQ6sXawA8UtaquT79VyacPUp2kFvXoLy2KtWOgicHyOXMQmkuIRdmXVyVISEg=
X-Received: by 2002:a05:6512:3586:b0:4ca:ba85:6c41 with SMTP id
 m6-20020a056512358600b004caba856c41mr261101lfr.520.1674005479996; Tue, 17 Jan
 2023 17:31:19 -0800 (PST)
MIME-Version: 1.0
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com> <20230117161818.2dba77f3ee9b8709947b58f2@linux-foundation.org>
In-Reply-To: <20230117161818.2dba77f3ee9b8709947b58f2@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 18 Jan 2023 09:30:56 +0800
Message-ID: <CAGWkznEUykN88ucXDEBQNtR-uL=yr6Bh7nfQ1YL_QqBAvF2AQg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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

On Wed, Jan 18, 2023 at 8:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
>
> > Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> > Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> > done by moving kmemleak stuff to mm/Kconfig.debug.
>
> Are we able to identify which commit caused this regression?
Actually, It could be deemed as a defect of 'mm: use stack_depot for
recording kmemleak's backtrace'(56a61617d).
>
> Thanks.
