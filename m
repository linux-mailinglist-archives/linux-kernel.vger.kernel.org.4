Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67262C681
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiKPRjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKPRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:39:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6D57B4F;
        Wed, 16 Nov 2022 09:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D2AAB81E2F;
        Wed, 16 Nov 2022 17:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31CEC433D6;
        Wed, 16 Nov 2022 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668620373;
        bh=CVMO7EESKWqmZ5u5VxTbvd5Ym1EchEZNsxXXHvZVU6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blV9DDcMNIR9TBx6F7nH2uj5mYsXlHXL3v6wCd4zREAUW7ujcITrHeemY1ZYpZaBm
         mjsxHpYj7SmpsdOu380aSCIUHsaJ3iBGI99+8+/uGinFHg6qQyak+U+phYMj0C4VfD
         7f6T/K5I63PTJWWhUa6m8TqnFpJBQ6ZVFCGY9J/V2ARAZYkSKleoSBPmEsVxBt73vN
         +vN3FRMeftv9nGmPZ9IeQOaVIgKe8xc77rZmiS9UhlnLY4d3XGWGPTRuPUp4CBSjLE
         xtA2ucZqfDce1D3LQh0hNY9whkgWQm+2UrhjGLzeSFB5rNpG8NxLjXjKa9TJyyFJEH
         KwbYOZxVPcH4w==
Date:   Wed, 16 Nov 2022 09:39:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] crypto: algapi - fix be32_to_cpu macro call in
 crypto_inc()
Message-ID: <Y3UgUwwV4qZMrzar@sol.localdomain>
References: <1668606771-5382-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668606771-5382-1-git-send-email-khoroshilov@ispras.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:52:51PM +0300, Alexey Khoroshilov wrote:
> be32_to_cpu() macro in some cases may be expanded to an expression
> that evaluates its arguments multiple times. 

When is that, exactly?

If that's true, then lots of other places in the kernel would need to be fixed
too.  Try running:

	git grep -E '[bl]e(16|32|64)_to_cpu\([^)]+\+\+\)'

If true, then it would be much better to fix the macros.

But more likely is that there isn't actually any problem.

- Eric
