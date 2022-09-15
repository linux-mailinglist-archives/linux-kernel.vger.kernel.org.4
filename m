Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F65B9F20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIOPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIOPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379D8048F;
        Thu, 15 Sep 2022 08:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A4CE624B1;
        Thu, 15 Sep 2022 15:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF35C433D7;
        Thu, 15 Sep 2022 15:44:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QBIF+TRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663256640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yyWzHROU9kEnjmKKhzTY5LfkMeTLQIiTrmiEeAJ7no=;
        b=QBIF+TRmrJ9BBoXcNSZPogvyVgAi6lpDHuhq6UZw7vtreOC75hxckoaDqZzRKME02yaXdr
        APJItTxeyNIC1U5qJo+XwicF9EkTbTxkwVcThRaWmkMEtC7mVjwQ+dNRaSDRM67XIi3b26
        f/JxHtHtWv4lRMfWilWmhYYCtkPtAbo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9114dced (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Sep 2022 15:44:00 +0000 (UTC)
Date:   Thu, 15 Sep 2022 16:43:54 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sven van Ashbrook <svenva@chromium.org>, linux@dominikbrodowski.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
Message-ID: <YyNIOg1mtnzQz1H7@zx2c4.com>
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Thu, Sep 15, 2022 at 12:22:53AM +0000, Sven van Ashbrook wrote:
> add_hwgenerator_randomness() currently blocks until more entropy
> is needed. Move the blocking wait out of the function to the caller,
> by letting the function return the number of jiffies needed to block.
> 
> This is done to prepare the function's sole kernel caller from a
> kthread to self-rearming delayed_work.

Isn't Dominik working on the same thing, but slightly different? I
recall he sent a patch recently, which looked pretty good, except it
just needed to be split up. I'm waiting for his v2. Does this build on
that?

Jason
