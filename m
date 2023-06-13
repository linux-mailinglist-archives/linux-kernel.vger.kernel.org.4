Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934872D766
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjFMCh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFMCh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D07410FE;
        Mon, 12 Jun 2023 19:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E6662B05;
        Tue, 13 Jun 2023 02:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C7CC433D2;
        Tue, 13 Jun 2023 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686623844;
        bh=ssAPgGS2d23iXRjVu4jNuQBYtcf86wc6r8T8a8Pw9PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snqC7+iqopXekqaUFANrgNUVQhgO6VAiiv5kUrVQoaQ7hwsgdK4dNTO7g1dant5/s
         UDFnP9L3YGw6E2YBxw74L9LLH3SCRXpAoJsoOaneqHH4bUkF/p7mEZow74ZTQ8KRFU
         zuaWQK48KFg9sVnBSKQhUtR2bk2XCRr4DL/yV/s6/s6OYMvW8K6EOk41stpCu4VIJM
         Uxx7psw5pWQTigVUVepz8SgEFfnRqgrTc5lylPu0DaMtKFMDyz/orrcsf1UUUS6IW5
         89aCZYCs0MAfiSDwTxjPy0h9DsfFps8GBPedMqnNHJGavtCVid/UBIJoG9bdsrOEJk
         JWk8dljDVEG6Q==
Date:   Mon, 12 Jun 2023 19:37:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hardening@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Replace strlcpy with strscpy
Message-ID: <20230613023722.GA883@sol.localdomain>
References: <20230613002258.3535506-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613002258.3535506-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:22:58AM +0000, Azeem Shaikh wrote:
> diff --git a/crypto/lrw.c b/crypto/lrw.c
> index 1b0f76ba3eb5..bb8c1575645b 100644
> --- a/crypto/lrw.c
> +++ b/crypto/lrw.c
> @@ -359,8 +359,8 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
>  	if (!strncmp(cipher_name, "ecb(", 4)) {
>  		unsigned len;
>  
> -		len = strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
> -		if (len < 2 || len >= sizeof(ecb_name))
> +		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
> +		if (len < 2)
>  			goto err_free_inst;

This is wrong because 'len' is unsigned.  So the -EFBIG return value is not
being checked for, so this patch actually removes the overflow check.

It looks like you've sent over 60 strscpy conversion patches recently
(https://lore.kernel.org/linux-hardening/?q=f%3Aazeemshaikh38+s%3Astrscpy).
That's concerning because this is the only one that I happened to review, and it
introduces a bug.  There are 60 others that could have this same bug.  Can you
please review all your patches for this same bug?

- Eric
