Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD245BC525
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiISJPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:15:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693E24BF4;
        Mon, 19 Sep 2022 02:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CE44B80946;
        Mon, 19 Sep 2022 09:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D454C433C1;
        Mon, 19 Sep 2022 09:15:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IFsPslV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663578930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B4GNXlutcVJv+lzFkU+fXLn2WjBirheENfIaXdm+UOc=;
        b=IFsPslV8VOM/JYzC6RpT35FR0vF4u7CXL3EhBCTCLqsBn2fqCyZ/flACrmpGIv7Rb1iebL
        GUfUoz3xKvpSXhscqXgroMK09B9gQf0DEYWBQ6fL7HHTpERVxpaNmmNGHEUK1N9IfoUOB9
        9il14Dwe1n4jABvndprBbXDdTquDey4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8dc0f153 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Sep 2022 09:15:30 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id m66so29197179vsm.12;
        Mon, 19 Sep 2022 02:15:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf1DFTZtSD9BAxjMXYnMdaiLV2AtBPxmE2kDoUxDKhcmZ9mbyzag
        zF98Hpuj86gujzLue+wJ+auQKpss/wtQuciTa3g=
X-Google-Smtp-Source: AMsMyM66EqAG4i9aY3Rht4pK16ziCNKhRlhjbO5eGIR14yQ9uVLz95OO0NaO7s4+u32astKtFEk9SCyaSsgq4waO4C4=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr6264056vsf.21.1663578929003; Mon, 19 Sep
 2022 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <4deaa04b-f103-9cc4-7946-9ea69afd94d0@leemhuis.info>
In-Reply-To: <4deaa04b-f103-9cc4-7946-9ea69afd94d0@leemhuis.info>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Sep 2022 10:15:16 +0100
X-Gmail-Original-Message-ID: <CAHmME9pVCgY7kD9C=N77cYnwk89ryeZh+UWTUs660VgVQ0AaRQ@mail.gmail.com>
Message-ID: <CAHmME9pVCgY7kD9C=N77cYnwk89ryeZh+UWTUs660VgVQ0AaRQ@mail.gmail.com>
Subject: Re: [REGESSION] Bug 216502 - slow crng initialization on Rockchip
 3399 (Friendyarm NanoPi M4)
To:     regressions@leemhuis.info
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 1:17 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker speaking.
>
> I noticed a regression report in bugzilla.kernel.org. As many (most?)

I saw. I'll follow up there rather than splitting the thread to here.
