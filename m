Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6932C62D1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKQDp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiKQDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:45:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC162D1CF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:45:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x102so843654ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BpPHy8dIR7jqC5rl0a6Tr8UGHuG0L95Xmvj3K3gkXo=;
        b=EE+QSXJEBqMDGtVkHlILhdYgt/UK/oYBT69ZSCMuvaToqEF8VFPjmrGPILWM+yaXMu
         NNFJidNHnfzJmC6hfyib5TY2eXbqP67ByeWKamcFhGC7zlYLZdJg/jyZ+uGQ+7dYFUG2
         CwLH1mWHf3E9QENJgOEO/1kXZBC1nIf7vBk0xCSMXqNMhaw2nZpQ9AnaGyq4LW8Gj6R0
         Fv/XD0LWsoMOENJvWX3/u2Un+fSpKmLxDowexCxFFqhaaZuK4q+3l4wskBjt1v7ZMoVS
         nCcf1EuVae6se0LwzZaBEvefaAgiJDmeWXw6Gxe5FbVj8iNbzX9vpbqQxkBLtqVKuLVT
         NzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0BpPHy8dIR7jqC5rl0a6Tr8UGHuG0L95Xmvj3K3gkXo=;
        b=djTcOA0Dto3XB9rpqyQ12vjJOKe0sceGIVDcaHm+qyE7aN//FGGzfXC4CLm3rg+AXR
         YrwUg00Q2OcZXWm4EgLeN+0fd/VRoJsG71yjXuS+aDbgq9cckKNlJi+O01fAJVLabqcS
         cfClV1bpWqpSuebLtAjt1qktzZ9qkEkZKpIVxPIhFYQHyB/xdUEMFQNKHe/nyWc2y30d
         llfavChnH5Zst7dLPCTuiWnm558afhRe902Grk5gzr/C/8OJ+8BeTpIxN0Il3yLZrI+J
         TYOEsHWHuOpgahOMs6XmNcStHey1scG3pf623VJ5qXHgfB8UKU7HPGFvmUi3IvgEvpA/
         DM6w==
X-Gm-Message-State: ANoB5pkT3eY0fR5zxbcaCzGDpi1P+gPXP302M0kX613HXKiXOLSdR1Ml
        QctZf835qsuqAd806Z67QB980GsVfbxuTg==
X-Google-Smtp-Source: AA0mqf7OdTW6qYKwHcDr178+TMVd6R20KJSkUnR/LbApiENBVa4qp0GmsnjGZD7wa1szz2zABI5pDg==
X-Received: by 2002:a05:6402:1f89:b0:458:caec:8f1e with SMTP id c9-20020a0564021f8900b00458caec8f1emr556391edc.280.1668656753937;
        Wed, 16 Nov 2022 19:45:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id be22-20020a0564021a3600b00461a6997c5dsm8256487edb.83.2022.11.16.19.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Nov 2022 19:45:53 -0800 (PST)
Date:   Thu, 17 Nov 2022 03:45:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT
 since it is not a root
Message-ID: <20221117034552.he33qqvubfenq5co@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20221113005618.29679-1-richard.weiyang@gmail.com>
 <20221115142914.x6d2q3qz4xurikrq@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115142914.x6d2q3qz4xurikrq@revolver>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:31:15PM +0000, Liam Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [221112 19:56]:
>> Root node is return at the beginning, so we are sure bit 0 is not set.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> ---
>>  lib/maple_tree.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 9aad98c24f3e..f8c4755e7c75 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -436,7 +436,7 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
>>  		return 0; /* Validated in the caller. */
>>  
>>  	p_type &= MAPLE_NODE_MASK;
>> -	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
>> +	p_type = p_type & ~mte_parent_slot_mask(p_type);
>
>I think there is a larger cleanup that can be done here.  It looks like
>mte_parent_enum() is called from one location and that location is a
>wrapper.
>
>The check for the root bit should also probably trigger a WARN_ON() and
>still return 0.  I don't think the callers are doing enough to validate
>it - although they should never reach this function with a root node.
>And, in fact, I am not doing enough in the test code since I didn't
>guard this correctly in the verification of the parent slot before
>calling this function.
>
>Thanks for pointing this out.  I will send out a patch to clean this up
>shortly.
>

Yep, look forward your cleanup.

While I have a question here. We get 4 types in maple_type, here we just
return two of them. This means the other two is not possible to be parent
node, right?

>>  
>>  	switch (p_type) {
>>  	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
>> -- 
>> 2.33.1
>> 

-- 
Wei Yang
Help you, Help me
