Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96362FE05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiKRTdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKRTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:33:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC5A470
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b29so5779962pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63iFZaC3bl3tOuW2CMEl6zmyAMZjwWOtMFVH6bKwczg=;
        b=Y7FaiGRnZwLO45Av0DFZX/du9RQOTo8seettPt4GbIvRtXbTUOfDmbxc0SS+/TTanZ
         VfGyRslnqeJ/M7VnQF9OMXbMhlXdvPLo5T6OPeYtJ35x3FohUcaVWPRAbMNZjPkNA5rn
         5jUEjmddD4un3e0B+pSKHA6Ksez5gvXiVHPw+qSMjq5jNNEzH3/w8kH0d/hguzMOzKAE
         IGf+N9+Hi0JFUg80fJQD855WqN2WF+K7Gl2soXFRAbdJvSABUV7sbf4ah9Ivk0cUhdba
         VafUMMA5SFp7naA/MbV/nTAy3SGcMJk5/KY37lxNwOqp4oWa1McDJ7mpqzoEGCFdXSbm
         zHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63iFZaC3bl3tOuW2CMEl6zmyAMZjwWOtMFVH6bKwczg=;
        b=EAhiPxB8IjxY7TrGY7QEw3L0Gat90I9vBtagVpqFQp5UpL8hCN/tvWrtX4Kj8GkgYI
         vy/oiG3yWPa7Zm75iNz7Tivr0PyYt1NqEMQINCUjEo92wZOJE2ZYpXTqS/CM8mg9LNLF
         cb5OxbnnisJfb3l0SfSdIgn7lNlTy5RCkHhGq8g45y1Y7SjsFlDoNAGLUv7Oe+5BpSSD
         zzUqeetEwwBvfXdkIs0IMFqrPX5pZEN+ZK/0XQ7AnHCey0YpsrpexM8Qpt2aUpmig62t
         B4atU5ZgQfYZ06BHR4+8agyj4wN3758rObJ5CHeCUkxxIjOCoHacrz13ZBW/cXnJtd2Z
         wGYA==
X-Gm-Message-State: ANoB5pmDULaKsbbxFnVJUMJE+Z+e5GtQqut2kl4MoyBPgkGgZj32FT/D
        l7B/W0AlpgnOt5LZjdV6D2s=
X-Google-Smtp-Source: AA0mqf5GcuXyAnXI1LoWbVK1mzG48BpnYcQ2yBfPenFc6cQoZKKeoGRKN0ZolhrBMr6fP6NXNIBFUQ==
X-Received: by 2002:a63:5042:0:b0:46f:e658:a8ff with SMTP id q2-20020a635042000000b0046fe658a8ffmr7884443pgl.493.1668800012675;
        Fri, 18 Nov 2022 11:33:32 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090a8b1700b002135de3013fsm3107744pjn.32.2022.11.18.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:33:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 11:33:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 5/6] zsmalloc: Add zpool_ops field to zs_pool to store
 evict handlers
Message-ID: <Y3feChsaMtn7UOMn@google.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-6-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118182407.82548-6-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:24:06AM -0800, Nhat Pham wrote:
> This adds a new field to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Much clean than previous one.
Thanks.
