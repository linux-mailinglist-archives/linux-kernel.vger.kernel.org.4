Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212466AF327
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjCGTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjCGTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:00:43 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397A74DC8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:47:26 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id l2so8949925ilg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7BUelKDKk+33uckJ7LNeCbNjLijtX6ljbEKj2F7sL0=;
        b=mmKJPqfK6CbrD8XkPRewXyJ00DJMkprNnqvUdvJD3PrFuWnuda8yN3z2tyuHmzBzSi
         RjPA8mQzv8ntVFz+2/+MeDF8oLMW+gy1a1WyenLLr3HnpO4Q9dzZS88n6I6ey78FxYp+
         zw6j6o5KPZKbsVuVWmnH/CW19k9d9JYzgS2pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7BUelKDKk+33uckJ7LNeCbNjLijtX6ljbEKj2F7sL0=;
        b=f8s4Q7cuHS95yPpz5wag7k6YhrPEQ914sRN7DhOSZsWwXpl3mBkafxurRSzo/xr/HJ
         E4uAV2CwYdIyGcy4T4DG+xL++QX2ff8tKl7LrvLYzXnKV0Awer7OaL2Qri+xPFY47zll
         pxM4KwanL8T1u+vJJQWbGPY9qGgc9F+fs0IhNvVSRMHVW7e/D2U1+4504vSBWBa+eRXn
         4v4d9LkPjuUouemIwVfeOWEYDGb1KqdhaHzE1KE7NcAsKNjTLcaHDZE5YHgHHY8jC1dZ
         OpI9tPDXhUmQAVt7IH+bEOlLJBSEqv2yRdPc80CQIog4rjKUdFlps8xFtSQW4o9+PBgQ
         nLMQ==
X-Gm-Message-State: AO0yUKUXz2eWVDF4yBGH+ez6Tw817nQpvbEpO3BpSd3yzX4S/cJ4qgWQ
        uvt5XhTHhTrw3PtaTHjnijHtrlMlgtud3Wv4nvc=
X-Google-Smtp-Source: AK7set8O8k5rtCdoZsakVzW35/u63kFWO+QoorpyE4YOKrDKcWZI5qQoEa9t1aV7gn2MBK+vZxidXg==
X-Received: by 2002:a05:6e02:1a4e:b0:316:e941:245d with SMTP id u14-20020a056e021a4e00b00316e941245dmr13911927ilv.20.1678214840758;
        Tue, 07 Mar 2023 10:47:20 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id w2-20020a02cf82000000b003ec3b5225c3sm4199396jar.156.2023.03.07.10.47.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:47:20 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id e11so5793742ioe.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:47:19 -0800 (PST)
X-Received: by 2002:a02:aa0b:0:b0:3c4:e84b:2a40 with SMTP id
 r11-20020a02aa0b000000b003c4e84b2a40mr7756944jam.6.1678214839473; Tue, 07 Mar
 2023 10:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-5-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-5-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:47:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VTDHFkSf4qnexNOBoXzV-sMPBRjSqMrB_nrsuCPpO=WQ@mail.gmail.com>
Message-ID: <CAD=FV=VTDHFkSf4qnexNOBoXzV-sMPBRjSqMrB_nrsuCPpO=WQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: qcom-geni: drop bogus uart_write_wakeup()
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 8:43=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the bogus uart_write_wakeup() from when setting up a new DMA
> transfer, which does not free up any more space in the ring buffer.
>
> Any pending writers will be woken up when the transfer completes.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
