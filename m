Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACC05B323F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIIIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIIIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:50:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD512B341
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:50:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g4so986520pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NQ9A54Z8CrY5jmH+r9/WMnhPXv0fZegOM1GsxMLYivs=;
        b=fsuGRjKJLd6qfgSCuLuq3Lt6Y3e0yzujg28kWkL6OWPHdyEsFnzJfcfEuOvjIkg4ne
         tmnlQNnKoUdM46/oEukw1eYmkfgIP8rfXe9G1RJV6K2CN6FamgH+UuGDEYv9LUalZ9Yp
         WTc0KOpfouqx7byOabYsqG+/ARlXvXQ4Cgjc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NQ9A54Z8CrY5jmH+r9/WMnhPXv0fZegOM1GsxMLYivs=;
        b=jWbr0HuLyjPjkbfjaZY5hgNnyrt58IhpzrF8qcxoKz/RyAaUdYR8T2hYBdJDnQb1yw
         ONCGuE1JziaqW/Qv/QA8xPkbceBUL4UJBB66usv+pMbe8TDpfEZbykIzbhNxH5aZssgt
         jU6qcL9fcDqL8/hpQgjYexhuHZWTfCdwv2UPYR5TLdh5mP0eYYAPcO9WYVDH7mZ9ccBU
         RiLzAnDnr4sPqkp2sZp0uhz39fGRgYYqlTuwCh9BBwjv1pZj98RJ4xP9sExFNwHZ89oc
         Y6svA+VtUkrb5E7GeiYjcEX9nf/4f2A8Fp2x9drCKLbFO8urSS3Mypzf3cPuZ3hVP7Gq
         2ETg==
X-Gm-Message-State: ACgBeo3ZaVRf6JJOc1N7OJx6RtSPhN+d6b1d/7WBBW3wSgnktqP72N3T
        0Z6pnrDAy4b79dggjNo+1bKVHA==
X-Google-Smtp-Source: AA6agR4eVohPouIdbf94GuuS4F+zf9LrnIGKPWj4kthWqhX2bHCNKX7dTvOXveIWtBGoANoxSvL6YA==
X-Received: by 2002:a63:6b05:0:b0:41c:2216:d2b2 with SMTP id g5-20020a636b05000000b0041c2216d2b2mr11697974pgc.118.1662713442523;
        Fri, 09 Sep 2022 01:50:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:48ca:975b:3395:bf])
        by smtp.gmail.com with ESMTPSA id b2-20020a636702000000b0041cd2417c66sm796886pgc.18.2022.09.09.01.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:50:41 -0700 (PDT)
Date:   Fri, 9 Sep 2022 17:50:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] zsmalloc: use correct types in _first_obj_offset
 functions
Message-ID: <Yxr+XNIoR3e3T84R@google.com>
References: <20220909083722.85024-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909083722.85024-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/09 11:37), Alexey Romanov wrote:
> Since commit ffedd09fa9b0
> ("zsmalloc: Stop using slab fields in struct page") we are using
> page->page_type (unsigned int) field instead of page->units (int)
> as first object offset in a subpage of zspage. So get_first_obj_offset()
> and set_first_obj_offset() functions should work with unsigned int type.
> 
> Fixes: ffedd09fa9b0 ("zsmalloc: Stop using slab fields in struct page")
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
