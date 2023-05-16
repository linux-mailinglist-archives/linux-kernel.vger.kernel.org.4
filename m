Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC370425C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbjEPAkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjEPAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:40:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4194486
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:39:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so9212611a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684197574; x=1686789574;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anq0Dx/y6CxVEmQw6r0YtSvw2DpI1Jz0AvRNCGxjAb4=;
        b=WSyNAaJoTiySOyqUHAL2TFJcCFF0bl5Jb/d7rhS5/7LFDEIZ+QwDbFi8p1gy8aV37d
         YuoG0B3CFmgbaI2StCVZ50DuXpMYnTVCco553c7CZWf81mMRjpeMJQHUF8wZ3G27Vsom
         e/QthlyzAXwogcdsN5lNnbKiutgRiiOX4ViKldqBRG+gS/vOtVmoHLPZWQJ+UiXpTAR/
         ZYy1zwTAnS08mrp8jtqPCVd2B6Pv/ovGn1AAntBKWNmq43aRv8Zoe/RyNvqqAXarQT5q
         71OG1+XvSE8NxTlmT5qp09v2BZiQJb7wQ1UdHq90XqqNHQwZtS3wa/B9GGJmoxeuxUIh
         D7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684197574; x=1686789574;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anq0Dx/y6CxVEmQw6r0YtSvw2DpI1Jz0AvRNCGxjAb4=;
        b=ZHT5FEuhbProhCqIquKT0vTVYHCbJdUs5PGp9PYRqHka0bkUl3XKPvaGhVshPvYouy
         LzlXjb68KVGQBzPKwJ0H56f+6ooMgYoK8d+nZGMAuHlCL+idQpWiDA1E7yZbTsf8uSvr
         1OIjOV2M4Kb2FbeggeFmoDGqm6HhFmvo4m8PvjqtkEcNHDKsKE5ed15goQeUoiwiykHH
         Ha6jEjJM0I9xuanJEmcFj6JrXvz+g6HwXyxBroipXoT4npMCRf3Bl4v7s+IWY987EcE/
         /VkCFnUEu0aTYoqNnLwy9AIFngLTegHLpbqKD6G8u+FmgDC7mH/sHCO7uruW/CLo/PPA
         J9Kw==
X-Gm-Message-State: AC+VfDwu5EbtJf0lOtrJ/T3xG3t14K1YF1Nze8zS3SMcKjbbN3rdk2um
        sQd7lJWL1PO6e6hV7mOLKn4+muzU1bsN6nTlo8A=
X-Google-Smtp-Source: ACHHUZ5NcTS8/wwjOKQBJzOZQS0mPdkTYYWeK79aGZ375sI2PtGiKnEbk2+oDyJSvUhi3LQACWeYFw==
X-Received: by 2002:a17:90b:3609:b0:247:2437:d5c4 with SMTP id ml9-20020a17090b360900b002472437d5c4mr35808739pjb.13.1684197573978;
        Mon, 15 May 2023 17:39:33 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ob15-20020a17090b390f00b002502161b063sm198088pjb.54.2023.05.15.17.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:39:33 -0700 (PDT)
Message-ID: <52da839c-f23f-3341-961d-a253003bfbb3@bytedance.com>
Date:   Tue, 16 May 2023 08:39:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 02/10] maple_tree: Drop mtree_alloc_{range,rrange}() and
 related functions.
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-3-zhangpeng.00@bytedance.com>
 <ZGJrketUDnGkWw8b@casper.infradead.org>
 <20230515173516.5tmytjvnzvdogfm7@revolver>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        akpm@linux-foundation.org, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230515173516.5tmytjvnzvdogfm7@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 01:35, Liam R. Howlett 写道:
> * Matthew Wilcox <willy@infradead.org> [230515 13:27]:
>> On Mon, May 15, 2023 at 09:17:49PM +0800, Peng Zhang wrote:
>>> Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
>>> mtree_alloc_{range,rrange}() currently have no users and can be easily
>>> implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
>>> mas_fill_gap() are just their internal functions, drop them together.
>>
>> No, I think this is the wrong way to go.
>>
>> Most users should not be using the mas_* API.  These are the advanced
>> APIs.  Most users will want to use mtree_alloc_range().  Just like most
>> users of the XArray use the xa_insert() API rather than open-coding the
>> xa_state and calling the xas_* APIs.
>>
>> Please read Documentation/core-api/xarray.rst and maple_tree.rst for more
>> details on Normal vs Advanced API.  The real problem is that we have so
>> few users today, so you haven't seen that most people don't want to use
>> the advanced APIs.
> 
> 
> Peng, Apologies on the confusion.  Please do as Matthew said.  If you
> have a way to unify the functionality to use the same internal
> functions, then I think that would be a welcome change.
> 
I will implement new mtree_alloc_{range,rrange}() using other internal 
functions.
