Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99056E8842
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjDTCrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDTCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:47:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930B4C05
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:47:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a686260adcso7196605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681958822; x=1684550822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONGcsQhQe5EvPEMRGVWXOw89umdmRiF62BqlC5adKeI=;
        b=doyqjWx+2bTIsT9FbRCU0F581ywpOcsJmoTejK2QuOP6Owg0kPKux89cd2wp/LQVF0
         3mTPmTC6/peMzHNY+2spKZjC46AXrjhckyWYLQgCfesJBcvteL/dmg/GcKibc2/zmD+e
         xbScjemnl1cw7HSGj+7F1N7EqZQBKBU9EZQF74Y2APqGsKgIa3AN2ZhrNfygbkr30S7d
         G14hinuZt7Vtd7kdQ0NmWI0ZCSSSJesV0BrpVHsVSP1Fg+48oFyFAW1gwwwATuZHBT48
         Af97GHaGEmaW9tzwwDa6wQS63i1n3sl5YdiQU+YhC1/25FrY6O0CiZmfy8hwJIOLTZuV
         zKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681958822; x=1684550822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONGcsQhQe5EvPEMRGVWXOw89umdmRiF62BqlC5adKeI=;
        b=WaTlUaaQwCiCgaCvGJXGHTnCHxSmN9MS7ECFMvFlh4r2YUGK8W7zXjdQHbcV4DHwDX
         3nO/d2VdylxelnIprHdby72LvFC+/sHRBJniUfUmf74PDzHtGa7VmpuVkglM2tGfOH0s
         xEZiFYkk9MP4DnyKX+A/lrSlnEr9mz1+dVbItvHDrGozxWUfqnhVJFOLk2rkSCiUPYVI
         p4+fxrGvnMzsK2U+cu3F8tJSVZ4a7DJzEuwy+84rMpaI9qULdU0tXEi46eIp7gPP+MDV
         mR+jsEmYIrUewXqhIu6Y77zp0qLNV4jGueB9ggml9W+vvRRgQtppf/n+2RMlF9t9dAf3
         rqpA==
X-Gm-Message-State: AAQBX9cHxP0jxl7bnqyiSci/4pL/Y8uy5eoZC3R/aKxzkThzSNW8JNwe
        lpS0mEB2Od1+60ib7mr7Z8yNyA==
X-Google-Smtp-Source: AKy350bDwyoIChbds7xq1ecwfOCztzTynvx7cLW+ChaUaqWIqLPh7uhf6YD22ulu7zYqyDP6h2ZDOA==
X-Received: by 2002:a17:903:18f:b0:19a:b427:230a with SMTP id z15-20020a170903018f00b0019ab427230amr8253487plg.63.1681958822010;
        Wed, 19 Apr 2023 19:47:02 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001a681d123a0sm114401pls.297.2023.04.19.19.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 19:47:01 -0700 (PDT)
Message-ID: <6a24bc86-0c19-b8c9-2e27-86282ee07171@bytedance.com>
Date:   Thu, 20 Apr 2023 10:46:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] maple_tree: Fix allocation in mas_sparse_area()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230419093625.99201-1-zhangpeng.00@bytedance.com>
 <20230419124902.7cb9b5c54afa37736e7b0e3a@linux-foundation.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230419124902.7cb9b5c54afa37736e7b0e3a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/20 03:49, Andrew Morton 写道:
> On Wed, 19 Apr 2023 17:36:25 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:
>
>> In the case of reverse allocation, mas->index and mas->last do not point
>> to the correct allocation range, which will cause users to get incorrect
>> allocation results, so fix it. If the user does not use it in a specific
>> way, this bug will not be triggered.
> Please describe the user-visible effects of the bug.  I assume "none",
> because there are presently no callers which can trigger it?
>
>> Also re-checks whether the size is still satisfied after the lower bound
>> was increased, which is a corner case and is incorrect in previous versions.
> Again, what are the user-visible effects of the bug?
>
>
This is indeed a bug, but only VMA uses it now, the way VMA is used
now will not trigger it. There is a possibility that a user will
trigger it in the future. As a general-purpose data structure library,
Maple tree is treated as an opaque box by its users. I think that
as long as users use the API provided by Maple tree correctly,
there should be no errors in maple tree. Just like other data structure
libraries (such as rbtree). So I fixed it. It's easy to write test
cases to trigger this bug, but I haven't written test code yet.

Sorry I didn't describe it in detail. In the future I will describe
user-visible effects in detail.

Thanks.

