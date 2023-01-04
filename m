Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368465D2C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjADMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjADMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:34:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0BFCDC;
        Wed,  4 Jan 2023 04:34:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847736142A;
        Wed,  4 Jan 2023 12:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D831C433EF;
        Wed,  4 Jan 2023 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672835661;
        bh=BNpkNAQs+LtXaV3gCdiS/EylpKApCKA/YbkYZzRg+vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrIifA3tv/KKms2CNXkON0xG6whoCAmiFyLeOMmJLX+Yu3gYEEke7xke4oRtWTDIa
         iJa4lg9mHk8hBKm8Rzhxu6VZTgcjBvxHmMSiXoStD4uVc9DZdoJ5l9FhK3/FZsNRna
         +SSC3d9/raSAR+KSOHDNrZqdaXc1NyMY88I/KTWHkZ5xJLkxwusq/5pDh596bEqkJ6
         ACq0KXnhXbb73pfFMPTAeExe2WL5YzPR8W9dW9GGRcVvKpx2zELNMc6RIPtvY4k/xb
         isewaApkVPHDU574k6Gbo7S/sQyOaFDvezr/xfPBjgLxNTbtmoEt6Ep1MdnM/+6m2s
         mz6MjjQiQcInw==
Date:   Wed, 4 Jan 2023 12:34:19 +0000
From:   ", Jarkko Sakkinen" <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH v4 2/3] KEYS: Add new function key_create()
Message-ID: <Y7VyS8ykmcglAgRv@kernel.org>
References: <20221212-keys-blacklist-v4-0-00afeb3137fb@weissschuh.net>
 <20221212-keys-blacklist-v4-2-00afeb3137fb@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212-keys-blacklist-v4-2-00afeb3137fb@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:08:23AM +0000, Thomas Weiﬂschuh wrote:
> key_create() works like key_create_or_update() but does not allow
> updating an existing key, instead returning ERR_PTR(-EEXIST).
> 
> key_create() will be used by the blacklist keyring which should not
> create duplicate entries or update existing entries.
> Instead a dedicated message with appropriate severity will be logged.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  include/linux/key.h |   8 +++
>  security/keys/key.c | 149 +++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 120 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index d27477faf00d..8dc7f7c3088b 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -386,6 +386,14 @@ extern int wait_for_key_construction(struct key *key, bool intr);
>  
>  extern int key_validate(const struct key *key);
>  
> +extern key_ref_t key_create(key_ref_t keyring,
> +			    const char *type,
> +			    const char *description,
> +			    const void *payload,
> +			    size_t plen,
> +			    key_perm_t perm,
> +			    unsigned long flags);
> +
>  extern key_ref_t key_create_or_update(key_ref_t keyring,
>  				      const char *type,
>  				      const char *description,
> diff --git a/security/keys/key.c b/security/keys/key.c
> index c45afdd1dfbb..f84bcd8457f4 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -788,38 +788,18 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
>  	goto out;
>  }
>  
> -/**
> - * key_create_or_update - Update or create and instantiate a key.
> - * @keyring_ref: A pointer to the destination keyring with possession flag.
> - * @type: The type of key.
> - * @description: The searchable description for the key.
> - * @payload: The data to use to instantiate or update the key.
> - * @plen: The length of @payload.
> - * @perm: The permissions mask for a new key.
> - * @flags: The quota flags for a new key.
> - *
> - * Search the destination keyring for a key of the same description and if one
> - * is found, update it, otherwise create and instantiate a new one and create a
> - * link to it from that keyring.
> - *
> - * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
> - * concocted.
> - *
> - * Returns a pointer to the new key if successful, -ENODEV if the key type
> - * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
> - * caller isn't permitted to modify the keyring or the LSM did not permit
> - * creation of the key.
> - *
> - * On success, the possession flag from the keyring ref will be tacked on to
> - * the key ref before it is returned.
> +/*
> + * Create or potentially update a key. The combined logic behind
> + * key_create_or_update() and key_create()
>   */
> -key_ref_t key_create_or_update(key_ref_t keyring_ref,
> -			       const char *type,
> -			       const char *description,
> -			       const void *payload,
> -			       size_t plen,
> -			       key_perm_t perm,
> -			       unsigned long flags)
> +static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
> +					const char *type,
> +					const char *description,
> +					const void *payload,
> +					size_t plen,
> +					key_perm_t perm,
> +					unsigned long flags,
> +					bool allow_update)
>  {
>  	struct keyring_index_key index_key = {
>  		.description	= description,
> @@ -906,14 +886,23 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> -	/* if it's possible to update this type of key, search for an existing
> -	 * key of the same type and description in the destination keyring and
> -	 * update that instead if possible
> +	/* if it's requested and possible to update this type of key, search
> +	 * for an existing key of the same type and description in the
> +	 * destination keyring and update that instead if possible
>  	 */
> -	if (index_key.type->update) {
> +	if (allow_update) {
> +		if (index_key.type->update) {
> +			key_ref = find_key_to_update(keyring_ref, &index_key);
> +			if (key_ref)
> +				goto found_matching_key;
> +		}
> +	} else {
>  		key_ref = find_key_to_update(keyring_ref, &index_key);
> -		if (key_ref)
> -			goto found_matching_key;
> +		if (key_ref) {
> +			key_ref_put(key_ref);
> +			key_ref = ERR_PTR(-EEXIST);
> +			goto error_link_end;
> +		}
>  	}
>  
>  	/* if the client doesn't provide, decide on the permissions we want */
> @@ -985,8 +974,94 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  
>  	goto error_free_prep;
>  }
> +
> +/**
> + * key_create_or_update - Update or create and instantiate a key.
> + * @keyring_ref: A pointer to the destination keyring with possession flag.
> + * @type: The type of key.
> + * @description: The searchable description for the key.
> + * @payload: The data to use to instantiate or update the key.
> + * @plen: The length of @payload.
> + * @perm: The permissions mask for a new key.
> + * @flags: The quota flags for a new key.
> + *
> + * Search the destination keyring for a key of the same description and if one
> + * is found, update it, otherwise create and instantiate a new one and create a
> + * link to it from that keyring.
> + *
> + * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
> + * concocted.
> + *
> + * Returns a pointer to the new key if successful, -ENODEV if the key type
> + * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
> + * caller isn't permitted to modify the keyring or the LSM did not permit
> + * creation of the key.
> + *
> + * On success, the possession flag from the keyring ref will be tacked on to
> + * the key ref before it is returned.
> + */
> +key_ref_t key_create_or_update(key_ref_t keyring_ref,
> +			       const char *type,
> +			       const char *description,
> +			       const void *payload,
> +			       size_t plen,
> +			       key_perm_t perm,
> +			       unsigned long flags)
> +{
> +	return __key_create_or_update(keyring_ref,
> +				      type,
> +				      description,
> +				      payload,
> +				      plen,
> +				      perm,
> +				      flags,
> +				      true);
> +}
>  EXPORT_SYMBOL(key_create_or_update);
>  
> +/**
> + * key_create - Create and instantiate a key.
> + * @keyring_ref: A pointer to the destination keyring with possession flag.
> + * @type: The type of key.
> + * @description: The searchable description for the key.
> + * @payload: The data to use to instantiate or update the key.
> + * @plen: The length of @payload.
> + * @perm: The permissions mask for a new key.
> + * @flags: The quota flags for a new key.
> + *
> + * Create and instantiate a new key and link to it from the destination keyring.
> + *
> + * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
> + * concocted.
> + *
> + * Returns a pointer to the new key if successful, -EEXIST if a key with the
> + * same description already exists, -ENODEV if the key type wasn't available,
> + * -ENOTDIR if the keyring wasn't a keyring, -EACCES if the caller isn't
> + * permitted to modify the keyring or the LSM did not permit creation of the
> + * key.
> + *
> + * On success, the possession flag from the keyring ref will be tacked on to
> + * the key ref before it is returned.
> + */
> +key_ref_t key_create(key_ref_t keyring_ref,
> +		     const char *type,
> +		     const char *description,
> +		     const void *payload,
> +		     size_t plen,
> +		     key_perm_t perm,
> +		     unsigned long flags)
> +{
> +	return __key_create_or_update(keyring_ref,
> +				      type,
> +				      description,
> +				      payload,
> +				      plen,
> +				      perm,
> +				      flags,
> +				      false);

I'd consider:

        return __key_create_or_update(keyring_ref, type, description, payload, plen, perm, flags,
	                              false);

I don't see any logical reason to spread this to 8 lines.


> +}
> +EXPORT_SYMBOL(key_create);
> +
>  /**
>   * key_update - Update a key's contents.
>   * @key_ref: The pointer (plus possession flag) to the key.
> 
> -- 
> 2.39.0

BR, Jarkko
