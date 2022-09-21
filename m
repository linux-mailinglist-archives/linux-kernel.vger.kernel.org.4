Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2955E53C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIUT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:26:16 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C535E93202
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=66rcljKTkOZrwZgqNEXo+xZF7AoDxDT9ScP9aV+15Gc=;
  b=rVC//fao0B9QMsmbV5dysTAr4nSlIY7m9ISq3FAz53+FQ9oxEMyp3Bk8
   NRkCoHPbjvA3n9vo6pM9oMPUTDPZ/HaE+DkFlbIzz8CmOQPLP9b8cP4o8
   MZPDwjSxm6NAhj6BmH/2EEVHw851vN4QJNN5u/R6vKSslehwh59e/M3f2
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,334,1654552800"; 
   d="scan'208";a="24337809"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 21:26:11 +0200
Date:   Wed, 21 Sep 2022 21:26:10 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     cocci@inria.fr, linux-kernel@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH] scripts: coccicheck: use "grep -E" instead of "egrep"
In-Reply-To: <20220921091341.217365-1-gregkh@linuxfoundation.org>
Message-ID: <alpine.DEB.2.22.394.2209212125590.2783@hadrien>
References: <20220921091341.217365-1-gregkh@linuxfoundation.org>
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



On Wed, 21 Sep 2022, Greg Kroah-Hartman wrote:

> The latest version of grep claims that egrep is now obsolete so the build
> now contains warnings that look like:
>         egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the vdso Makefile to use "grep -E" instead.
>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: cocci@inria.fr
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks.

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index caba0bff6da7..2956fce8fa4f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -47,7 +47,7 @@ FLAGS="--very-quiet"
>  # inspected there.
>  #
>  # --profile will not output if --very-quiet is used, so avoid it.
> -echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
> +echo $SPFLAGS | grep -E -e "--profile|--show-trying" 2>&1 > /dev/null
>  if [ $? -eq 0 ]; then
>  	FLAGS="--quiet"
>  fi
> --
> 2.37.3
>
>
