Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09CD63B8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiK2D6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiK2D6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:58:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140AAA1A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:58:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id o1so7952164pfp.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxmZ2Yys/5XwKGWY9dVGrUIryLuN0T7PNro9+OrkmPY=;
        b=Mz/KYQj4557rDREjSNJ+QjdnEF0OsZ3QzTnxYeBm1s9iqvUlnqNM2QgIYXHIdn5zGB
         JHdIiAR/eSUu6+cYxpeRUKTg3BrF1aYKJN7zQEGDTvvQblhZXd5X7C6Kje7MSKp86pVy
         7LGdDYpEfLlf8JzpdnEW4kvx4+PPWUJwF1rok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxmZ2Yys/5XwKGWY9dVGrUIryLuN0T7PNro9+OrkmPY=;
        b=WEz0INazXig0v2gcUfhFMGD66cS+pbWt4IbEa/emQ0dr+bpFpPjE4Z0jvQm1bx/loD
         QRT3VwzlVybGeHW4t+JRI7dU/CGz1hkgF+WBEteJ7xudbElfLLZLAOoGSBhYuDt2HBd4
         e02q72Sxhzv0nkhyDslQdV6VXRPRHwPOpFzMChA4TcgQV/sCg7yRUeoxYADmn463KKZi
         SrgwrkEVb5IgS8l9dyUm2b94Y67u8u8OsTo/rrcBsbA3aZfu7sgzaNC2RLthP6+A1AYH
         o66EkkRw3zbnZhZm/9EChVQMCI9Ko/SKrrT8rO5wpP1v3gcxPQgnUusHE1B2a6CcP/6C
         WzeQ==
X-Gm-Message-State: ANoB5pnN0IZ7xX+WcNZ+0YCGPs/zBThjBN1xsd2OQzY99TsVV8WrlKvZ
        Ti5SMoSutkPLRd39TUXF7vdtKA==
X-Google-Smtp-Source: AA0mqf4b+nKb9cdt7ZjVOnQ4xx29Y49/j2AF10vzvVPcK5HAx41eMy5kYq8xAzwc4EKtOjsqwy0nYg==
X-Received: by 2002:a63:f90d:0:b0:477:7f9:aecd with SMTP id h13-20020a63f90d000000b0047707f9aecdmr37032793pgi.242.1669694295489;
        Mon, 28 Nov 2022 19:58:15 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id h11-20020a62830b000000b0056c063dd4cfsm8818645pfe.66.2022.11.28.19.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 19:58:15 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:58:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y4WDUsJCkY5GpIdY@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/28 11:16), Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
