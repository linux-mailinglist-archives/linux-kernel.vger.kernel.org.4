Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE16C2377
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCTVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCTVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:17:52 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637019B3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k6Y/LaPlIX/FUHKVPdvJK9oxphvVPlynLHe6aEtfiIA=;
  b=PFqlaCISCaH/5bQEh0BUsNwbR0pgsZ+sAJsykNRKPUri3xiW+Y50xb91
   ldqOzLG1pr5GfEyaBKIrY3ZgCxy8dK++LbqXxsdyDv9X+3IR8MY3mcEy8
   o69L+l3D0kM2Bd7irmERnJcEpmr0uJFnEHZlqjXH5vYZEVpHHOLO9GW9k
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,276,1673910000"; 
   d="scan'208";a="98173617"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:17:46 +0100
Date:   Mon, 20 Mar 2023 22:17:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
        drv@mailo.com, dave@stgolabs.net, yang.lee@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2] staging: most: use inline functions for
 iface_to_hdm
In-Reply-To: <20230320205207.20062-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303202217110.2906@hadrien>
References: <20230320205207.20062-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe "define iface_to_hdm as an inline function" would be better.  "use"
is not very precise.

julia

On Mon, 20 Mar 2023, Menna Mahmoud wrote:

> Convert `iface_to_hdm` macro into a static inline function.
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell
> what type it applies to.
>
> One can get the same benefit from an efficiency point of view
> by making an inline function.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
> 	edit subject line.
> ---
>  drivers/staging/most/dim2/dim2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index b8bd01ca1f11..21d1c9f24c3d 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -108,7 +108,10 @@ struct dim2_platform_data {
>  	u8 fcnt;
>  };
>
> -#define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
> +static inline struct dim2_hdm *iface_to_hdm(struct most_interface *iface)
> +{
> +	return container_of(iface, struct dim2_hdm, most_iface);
> +}
>
>  /* Macro to identify a network status message */
>  #define PACKET_IS_NET_INFO(p)  \
> --
> 2.34.1
>
>
