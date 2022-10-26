Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC97C60DAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiJZF7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJZF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60EAB3B0F;
        Tue, 25 Oct 2022 22:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3783961CE4;
        Wed, 26 Oct 2022 05:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F29C433C1;
        Wed, 26 Oct 2022 05:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666763940;
        bh=NLqLVai4U31syDts05OugswrP3rn8NY2PZmT9SycAN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLbr9AT5y4NoFueDmIc+4+aBU2fX9VxQrWpR66w3Mm307/H8lPe+gKwwtG9vsnPJ+
         pXJ9tXkVOrP51QR1DTj8+IO2wi9wD0vINHJ22l6a5B4+OKE9QQJsz+YYNn1UO0t5d6
         mxtMD+L/pMo+RLHqEg43RjgZtqsO6EOv8aMvA7bg=
Date:   Wed, 26 Oct 2022 07:59:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 3/8] LSM: Identify the process attributes for each
 module
Message-ID: <Y1jM2SoKbCQ4/bsd@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-4-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:14AM -0700, Casey Schaufler wrote:
> Add an integer member "features" to the struct lsm_id which
> identifies the API related data associated with each security
> module. The initial set of features maps to information that
> has traditionaly been available in /proc/self/attr.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  include/uapi/linux/lsm.h   | 14 ++++++++++++++
>  security/apparmor/lsm.c    |  1 +
>  security/selinux/hooks.c   |  2 ++
>  security/smack/smack_lsm.c |  1 +
>  5 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dd4b4d95a172..46b2aa6a677e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1608,6 +1608,7 @@ struct security_hook_heads {
>  struct lsm_id {
>  	const char	*lsm;		/* Name of the LSM */
>  	int		id;		/* LSM ID */
> +	int		features;	/* Set of LSM features */

Again, be explicit about size please.  And documentation.

>  };
>  
>  /*
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index d5bcbb9375df..61e13b1b9ece 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -29,4 +29,18 @@
>  #define LSM_ID_BPF		42
>  #define LSM_ID_LANDLOCK		43
>  
> +/*
> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
> + * context represents. Not all security modules provide all of these
> + * values. Some security modules provide none of them.
> + */
> +/* clang-format off */

Why this comment?  That shouldn't be in uapi files.  Or any header
files.

> +#define LSM_ATTR_CURRENT	(1UL << 0)
> +#define LSM_ATTR_EXEC		(1UL << 1)
> +#define LSM_ATTR_FSCREATE	(1UL << 2)
> +#define LSM_ATTR_KEYCREATE	(1UL << 3)
> +#define LSM_ATTR_PREV		(1UL << 4)
> +#define LSM_ATTR_SOCKCREATE	(1UL << 5)
> +/* clang-format on */

Again, please drop.

Where is it documented what these attributes actually mean?

thanks,

greg k-h
