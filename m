Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29537625864
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiKKKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKKKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:31:13 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCBFCD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:31:00 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so4071687pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EoWEktzF4xunmTW3NPGj5C3ZY4hEtE5YC4CZzU3s8w=;
        b=acyxfZqCeg1dzpt9TFsjnhQn9D441fcog0e95pfckukoQsxwDvCRQhFPgJR8Ehj06A
         iWatB6dA0pInT1CkyiQOUD0zDDsWAN2DpZIfBoidcBu9vwJ4hHQ/cjCGAL491uyM1d5M
         CxGvCxanZyHQXgfwaH56kiadHxDZInMg512oyn/U9JyNWJf8eVsn1yuS/eJcy20WcHbM
         c5p3wqwWD7l00XibEwWAb2jkIBTjAEdoin7Ty3U1vGFZJnrocWcOIUXSVFiUqpPSmhKs
         Ghb0V5BZ3jXS330npx/BMf9ZkicttdE+ysJdV8Q+Uw1Roid4AyagEcXgZQqYjYVL5WSy
         jMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EoWEktzF4xunmTW3NPGj5C3ZY4hEtE5YC4CZzU3s8w=;
        b=dEw7BVi8fjZpl8A76yxIVtkPQoCRhyJXZDnQ2dBpLjjwYDyF8v34CdK2mJup8c+nY+
         DDoh2zA/vBeKNopqRnDLY1uRLvwJE94Y2jaENCvmiccD163oauISILsPNoZPDhRGGUOz
         2H6HlszLfOyEJJCGoxMe6LZnvvkNqyzUcXKymgPprXMqGMBhNdsT6FRH7QrWHdUhVh7m
         Fn7vmHBk+S5S9q0Rmu9SeQwzmVrHXsjPrb+BPbGdZwTgLkEgbl40dH0OdENOybIouLbw
         SZEtqm4QtYZ1J31kCLCLAX9xIOyXxt64DPJan1ygvuBh7+pCP/MzXjbqvvy3RvaGKGeI
         V04Q==
X-Gm-Message-State: ANoB5pkB4HznimLrPT+3EWo4Y3RinlaztekxY2YcRZEgMvFL2DKuEuwv
        oPlTqfNAK+x5wVsXZN7gm+sMN9BD0AZLderRxk47LA==
X-Google-Smtp-Source: AA0mqf62BtjjmpjdtBI9U+VBt4c8CQ0WDBXW8v/LnUZ18mTN/2cC9XpELje/r/6EYWBc30pZC0IKiaa8mWK5GAWeizE=
X-Received: by 2002:aa7:924c:0:b0:566:9f68:c0ad with SMTP id
 12-20020aa7924c000000b005669f68c0admr1951719pfp.57.1668162659697; Fri, 11 Nov
 2022 02:30:59 -0800 (PST)
MIME-Version: 1.0
References: <22aa78389c9b4613841716c5b7bd89aa@hyperstone.com>
In-Reply-To: <22aa78389c9b4613841716c5b7bd89aa@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Nov 2022 11:30:23 +0100
Message-ID: <CAPDyKFofO7JKpE6tEndFfYEYHAr-hHbs2rxwMfUNAK+rx0k7=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: Requeue req as head if driver touched it
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 09:30, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> In case the driver set RQF_DONTPREP flag, requeue the request as head as
> it is likely that the backing storage already had a request to an
> adjacent region, so getting the requeued request out as soon as possible
> may give us some performance benefit.

This is a bit handwavy to me. Would you mind extending this with a
small concrete example, to better understand the benefit?

>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Other than the above nitpick, I can't think of any obvious unwanted
side-effects this could have. So, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d..d863c826fb23 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1429,7 +1429,7 @@ static void blk_mq_requeue_work(struct work_struct =
*work)
>                  * merge.
>                  */
>                 if (rq->rq_flags & RQF_DONTPREP)
> -                       blk_mq_request_bypass_insert(rq, false, false);
> +                       blk_mq_request_bypass_insert(rq, true, false);
>                 else
>                         blk_mq_sched_insert_request(rq, true, false, fals=
e);
>         }
> --
> 2.37.3
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
