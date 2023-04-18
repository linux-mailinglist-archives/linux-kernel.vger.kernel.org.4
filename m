Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6796A6E6712
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDROW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDROW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:22:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847AA5E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:22:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so4244298a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681827749; x=1684419749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr9HMDo/MJuNTypI5wjgUQXDgpx9NKUHRJlWMwJUMe0=;
        b=MLJQYZpT1NO7iCJDWnA9xhAZ+xHe5Vpo0FCWFXyT9e/lUJmC6mLC6vgyGuOLi/mgLM
         Bqrx1OLzSftCNclvNC94Dod0HcSWqS/f7p3ttWCYqwuFDnJmruDlNEkZrk07jbPTC/Kd
         noCDHDv8KWaVJ9FoQoY08Psu6rfAZMPfDjvZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827749; x=1684419749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mr9HMDo/MJuNTypI5wjgUQXDgpx9NKUHRJlWMwJUMe0=;
        b=TQrwr80tu+wBE7HXM2XnkDCT1l8U26ZZexsivXrjSJ1OIYarkgyeWazKEDhsncxdWP
         fMrvqcY0qXyUJYuV/CoOAULOffKBnLyr/98ZPFgJtumMKZyDTtTUqp7daW8yZbGGsbHt
         DcoBZ3gVpxqzG96AQtZ0IT+U+E1yfv+ExxGgANd9AGviHzYVLhaU6Wz2Jmz84zO+PipL
         cO6+iLLMWIvxqYWEYTalBkmBF02U18qBAwRdBZ9LZpvCOXI9NlPD26Jke6+nKTmyNzaY
         koOHB66ad3eZAV9/DwG7ldokrfdqrnAlpBUHk5X6TMpK4ixtR6S4QKGt83G33gDCmsvy
         jBHw==
X-Gm-Message-State: AAQBX9egYPtgimsPaYDlnHpxISB9n9PsXfqK09nHYJxpDDwf3KN3XiOO
        50C6BhPzU2fVlQyFpK9PqYVtB3ZctFeJVg+ovZey+A==
X-Google-Smtp-Source: AKy350b0d2pT3khsCI4KBUJw5RT8tDGKZ0KpLZ71M+6atCN+70R/Yc/s7GtRQ9LLOhNr+SjzvIlKxQ==
X-Received: by 2002:aa7:de10:0:b0:506:b24c:284f with SMTP id h16-20020aa7de10000000b00506b24c284fmr2472275edv.26.1681827748995;
        Tue, 18 Apr 2023 07:22:28 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id k21-20020a056402049500b00502b0b0d75csm7064021edv.46.2023.04.18.07.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:22:27 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso69178915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:22:27 -0700 (PDT)
X-Received: by 2002:adf:e195:0:b0:2d7:9771:fc4b with SMTP id
 az21-20020adfe195000000b002d79771fc4bmr620802wrb.5.1681827746736; Tue, 18 Apr
 2023 07:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-3-fshao@chromium.org>
In-Reply-To: <20230418124953.3170028-3-fshao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Apr 2023 07:22:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVH3H9R=dnrOkiCEa-+izcSKjfdXbRDP8bc4xo_AhMnw@mail.gmail.com>
Message-ID: <CAD=FV=WVH3H9R=dnrOkiCEa-+izcSKjfdXbRDP8bc4xo_AhMnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: goodix: Add support for
 powered-in-suspend property
To:     Fei Shao <fshao@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 18, 2023 at 5:51=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> In the beginning, commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the
> reset line to true state of the regulator") introduced a change to tie
> the reset line of the Goodix touchscreen to the state of the regulator
> to fix a power leakage issue in suspend.
>
> After some time, the change was deemed unnecessary and was reverted in
> commit 557e05fa9fdd ("HID: i2c-hid: goodix: Stop tying the reset line to
> the regulator") due to difficulties in managing regulator notifiers for
> designs like Evoker, which provides a second power rail to touchscreen.
>
> However, the revert caused a power regression on another Chromebook
> device Steelix in the field, which has a dedicated always-on regulator
> for touchscreen and was covered by the workaround in the first commit.
>
> To address both cases, this patch adds the support for the
> `powered-in-suspend` property in the driver that allows the driver to
> determine whether the touchscreen is still powered in suspend, and
> handle the reset GPIO accordingly as below:
> - When set to true, the driver does not assert the reset GPIO in power
>   down. To ensure a clean start and the consistent behavior, it does the
>   assertion in power up instead.
>   This is for designs with a dedicated always-on regulator.
> - When set to false, the driver uses the original control flow and
>   asserts GPIO and disable regulators normally.
>   This is for the two-regulator and shared-regulator designs.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
>
> ---
>
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 46 +++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 7 deletions(-)

I privately reviewed earlier versions of this patch, so it's
unsurprising that I have no comments. Assuming that the DT folks don't
have any objections to the bindings change, this LGTM.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
