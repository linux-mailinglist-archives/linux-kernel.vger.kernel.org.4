Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12975035F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGLJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjGLJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:38:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A41BC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:37:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e97fcc60so4630040b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689154586; x=1691746586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFHWPlgRbtTouEuL3TeQmFRHeduzwEODVigacZ0+gS4=;
        b=GKmJfOeIEIc4sMsB8+wLlH24vpi8x6P62iWehaiD+04F0wGl9swftnf0ErbHjBYB1O
         QPqgPZz/QO6SyeDyOtGCplwMCc/OIFStZ0+1Dbr6J2NfRs4pVFxqFVrgQfJ+6435HrvO
         7aG6xL3f8UGifyTxQS63ngWA/mLx7U62bBayYCx0/o2fKONSPdv5oO28W2b/+6/B3jGa
         adn5f2G9OIAS/a5JeZPBTAqGewr7/ddrcFjj0/kmWCWGSt7GXKkWntTXB66dWfACyizb
         DfjLrqrAndSuxHMrrJJghgwervtRkyhSybXTFqA+wKtq9S1OT+S4lPvClWjyhEqLwvSp
         oAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154586; x=1691746586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BFHWPlgRbtTouEuL3TeQmFRHeduzwEODVigacZ0+gS4=;
        b=kK+ITf/zIb1WhrdAAM/eR5CMJuUs4FwcK51s5NiAvjcsGpXETQDTmZv0JdAO5N0d4Q
         YOH8gG5eZ+DC/qDPQ3LyZoDPyVAHch6XbYBaJi/3IQH91YrWa9SAczvDgeS0ZnTO8+t8
         zxWgY2AIjuv/1f8/nLUnQGe6Htu9IaIV1HNy9vCxFMRE/sKYQMLZj4wl9A6ZE5qkz77w
         /tH5pPhfGNyybS0wk/rXvXSPEB6q69sct6c5Yg1vhOcwK59o+Ft/j4R3OUnjvq8StaPX
         O8Va2L+bO0eN2sCLEiqjoyBuk640d0HE1Hepqqiuh7f9m6CPUCbahiW73+egJ4wmFMbg
         Nzbw==
X-Gm-Message-State: ABy/qLaRl59CUvEC4QuYJaNcA1ovSBQNRM56JJGnairXULctar91ibDe
        0QPyh/IPIn0JU+DP4Yhl2zUGFQ==
X-Google-Smtp-Source: APBJJlFuDsMtEgwyPNUmKNdUKUx+QSC4zv7Q3PcSmEwSKnrV0j36T7YCZ724fOrdm4zLOy1Kpn32tQ==
X-Received: by 2002:a05:6a20:418:b0:112:cf5:d5fb with SMTP id a24-20020a056a20041800b001120cf5d5fbmr11212751pza.50.1689154585901;
        Wed, 12 Jul 2023 02:36:25 -0700 (PDT)
Received: from [10.254.22.102] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id p1-20020a639501000000b0054fe07d2f3dsm2973750pgd.11.2023.07.12.02.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:36:25 -0700 (PDT)
Message-ID: <e38e8525-3e9c-8925-2160-228875183f28@bytedance.com>
Date:   Wed, 12 Jul 2023 17:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm: kfence: allocate kfence_metadata at runtime
To:     Alexander Potapenko <glider@google.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
 <CAG_fn=Vj+rqkz0_3kvBoBVoxET10KV-zoD=YtJmCfsA8YEMemg@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CAG_fn=Vj+rqkz0_3kvBoBVoxET10KV-zoD=YtJmCfsA8YEMemg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/12 17:30, Alexander Potapenko 写道:
>> Below is the numbers obtained in qemu (with default 256 objects).
>> before: Memory: 8134692K/8388080K available (3668K bss)
>> after: Memory: 8136740K/8388080K available (1620K bss)
>> More than expected, it saves 2MB memory. It can be seen that the size
>> of the .bss section has changed, possibly because it affects the linker.
> 
> The size of .bss should only change by ~288K. Perhaps it has crossed
> the alignment boundary for .bss, but this effect cannot be guaranteed
> and does not depend exclusively on this patch.
> I suggest that you omit these lines from the patch description, as
> they may confuse the readers.
Ok, I'll revise it to avoid confusion.
