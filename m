Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A864C453
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiLNHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:16:47 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFD233B2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:16:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t2so2460997ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/c2imGywrXMtFxA7big1ynKkwWHj2fMs98/T/6C4pE=;
        b=KZl4nVIgtb+Mf+JF7RIGzeSuGfFTUnAn1pGugolhqXd0hlt4rjbHJjmmsz5cS4bdW/
         pYCkm2f+TEiDbKVVoeOCjK6H+N5TqQT7ZUtJRNcjM7LDfaXxXn0jwVArs2F5eLIDrXQo
         AuW1wwuPC5AdnsM794ICUfAQYSES3udZI13eXfo/E/eWQE+MD05hXD1Lzr6lpW71Ll6j
         pLzXM7qmqEH5/FX9uWmVC6FC7DrDgkBTMCX/3LrbirxDDIZg2XZvPTS6utvVdzuu3x8f
         Jq/dpGj/6bs2CQ/gO1EWEDmQzsR4Imvy31SnktIiacHBIXqFXyevERxOd0tZ3MhJXRRV
         B/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/c2imGywrXMtFxA7big1ynKkwWHj2fMs98/T/6C4pE=;
        b=LFetm7AcPqkH5ciZyAWeC1QEOpL3pqby2Y08ed5gSIO5eoVGRTRPshIyE9NJOZ+cEE
         +Q6U4VvPa8QqhH+U4kCACbuc1bPrJ6kTS2vrNdekQMsIUY+mraoa4vyEITYdZ5JbjqwG
         ZzV4YaJWcV/e5z9qt4wZT1JdKpgQ1PPTp760O7eOdHlQFctJd8p9Dg8qvl63n33/jGK4
         rzb4eLlqW8MsELM48CyKcDmJJ0hgguqwYivguhg9Yej3i/AzYV8UDyjdZDGgW5sYPhzP
         4NTY6UG+Huz6PNATmoemtKC2v0hry7U9b4ZP0flveMOMmbLBBSZELxSJkpLIYZF3cy2+
         27iw==
X-Gm-Message-State: ANoB5pm0psafkp7bD8znQmHjLMJE4doK75v/lZRdC/F0Le7O7BIBsCB6
        mK6/MObaGNsCvtpCILj0Vh0utILcybZyqeWJ98bYc7B3
X-Google-Smtp-Source: AA0mqf4oNSM6h5mjH9kXsmyHt7JPwMmcPl2OvfaKWmEwaL7nnMxpxbr9FSu90DocYjg56JCQTvbz0Wj9pRhQJV6mbc4=
X-Received: by 2002:a17:903:3052:b0:189:651c:f023 with SMTP id
 u18-20020a170903305200b00189651cf023mr63925289pla.78.1671002205320; Tue, 13
 Dec 2022 23:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20221213043936.6345-1-richard.xnu.clark@gmail.com>
In-Reply-To: <20221213043936.6345-1-richard.xnu.clark@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 14 Dec 2022 15:16:33 +0800
Message-ID: <CAJhGHyA--bPT9ya+mFzZ7h4yUfTXFJ5-BFdynGFC61A-4gdLWg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Add a new flag to spot the potential UAF error
To:     Richard Clark <richard.xnu.clark@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 13, 2022 at 12:40 PM Richard Clark
<richard.xnu.clark@gmail.com> wrote:
>
> Currently if the user queues a new work item unintentionally
> into a wq after the destroy_workqueue(wq), the work still can
> be queued and scheduled without any noticeable kernel message
> before the end of a RCU grace period.
>
> As a debug-aid facility, this commit adds a new flag
> __WQ_DESTROYING to spot that issue by triggering a kernel WARN
> message.
>
> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
