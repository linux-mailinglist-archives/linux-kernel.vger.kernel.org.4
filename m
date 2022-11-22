Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E656335CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKVHTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:19:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1F31226
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:19:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so12839820pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqEub+lBBfeFrlj2C/SHm/KndBPQPD1Sh86dd+BHV10=;
        b=ev5UBIGz62POaB/vsQAV1UYI1ZXeprMiRqs2YCiF5YudXKHXXORVNPt2w11KQ6pJxD
         L3tsvm9L8akWafdgBGvk3kR6AJC1lF3vW3ogxSMPOnreZa8EJ+HLYsvKHrGiSnYPpdQU
         rUpp4op6r0HxCHciWDdct9k5Erxv3YeF2BKKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqEub+lBBfeFrlj2C/SHm/KndBPQPD1Sh86dd+BHV10=;
        b=qeopa8k1BDS1SHbZB7QZs7MgsKuN9U3HN3IKC/ulMiMOoEbwd6TfCgsxBL7h7ViRkx
         KSsHYBsxPmpDQExSvL5UmahGYEGV4ZnZVLuWSp5KmEc36nI65bWhJ7pm20DSQJngQ9P/
         ICCrNsCLPaUQqV4GODyiQ1RBcz/p6qfP0A1KrShZUiu13clk5lrv+sAAy4gDrEexVn+B
         q46g9oE7YkINNEE4pIBViBaHLvap8kF6FcQEj7VN8uwGorY8QSLL01JOhNWWKiomxogP
         lm8iNwMHsLLEVd/oSob/F6/5YRl8saG18BFo9GSqBZ4Px4HCCVIRgEEL5ot0uKkbFfIp
         i4Tw==
X-Gm-Message-State: ANoB5pljBb5oNQzpc5i13FPLUXFtybW6oUNEzKfjg0wHtK56Iyies5vQ
        NzaMHQR9RbAqFU/0JynIxm2voA==
X-Google-Smtp-Source: AA0mqf4lFAfjXNiUEQzrIJ7luivqlYw1jYRvvNMfQIsZ4EoO0jnQvHWclDhJXP7iy4fY6fp/Tp/3ww==
X-Received: by 2002:a17:902:ce04:b0:174:af35:4b90 with SMTP id k4-20020a170902ce0400b00174af354b90mr2772552plg.8.1669101558926;
        Mon, 21 Nov 2022 23:19:18 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b00186efc56ab9sm11158142plx.221.2022.11.21.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:19:18 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:19:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3x38acHBZkWQbL7@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
 <Y3w+C8ClzP6VbqrA@cmpxchg.org>
 <Y3xFHIgkiZNYCbHi@google.com>
 <Y3xnf7pR4vI7o9PV@cmpxchg.org>
 <Y3xtpoQpb8DuiTlh@google.com>
 <Y3x109XxGY02Y7Vp@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3x109XxGY02Y7Vp@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 02:10), Johannes Weiner wrote:
> > Yes. "What if it would continue". Would it make sense to not
> > break on EAGAIN?
> > 
> > 	while (total < pages) {
> > 		ret = zs_reclaim_page(pool);
> > 		if (ret == -EAGAIN)
> > 			continue;
> > 		if (ret < 0)
> > 			break;
> > 		total++;
> > 	}
> > 
> > Then we don't need retry loop in zs_reclaim_page().
> 
> But that's an indefinite busy-loop?

That would mean that all lru pages constantly have locked objects
and we can only make partial progress.

> I don't see what the problem with limited retrying in
> zs_reclaim_page() is. It's robust and has worked for years.

No problem with it, just asking.
