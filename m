Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635196C050C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCSU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCSU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:56:50 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ACE1A4BE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8yW3l+zoteRKLP1DJcoOgBiT683IGyZbqjmmCXqwoN4=;
  b=eYw9UF4or3D6rGM1eTgP7DCKitqNo4K2q4c2p7rRyvVwRmAefSB+wFdk
   Nqcan21mi0R0MQvw9AuZdWex7oH2R4mTzXnGejToJw6bcEv4rHrA+sHh+
   PQg9vrMOgr4wfOKl1GgFkdviP3Ft0NtyU0RvtYOA2Js3PpXZgXQHQDdE+
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="50621659"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:56:47 +0100
Date:   Sun, 19 Mar 2023 21:56:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
In-Reply-To: <20230319204935.259217-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303192156060.2867@hadrien>
References: <20230319204935.259217-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2023, Menna Mahmoud wrote:

> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline function.
>
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell what type
> it applies to.
>
> One can get the same benefit from an efficiency point of view
> by making an inline function.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> changes in v2:
> 	remove newlines added in previous patch.

This is not the right solution.  Greg is supposed to ignore your previous
patch, so he won't have the newlines that you are removing.

julia

> ---
>  drivers/staging/greybus/gbphy.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index 1de510499480..03a977056637 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,8 +15,10 @@ struct gbphy_device {
>  	struct list_head list;
>  	struct device dev;
>  };
> -
> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> +{
> +	return container_of(d, struct gbphy_device, dev);
> +}
>
>  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>  {
> @@ -44,8 +46,10 @@ struct gbphy_driver {
>
>  	struct device_driver driver;
>  };
> -
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct gbphy_driver, driver);
> +}
>
>  int gb_gbphy_register_driver(struct gbphy_driver *driver,
>  			     struct module *owner, const char *mod_name);
> --
> 2.34.1
>
>
