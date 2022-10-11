Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B65FAAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKCbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKCbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:31:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A444545
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:31:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z20so11926741plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RiYkkaouCeju2FK9kFYRxZwyL4FwNeYIrqFqqh+8sc=;
        b=mr1k+gWlKAo9bIQwNZpgToG2BhZrpjLTAAlzhQff6okpkL0TUG3ii+mwI/k1m7awkz
         ejbIaL5o1MiVuEwa4xhBF08UlDVABuuDTGiEbLqKAmV7t7yJ74nr4TVfN496TdGH1a4p
         CAeonB7ZoeeuGXq8tR14Auvf9qYfCo5pzw6GQjum9KxjbFJs8hSrP8zuvxZ4/md0k8GN
         0vy22ugu5qUMiT7jHDSKcT6EmWeMryqkQfcDeXCgJDHhv3n/aaHBofXmUFI14zcFBEP/
         /WCPaOXdBPuXyKxl076yqq3Mr/n79xF3sj7UpKg/8g9TgyUJcbzIwpjpy1Wh76qMFP2A
         EUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RiYkkaouCeju2FK9kFYRxZwyL4FwNeYIrqFqqh+8sc=;
        b=LJoYC5wWdkHU2hrSvwOPAOiQz2GRZ1KCsAgcaPhTEIEL2na2LD4AQyZfLAE4/7rfQh
         70rExAqHhwsRxknqjlqGZfINOwe906ITil4+OmEJmgMlAijUg/nSUrxvz8hUoX+MpErA
         00R7lfoOiuWzFzw3dj0FX6rb82+ZP9xryU9L9SOt5G4mdTOSks/1AlQGDMGjecCGl5zU
         ZmyEtTJjpUjeqT3dKY7+JgXyvGv4wdf9WkxEGP2nVimddhiCQf4LCHpHzP0F/d+bnfQ8
         IeQxRE8/v01kJNCfB5RTX8nQw7OUU8qWndzqPn1nPfe5PftdCsRkZIqdKxyjzdppTRPP
         pJ+A==
X-Gm-Message-State: ACrzQf3+qJCWIvJo1uTsSmPX+cRWupuFm8P4gykn1koeJmgt/DcxyEn+
        vN9mYMQxrMyaFg3/2J+lw6U=
X-Google-Smtp-Source: AMsMyM4yADhpfCygecGf0o3F0Rw6HAS3QBM5Dzy6J5SvS3nnfN5iYTSMDY2ObyFxDUv0RapjAUfoQQ==
X-Received: by 2002:a17:902:d70a:b0:178:5d52:9e41 with SMTP id w10-20020a170902d70a00b001785d529e41mr22226129ply.0.1665455475790;
        Mon, 10 Oct 2022 19:31:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b0043954df3162sm7073872pgn.10.2022.10.10.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:31:14 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     imbrenda@linux.ibm.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Tue, 11 Oct 2022 02:31:09 +0000
Message-Id: <20221011023109.322501-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010154248.1ee86294@p-imbrenda>
References: <20221010154248.1ee86294@p-imbrenda>
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

>
>> Hello, Thanks for your reply.
>> 
>> >
>> >why are you trying so hard to fix something that is not broken?  
>> 
>> Actually, it breaks the definition of unmerge, though it's usually not a big
>> problem.
>> >
>> >can't you just avoid using use_zero_pages?  
>> 
>> use_zero_pages is good, not just because of cache colouring as described in doc,
>> but also because use_zero_pages can accelerate merging empty pages when there
>> are plenty of empty pages (full of zeros) as the time of page-by-page comparision
>> (unstable_tree_search_insert) is saved.
>
>interesting, this is some useful information that you could have written
>in the cover letter and/or commit messages, to explain why you are
>proposing these changes :)

Yes. I have done it in v3. 
Thanks.  
>
>> 
>> >
>> >why is it so important to know how many zero pages have been merged?
>> >and why do you want to unmerge them?  
>> 
>> Zero pages may be the most common merged pages in actual environment(not only VM but
>
>also interesting information, which you could also have written in the
>cover letter and/or commit messages
>
>> also including other application like containers). Sometimes customers (app developers)
>> are very interested in how many non-zero-pages are actually merged in their apps.
>> 
>> >
>> >the important thing is that the sysadmin knows how much memory would be
>> >needed to do the unmerge, and that information is already there.
>> >  
>> 
>> I think it's about chicken-and-egg problem.
>> 
>> 
>> Anyway, thanks for your reply.
>> 
