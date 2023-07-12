Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766574FC14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGLA2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLA2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:28:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBDDC;
        Tue, 11 Jul 2023 17:28:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8c81e36c0so31703625ad.0;
        Tue, 11 Jul 2023 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689121682; x=1691713682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pyRQfW5DbXcPYwgx/o8m7UZH6m6LX8pSrhSqkuWjO8=;
        b=aWCWG4qSdsaivaMi9gCytkAWE93sAreOfi+lQ4zwRqmBtdpKr2BVh4dmDjEARSvQqy
         yhv8D+FCnaDTJ2T1hgnZVknaHQhe+FRBcj6qtnpSESRWcyPWMm/RdkdD5te52AoFHvQS
         S4VUIv0SQYrFAUGNOPCdOrfIkupwIltkgEBt6OUVpInSx7gLMJhYZrf8K9/pmlHVJU9Z
         8Jh4KE9KaDhnBTMUd6TWl+Bn9nuFas74pti+BQWmiVliWMG200g+qkA2FGTv3+p8P/4c
         uIWhtvQ0L9APJnM2RZ+EH9ei1LnEj6dc6VB6t5lBeJCLOOox/X5G5yRYYNmtGqWUBmUI
         vvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689121682; x=1691713682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pyRQfW5DbXcPYwgx/o8m7UZH6m6LX8pSrhSqkuWjO8=;
        b=H4EzmMvRV0FjtdLpuuK7xBYdBueBrmZIbKBZny9KqGPudcE0H35NHUpxIBFu+thr59
         Aw05p12n6Gmz5tc6wDzRcJYMvtt8jpOgKAC49LyfptnQFGAazGctczA3NpPh1r2yTnHX
         zOksAU1HfQeaG9KtHxUX9Rh/zEpTxG+TCLXsDhB5taFQ4alWyVsEQ3rzITYhIEpQJ4X2
         RFwgP6bbgEnepBxrix6HY3Qo6RAUaLSCIywcIMnY/8zv/i5kO2aWD57ih7H9jMmFBjNY
         URwliHoQq1ApzJzmVnFmibUcoxmSGWzYnpCMSQ4DRDFGcjLLRxYGHBOSXGoBilRDHxqO
         S5Mw==
X-Gm-Message-State: ABy/qLY+G3F8Z7xjJMTHbMoLfPbAE42RMMOQ3/YR7ZbG6YzhDHssxXqV
        VYWTekkZyYG14UaAh+4JDxQ=
X-Google-Smtp-Source: APBJJlEeIQp9RZX1tZsYqnDkzgQVsemzMc1ww2QpkTmRGQTLSOAegaw44Fi0YF210vQOK/OY77GS5A==
X-Received: by 2002:a17:902:b7c1:b0:1b9:e8d9:7e42 with SMTP id v1-20020a170902b7c100b001b9e8d97e42mr3985454plz.69.1689121682211;
        Tue, 11 Jul 2023 17:28:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902c2d000b001b89612dc7dsm2535444pla.142.2023.07.11.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 17:28:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 14:27:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 0/9] rust: workqueue: add bindings for the workqueue
Message-ID: <ZK3zj4xPBD0NfaxM@slm.duckdns.org>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <ZK3VEPeBEyErmerR@slm.duckdns.org>
 <CANiq72nktgf_j-+S7snysQgwqeqB12sfjc-vrLsnOUKiZZ5WJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nktgf_j-+S7snysQgwqeqB12sfjc-vrLsnOUKiZZ5WJw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Miguel.

On Wed, Jul 12, 2023 at 01:44:47AM +0200, Miguel Ojeda wrote:
> > Please feel free to route the patches through the rust tree. If you want
> > them to go through the workqueue tree, please let me know.
> 
> As you prefer -- if you are willing to take them and/or maintain or
> co-maintain patches to it, and it is not a lot of work for you, then
> it would be great to get you involved, of course. Otherwise, we can
> apply them to the Rust tree too.

It's not a lot of overhead for me but I'm also not sure whether I can be
actually useful. Once folks are happy with it, I can create a separate
branch for this series in the wq tree so that others can easily pull from
it. Let's see how that goes and if my involvement turns out to be pointless
we can route future changes through the rust tree.

Thanks.

-- 
tejun
