Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69D96916F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBJC5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBJC5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E5721CE;
        Thu,  9 Feb 2023 18:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A7A61C61;
        Fri, 10 Feb 2023 02:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DB7C433D2;
        Fri, 10 Feb 2023 02:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675997838;
        bh=vlHhIdXTS5oFgxZgdZsqhtogZeGRy0OIjcjtrlIXonU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbrzFKje4/6nT96au/fRqGfHLCL0NCIPsGoLEsaqaCz6CKb37L+UE4PJ3AzQM0qDx
         Ijadx8FLFxyuCHV4285wBvfAW8DeuxmXjgAzDjrAAwQSu1mnIH/6GcwsYA969fRCJ8
         mMp1isXBM2+sCay1Z7ees8/O7syp3VbQHwffYua92pjpE36cdXAR7y3n7fknnDz7V/
         aQYoHygIBVIhgJQs6JscvZxBsvgH5tzBRuk74vFKJpjFaSDSicrRIsoySVL/giheTT
         INGKdMz5tXJFNcNxpLu3hPDrmHLW+FreJQ7Fgb+MoXa5BY+4I7OVAqKlSLP2U8X4zV
         uJzEuqCl0vBZw==
Date:   Thu, 9 Feb 2023 18:57:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: make kobj_type structures constant
Message-ID: <Y+WyjVE3Bn1x+gKx@magnolia>
References: <20230209-kobj_type-xfs-v1-1-9d3bd77715f3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209-kobj_type-xfs-v1-1-9d3bd77715f3@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 03:16:43AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_error.c |  2 +-
>  fs/xfs/xfs_sysfs.c | 12 ++++++------
>  fs/xfs/xfs_sysfs.h | 10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
> index ae082808cfed..b2cbbba3e15a 100644
> --- a/fs/xfs/xfs_error.c
> +++ b/fs/xfs/xfs_error.c
> @@ -228,7 +228,7 @@ static struct attribute *xfs_errortag_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_errortag);
>  
> -static struct kobj_type xfs_errortag_ktype = {
> +static const struct kobj_type xfs_errortag_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_errortag_sysfs_ops,
>  	.default_groups = xfs_errortag_groups,
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index f7faf6e70d7f..a3c6b1548723 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -69,7 +69,7 @@ static struct attribute *xfs_mp_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_mp);
>  
> -struct kobj_type xfs_mp_ktype = {
> +const struct kobj_type xfs_mp_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  	.default_groups = xfs_mp_groups,
> @@ -266,7 +266,7 @@ static struct attribute *xfs_dbg_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_dbg);
>  
> -struct kobj_type xfs_dbg_ktype = {
> +const struct kobj_type xfs_dbg_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  	.default_groups = xfs_dbg_groups,
> @@ -324,7 +324,7 @@ static struct attribute *xfs_stats_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_stats);
>  
> -struct kobj_type xfs_stats_ktype = {
> +const struct kobj_type xfs_stats_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  	.default_groups = xfs_stats_groups,
> @@ -410,7 +410,7 @@ static struct attribute *xfs_log_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_log);
>  
> -struct kobj_type xfs_log_ktype = {
> +const struct kobj_type xfs_log_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  	.default_groups = xfs_log_groups,
> @@ -564,13 +564,13 @@ static struct attribute *xfs_error_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(xfs_error);
>  
> -static struct kobj_type xfs_error_cfg_ktype = {
> +static const struct kobj_type xfs_error_cfg_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  	.default_groups = xfs_error_groups,
>  };
>  
> -static struct kobj_type xfs_error_ktype = {
> +static const struct kobj_type xfs_error_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
>  };
> diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
> index 513095e353a5..148893ebfdef 100644
> --- a/fs/xfs/xfs_sysfs.h
> +++ b/fs/xfs/xfs_sysfs.h
> @@ -7,10 +7,10 @@
>  #ifndef __XFS_SYSFS_H__
>  #define __XFS_SYSFS_H__
>  
> -extern struct kobj_type xfs_mp_ktype;	/* xfs_mount */
> -extern struct kobj_type xfs_dbg_ktype;	/* debug */
> -extern struct kobj_type xfs_log_ktype;	/* xlog */
> -extern struct kobj_type xfs_stats_ktype;	/* stats */
> +extern const struct kobj_type xfs_mp_ktype;	/* xfs_mount */
> +extern const struct kobj_type xfs_dbg_ktype;	/* debug */
> +extern const struct kobj_type xfs_log_ktype;	/* xlog */
> +extern const struct kobj_type xfs_stats_ktype;	/* stats */
>  
>  static inline struct xfs_kobj *
>  to_kobj(struct kobject *kobject)
> @@ -28,7 +28,7 @@ xfs_sysfs_release(struct kobject *kobject)
>  static inline int
>  xfs_sysfs_init(
>  	struct xfs_kobj		*kobj,
> -	struct kobj_type	*ktype,
> +	const struct kobj_type	*ktype,
>  	struct xfs_kobj		*parent_kobj,
>  	const char		*name)
>  {
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-xfs-c1670289be86
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
