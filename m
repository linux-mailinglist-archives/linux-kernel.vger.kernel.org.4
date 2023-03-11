Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACC6B57EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCKDAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCKDAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:00:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4E1151D2;
        Fri, 10 Mar 2023 19:00:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B4C5B8248E;
        Sat, 11 Mar 2023 03:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C661C433EF;
        Sat, 11 Mar 2023 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678503633;
        bh=rUdvhWn70PfTjrZiWuFzfL6i0ilNZGpzMShdJagugC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shgZQjHCKg4hSudPSRbA25wDHiEpyAe0nesRMePgXkjDR8z9kOxgHBGpQTgO3AMka
         sjl/QAN1M5suHktsHHcJ8rZWaEnj+c+by5E5HThBQnpHAjKwFVns7evS6Yi4QRsr4D
         AWTUFgLGEP4CGEveIkTdriix9/oA110VnSyG7xC2HF++iNS2qa8w0qMhS+x5C64Fxt
         xIgLXyRgT+sgEUXcwjza/Jx2BnZ4U7zVM12qiPbnoTPz+bXW8ySpsx1v/RO77tdQPh
         O9ltFz1OHJQUphrKXuWJnPigoGSUoWYkryciPMK1l47OKvnY4Y3saQHt3PnkUniuBm
         SctwoSqIjvpcg==
Received: by mail-ua1-f49.google.com with SMTP id l24so4813317uac.12;
        Fri, 10 Mar 2023 19:00:33 -0800 (PST)
X-Gm-Message-State: AO0yUKWePQMfs0ZXcGnc2+L/PtBIEs1Bm2fC1LOTYZfDrhZW9SOZ+aiS
        fRXOeXri0avv21xaCCSt8m4aYRlDIQEPCiBCvw==
X-Google-Smtp-Source: AK7set8xgX8DtsrAL+iBoo8IO5Ld3oM1dW73gRD2fp0NVF/t5kL088eW3IC5QV8kdWJ7Ht4S+A/RIs7rb2s/5lO77Pc=
X-Received: by 2002:a1f:b44c:0:b0:41d:acb5:6c1c with SMTP id
 d73-20020a1fb44c000000b0041dacb56c1cmr17481409vkf.2.1678503632076; Fri, 10
 Mar 2023 19:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20230310144704.1542114-1-robh@kernel.org> <CACRpkda+aEUD7A2e-TfY3=yJG4L+P+Zh8G9U1K0xHHA-DxnJiA@mail.gmail.com>
In-Reply-To: <CACRpkda+aEUD7A2e-TfY3=yJG4L+P+Zh8G9U1K0xHHA-DxnJiA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Mar 2023 21:00:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKSJXwJ20Mn=wua_7YwJ9nU4Xqq+b29mYvEw+JaoHEuhg@mail.gmail.com>
Message-ID: <CAL_JsqKSJXwJ20Mn=wua_7YwJ9nU4Xqq+b29mYvEw+JaoHEuhg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Use of_property_read_bool() for boolean properties
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:41=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Fri, Mar 10, 2023 at 3:47=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
>
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties.
> > Convert reading boolean properties to to of_property_read_bool().
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> You are using of_property_present() rather than of_property_read_bool()
> but I'm not picky about commit message details.

ugg, well, it's the commit message that's correct. I missed updating
this one to use of_property_read_bool().

Rob

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
