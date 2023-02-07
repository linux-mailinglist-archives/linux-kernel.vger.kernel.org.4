Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D968CED1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBGFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:20:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9041E9F5;
        Mon,  6 Feb 2023 21:20:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1867DB816D5;
        Tue,  7 Feb 2023 05:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50A3C433EF;
        Tue,  7 Feb 2023 05:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675747223;
        bh=OwxoFBJ52qioqVj8L5GWl7Ol7CkRkpnbBBk035/GJNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8yfQKzhZZP1sgvmlUMLzjGSDPuPbWm6e/B5BIlHxIB7Dy6caqCWDcNNuKclXApU/
         hJEMcuvSmgmJILxb4XIl9nXV3RruWDS8aBh90CPtIMzqV3DIA2hTUiN8PL4c0Wrskd
         6+pkAC4Ty07Lp7zMVtNbXJrRy3QTGuck/nXDQML5P+Ds7IVgI0Hbc2GhdPB5wK6luk
         ajuNuEN2p4LkYjKgj+dZn9p9fqk7AXcPhS5gWV5jZbMXB28WXD2qXa7nfBYgFdmKq+
         PZXlOhNNcjN8PwllvNFg0Mn00GFZwD2foXfjPCXUP+pwzFskuMCWFfgnCkZiUJkZj5
         1XZJF3x2FPREA==
Date:   Mon, 6 Feb 2023 21:20:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - add diff-splits of src/dst into
 default cipher config
Message-ID: <Y+HfjH0YVYdX+BFq@sol.localdomain>
References: <20230202083805.21838-1-zhangyiqun@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202083805.21838-1-zhangyiqun@phytium.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:38:05PM +0800, Zhang Yiqun wrote:
> This type of request is often happened in AF_ALG cases.
> So add this vector in default cipher config array.
> 
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> ---
>  crypto/testmgr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 4476ac97baa5..6e8d08999104 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -356,6 +356,14 @@ static const struct testvec_config default_cipher_testvec_configs[] = {
>  			{ .proportion_of_total = 5000 },
>  			{ .proportion_of_total = 5000 },
>  		},
> +	}, {
> +		.name = "one src, two even splits dst",
> +		.inplace_mode = OUT_OF_PLACE,
> +		.src_divs = { { .proportion_of_total = 10000 } },
> +		.dst_divs = {
> +			{ .proportion_of_total = 5000 },
> +			{ .proportion_of_total = 5000 },
> +		 },
>  	}, {
>  		.name = "uneven misaligned splits, may sleep",
>  		.req_flags = CRYPTO_TFM_REQ_MAY_SLEEP,
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
