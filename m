Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3875FBE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJKXHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJKXHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C143179;
        Tue, 11 Oct 2022 16:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95A3FB80EA9;
        Tue, 11 Oct 2022 23:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F92EC433C1;
        Tue, 11 Oct 2022 23:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665529650;
        bh=SErtSIzqJxf+58W8QNfx55+T8mc2aypbI8+RKkBM1NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKxbc3kMqi/LJTyTUGXFRLKx3dYkrBmlCOsXgRH+zLTGOe+s+BU6aFd36t2Fg4GT0
         wu4xJ9phEcXV7ySn8/qU7s/u555o2LpoE5VCCEwPnmcaPdhy5qVg5H9EADieyF6LSc
         wWNK21Ze42XzpKMuOyRkRNIcBcmGVbP7Hohe2bsBQ9XbshxFIuLmJgcRa2w9sgLcqD
         UMLJKusnEJqS/GnkDEUDukGMoHbXSR6wmyxdVX0eewKY2/TXm0Eyb0qoLBC/T0NIsU
         RD64piGKrTIqnQ+Rhc2ISuGdI0wAdbZaln5POCyVJUbQyjaJ0FmLRPSNcYPU+Bb/GK
         eOXuzAdtvtvoA==
Date:   Tue, 11 Oct 2022 16:07:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, hch@lst.de,
        smueller@chronox.de, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel-team@cloudflare.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [RFC PATCH 1/1] crypto: af_alg - Support symmetric encryption
 via keyring keys
Message-ID: <Y0X3L/jhinCqJXxj@sol.localdomain>
References: <20221004212927.1539105-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004212927.1539105-1-fred@cloudflare.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On Tue, Oct 04, 2022 at 04:29:27PM -0500, Frederick Lawler wrote:
> We want to leverage keyring to store sensitive keys, and then use those
> keys for symmetric encryption via the crypto API. Among the key types we
> wish to support are: user, logon, encrypted, and trusted.
> 
> User key types are already able to have their data copied to user space,
> but logon does not support this. Further, trusted and encrypted keys will
> return their encrypted data back to user space on read, which make them not
> ideal for symmetric encryption.
> 
> To support symmetric encryption for these key types, add a new
> ALG_SET_KEY_BY_KEY_SERIAL setsockopt() option to the crypto API. This
> allows users to pass a key_serial_t to the crypto API to perform
> symmetric encryption. The behavior is the same as ALG_SET_KEY, but
> the crypto key data is copied in kernel space from a keyring key,
> which allows for the support of logon, encrypted, and trusted key types.
> 
> Keyring keys must have the KEY_(POS|USR|GRP|OTH)_SEARCH permission set
> to leverage this feature. This follows the asymmetric_key type where key
> lookup calls eventually lead to keyring_search_rcu() without the
> KEYRING_SEARCH_NO_CHECK_PERM flag set.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

There was a similar patch several years ago by Ondrej Mosnacek:
https://lore.kernel.org/linux-crypto/20190521100034.9651-1-omosnace@redhat.com/T/#u

Have you addressed all the feedback that was raised on that one?

Two random nits below:

> +	*dest_len = key->datalen;
> +	*dest = kmalloc(*dest_len, GFP_KERNEL);
> +	if (!*dest)
> +		return -ENOMEM;
> +
> +	memcpy(*dest, ukp->data, *dest_len);

This should use kmemdup().

> +	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
> +			   !strcmp(key->type->name, "encrypted")) {
> +		read_key = &read_key_type_encrypted;
> +	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
> +			   !strcmp(key->type->name, "trusted")) {
> +		read_key = &read_key_type_trusted;

These need to use IS_REACHABLE(), not IS_ENABLED().

- Eric
