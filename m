Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FA6B6717
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCLOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:12:54 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDF3BDB5;
        Sun, 12 Mar 2023 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Sh+uFbFcoNlwdgGV/4sI5udPXzj2znbd+ERSzswWHME=;
  b=pduNCQ/z+hOAQR+D7AlHkgsFHO97hTPfr7Ok8EgXV3dyLZnnJ/UaM+1s
   pekDkGCmTI+9DdcsTIjuqEYZs4uczZ6ZtozLDGuQyzlcn5garnOFjfaOf
   c6okVnz1RIpVJ0iwXsXQXnC73w16QPGwzY9ZPHbvlXJ9GVepv8g6+Vy9N
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,254,1673910000"; 
   d="scan'208";a="49927439"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 15:12:48 +0100
Date:   Sun, 12 Mar 2023 15:12:47 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     outreachy@lists.linux.dev, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: enclose Macros with complex values
 in parentheses
In-Reply-To: <20230312133347.120944-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303121507450.2865@hadrien>
References: <20230312133347.120944-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1354038481-1678630367=:2865"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1354038481-1678630367=:2865
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 12 Mar 2023, Menna Mahmoud wrote:

> enclose Macros with complex values in parentheses is especially useful
> in making macro definitions “safe” (so that they
> evaluate each operand exactly once).

enclose -> Enclose, and Macros -> macros

I don't understand the above comment though.  How does adding parentheses
around the body of a macro cause the operands to be evaluated only once?
And the macros that you have changed don't have any operands.

The value of adding parentheses is normally to ensure that the body of the
macro doesn't interact with the context in a weird way.  For example, you
could have

#define ADD 3 + 4

Then if you use your macro as 6 * ADD, you will end up evaluating
6 * 3 + 4, ie 18 + 4, when you might have expected 6 * 7.  The issue is
that * has higher precedence than +.

But I don't think that such a problem can arise with a cast expression, so
parentheses around it should not be necessary.

> this error reported by chechpatch.pl

this error is reported by checkpatch.

>
> "ERROR: Macros with complex values should be enclosed in parentheses"
>
> for ADE7854_SPI_SLOW, ADE7854_SPI_BURST and ADE7854_SPI_FAST
> macros and this error fixed by enclose these macros in parentheses.

The last two lines aren't needed.  One can easily see that from looking at
the patch.

julia

> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index 7a49f8f1016f..41eeedef569b 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -139,9 +139,9 @@
>  #define ADE7854_MAX_RX    7
>  #define ADE7854_STARTUP_DELAY 1000
>
> -#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
> -#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
> -#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
> +#define ADE7854_SPI_SLOW	((u32)(300 * 1000))
> +#define ADE7854_SPI_BURST	((u32)(1000 * 1000))
> +#define ADE7854_SPI_FAST	((u32)(2000 * 1000))
>
>  /**
>   * struct ade7854_state - device instance specific data
> --
> 2.34.1
>
>
>
--8323329-1354038481-1678630367=:2865--
