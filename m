Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6C60DAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiJZFzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiJZFzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD6437E2;
        Tue, 25 Oct 2022 22:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52AB761CE4;
        Wed, 26 Oct 2022 05:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7CC433C1;
        Wed, 26 Oct 2022 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666763708;
        bh=8+rM/FGEitKFjhRuQ68f+Jw14IctZ4UiyrnOLxUonQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrL4SIAO04f3nBCO0CEqmO+q7EsH1h8pKudxFveiVihCQOKSsoArGN5pjUad+g9hE
         nGj33BGhdjox442rjmejzq14qeWsGaX9k8g/+lYWXRy74Pmk7XFRYSJaw063z3/qzM
         s9XQEqmCsQ7TnSCFaWKzAKVvK9wXa8KtuFdThXBE=
Date:   Wed, 26 Oct 2022 07:56:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 1/8] LSM: Identify modules by more than name
Message-ID: <Y1jL8ZiCO+a7n8Wz@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-2-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-2-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:12AM -0700, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> a single member, which is the name of the module. Change the
> security_add_hooks() interface to use this structure. Change
> the individual modules to maintain their own struct lsm_id and
> pass it to security_add_hooks().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h    | 11 +++++++++--
>  security/apparmor/lsm.c      |  6 +++++-
>  security/bpf/hooks.c         | 11 ++++++++++-
>  security/commoncap.c         |  6 +++++-
>  security/landlock/cred.c     |  2 +-
>  security/landlock/fs.c       |  2 +-
>  security/landlock/ptrace.c   |  2 +-
>  security/landlock/setup.c    |  4 ++++
>  security/landlock/setup.h    |  1 +
>  security/loadpin/loadpin.c   |  7 ++++++-
>  security/lockdown/lockdown.c |  6 +++++-
>  security/safesetid/lsm.c     |  7 ++++++-
>  security/security.c          | 12 ++++++------
>  security/selinux/hooks.c     |  7 ++++++-
>  security/smack/smack_lsm.c   |  6 +++++-
>  security/tomoyo/tomoyo.c     |  7 ++++++-
>  security/yama/yama_lsm.c     |  6 +++++-
>  17 files changed, 82 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..e383e468f742 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1602,6 +1602,13 @@ struct security_hook_heads {
>  	#undef LSM_HOOK
>  } __randomize_layout;
>  
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;		/* Name of the LSM */

Based on the "unsigned vs. signed char" discussion happening on lkml
right now, this should really be "u8".

Also, can you use kerneldoc formatting so that the field name is not
after the variable, but above it in the comment, so that the kernel doc
tools will properly pick it up?

And what is going to guarantee the uniqueness of this string?

thanks,

greg k-h
