Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4365D2CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjADMfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjADMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:35:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9EF1ADBF;
        Wed,  4 Jan 2023 04:35:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D510B8162F;
        Wed,  4 Jan 2023 12:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF41C433EF;
        Wed,  4 Jan 2023 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672835709;
        bh=j6ukuFCDMc/hoZSsjDxvJ0xbGxxQjsTmxFt/xDHTJvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdcUCQzsCsWNQG52YXqCwSsAQBQbKiBelpFdOLzso+REJ3Bti7ODvy79YwZw0RqN0
         /4dUsFSSy0GVpjIorkAVjH9OBvkxzTmmtulrtD3IfMHkRFvE2lVsJDphlq18vIJwXf
         pYJsCC0LMgC0iZ6jypMg2+SVDiIylv8hy0GEf1yHD0OXNkDzWNHvFVwum+v2NDAy+f
         TqfHGlWOoIqa0nA7Qmb7aExe2cIGQN6avJSWQ0/hXdE7pTwHd11kveX+NcY5B0+JAX
         +jOUgkgbAWOSm82EKYBUm8gX4wawBTk9f/IClGQ7ZyLoZQond+Yu2ATc4eFa7cvUlR
         xsNJoDXEe1voQ==
Date:   Wed, 4 Jan 2023 12:35:06 +0000
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
Subject: Re: [PATCH v4 3/3] certs: don't try to update blacklist keys
Message-ID: <Y7Vyet6+pytBDOeR@kernel.org>
References: <20221212-keys-blacklist-v4-0-00afeb3137fb@weissschuh.net>
 <20221212-keys-blacklist-v4-3-00afeb3137fb@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212-keys-blacklist-v4-3-00afeb3137fb@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:08:24AM +0000, Thomas Weiﬂschuh wrote:
> When the same key is blacklisted repeatedly logging at pr_err() level is
> excessive as no functionality is impaired.
> When these duplicates are provided by buggy firmware there is nothing
> the user can do to fix the situation.
> Instead of spamming the bootlog with errors we use a warning that can
> still be seen by OEMs when testing their firmware.
> 
> Link: https://lore.kernel.org/all/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
> Link: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  certs/blacklist.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 6e260c4b6a19..675dd7a8f07a 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -183,16 +183,19 @@ static int mark_raw_hash_blacklisted(const char *hash)
>  {
>  	key_ref_t key;
>  
> -	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
> -				   "blacklist",
> -				   hash,
> -				   NULL,
> -				   0,
> -				   BLACKLIST_KEY_PERM,
> -				   KEY_ALLOC_NOT_IN_QUOTA |
> -				   KEY_ALLOC_BUILT_IN);
> +	key = key_create(make_key_ref(blacklist_keyring, true),
> +			 "blacklist",
> +			 hash,
> +			 NULL,
> +			 0,
> +			 BLACKLIST_KEY_PERM,
> +			 KEY_ALLOC_NOT_IN_QUOTA |
> +			 KEY_ALLOC_BUILT_IN);
>  	if (IS_ERR(key)) {
> -		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
> +		if (PTR_ERR(key) == -EEXIST)
> +			pr_warn("Duplicate blacklisted hash %s\n", hash);
> +		else
> +			pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
>  		return PTR_ERR(key);
>  	}
>  	return 0;
> 
> -- 
> 2.39.0

Reviewed-by: Jarkko Sakkinen <jarko@kernel.org>

BR, Jarkko
