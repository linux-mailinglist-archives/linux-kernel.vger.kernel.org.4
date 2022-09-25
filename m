Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956445E945D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiIYQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1642CE0D;
        Sun, 25 Sep 2022 09:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E3961223;
        Sun, 25 Sep 2022 16:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83E6C433D7;
        Sun, 25 Sep 2022 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664123356;
        bh=3itHI1OJ7KHfwqLn3q61FmEtR1dnNNuAGxRwnqrjLt0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qy/Nh6z6Ez/G9scDoaylDh9stBKhzddKzH0woXNa7GbLqYYKAEX0aBwmGGl9CqOQe
         AnwGeeph2kkF6bH0+39N9VoANp38ynIo0fWF4PXy0iObV8L0bIYFjzv97CE+ZgcoVm
         NpU31MzCd7d3McfES0IUgYlSAwfXjXAnSh+SML/4=
Date:   Sun, 25 Sep 2022 09:29:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-Id: <20220925092914.23855d9c85788a92c1f20c38@linux-foundation.org>
In-Reply-To: <Yy7d5qWpT5Xj2WvN@zx2c4.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
        <20220923154001.4074849-1-Jason@zx2c4.com>
        <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
        <Yy7d5qWpT5Xj2WvN@zx2c4.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 12:37:26 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> Or maybe older compilers do something worse? On x86_64, clang doesn't do
> the smart thing until clang 13 and gcc not until gcc 11. So maybe your
> text size blew up because your compiler is old?

I used gcc-11.1.0.
