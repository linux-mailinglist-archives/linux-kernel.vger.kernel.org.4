Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91760DAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiJZGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiJZGAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C6B56DE;
        Tue, 25 Oct 2022 23:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0164FB81F42;
        Wed, 26 Oct 2022 06:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D205C433D6;
        Wed, 26 Oct 2022 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666764003;
        bh=V7hGlTMiOpQOdktPhd0dorsnF1D2hXM+7RTnQYhztnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1Pxrhrq2RZvcFCJm44OUhCFiINAV/WNdw9P5IARe8zg3uK4Y9jYzwQWTbcI+PQ6A
         HWFSBlaE+k+CMYkK8aMekjhOmmHgfXvzTnCZRJjfZbWphT3AZQrwsAvDohql3npSco
         O/+V4wG9oEiSAQMyRkhMk0ELo7bwGFziKlDbtkoU=
Date:   Wed, 26 Oct 2022 08:00:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Message-ID: <Y1jNGMKfb+NUPrJS@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 17 +++++++++++++++++
>  security/security.c      | 18 ++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ca1b7109c0db..e1678594d983 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -138,6 +138,23 @@ enum lockdown_reason {
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>  
> +#define LSMID_ENTRIES ( \
> +	1 + /* capabilities */ \

No #define for capabilities?

> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> +
> +extern int lsm_id;

u64?

thanks,

greg k-h
