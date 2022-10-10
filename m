Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E55FA1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJJQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJJQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB41004A;
        Mon, 10 Oct 2022 09:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793DA60FB6;
        Mon, 10 Oct 2022 16:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2493DC433C1;
        Mon, 10 Oct 2022 16:25:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hKX58m4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665419113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+L1uK7+UFXjdLSmw+INFF3+OueVNNJPFpoH4rnfXRY=;
        b=hKX58m4SkxMn/4N2BcZIg6c3o9EQ0i0NW4OerpIDzbkNjeukCo4rcAnX2cWJwxIIKVSVJa
        fndWIcyVHryp7okrgaLhyAbfDqRBYBEBV9+kUvak7uq3NgknwUFfVtPJEW7GWFatboBqL1
        AcOwLf3bWLsEuYfe5t5xuG4SJrCrjnQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9b333b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 16:25:13 +0000 (UTC)
Date:   Mon, 10 Oct 2022 10:25:11 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        linux@dominikbrodowski.net, ebiggers@google.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: INFO: rcu detected stall in hwrng_fillfn
Message-ID: <Y0RHZ1ZIRcaIssHl@zx2c4.com>
References: <CAO4mrff==O4pbJc+OjnrLz3so1D6spp_YvOkSiu-cFp3z8ZbHQ@mail.gmail.com>
 <CAHmME9rX9rtfvHreQFmNbp1RZmm0+VfU7LVPPVVYmk1-ME6sqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rX9rtfvHreQFmNbp1RZmm0+VfU7LVPPVVYmk1-ME6sqg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:16:05AM -0600, Jason A. Donenfeld wrote:
> Interesting that you're seeing this on a 5.18-rc6 kernel. That means
> it's *not* caused by the recent changes. (And the virtio hwrng driver
> has quality=1000 anyway.)

Oh, I think this was fixed in 5.19 by
228432551bd8783211e494ab35f42a4344580502?
