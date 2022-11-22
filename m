Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE272633204
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiKVBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKVBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:12:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E064E2228
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:11:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so4528357pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgNjS0UJ131zlOU05vdNu0piWj8Kc+9WkSNT0ATjhBg=;
        b=V994F+sAbbaG5E7x6m4RuvkETBRWaQ2OdqDr+K4OemduSvQxL9GSU0gAHNud7osy5S
         lNQ/SGBI3eYMAmF6jANPc+6Ge6Qfeqnt/w30b+qNo2wBoJHf3R37grdqjyUjP/g8Jn0Z
         /p6+fX4DCuj67fvBqABSRBwyEV8QXodataSLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgNjS0UJ131zlOU05vdNu0piWj8Kc+9WkSNT0ATjhBg=;
        b=qo/R5qunTDkTKwjNbAA8XUhYZEEr0MBPZpe2sACHmAvGw06ncY3RiK19aaahNbh1p5
         V5tPI6tcFPL+iKtcmNQitAbnIsOr3lnvgJNpGQ6l9YxvoN+UfDEpULOHXs3baizwuYnQ
         BqvvTbbNgP0hVxyw3axENzR41YCUeuNhu+O4KqveVXVqI2LCEqh6JWIBHVqsMVisouc1
         pgiVjGZ3roDk2/BDiCfzOPgMcV2AePbRuitD2aBXDDqwIoGmQmC743YWif2ffUZzrPcM
         AuCuWlIn5tKswYEAVH1KWD623tiajwa4q1dB4b24ZNypmUe0kEDegqdOjmdzKIJLrXSx
         Zh0Q==
X-Gm-Message-State: ANoB5pkM4nYcRnJU8GfQONe6B85i/5XXBRKBZWu2GKuPVeRx5mGdyxw/
        1qrLw/4tVSXVVsB48Ic2izVQ+svB6Y9Meg==
X-Google-Smtp-Source: AA0mqf7g9aoe1K93gtmC+jmT/db9YNkf33/9z5vaZvtwktPNwwB2bIjpoS7yuVgzNlHqfHFL8LOknA==
X-Received: by 2002:a17:903:2144:b0:188:a1eb:9a8a with SMTP id s4-20020a170903214400b00188a1eb9a8amr5830618ple.153.1669079511939;
        Mon, 21 Nov 2022 17:11:51 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id o71-20020a62cd4a000000b0056cee8af3a5sm9296579pfg.29.2022.11.21.17.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:11:51 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:11:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 5/6] zsmalloc: Add zpool_ops field to zs_pool to store
 evict handlers
Message-ID: <Y3wh0i5r+9Gk2Okf@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-6-nphamcs@gmail.com>
 <Y3kGwF0BENkuJnS3@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3kGwF0BENkuJnS3@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/19 11:39), Johannes Weiner wrote:
> On Fri, Nov 18, 2022 at 04:15:35PM -0800, Nhat Pham wrote:
> > This adds a new field to zs_pool to store evict handlers for writeback,
> > analogous to the zbud allocator.
> > 
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Nice, much simpler. This should make Sergey happy too :)

Yup looks good :)
