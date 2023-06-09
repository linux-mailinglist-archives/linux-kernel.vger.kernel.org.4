Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA5729FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjFIQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbjFIQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:14:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388443A91
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:14:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33e4e59da95so8453295ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686327258; x=1688919258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f7kvEzbwR1d0awtJj62+jmeZjRD6tDFL65qplHJ0cw=;
        b=GLVbBWhyARSwVNiadUE2wcKKKqAZgBdj1SU4f6HFEhu5ELWd0UXmrCWSv0GYxqJ1Hx
         wzNQ2pCxM1Te7UGHhrpzhguEcyQfHkW6gz/2OP8QrCPoOJVIhaiqiaZMMKewkxJxQUpX
         ZIHg4Q9VpkNIw+RZv3X4BW5LGb6nn50K1zER8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327258; x=1688919258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f7kvEzbwR1d0awtJj62+jmeZjRD6tDFL65qplHJ0cw=;
        b=fkKhJqwcc8yuNqDQWGwKCGb8Br8FHhyIJDeSTq6K2y0a3iF0BjpBOKORh3OUVbkmyM
         CsC6Mm2m3vLXZP57qR7APrD5HDgT0ggM8Pt5unonFKX9NnAq6fiL/dmYgnr0aBAgDN+N
         X9BwI2PyHu9cx9q4/qbTQwNvzsOHnWdbg+l96QqdV9krfLjsV97fAdK8hZyjrkLJmeJD
         4bqi60Zh6V4t9URA9qJKLZ2GG/DsOVC/+gGCVmPFhccakC7av1jAMSp7/MHhURGN77CX
         CGE7AUypiXtdtT+LUyDsI3YakPtjSjoWBSO1WBfHQ7sjdizRH2RJQQMHk6LVfcOBZZOS
         dq1A==
X-Gm-Message-State: AC+VfDydFtqs9o5MCQaMlAAD6cnmwhrgmbRrhAXc2q8bGERW3yXOGAy1
        8g9Co5iVLMdMJwQpFshm2LPFoW4GWOR8mPIcGOo=
X-Google-Smtp-Source: ACHHUZ4HFoxp4UmO0M+w/RpK0TsqIv0Fh/hO5wbF9F+QqwhjnGmZWTG65eh+t6hu5J2HRm6Rt5Gzmw==
X-Received: by 2002:a92:d28a:0:b0:33d:4b18:97ff with SMTP id p10-20020a92d28a000000b0033d4b1897ffmr1665559ilp.23.1686327258087;
        Fri, 09 Jun 2023 09:14:18 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id y16-20020a92c750000000b0033e62b47a49sm1153689ilp.41.2023.06.09.09.14.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:14:17 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33d928a268eso287965ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:14:17 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a82:b0:32f:7715:4482 with SMTP id
 k2-20020a056e021a8200b0032f77154482mr423772ilv.4.1686327256892; Fri, 09 Jun
 2023 09:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com> <20230609063615.758676-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230609063615.758676-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jun 2023 09:14:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPSwWpkGN3UyFm1c84gj7iDC7dYrT9CCqWnqkTun-4cg@mail.gmail.com>
Message-ID: <CAD=FV=UPSwWpkGN3UyFm1c84gj7iDC7dYrT9CCqWnqkTun-4cg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 8, 2023 at 11:36=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The ili9882t is a TDDI IC (Touch with Display Driver). The
> datasheet specifies there should be 60ms between touch SDA
> sleep and panel RESX. Doug's series[1] allows panels and
> touchscreens to power on/off together, so we can add the 65 ms
> delay in i2c_hid_core_suspend before panel_unprepare.
>
> Because ili9882t touchscrgeen is a panel follower, and
> needs to use vccio-supply instead of vcc33-supply, so set
> it NULL to ili9882t_chip_data, then not use vcc33 regulator.
>
> [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium=
.org
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 12 deletions(-)

This seems reasonable to me now, but only makes sense to land if the
panel follower patch series [1] lands. That series is currently at v2
and will at least need a v3.

[1] https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.or=
g
