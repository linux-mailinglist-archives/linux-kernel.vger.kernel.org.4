Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7339E6FD767
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjEJGuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjEJGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:50:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82474230
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:50:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso4950739a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683701444; x=1686293444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBNyDzGV0+bpbqmbM9UHLvmCT8xuKA/I/1Ao4NjaKaA=;
        b=kQeLMV24qaSJpFhT994mhDIr8gPLs+LXzTQVn7pnmp2SyQ3ctY+mLs6z0/sGrh2hpb
         2IfOvDayuHBUa55qlpx8n14pan1ddvYo6pwBdCHNoxkjn7u0kE4qfydq4KnUKW6cgW20
         HMtoIsTpxX5Kja+oOYIDJLhFdnbKA/dB/c5YMWmdwq/rkrWxovEkkvKRxvseokONRNn9
         y/9jtDHQX33gSF1sB1qhjMnv/lnvXEv/6IQkZtTckp4wMC7wuTDuIrrMzDv+/8BOG0i4
         umue7sp25zLzM6GGUVWPHbPFDrFcZ4GDht7DLuVLMN87JIxU8zyHdm8f+i0Kx04/Ud1H
         O0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701444; x=1686293444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aBNyDzGV0+bpbqmbM9UHLvmCT8xuKA/I/1Ao4NjaKaA=;
        b=FKA5smHrVIxtwujamF4/sHyo5/glYL66Qo6uv+cJiGhSd46lRfssp5Zqw4EDzUkpXA
         CsAQ9shvX6uyiPQ6AI2PEx2ITlYuwhU51+XeayrkgJJYkZ4l/c3F++BEesDcIfqlbkFM
         mMCDVa82lvJYs4BgXBe2FeeNKZtTSYjiZid7zFumVE86Ha/bXmf97i+1+dgad1fU8/Ym
         j2u/SO5bQrYRpPpWWM/xiGLqSuH0RqBadU4mBlCNc2GhQQdleyTLgStir+ePed2E+yME
         dt1CbWJaLK2luU/rav0Md9pRufGKwDZqg8QYiNyfTWvs5wY5Gu2LproZgIipWSJIgRHy
         qpDQ==
X-Gm-Message-State: AC+VfDwX7zW/D+Un7PDvYYU/pCE9PWjYX38r975IWoBXqH19Km3m4U+a
        jOKNmmc65lWpajg/6BcBqAmWAPJBF0KYf1LqjeY=
X-Google-Smtp-Source: ACHHUZ7KrmVEev/dRYM18ZPSJCtntINwAhVP2JSzoMcOHxfu8aWlhH9iOCGMymH6JfTeF939/JSPkw==
X-Received: by 2002:a17:90b:198b:b0:24b:8480:39d6 with SMTP id mv11-20020a17090b198b00b0024b848039d6mr16355701pjb.0.1683701444230;
        Tue, 09 May 2023 23:50:44 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090aec0800b0024e4efbb843sm2230903pjy.22.2023.05.09.23.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 23:50:43 -0700 (PDT)
Message-ID: <dd5f9565-50fc-b017-77a4-3fefd64e4a7e@bytedance.com>
Date:   Wed, 10 May 2023 14:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] maple_tree: Drop mtree_alloc_{range,rrange}() and
 related functions.
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230510061049.53977-1-zhangpeng.00@bytedance.com>
 <20230510061049.53977-2-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230510061049.53977-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/10 14:10, Peng Zhang 写道:
> Drop mtree_alloc_{range,rrange}(), mas_alloc() and mas_fill_gap().
> mtree_alloc_{range,rrange}() currently have no users and can be easily
> implemented with mas_empty_area{_rev}(). mas_alloc() and mas_fill_gap()
> are just their internal functions, drop them together.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Sorry for missing mas_rev_alloc(), change the commit message to the
following:

Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
mtree_alloc_{range,rrange}() currently have no users and can be easily
implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
mas_fill_gap() are just their internal functions, drop them together.
