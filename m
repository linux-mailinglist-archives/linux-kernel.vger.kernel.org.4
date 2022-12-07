Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABC645A01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiLGMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLGMiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:38:46 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418F419BB;
        Wed,  7 Dec 2022 04:38:34 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id m14so27887379wrh.7;
        Wed, 07 Dec 2022 04:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRrflo0GcL3wDE3RqSPwP5BDQbI3MrgakFXIOceJCzo=;
        b=SlfDRCyxNGDt7HpPAS9DcfJf0pFUmoaSomGG7uiiDYcTvWsx3IWKnyw9V7VRHeiaMH
         EmCN6drRbqsHoYecTq3KbxiFIC3WnvKdiNVoqhOMNw/uhZ0Pd/C6DOAT/+TnVfKVQ+8h
         YbgnGrAc0BLtfJf5bjFgc/DadsSNId+4efNK5NOtgThYFnADtEZaMp/ds8CVk3bPlP+P
         X3sPcUYBGO3eCg2dUpoEETmTb6OWO0G+PBOt7Q5jA8ZjT9F0pIXTOt7D9DjEU2wxhNga
         ScNGpXGON/idOrqPrBhFSqwE/HBie7cS8zgBbDCfGviXVBMH7JgYDXGQKB2Em+JlPr25
         2oYg==
X-Gm-Message-State: ANoB5pk5kArfNawBk7jG29EYqciZW7xXnXQb8IsaHPu2knTYjbJV+whB
        IRrqNgwpbpNPmcJu3bKsOC1ErYRuAYs=
X-Google-Smtp-Source: AA0mqf7s3NXYwZdH9sRNMIGnjNNLFl+86K47grjBqwwlbmcZ8QGne107Wy+eXYLOvYCIzlRPa8ljpA==
X-Received: by 2002:a5d:6d49:0:b0:236:bad6:44df with SMTP id k9-20020a5d6d49000000b00236bad644dfmr53115389wri.489.1670416712839;
        Wed, 07 Dec 2022 04:38:32 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h41-20020a05600c49a900b003c6bd91caa5sm1508156wmp.17.2022.12.07.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:38:32 -0800 (PST)
Date:   Wed, 7 Dec 2022 12:38:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v4] rust: compiler_builtins: make stubs non-global
Message-ID: <Y5CJRuwJlneWifEO@liuwe-devbox-debian-v2>
References: <20221205215000.2563281-1-gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205215000.2563281-1-gary@garyguo.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:50:00PM +0000, Gary Guo wrote:
> Currently we define a number of stubs for compiler-builtin intrinsics
> that compiled libcore generates. The defined stubs are weak so they will
> not conflict with genuine implementation of these intrinsics, but their
> effect is global and will cause non-libcore code that accidently
> generate these intrinsics calls compile and bug on runtime.
> 
> Instead of defining a stub that can affect all code, this patch uses
> objcopy's `--redefine-sym` flag to redirect these calls (from libcore
> only) to a prefixed version (e.g. redirect `__multi3` to `__rust_multi3`),
> so we can define panciking stubs that are only visible to libcore.
> 
> This patch was previously discussed on GitHub [1]. This approach was also
> independently proposed by Nick Desaulniers in [2].
> 
> Link: https://github.com/Rust-for-Linux/linux/pull/779 [1]
> Link: https://lore.kernel.org/lkml/CAKwvOdkc0Qhwu=gfe1+H23TnAa6jnO6A3ZCO687dH6mSrATmDA@mail.gmail.com/
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

It seems that the only difference between v3 and v4 is Nick's ack.

You can put a changelog by adding a `---` section -- it will be stripped
by git-am automatically.

Thanks,
Wei.
