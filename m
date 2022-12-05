Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8A6429FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLEOAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLEOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:00:06 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA318EE13
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:00:04 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id s10so3418964qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc+cLLtHJGOP66cgSux+fMADmZs9geR0ByZCxx6UhW8=;
        b=dcA+CKALs3v3yWgLoLv6Im5Q0FCiGYalGkOrfujc38CCg1+dizT+6ag9Ldg5FOAHaV
         rvOd7Z/0Pu5esu372X9Zs7Sldia20SoxnLsgGbIzUBvtwALVsas9IyLP9Y2qe1FIS1f/
         Z0A9Cy3559ZsWiHJA89AYfX34xfSjwgN9Q9Y9zRlnPePNjJqNkBQ8+Gf9LuyivK9L5/8
         FdWuMTLAeiBMsWpPvw21rUSNpgUWRt5EqU89N7wVhmZ6jZKSWmwNrk8YFLkthv0oufkS
         z4SkNsI/dOhZ3ZqQvGlEI/tqka/ROZV+1dL3/CtdkMlrGDaFIM8+eP6Fw+Kj5Ev6Om3k
         oAew==
X-Gm-Message-State: ANoB5pnyzP2jBPoueTnU2ufLEyNHn4TklsomCeLv/RCeaunxGK4R10SL
        6DJOpkeBg7SY/fT7NHANAsttR074Bc7pF5RaJsA=
X-Google-Smtp-Source: AA0mqf5RVgc3Y77ZsHXC7qS4igV8TUMZxZEcLBgLFWNH4NPlW7DXBgp+uD1OuVuNYtiQQ7PZmqE0ks2d/u5SAPbd45k=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr71735755qkb.443.1670248803895; Mon, 05
 Dec 2022 06:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 14:59:49 +0100
Message-ID: <CAJZ5v0gJuE0SOqErrZPSHKjgNuVqk0gtaQpPztGBqP1zqn9AEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 1:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.
>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: - removed one parameter, now matches container_of(), thanks to
>       suggestion from Sakari
>     - changed Jason's tag to suggested-by and reviewed-by
>     - added Andy's tag
>
>  include/linux/container_of.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2008e9f4058c..1d898f9158b4 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -22,4 +22,17 @@
>                       "pointer type mismatch in container_of()");       \
>         ((type *)(__mptr - offsetof(type, member))); })
>
> +/**
> + * container_of_const - cast a member of a structure out to the containing
> + *                     structure and preserve the const-ness of the pointer
> + * @ptr:               the pointer to the member
> + * @type:              the type of the container struct this is embedded in.
> + * @member:            the name of the member within the struct.
> + */
> +#define container_of_const(ptr, type, member)                          \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> +               default: ((type *)container_of(ptr, type, member))      \
> +       )
> +
>  #endif /* _LINUX_CONTAINER_OF_H */
> --
> 2.38.1
>
