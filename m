Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3F63B8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiK2Dr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiK2Drz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:47:55 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDF11A08
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:47:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so4288427plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu/MkNTnbzTmTVxpxZSKeNeNonYzZiZ/WvCG/yFRvMU=;
        b=ngpvFrUIbdMzDb3VKsM/bULcse782/i69VoDfCTk4NK5NGWn7PCCkEKfOnF4tQjzR3
         D1ctNMkbQGZYQVB1yR1IaNRbJff86ZHIV0f5HMWCf+lZDlReR5PiwBLm/JRi8v1uvdmO
         YkhJPMd3mQ2jnbxmcg0vOuQP77cXePU3QmzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu/MkNTnbzTmTVxpxZSKeNeNonYzZiZ/WvCG/yFRvMU=;
        b=0n5UmF7ImlbLokhRPlxXZ+21lc+lDs3kgZvfBLJM62zczjA4NU1c+WkKX6mTqKguUw
         Mi1hd+3QmdFu/5aeSyxTBLsmkvIIxvDVQQMMquc+xZcNy4+TnspSE8GK5sDUX2Q/6G3V
         6+g2YRXKtp7XJZTBYoNtSGI82amkfx0n70kJp7Q5hXErZbqH8r2WYNMbj9J8orLu/svE
         eTEOWRhgblyhduyPrWb+2tRmVxECi7KIy/HbiR21NHBF4vi+5H3xIJcZP7GCVE5sigYs
         bvhsv548+wYFrSyHtfDzmChNLn+f+Yf9kwxawI/yyXBwkENN7bizQCihRaUYfF0PHrtH
         SYtQ==
X-Gm-Message-State: ANoB5plCnLkKjHBRTrB+0JtkVlAb6yJeLatY89XB/bD2mYrByWFJ02PM
        YYPlheTV2Nctc53URnnULDL7qw==
X-Google-Smtp-Source: AA0mqf5krzlbs/ipXQeT5uiqPLFPPBRJ95dOIEb2afXaeCFnajvSvPOhOGZvabmJag94y6wBLmKLSw==
X-Received: by 2002:a17:902:ead1:b0:188:f461:800f with SMTP id p17-20020a170902ead100b00188f461800fmr35110046pld.56.1669693673807;
        Mon, 28 Nov 2022 19:47:53 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id 125-20020a620683000000b0056be1581126sm9033112pfg.143.2022.11.28.19.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 19:47:53 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:47:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 1/6] zswap: fix writeback lock ordering for zsmalloc
Message-ID: <Y4WA5DQMjXrjC8uO@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/28 11:16), Nhat Pham wrote:
> zswap's customary lock order is tree->lock before pool->lock, because
> the tree->lock protects the entries' refcount, and the free callbacks in
> the backends acquire their respective pool locks to dispatch the backing
> object. zsmalloc's map callback takes the pool lock, so zswap must not
> grab the tree->lock while a handle is mapped. This currently only
> happens during writeback, which isn't implemented for zsmalloc. In
> preparation for it, move the tree->lock section out of the mapped entry
> section
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
