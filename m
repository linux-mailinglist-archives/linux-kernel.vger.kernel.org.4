Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35BF644A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiLFRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiLFRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:22:51 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48507303F5;
        Tue,  6 Dec 2022 09:22:50 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id u12so23523565wrr.11;
        Tue, 06 Dec 2022 09:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h458RF1zVZ1EV5DsW5Ozll8gVo7xVTHiPN8UW60GA68=;
        b=MAdwXevRAeZXm9ebxFKC37IdNfLB8qCjRWWBrM8437ruIZ5E7cRHqxnnWwNUKLKS/A
         ZV1JwKU7L2n1LIN9PDqIdnd2hb0fm32HJeadSu13D/nXBkYPFU9j8j95fe6e7bOgLeyv
         gBo6MF2OouZon21KzCukqIHCSz2+P0ewnj0Zyt5dMqjWf2XhfXORaKFz5DV4nyAaXCFc
         WKpSMHgNwImlsv/6Buk9EguUXxjkC89xTmc41GG5c5yQG2IXw3BtwNRtDE5wvskIzYMf
         LYHeskFTK23tvoT1TOxMw4fWFC9txj6FcAt0WeYc1g9jtFa/cK6zm7M8KK/L1fryGOAd
         RiNA==
X-Gm-Message-State: ANoB5pkkInLqtKF/L+jiAZXL2K0FBI0o6qBTF0y4tMAB36TgzyqxfDe4
        fwPF4fVRx+J3G/XeupmA4EQIQiP32sk=
X-Google-Smtp-Source: AA0mqf69t2edOthKa9N0tlXb6In5lgsG6vbYRgykNTLjMAQGRTNDzlhy0o7aKePbqfG0Z7vVISKD6Q==
X-Received: by 2002:adf:f94f:0:b0:241:f467:f885 with SMTP id q15-20020adff94f000000b00241f467f885mr37985303wrr.482.1670347368751;
        Tue, 06 Dec 2022 09:22:48 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e14-20020adff34e000000b0024228b0b932sm21286544wrp.27.2022.12.06.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:22:48 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:22:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1] rust: alloc: remove the `borrow` module (`ToOwned`,
 `Cow`)
Message-ID: <Y496ZhJF2ND+ND3L@liuwe-devbox-debian-v2>
References: <20221206010519.39075-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206010519.39075-1-ojeda@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 02:05:19AM +0100, ojeda@kernel.org wrote:
> From: Miguel Ojeda <ojeda@kernel.org>
> 
> The `Cow` type [1] requires that its generic parameter type implements
> the `ToOwned` trait [2], which provides a method to create owned data
> from borrowed data, usually by cloning.
> 
> However, it is infallible, and thus in most cases it is not useful for
> the kernel. [3]
> 
> Therefore, introduce `cfg(no_borrow)` to remove the `borrow` module
> (which contains `ToOwned` and `Cow`) from `alloc`.
> 
> Link: https://doc.rust-lang.org/alloc/borrow/enum.Cow.html [1]
> Link: https://doc.rust-lang.org/alloc/borrow/trait.ToOwned.html [2]
> Link: https://lore.kernel.org/rust-for-linux/20221204103153.117675b1@GaryWorkstation/ [3]
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
