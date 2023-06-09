Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C072A20C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjFISVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFISVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:21:43 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F03583
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:21:42 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b04706c974so10221845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334902; x=1688926902;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/+y/6j1ALrc42P2Rr76MxD2YIeDBXVc8CafCJ2zOkc=;
        b=InN6Ka317rvAPkeYXkkMbSyLbayiidlxJzSyIeCiAKliZro/ns1Ap5X3e2nP4c9hgo
         PpQDZXjqTd5iB+WOq2/LcMkcpjruaFrbK9iGlDefdHQZiMpDLbUoDZhCi8O4YrppGkFQ
         x+29IKIY51PDCWtsjioL091BUMAs8qqKNGZNy7lDbbejKV+lwGKMuaCHdmDzouRHZ1+u
         HKQEN4oMUE0d2r9sjsGlY/wCK6+pjgJyZAMIyZkrvj5/8FIj86NaP5PWFJprk9GRMdHM
         iJLNdTIuu88xTlbr0fovBI7KfvNviebtcBDiF4IGV/Zn8YaYNWlPNKWd3i7U6pSK6hyy
         EpMw==
X-Gm-Message-State: AC+VfDyJ5aiuJJV2t01t14oX0YKgN3l30DfwGxXZMFkGX+wItzsvFigt
        HiGZC0cGf7rQJbauoI8VDt3bRg==
X-Google-Smtp-Source: ACHHUZ7RUR0qSoKvtN+A82er22MA4OCK6oYpo9NtISCC+Mhu6QhbhjQYpCYoqPSqN3+u4aYXTdNl+w==
X-Received: by 2002:a17:902:bc85:b0:1b0:772f:e3e3 with SMTP id bb5-20020a170902bc8500b001b0772fe3e3mr2039741plb.52.1686334902093;
        Fri, 09 Jun 2023 11:21:42 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b00199193e5ea1sm3591234plh.61.2023.06.09.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:21:40 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
In-Reply-To: <7hsfbjxcqs.fsf@baylibre.com>
References: <20230511133226.913600-1-msp@baylibre.com>
 <20230523114618.laajn2et5nbcxszv@blmsp> <7hsfbjxcqs.fsf@baylibre.com>
Date:   Fri, 09 Jun 2023 11:21:30 -0700
Message-ID: <7ha5x8xzrp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@kernel.org> writes:

> Markus Schneider-Pargmann <msp@baylibre.com> writes:
>
>> just wanted to ask if I need to do something specific for it to go into
>> a rc? Sorry if I missed doing something for that, I haven't had to fix
>> something in an rc that often before.
>
> I think the  Fixes tag is enough to indicate that.
>
> Steven, is there still time for this fix be queued up for v6.4-rc?

Steven: gentle reminder ping.
