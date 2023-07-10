Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CA74D40F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGJK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGJK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:59:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E3B1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:58:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66c729f5618so3771431b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688986721; x=1691578721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJG2s9++f1Tq43C8nTe1vusCTWa1w6VOf0Nc/0qr1bc=;
        b=cKdGo6luZE6/wyeOLKWmhZkMm8M9MCBnKpAVfD//7521pQuMoN8btgJJ+2BaO/bv/O
         cqRNM7oi65pYwa+/o+ez1GXe+NAhCw8fcJ0UXxG4WgLx/SQPAg+WAs1sNv8WVsqEV+b5
         8iTYK0WqSYH5BzKkpswldpM3L4JXof6Rh3geezbs3+XCtASvom/EgXO1j0cCh2IcHRgG
         nEt+WyjcR/ceWDcVoUcaoQxGGG6nc29l2CZ/bJcF/O8VOeHP5mQx3Bxl8Nvr7dkgJYMJ
         R+BPnOANyUszDgmSkgSHhtdg6tLNZFX5NqT3RKWZJwbGtuPBhil5McJTWm5cMJbc/9Li
         MYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986721; x=1691578721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJG2s9++f1Tq43C8nTe1vusCTWa1w6VOf0Nc/0qr1bc=;
        b=KMTpAJLEFf7wY4jH0YmRGl7sJpW0boPZd3HfLS9XgjXquKlF6dDgtNNxicObKPT1bd
         DZdncfZbwSQRYfc9lmKOaA8LLPV+yONDRM6xOs6wRW2jGUwUAqqh/dck/Vq3WsKL3e1f
         fwUnlm70zp6YgoMiJi8XCB8xxBov0WhhZCk7WPo5tBqVQHiHbCWDHqr4U30gfxen9wdT
         tWNfmAyOKHttlwKR7PVYhKsil5RyFzeYvparwqO07bQsBEw1K727JpQENVUDOkx+UzNM
         ZKSgYsnkOCMvhmozupCr1jJxuU1JRolEV4SOKN/qdTEU09hrdXuVKEyquTC3fEujGMQ7
         j28w==
X-Gm-Message-State: ABy/qLbukrF9k+fCGsqe6oWtV/m1w+FHAV0f9qGzgnHq3BNBaoaUwOFA
        ertYHL4rXaGwhYvwbyLgdco8Uw==
X-Google-Smtp-Source: APBJJlEuiQjcQvPJVlTos6Efw7mgpBrtolrrjkWuHCzIzouvZZQ6/nfWHceXiNG4c/N7mLStOsdRvA==
X-Received: by 2002:a05:6a20:5483:b0:127:3c6e:fc83 with SMTP id i3-20020a056a20548300b001273c6efc83mr15851991pzk.42.1688986720819;
        Mon, 10 Jul 2023 03:58:40 -0700 (PDT)
Received: from [10.90.35.114] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0067ab572c72fsm6919768pfh.84.2023.07.10.03.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:58:40 -0700 (PDT)
Message-ID: <8bc21e32-fdb0-e1a3-477f-dd660646ccdd@bytedance.com>
Date:   Mon, 10 Jul 2023 18:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: kfence: allocate kfence_metadata at runtime
To:     Alexander Potapenko <glider@google.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
 <CAG_fn=XH8s8JbMKjsyyw_FZhLuoBqAwWU_+hCGyAXwe3wTBCWQ@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CAG_fn=XH8s8JbMKjsyyw_FZhLuoBqAwWU_+hCGyAXwe3wTBCWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/10 18:37, Alexander Potapenko 写道:
> On Mon, Jul 10, 2023 at 5:27 AM 'Peng Zhang' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>
>> kfence_metadata is currently a static array. For the purpose of
>> allocating scalable __kfence_pool, we first change it to runtime
>> allocation of metadata. Since the size of an object of kfence_metadata
>> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
>> without enabling kfence.
>>
>> Below is the numbers obtained in qemu (with default 256 objects).
>> before: Memory: 8134692K/8388080K available (3668K bss)
>> after: Memory: 8136740K/8388080K available (1620K bss)
>> More than expected, it saves 2MB memory.
> 
> Do you have an understanding of where these 2MB come from?
> According to your calculations (which seem valid) the gain should be
> 290K, so either 2MB is irrelevant to your change (then these numbers
> should be omitted), or there's some hidden cost that we do not know
> about.
I don't know why the 2MB memory was saved, but it looks like it has to 
do with the .bss section, maybe removing this array affected the linker?
