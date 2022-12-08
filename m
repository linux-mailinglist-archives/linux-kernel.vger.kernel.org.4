Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8405647800
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLHVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:32:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EC1209C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:32:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so2195994pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TrQiFZlVHCDTQZCh8d0lNxTCa2DqXYRVLa5t6bBFo4=;
        b=HoGLKZMHw915NF5vqn7lXXRKSXbZ1SPCMMapkTLnUmxiXPa7OuhV6wJjen2dNpuBB9
         kSmJN6yLnBh8zJnIOmyf9cW3UehPdl84indT46fiDhl/boDQEOAR4T1CqhthfV0JRk+A
         TRM2ZcEpi+aDQXUw5lceStPgq4Ott6/LOdkFN3kBz26KL5IdqHNI8JyxOa8miefCSQVC
         KvtXbAUET8S3spLckG3ejH+N+iSWyvvCykclszNnMhVgJETG5s7V7kduWqPubfnyCX0G
         nvZ7C6FcRtJZhGdRxnjk5zBk0l/riQ2e+wRVnu7GaXTEGkUUeh1sgsokZRdrD7unngSe
         jZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TrQiFZlVHCDTQZCh8d0lNxTCa2DqXYRVLa5t6bBFo4=;
        b=TQou1vnnV8VSOadvrIaJMSgQsRqoFLgaGtU1l+LX60Z839ouwJtCt/7MKccuDV2tX6
         rDq4ZJy0Ia076v8OKJGRjfHM9mz1XAOpSMFJrD3fgKdjcel+frm4nm7LDC+0aMf08Xz5
         G2PNoV35xjtIEp+ogoZeGJSo20tIIV+9yFDSf1jfIJRb/gNEFh7ta1qr1TLU2PrZ7P0J
         JjthOxMHAoV3q04RPgdQW2jVUyTgsWT81PKHrIWqsACy5Xvwx5Qh+PKX6XspYrJOnz0B
         xrE0dJdodJk5Uclu3O9qbA3JjBiOVfq+R+JgpqqvD7WzAxISSfklZFuugz6Gw4gf+4fr
         rf/g==
X-Gm-Message-State: ANoB5pkNrEilbmMRirye2toQYi0/a/flEqnbkz58U+y781b1cEzGSX9c
        R5p9U+SFipuQfRy9xHRjl/w=
X-Google-Smtp-Source: AA0mqf7M6QgtFTdNPWkN/TG+ZEgfifAkZcyXsSnNeA+4G+mvo23tR2sS09f4X9rcsRqBwgsLQAsELg==
X-Received: by 2002:a62:ee14:0:b0:566:900d:6073 with SMTP id e20-20020a62ee14000000b00566900d6073mr2758766pfi.24.1670535166649;
        Thu, 08 Dec 2022 13:32:46 -0800 (PST)
Received: from fedora ([2601:644:8002:1c20::2c6b])
        by smtp.gmail.com with ESMTPSA id 21-20020a621715000000b005609d3d3008sm16239132pfx.171.2022.12.08.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:32:46 -0800 (PST)
Date:   Thu, 8 Dec 2022 13:32:43 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: swap: Convert mark_page_lazyfree() to
 mark_folio_lazyfree()
Message-ID: <Y5JX+1qOuFi546og@fedora>
References: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
 <20221207023431.151008-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207023431.151008-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:34:31AM +0800, Kefeng Wang wrote:
> @@ -402,7 +402,7 @@ extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
>  extern void deactivate_page(struct page *page);
> -extern void mark_page_lazyfree(struct page *page);
> +extern void mark_folio_lazyfree(struct folio *folio);
>  extern void swap_setup(void);

Can we rename this function to folio_mark_lazyfree() instead so it's more
consistent with other the folio functions. Also I believe we can get rid of
the 'extern' keyword.
