Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBF55B645A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiILXtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:49:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835651A02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:49:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so371216pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=gvVP6Dht50nvTmYpmhiCsT/vQD8yVyq8IcRlXJGAZO4=;
        b=7lKflC4YiOFpkGbEsBl0lk8jvcUJpq8Mn4WIVH4JGd/0i1rkQd/nDb7t6hpWkSWFzJ
         eUbjyzDKPF4xz3pKr3Y8OI1KURS2Q9G8wIXXxGNSH/USCC4B6hShEMo9e+tEjY68nUJf
         UovXQY3b+P+rpVl0VMrKNawPdTEvbynd0nZQlI9EDJ7AkUSbwrZQDjT/e0O7550WBHys
         vRkoFtMF7lbu5NT9ZIBYBapkspod9p40msbzPOPrmjrlP702oPOecR1Vk2QLp9qHjazW
         bwW4lnyxLk6TchG75/gUtNnMGU5wludI75C1zqBNKEBUWxtwf9y/otAk/y6RD1ryqGR7
         nZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gvVP6Dht50nvTmYpmhiCsT/vQD8yVyq8IcRlXJGAZO4=;
        b=sR4lvvBJnc3LRwzQ3/40gXTh1iFeDFCrvREO4K4/AXtDMa8ofddrsjXLcThgPoNFh4
         FRZpOyxsgQqazP5j322irVjs0Cckcdoy2u6SMU3jMwAWV7QxZyQCO8c9w1PyIxIQUKWC
         KxSzPX1bMTNh/q1Z55su7n7SkRX6lucevrN+1c8yR9eoqHO/IeStmW4YR7hFFxOREBLY
         LC94papTaMqTWZzrJmSwl3u2h49FEmSrI83qsu6o1CO3YqUMWf4UDchCMTC35tJpIldi
         i/+Rd0M53UNTX+wVUXluz2IkXXwaszIzjtpAlfC8n9LOJHnX9KTUqvRVG1xpJnosZeTL
         Vb3g==
X-Gm-Message-State: ACgBeo0dmvyBri3BG3xf4icMbOhaknL4fLPz+yQFHbvjfAypWO5f8eG5
        4dSkSXHqmhs/O9e9rPWKuVX7jnV6ooyqx6IALM6F4w==
X-Google-Smtp-Source: AA6agR7meWyAXm13+eJxe8HZ5xJMwReynqtEsFTrvRWvkHPx5MWafsHFEg/X2fu30Fp4Ll47gDa2tOOPQvnWuzZYJRg=
X-Received: by 2002:a17:902:f24c:b0:178:11ed:6af4 with SMTP id
 j12-20020a170902f24c00b0017811ed6af4mr16438745plc.135.1663026559799; Mon, 12
 Sep 2022 16:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220828120153.1512508-1-axel.lin@ingics.com> <f8a92b6d-ad23-24e7-2a01-73839e57cb85@baylibre.com>
In-Reply-To: <f8a92b6d-ad23-24e7-2a01-73839e57cb85@baylibre.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 13 Sep 2022 07:48:44 +0800
Message-ID: <CAFRkauDKUGRracu2ofc=q-UTjWaeef5GfevT6kHnP=MWo__BGw@mail.gmail.com>
Subject: Re: [RFT] [PATCH] regulator: tps65219: Fix .bypass_val_on setting
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jerome Neanne <jneanne@baylibre.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Axel,
>
> On 28/08/2022 14:01, Axel Lin wrote:
> > The .bypass_val_on setting does not match the .bypass_mask setting, so =
the
> > .bypass_mask bit will never get set.  Fix it by removing .bypass_val_on
> > setting, the regulator_set_bypass_regmap and regulator_get_bypass_regma=
p
> > helpers will use rdev->desc->bypass_mask as val_on if the val_on is 0.
> I think this will result in exact same behavior. val would be assigned
> to 1 when enable is set and 0 otherwise. Anyway you are right this line
> is useless.

Setting .bypass_val_on=3D1 won't set TPS65219_LDOS_BYP_CONFIG_MASK bit.
The TPS65219_LDOS_BYP_CONFIG_MASK is BIT(6), so you need to set BIT(6)
instead of 1 for .bypass_val_on.
Remove .bypass_val_on setting then it will use .bypass_mask as
.bypass_val_on setting.

Regards,
Axel
