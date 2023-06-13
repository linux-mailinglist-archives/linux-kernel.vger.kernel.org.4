Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3872E68B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbjFMPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242727AbjFMPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:02:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99150E56
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE8462FDE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6836C433F0;
        Tue, 13 Jun 2023 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686668554;
        bh=8Umx/kFk8/RvM+evuOYakjTUkMDLceHez9M35EHnaIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8NDowzvc1+V4vNOoTOiq8FGf6dry5+ixkm+/gXKiK5/M52s4/ItM/ChMF8GqapF2
         yk/mqRrTJGEq30jIO80ilSAtP6IvxPPfzFlIlS4xIJR9c2GyoyGnfdB7W9CoP7mIPx
         XsxQ06gLAKi3FwhAzUYCqYqy/vZpdGaJg3qbNq9Q=
Date:   Tue, 13 Jun 2023 17:02:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: Add debugfs file for forcing field writes
Message-ID: <2023061322-garter-linseed-6dfe@gregkh>
References: <pnd1qifa7sj.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pnd1qifa7sj.fsf@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:42:27PM +0200, Waqar Hameed wrote:
> `_regmap_update_bits()` checks if the current register value differs
> from the new value, and only writes to the register if they differ. When
> testing hardware drivers, it might be desirable to always force a
> register write, for example when writing to a `regmap_field`. This
> enables and simplifies testing and verification of the hardware
> interaction. For example, when using a hardware mock/simulation model,
> one can then more easily verify that the driver makes the correct
> expected register writes during certain events.
> 
> Add a bool variable `force_write_field` and a corresponding debugfs
> entry to enable this. Since this feature could interfere with driver
> operation, guard it with a macro.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
> * Add macro to guard the debugfs entry.
> * Fix `Signed-off-by` in commit message to match actual email address.
> * Link to v1: https://lore.kernel.org/all/pndttvcu3ut.fsf@axis.com/
> 
>  drivers/base/regmap/internal.h       |  3 +++
>  drivers/base/regmap/regmap-debugfs.c | 11 +++++++++++
>  drivers/base/regmap/regmap.c         |  2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index 9bd0dfd1e259..6472b3222b82 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -125,6 +125,9 @@ struct regmap {
>  	int reg_stride;
>  	int reg_stride_order;
>  
> +	/* If set, will always write field to HW. */
> +	bool force_write_field;
> +
>  	/* regcache specific members */
>  	const struct regcache_ops *cache_ops;
>  	enum regcache_type cache_type;
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index c491fabe3617..f36027591e1a 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -636,6 +636,17 @@ void regmap_debugfs_init(struct regmap *map)
>  				    &regmap_cache_bypass_fops);
>  	}
>  
> +	/*
> +	 * This could interfere with driver operation. Therefore, don't provide
> +	 * any real compile time configuration option for this feature. One will
> +	 * have to modify the source code directly in order to use it.
> +	 */
> +#undef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> +#ifdef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> +	debugfs_create_bool("force_write_field", 0600, map->debugfs,
> +			    &map->force_write_field);
> +#endif

Please no, that means this will never ever ever get used, and if it
happens to break the build or runtime, no one will ever notice it.

If you need this for your device/tree/distro, great, just keep it as an
out-of-tree patch with the huge header "NEVER ENABLE THIS IN A REAL
SYSTEM" or something like that.

But as-is, we can't take this, sorry.

greg k-h
