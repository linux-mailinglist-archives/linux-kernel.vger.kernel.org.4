Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBB6282A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiKNOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiKNOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:32:48 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842032A712;
        Mon, 14 Nov 2022 06:32:47 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id w14so18584808wru.8;
        Mon, 14 Nov 2022 06:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCY5hqYU1SfTXWjQyYMV6/iKq7L1yppgMWYjdS1kJoY=;
        b=zUd/BDFZ6QSuYffmaraR6cXXQGnPRFJpP9ZLqdGBz00W6pm97vWTOYiovBgt0Gs38a
         xcgfqfdoK9N96zTTE+SS4ARAGfbRBURBIsVroLTBtMzzxcfSqy+plOGinVHV8ByRXjXk
         ZpbOtrGK1cFEjEGAqpLLfC+zneFixUZQPH70aPVitCD2FsaTBPu4weRIafrF7HL3+yHZ
         szu4mWHBkOk+Utx2k6J6oYOeJWtK+42eB6j4OHVALSTb5qOHIzn/qQX4aWrvFrEQeFvz
         QOIbTvk9j911zVSClnIIP5e4XRR6lBtreD6FUmdFZo94y8t/X9j0lneCK4Lug4I1zWvy
         xJ7g==
X-Gm-Message-State: ANoB5pnJ8k7u4bXxs/ggEFoWiVhNgSGsv4npNGdzfJOU7QJlLDvpnzgF
        XdaCedlXJWc3HoEq/+ONzUQ=
X-Google-Smtp-Source: AA0mqf44IOc5pBuohngXoHzggcsR7YAaWDyqU68BandfFZcF4YWXfAEJc2IF2+LorP2JCqRjywxesA==
X-Received: by 2002:adf:f342:0:b0:236:57cf:1b6f with SMTP id e2-20020adff342000000b0023657cf1b6fmr7859753wrp.153.1668436365814;
        Mon, 14 Nov 2022 06:32:45 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d4884000000b002383e977920sm9651659wrq.110.2022.11.14.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:32:45 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:32:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 27/28] rust: types: add `Either` type
Message-ID: <Y3JRi2cn77rzunaW@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-28-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-28-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:39PM +0100, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Introduce the new `types` module of the `kernel` crate with
> `Either` as its first type.
> 
> `Either<L, R>` is a sum type that always holds either a value
> of type `L` (`Left` variant) or `R` (`Right` variant).
> 
> For instance:
> 
>     struct Executor {
>         queue: Either<BoxedQueue, &'static Queue>,
>     }
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
