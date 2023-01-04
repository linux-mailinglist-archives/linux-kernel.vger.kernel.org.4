Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338865D2B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbjADMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjADMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:31:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6DFCDC;
        Wed,  4 Jan 2023 04:31:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97ED76141B;
        Wed,  4 Jan 2023 12:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8437C433D2;
        Wed,  4 Jan 2023 12:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672835475;
        bh=TS1eRADAwtsICh+WYhgcEE7ywnYS5xNwOmdPOvBMuuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev46Sg1uRedN6plR7JXX+dH8bN38+vYwuymqfGXUcFSIjQbq2rGDiNqKSoiRaTKQ7
         OB67NyWXK2MYJ73x2MaureToMeM/AQXoD2u4F+OLypuPDZtYW/w2E36HuqBgSBcNJM
         RqbUJ40TD3h+rhHcnIuD3BhTtVWCrkNIxgQZvOAPHmunbk2AT9sDrSIXoiyVMvMDhl
         Ne1wtTc8EI0nveYyEM3L+nycwBCkQel0y8TJzZAKnz8MUHLWT0LhEB6UvjM74CGbNc
         oGWtLrAON4ymqruvUEEIhkGU7iI8Kla1eRzx6wc6OBgCm1g9YBS0I+ppBNwVGlA8+i
         E2cwMkCUQxIfw==
Date:   Wed, 4 Jan 2023 12:31:12 +0000
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
Subject: Re: [PATCH v4 1/3] certs: make blacklisted hash available in klog
Message-ID: <Y7VxkG0ZsfJEyuFP@kernel.org>
References: <20221212-keys-blacklist-v4-0-00afeb3137fb@weissschuh.net>
 <20221212-keys-blacklist-v4-1-00afeb3137fb@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212-keys-blacklist-v4-1-00afeb3137fb@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:08:22AM +0000, Thomas Weiﬂschuh wrote:
> One common situation triggering this log statement are duplicate hashes
> reported by the system firmware.
> 
> These duplicates should be removed from the firmware.
> 
> Without logging the blacklisted hash triggering the issue however the users
> can not report it properly to the firmware vendors and the firmware vendors
> can not easily see which specific hash is duplicated.
> 
> While changing the log message also use the dedicated ERR_PTR format
> placeholder for the returned error value.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  certs/blacklist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 41f10601cc72..6e260c4b6a19 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -192,7 +192,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
>  				   KEY_ALLOC_NOT_IN_QUOTA |
>  				   KEY_ALLOC_BUILT_IN);
>  	if (IS_ERR(key)) {
> -		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
> +		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
>  		return PTR_ERR(key);
>  	}
>  	return 0;
> 
> -- 
> 2.39.0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
