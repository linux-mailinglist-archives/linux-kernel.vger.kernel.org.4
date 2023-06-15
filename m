Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB087315BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbjFOKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbjFOKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:49:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04751FC7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:49:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso10345739e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686826178; x=1689418178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpvlEuL1nAvduidLX2FmqNuHmPqfOX2zdeJ9lWWasEk=;
        b=nw6V/9ZR4gvQH8vgqLLFZAzeN2ccX9+mIGVHkN7SWaPoYSCL1R1XpdtZaFD+q4VfdQ
         GRv2YA4Zw2B2bg3JLdeUgKBi+Jnp/XL7ZVynE13umow46q8KQTM7y5iw8OIeC8iLSAaW
         9f74mzQEAcvWnHwOrvxjWXIbbpCMrTGfrj+HX4wOOXAQ5+wekD+7MOc2zOox6cfUT6U9
         gZJRW4fpTX/rcb1I4u2tg2n5UEP9XF6H8esnLBGFhzQRoK7CGOZvI9RAZTOjUtFbF+hb
         v2Fz45TjZXlJo3lrzKQqN7LoqF2ytCI8Hw6H1Saz+/W5zmtqrsQMyZLiYAz1azAwXumk
         ta5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826178; x=1689418178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpvlEuL1nAvduidLX2FmqNuHmPqfOX2zdeJ9lWWasEk=;
        b=l3keee2VWzmIWbcmF7kx7QzTQQPLPk9nGntfz7i1Jm3j5rseHY4LPKgmlUYHda3XaR
         l6f+3JZposTzlg/zmYyNN/DWKnLff29ZzIZwVz7SvUEEjvnwlH6A5JihBhvnuSwPY9ga
         XyvxxgSQO3AFIgjnKHG9qia5NG1rU+LKh5swkhNrumRdRTOK6FGTxqnc8XQ2B9mxjEFp
         InxYR4zOMdhxqlU2L9SYEZNGmDkm2KF+F28QB6oZLZZufSBTbFZr9hY9T/oHqjO2io2l
         nUjDRmBRgvUzKnOlrW+o8jKF+L5mKdJPkaYl6JHwzU0VIg0nwuUE7XOpcqHfyCUNp6vB
         lGWQ==
X-Gm-Message-State: AC+VfDwpyZ5CovahIBrFscncZKVS0x3TWw16geMPbJvjshrbyY+uCHjk
        htOCYxNmm6O+uoPdXfe47BmB0qotZ40gZSU+iOOS+g==
X-Google-Smtp-Source: ACHHUZ6X1HXF+GZI6JpYESovrdqXgdUkrikj+Q826FN7vg2TCw8Km+WAPMFChwspZmUtxqYlaYoUzoF80HbXwJP68dE=
X-Received: by 2002:a19:690c:0:b0:4f7:8df5:43df with SMTP id
 e12-20020a19690c000000b004f78df543dfmr1864405lfc.30.1686826178002; Thu, 15
 Jun 2023 03:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230615013645.7297-1-liangchen.linux@gmail.com> <20230614212031.7e1b6893@kernel.org>
In-Reply-To: <20230614212031.7e1b6893@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 15 Jun 2023 13:49:02 +0300
Message-ID: <CAC_iWjJACJY4T2moyO3cy1_e+t72KYnsux4DUUJ-4bV=5emT-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] page pool: not return page to alloc cache during
 pool destruction
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Liang Chen <liangchen.linux@gmail.com>, hawk@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Thu, 15 Jun 2023 at 07:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 15 Jun 2023 09:36:45 +0800 Liang Chen wrote:
> > When destroying a page pool, the alloc cache and recycle ring are emptied.
> > If there are inflight pages, the retry process will periodically check the
> > recycle ring for recently returned pages, but not the alloc cache (alloc
> > cache is only emptied once). As a result, any pages returned to the alloc
> > cache after the page pool destruction will be stuck there and cause the
> > retry process to continuously look for inflight pages and report warnings.
> >
> > To safeguard against this situation, any pages returning to the alloc cache
> > after pool destruction should be prevented.
>
> Let's hear from the page pool maintainers but I think the driver
> is supposed to prevent allocations while pool is getting destroyed.
> Perhaps we can add DEBUG_NET_WARN_ON_ONCE() for this condition to
> prevent wasting cycles in production builds?

Yes the driver is supposed to do that, but OTOH I generally prefer
APIs that don't allow people to shoot themselves in the foot.  IIRC
this check run in fast path only in XDP mode right?  If this doesn't
affect performance,  I don't have any objections.  Jesper was trying
to refactor the destruction path, perhaps there's something in this
that affects his code?

Thanks
/Ilias
