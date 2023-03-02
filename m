Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D96A8974
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCBTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:22:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0863B0F1;
        Thu,  2 Mar 2023 11:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 269E4B81440;
        Thu,  2 Mar 2023 19:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A15C4339B;
        Thu,  2 Mar 2023 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677784920;
        bh=u2ETyMMWLefkMOTiZAX4m6udjfmcpjpLan8MZELaPRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W5sk2vWK1Rnf1JT2ayvNiFdNhO6FJCa3Sy/DXEEAyull9UEwrMPECbHMRCY0fiTMq
         M0yzwRTR+UXWvXFnRbP9p3Dpu4mammGG2mLklCz1cQ2Gvek9UJngKAos5cbyU2kJ+z
         9whroInCV7LVAykTkK7oWZKkPACSFl0ZFyH9JbPOn9ebDvwZ2NHt0jw8ZN/Nw8qysD
         vKReu05g46rIYFYbOi7nslJf1L8cdQHBhB59z0uXjyneshfTzoJ5ZYkJFS+uN7E+QJ
         KAQgyasW2HK71fZ8bMzhtHy43ASYBB3Z253qT+7Pb1kQaV9WJMaX9VjfkR8klZDL/I
         mvp5W+oftBFwg==
Received: by mail-ua1-f44.google.com with SMTP id bx14so104565uab.0;
        Thu, 02 Mar 2023 11:22:00 -0800 (PST)
X-Gm-Message-State: AO0yUKXOCJad1IuYnDO83G1/TtaB7JKayqe6jVLbmL4yGpzdD5x/Rr80
        vzhxzel3Acqz2HVGb3PcJ3wlu9Caev0aQxAcPw==
X-Google-Smtp-Source: AK7set+By6mMmtpNevkrZDxOqkfNXCynDSWK6HZExynOWNBO2b8njhtcc3mYR/TCzZt26k4m/i2DzpqpFOH5ndzF9K4=
X-Received: by 2002:a05:6122:e0f:b0:406:8403:4e64 with SMTP id
 bk15-20020a0561220e0f00b0040684034e64mr5867611vkb.2.1677784919678; Thu, 02
 Mar 2023 11:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20230301152239.531194-1-miquel.raynal@bootlin.com> <20230301152239.531194-2-miquel.raynal@bootlin.com>
In-Reply-To: <20230301152239.531194-2-miquel.raynal@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Mar 2023 13:21:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK86M608bKtY9dYGN6Vwe84W33bFiBwtrocoO8mE1HMzQ@mail.gmail.com>
Message-ID: <CAL_JsqK86M608bKtY9dYGN6Vwe84W33bFiBwtrocoO8mE1HMzQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] of: Fix modalias string generation
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl, Stephen Boyd <stephen.boyd@linaro.org>,
        Peter Chen <peter.chen@nxp.com>
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

On Wed, Mar 1, 2023 at 9:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> The helper generating an OF based modalias (of_device_get_modalias())
> works fine, but due to the use of snprintf() internally it needs a
> buffer one byte longer than what should be needed just for the entire
> string (excluding the '\0'). Most users of this helper are sysfs hooks
> providing the modalias string to users. They all provide a PAGE_SIZE
> buffer which is way above the number of bytes required to fit the
> modalias string and hence do not suffer from this issue.
>
> There is another user though, of_device_request_module(), which is only
> called by drivers/usb/common/ulpi.c. This request module function is
> faulty, but maybe because in most cases there is an alternative, ULPI
> driver users have not noticed it.
>
> In this function, of_device_get_modalias() is called twice. The first
> time without buffer just to get the number of bytes required by the
> modalias string (excluding the null byte), and a second time, after
> buffer allocation, to fill the buffer. The allocation asks for an
> additional byte, in order to store the trailing '\0'. However, the
> buffer *length* provided to of_device_get_modalias() excludes this extra
> byte. The internal use of snprintf() with a length that is exactly the
> number of bytes to be written has the effect of using the last available
> byte to store a '\0', which then smashes the last character of the
> modalias string.
>
> Provide the actual size of the buffer to of_device_get_modalias() to fix
> this issue.
>
> Note: the "str[size - 1] =3D '\0';" line is not really needed as snprintf
> will anyway end the string with a null byte, but there is a possibility
> that this function might be called on a struct device_node without
> compatible, in this case snprintf() would not be executed. So we keep it
> just to avoid possible unbounded strings.
>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Peter Chen <peter.chen@nxp.com>
> Fixes: 9c829c097f2f ("of: device: Support loading a module with OF based =
modalias")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Ahh, an off by 2 error. ;)

Reviewed-by: Rob Herring <robh@kernel.org>
