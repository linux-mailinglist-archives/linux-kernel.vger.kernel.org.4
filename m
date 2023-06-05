Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4744722B50
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjFEPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjFEPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:37:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48477183
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:37:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75da00a1eddso160517685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685979439; x=1688571439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TrIpOBmB/O1LiAz1dz9+bGNW7mEPnVUxCMawP9S5iw=;
        b=jxqV3Ubd2paywKj2dE2r4YpkditdtjIRPh6+ezHcG5zDbDKr56koNxV7sQ4cr8AOsK
         wPtiLhLbnXkSYFRHkMuG+r87xm1aOArv+GtY3WeaotOTdh8GqKtryCz5X6GdDhjznTHv
         by5bT5JfCwYoG1FJfQ/xayqEXEzUZT942/KZFvXp+n2+MjD7/GM/Y3mcYf/dK3DJO7fm
         DzU9g2RcfmueNnHq9nC/GzvsRX0HIYos275jTSPtGpD19Y1IkYaYwmvT36gMdE3N2M7n
         wRZHScQk/plyJYiLgTTbDhkcamrU0FqbqgqjGI8lAR2ZakKovq0AUGHU6xVIVhB9l7id
         nLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979439; x=1688571439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TrIpOBmB/O1LiAz1dz9+bGNW7mEPnVUxCMawP9S5iw=;
        b=B7F3Q1IqtZ4oR+LJwPkUMPoGpiDZnjDUtr0yQqqhCznj+xi9abfEKtOwHNKzNyX8kv
         fO2DCDHfvKGQ0hzlyyPy9O/OtDodz36cYBjP3ZA2aqz1b/Uag46bX5O87+xTPrQrHOMP
         R9cYvLKhMSW6Psl2EqYwtUHToM8aR9cb/r+xUQ4VwakM/sjh5CbwX+/xz6GHKw5pQL6P
         RgAG4uQcpp0b3ocKxV3sJelRu/NojfA3nQwUe0VEOIi1TH6PsQMnpBhYVWvBUwSo5cP9
         JKXVEpLk5nH2YmuJmpd0RN9Rw4SLXYjdn+D+0h7KxDtuHB8EtvTVf275GrC4L//ER80a
         7BMQ==
X-Gm-Message-State: AC+VfDwfSAibBg6Laa5ZFEieyOrne44d2y9dWSYOdgfRsh+n5L9Wk2/I
        dBdaBxHk4xUVK8uBL2k1J7y/sQ==
X-Google-Smtp-Source: ACHHUZ6HS+VuSbJvbhqET6JLLoVFCK6yMwRfpEcbT/SdgCcXdPTt9oU4lqcyrM1OCMn+vzx3axKnIA==
X-Received: by 2002:a05:620a:4088:b0:75b:23a1:462 with SMTP id f8-20020a05620a408800b0075b23a10462mr62828qko.40.1685979439274;
        Mon, 05 Jun 2023 08:37:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a13c900b0075b37599295sm4230802qkl.56.2023.06.05.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:37:19 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:37:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 4/7] mm: zswap: remove page reclaim logic from
 zsmalloc
Message-ID: <20230605153718.GB221380@cmpxchg.org>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605085419.44383-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:54:16AM +0200, Domenico Cerasuolo wrote:
> @@ -884,14 +842,6 @@ static inline bool obj_allocated(struct page *page, void *obj, unsigned long *ph
>  	return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
>  }
>  
> -#ifdef CONFIG_ZPOOL
> -static bool obj_stores_deferred_handle(struct page *page, void *obj,
> -		unsigned long *phandle)
> -{
> -	return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
> -}
> -#endif

You can actually remove even more here.

The entire concept of deferred_handle is about serializing free with
reclaim. It can all go: OBJ_DEFERRED_HANDLE_TAG, the member in struct
link_free, this function here, find_deferred_handle_obj() (declaration
and implementation), free_handles(), and the deferred handle bits in
obj_free() including the handle parameter itself.
