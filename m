Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B704622DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiKIOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKIOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:22:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF61F9D0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:21:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60B6EB81F05
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B39C433D6;
        Wed,  9 Nov 2022 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668003659;
        bh=qZkVydHoGkCBeu5yERvjFg6CPgR0Y609bznL/hnuNW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHSFKgQtE+uEL8VluDAAZHtHR4M24OhfOyDN8vxeFXT8qPp1s8ELqg5WvFlgVD0tk
         8cMaEJRCpVku604D579wca05kDnvey5MrSFJ95Vrs9h08UWQG4YQZj0qJBK+2vAQu4
         2pG540SowMzHpmK7Rv5BlFQ6f9nTZbRbciuthpd4=
Date:   Wed, 9 Nov 2022 15:20:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yureka <yuka@yuka.dev>
Cc:     samuel.thibault@ens-lyon.org, w.d.hubbs@gmail.com,
        chris@the-brannons.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: remove usage of non-standard u_char
Message-ID: <Y2u3Rx30Zp39cFq0@kroah.com>
References: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:17:43AM +0200, Yureka wrote:
> From: Yureka Lilian <yuka@yuka.dev>
> 
> This code is included in the build tools makemapdata and genmap, and it
> expects that libc exposes a definition of u_char. But u_char is not
> defined in either C or POSIX standards, and some systems don't have it.
> Namely this breaks the build on hosts using musl libc, because musl only
> exposes u_char if _GNU_SOURCE is defined.
> 
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4bf2ee8ac..4ce9a12f7 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
>  
>  static inline struct st_key *hash_name(char *name)
>  {
> -   u_char *pn = (u_char *)name;
> +   unsigned char *pn = (unsigned char *)name;
>     int hash = 0;
>  
>     while (*pn) {
> -- 
> 2.37.3

This patch is corrupted and can not be applied.  Please fix up and add
the proper cc: stable tag when you resend it.

thanks,

greg k-h
