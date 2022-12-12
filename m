Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34464A85A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiLLUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiLLUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:02:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26D1758D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:01:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x66so688468pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWlj9/EbHKVaKHZT5V8RMD2Y86vzmO3TVzOVHSD1M3g=;
        b=jC4zI2wmQYF6SKM9oT//lZJLdRTQYjwx8uCoxzRyclkJ08YpgGRQqGt+g0r1VI9eGQ
         Q/YYQgPtda17JQPyBmbYAzBtsNJPr/mm/uLgZNBu7DNZEYoVJ5qqom5yTuIJBer4N/jO
         G/r3HPR5U76F7b+ejorRyVVMsbpBPxxJk2ZefqIyRL7HfzKrBq23coLKH/n3+/AE1ikD
         q5vkAy8B6PiyCYul4gEukrofImv1TZXMsljSMLi+jyD2uOr5iB6JdAU4GtoXaRWmuGXE
         6rXXnX+V8LCLhAxUBrQ4W/Ld1el1Etuxu4hqAtUdie80zKX9mzNY0PZhSFK0LAlvyRXN
         iU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWlj9/EbHKVaKHZT5V8RMD2Y86vzmO3TVzOVHSD1M3g=;
        b=PLnivHveiBB6/HNwyLLoxfoXS9Bgn7zLjd2R21J5gYpNxhrJBkP+Ie1DchqGLNL0e6
         LQaJyRcPZuYCSS89/d9Kg7PQsSK2oMhbh+Lk+h/Q4c8Fcwlv8D+tk0/Hv7ODpcbrVM4z
         hnVxk1YrH9ZT25t1jcwiVR4EmB1fiLmq0yJ6xvELvsd416aTgJr8pZIFU4Ef2Auxq1EQ
         JxNL8P+8VDSXxbxO1RZIoxSQFshftdRMl5zyTaJZQQqf+rDwWZxNqnR+T7lst1iff6dw
         V2SS76gBrQZlDDLd5eei5JZ3BSMUn+jDf8V+iDYt4K/Su5v20r+lOxZhhD/xikvbxehg
         CmkQ==
X-Gm-Message-State: ANoB5pncVbKrr5Bk33g6ZB750+hCk7oOzST8Rc2CcyNEKv6ap+Q34/vA
        2M9aPlMc1L8o9n8XpUaZaTM=
X-Google-Smtp-Source: AA0mqf4udGxAJH7IBnh0k5H97MR10twh5aJZ8Ece0XD+YX8GD1Dob56pIzeKFyokjWbIFt8Cwark8w==
X-Received: by 2002:a05:6a00:1c9f:b0:578:144f:ad59 with SMTP id y31-20020a056a001c9f00b00578144fad59mr11968029pfw.9.1670875315851;
        Mon, 12 Dec 2022 12:01:55 -0800 (PST)
Received: from fedora ([2601:644:8002:1c20::2c6b])
        by smtp.gmail.com with ESMTPSA id q18-20020aa79832000000b00576984617b1sm6215689pfl.60.2022.12.12.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:01:55 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:01:53 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: Convert mark_page_lazyfree() to
 folio_mark_lazyfree()
Message-ID: <Y5eIsdb+TU6HL9eZ@fedora>
References: <20221207023431.151008-2-wangkefeng.wang@huawei.com>
 <20221209020618.190306-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209020618.190306-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 10:06:18AM +0800, Kefeng Wang wrote:
> mark_page_lazyfree() and the callers are converted to use folio,
> this rename and make it to take in a folio argument instead of
> calling page_folio().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

 
