Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB65745B92
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGCLuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjGCLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:50:08 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15068194
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:50:07 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-988907e1b15so380161966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688385005; x=1690977005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SzNF2Xp9ZY8Wj02jDl62Q9tRowvgKYaFK1hebcuMF8=;
        b=pgdnlTh7+dQSQr4HXDzPTcsLOQlcjEHZQKHGP8SUHPN3/ATvqnlbPaxBaM0s7GaUvw
         RNvdRo93wXLXicgZGyBhr6ZaC7R7ulc3EeshDcjqG+ymW8vmixEwqNuGgEZgFwma+dXs
         PuAJ3SfbY6DIDtw7FWQQehgD5uzUfk/kymMLnXbNQaYbsaHYBje2TTwgvzNaVUl5hyAu
         mjU5Htde/TqTtks02Ohuj1rUzDg6n9J+Od7vyRrVjEeU723xdaTuLfKYG9rmCbv1HqKq
         Qwo0hAGqQyNLiF1/67JGjZjZUaJ7oZpn8LbSv7zzUM7/f5VgOaTJPHaDBhaZfaAScZtR
         Tp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385005; x=1690977005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SzNF2Xp9ZY8Wj02jDl62Q9tRowvgKYaFK1hebcuMF8=;
        b=jF8vHLm84CB7uEg8Gw8oLXipTRy8DJGVQzjVxRZ0zNiBQ/JOdwR5PThiTULEADpz7o
         QvQQ+vrI1F0qi4LD3CZtqOp5/SNczaWtZv9HRH1WRPub0OIYb4cozhAyThdCifh5em25
         cLbpFH7rpDl24hEWjKMNgjZk2TwyBf5E6Lmklhd7nyh3ojdnFdXfVIscf6YLD6VQvh/n
         morpItZumvu2HDtQ6ow1C1oRZtr+6Cik4mPSnMbrM1DpHl8LrXixU47hojtehj+LN3RI
         NvAZM3ZvDOIQiGM3I6MX4eoRgDy49ObzwDk/VNOBcaI85GFrf/gGO5WRS95O8edQXM1T
         PlQQ==
X-Gm-Message-State: ABy/qLaKjaA88Ru5IP0R0NkxHNgDIfVdvcWtUuAYIXQCXlZ0OrspzLZl
        fho+I5cXy9Ae3Z/HBwLDJ0b+l3wkgDrwqHE=
X-Google-Smtp-Source: APBJJlFgAj9K0YUTqhagRD6cI8VCPje3jm3GVaqxDZ8a4l8+2/DnyNUX8Fzj6a1eJXu/gYFu03qpStGBcxSRJ3I=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:4bcd:b0:992:4ba4:dc4a with SMTP
 id x13-20020a1709064bcd00b009924ba4dc4amr24697ejv.13.1688385005551; Mon, 03
 Jul 2023 04:50:05 -0700 (PDT)
Date:   Mon,  3 Jul 2023 11:50:00 +0000
In-Reply-To: <20230624092330.157338-2-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230624092330.157338-2-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230703115000.2006682-1-aliceryhl@google.com>
Subject: [PATCH 2/7] rust: add derive macro for `Zeroable`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Add a derive proc-macro for the `Zeroable` trait. The macro supports
> structs where every field implements the `Zeroable` trait. This way
> `unsafe` implementations can be avoided.
> 
> The macro is split into two parts:
> - a proc-macro to parse generics into impl and ty generics,
> - a declarative macro that expands to the impl block.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

