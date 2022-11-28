Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4C63B23C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiK1T2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiK1T2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:28:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4126482
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:28:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c15so7422147qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4K7CdrO1bVG1lma0UHiRT4m0Q8nKmohqqgtpJrE588=;
        b=j4I86y6wdhKn8Hv3cB1Ggw3Y3oZkLus35E2C4t/nVedgQZYs6BmhQQjn5ZvqNwDkR4
         DhN0G81WwvwckgmQ3WuYV88zFUTjiqMfRcvdytnxZ5SIzQqYSxhRRVnhi4yq+ovF2n9O
         knl1EFAaO34BZsV7+cclB5D61z2P7xJ/BQBAVpy8d3NusKOmXtgzLVZIOt1/Hlbiygm9
         IgVuVmTZMCkCi5nyG0vW5l38IUObFiWMsTGER4xwi04jJTi6v9UsFYgc5JgQQAzaEQ5J
         xaG4uM+JKZthiyA/OAxJbv1Z0qAQiC7/vc542rVWOjn3zoKQWCgjVFLfeCbXvUHT09nQ
         UEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4K7CdrO1bVG1lma0UHiRT4m0Q8nKmohqqgtpJrE588=;
        b=rIWRQfvipibfrD8I2UHZHTp8r5Gx+gs3bviVqqgBs2o1ZzLV26BFb7FA5z0di5J1qU
         xPnYBGka8F+Xkeh59Lff+wYlorZniZEHiSog7dmVk09QI8qH7ODoCM5FmaXv38Iv+Iip
         CnYVXTMzpg9aajgIrOYPhCSOvxeM2ttjJLY8dW8DpwaLD2WrERy4OL9zhJgIJicdfBEM
         NeS5BeNIfu8Nn6b+PShL6ADhzIFIG0sjLGAN5/ZXZSN5sRvt/aEu6en1tareOOzPt8/8
         2i2624+eYbVyZGVpp53rLuF8oYsh/l6CLjM+nEjf8r7yeBEEoo30OYEkmZhJG3PBMV5s
         afEA==
X-Gm-Message-State: ANoB5pn2MGfipZPgFRfc82HoMJ+EnnNalBzui8+RLOkX8Nr+m+lJK+GV
        JrC0ay31kwNTMMHrPJEZ6G3aqA==
X-Google-Smtp-Source: AA0mqf4Jlo9bPOKU+NFC/VMZWSkEpQ/6kmrsGl9mG2CaDd2xNKrIysNaLrErxchfEsx9azuFvOOaDQ==
X-Received: by 2002:a05:622a:480e:b0:39c:e18e:758f with SMTP id fb14-20020a05622a480e00b0039ce18e758fmr31278458qtb.187.1669663712166;
        Mon, 28 Nov 2022 11:28:32 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a445200b006fafc111b12sm9166183qkp.83.2022.11.28.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:28:31 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:28:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y4UL3yF9erST4nEp@cmpxchg.org>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:16:15AM -0800, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Ok, this now also has the get_first_page() and the cond_resched() that
Sergey had asked for. Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
