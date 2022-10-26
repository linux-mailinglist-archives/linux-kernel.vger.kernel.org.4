Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A060DACB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiJZF52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJZF5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796A9DFAB;
        Tue, 25 Oct 2022 22:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E8161CE4;
        Wed, 26 Oct 2022 05:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A85C433D7;
        Wed, 26 Oct 2022 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666763844;
        bh=u/Tg8s3UpDgeoVclFwEvMCWrAfTB5BdmnJUYeICyxRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFkNfrpa5U4W6tHIcNaSS5VoyxQFYcpSEaRo7VAVafm3xeMfqzloxwT69cUyhBaT4
         pM33M+o+xvW6obU45dg5NzfpbvXG5bL1MeTqyOd9KRMOkbuIL4JKfFFOaf89vYQBDk
         kL5b4hwniARRiDJ7DnJbNr3GRDEUrLQpIKylfW3s=
Date:   Wed, 26 Oct 2022 07:58:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Message-ID: <Y1jMeWl0oV4/2zyE@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-3-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:13AM -0700, Casey Schaufler wrote:
> Add an integer member "id" to the struct lsm_id. This value is
> a unique identifier associated with each security module. The
> values are defined in a new UAPI header file. Each existing LSM
> has been updated to include it's LSMID in the lsm_id.
> 
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing
> modules numbered in the order they were included in the
> main line kernel. The first 32 values (0 - 31) are reserved
> for some as yet unknown but important use.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h    |  1 +
>  include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c      |  2 ++
>  security/bpf/hooks.c         |  2 ++
>  security/commoncap.c         |  2 ++
>  security/landlock/setup.c    |  2 ++
>  security/loadpin/loadpin.c   |  2 ++
>  security/lockdown/lockdown.c |  2 ++
>  security/safesetid/lsm.c     |  2 ++
>  security/selinux/hooks.c     |  2 ++
>  security/smack/smack_lsm.c   |  2 ++
>  security/tomoyo/tomoyo.c     |  2 ++
>  security/yama/yama_lsm.c     |  2 ++
>  13 files changed, 55 insertions(+)
>  create mode 100644 include/uapi/linux/lsm.h
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index e383e468f742..dd4b4d95a172 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1607,6 +1607,7 @@ struct security_hook_heads {
>   */
>  struct lsm_id {
>  	const char	*lsm;		/* Name of the LSM */
> +	int		id;		/* LSM ID */

Again, kerneldoc.

And if this crosses the user/kernel boundry, please make it __u64.  Or
__s32?  Something explicit please.

>  };
>  
>  /*
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..d5bcbb9375df
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linus Security Modules (LSM) - User space API

s/Linus/Linux/.


> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) Intel Corporation

No date for Intel?

> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +/*
> + * ID values to identify security modules.
> + * A system may use more than one security module.
> + *
> + * LSM_ID_XXX values 0 - 31 are reserved for future use

Reserved for what?  Why?

thanks,

greg k-h
