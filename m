Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475656C1621
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjCTPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjCTPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0E3C25;
        Mon, 20 Mar 2023 07:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451CD61582;
        Mon, 20 Mar 2023 14:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91810C433D2;
        Mon, 20 Mar 2023 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679324304;
        bh=9NBq/XA6M1Wf/4O3DnQ3RUmHZrzWtpFs7WveRpHGKh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuY/xnYIk2oPVsMR6H7VEiU00Me7r/Ic6JxUQVEt5F6VKPyDmfWwGQRn+oB4CIIdX
         MtLEJEbeEzGlPevscuS4+n+w5847wrreEaUMkfI2Ly/2zLohF77h6c8wTA91xLmR/Y
         97pfSZYY/kBltknpTcaIQxiwWOoq0FdmNnK0oFH+jDEoGox+N+bo8mhDpwQqppUwqB
         wlKMwuVnP8g/QAcLsnFTUQhmYTWAqle+cVjIr5Sj+HrHJNhlUQ8Ul9U9j4slYClgsB
         xnXgVU8ZGlhOP/NMt2wnZLcC5pkPsAreX4MqJBmOqM0SrIgtofF+dZYJ3F2nuK3h1R
         ERwc9h2+5T50A==
Date:   Mon, 20 Mar 2023 07:58:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2, RESEND 07/10] xfs: convert to kobject_del_and_put()
Message-ID: <20230320145824.GZ11376@frogsfrogsfrogs>
References: <20230319092641.41917-1-frank.li@vivo.com>
 <20230319092641.41917-7-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319092641.41917-7-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 05:26:38PM +0800, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Looks good to me,
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_sysfs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
> index 148893ebfdef..e2ff063e2c29 100644
> --- a/fs/xfs/xfs_sysfs.h
> +++ b/fs/xfs/xfs_sysfs.h
> @@ -48,8 +48,7 @@ static inline void
>  xfs_sysfs_del(
>  	struct xfs_kobj	*kobj)
>  {
> -	kobject_del(&kobj->kobject);
> -	kobject_put(&kobj->kobject);
> +	kobject_del_and_put(&kobj->kobject);
>  	wait_for_completion(&kobj->complete);
>  }
>  
> -- 
> 2.35.1
> 
