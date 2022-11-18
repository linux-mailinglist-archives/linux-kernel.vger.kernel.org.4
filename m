Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B562FFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKRWIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKRWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:08:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE20AD460
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:08:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w23so5702447ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKSjP9jIbGdZ8wbLlDbYShn3Lx3bNa4PD6IpDt+85XI=;
        b=jCHkY5be8ot6u32cjkAArYEdMbMdd/w6wP+nB4cDhKX2kolNOXxHlMgpNPhKHBZDun
         5iqAKa+xnzabXzyeEke9B6y/WqR9HZBzUOXDa+8z7VzbYb0ltRHjQ0nxGlRhhx+MagRo
         mnuJh20aB1V+bUj8jD0C4PPW8HbUzVKVlYkBoPqbn+bNkuPukYdTDZzBE6z6z7BrBsqt
         ve28ZH+WoPXL5Ou7XhswiBPFvUm+Y2vVcK7RoZQ+8eYcGn8GGmY5HZqiNF/d4N9rH6JW
         PpN9IQfDsmfx1mBDX3YomsLVWwd+Utvt4FKR4YXUglrsFZZ+wVieaj9l84mIlDUkSFUI
         Mvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKSjP9jIbGdZ8wbLlDbYShn3Lx3bNa4PD6IpDt+85XI=;
        b=LDwAkfV8We0tIOclGZpZ1wNJFkLCbN/G+iivF2s553Laf8QhoGfUmH92m9iYs2bWZj
         4WmaSs9h3JvxXMGICIcpIdmfXkoMNcjYyyQ2tFunbV6VMgZMptCa/t57dD2/Ttq3ElAh
         UNii3hY2RVxmm5eO7hFbpvk9LIC7hCkjqK9uEYCcm42Z7kBJmVBLZCTjFu9BA5UyY4Gu
         MIEHsH9shag7nUJsB0c6Ct1QOX2Vs2aBrH2Rnbstr46rDzSE3xb08GOdTx60vGGumR+w
         27QfcAPsLy2Bd+8ko/rJSG3rW9simz1JT/yfq/pKgJIPOZK8S32/Y5+ERb+y0RssT8U1
         RWJg==
X-Gm-Message-State: ANoB5pm1vg+xT83G+DNaPNUtPNdLyqTwbIWBt/GEBDpmAKQv8ksD7Asj
        urR3DX5yKkYlLA8d2RE+JYE=
X-Google-Smtp-Source: AA0mqf4oyTiXZv8g23McsjX9c4sNZxa1YSzTsl3yHDCHEpXc7lx6IEJWHWyf2U0zaUht3NSGqrNyeg==
X-Received: by 2002:a17:902:e849:b0:17a:aca0:e295 with SMTP id t9-20020a170902e84900b0017aaca0e295mr1553420plg.3.1668809289374;
        Fri, 18 Nov 2022 14:08:09 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b0017305e99f00sm4336459plg.107.2022.11.18.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:08:08 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     minchan@kernel.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 6/6] zsmalloc: Implement writeback mechanism for zsmalloc 
Date:   Fri, 18 Nov 2022 14:08:08 -0800
Message-Id: <20221118220808.1194168-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y3fyon7v00ABtU6M@google.com>
References: <Y3fyon7v00ABtU6M@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the suggestions so far and for the review, Minchan!
Quick question about your last comment:

>> +#ifdef CONFIG_ZPOOL
>
> Let's remove the ifdef machinery here.
>
>> +     /* Free all deferred handles from zs_free */
>> +     free_handles(pool, zspage);
>> +#endif

free_handles() here is for the deferred handle freeing, which is also
under CONFIG_ZPOOL now, so I don't think we should remove the #ifdef
CONFIG_ZPOOL here, no? Let me know if I'm misunderstanding your
suggestion, or if you have any further comments regarding this patch.
