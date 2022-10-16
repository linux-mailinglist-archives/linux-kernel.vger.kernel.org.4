Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9B600007
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJPOvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJPOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:51:16 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163411CFC7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GAXZusUTGXd8GtiU3oJfzZebCfauRy06xX4D1JKKRTs=;
  b=oAEVFMcRqNHtG/vJGzX4mpJJNG/R7AG95bbmRpYPVe8WhaAEVjBzY93E
   x4BxMLvBoaQdXos/iDPbcTkijV/88bO1IiFIMVqesNQpwDZDLvY40k3Mq
   ssrdGzgYsGeaJ8m3ZKWzOxN2VgA6b1b6UIFdufbZjw/1l/tLnJUwF7mYH
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,189,1661810400"; 
   d="scan'208";a="31574090"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 16:51:10 +0200
Date:   Sun, 16 Oct 2022 16:51:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
In-Reply-To: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Oct 2022, Deepak R Varma wrote:

> Include multiple statements of macro definition inside do-while{0} loop
> to avoid possible partial program execution. Issue reported by
> checkpatch script:
>
> ERROR: Macros with multiple statements should be enclosed in a do - while loop

I don't think this change will compile.  See if you can figure out why
not.

julia

>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/greybus/loopback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 1a61fce98056..37214cb43937 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  static DEVICE_ATTR_RO(name##_avg)
>
>  #define gb_loopback_stats_attrs(field)				\
> +do {								\
>  	gb_loopback_ro_stats_attr(field, min, u);		\
>  	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +	gb_loopback_ro_avg_attr(field);				\
> +} while (0)
>
>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\
> --
> 2.30.2
>
>
>
>
>
