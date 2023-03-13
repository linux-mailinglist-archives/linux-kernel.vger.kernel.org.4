Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB86B8321
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCMUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCMUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:53:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445530C7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:53:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s12so14642111qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678740799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXlzN006xu3ZBfFq7erm402Or2NyISMhbX+wHGYXkEM=;
        b=RDmBtzFUQNSD9k7vDVWoJ8xivUncG1fAfuOcyzlvynCqpKFdgiir/8a0fQYHDlwEty
         lZt369Z+aT9SloLpv4jerU095xvCqM31GaFCOB72saRT/GS88XmRm7AapWi3EMpJitQi
         7LCgBQPO6MCHbeKl4TRChLMnViLUbM+UBsEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXlzN006xu3ZBfFq7erm402Or2NyISMhbX+wHGYXkEM=;
        b=fN4g8hmvfG0YsSVS42DFI9oSHF08S1s7nYfBUxzSZZBOjsSEryBWxoH4xvpZT09LZn
         E2/JdLesVVR7OMvmXnNFhqCHUbuEioaKmRVg4yuE1O6SfmI8AYieuhvtlJhZRAl35f42
         SQIQ9f8sL6tfvz/cOBxuiQg5AqEh+g3a8O7LsPBS71X+BKvAnhsgwcRLGiVeSfSC6vel
         hv4W7KPRgidgtgkiITWsrAs8wHA70bhyji4VsKcC4ruMjz0Ocixg1vWUewQqLv3FB2bL
         A/4aMfZvnGDFMDz35cuSCREmJ7nHCXMsQwgH75+L56EGYPeqUYSmcIVxbeOl8jFdkPDB
         FgUg==
X-Gm-Message-State: AO0yUKWI0EVFIbW8anDeTB4ZWbXzLRzpcinEIVGBel+XLp+SN+pltJgr
        Vocd4HnsB4/y8iTYOr8/ilZMB+mgPQauvjqEog8=
X-Google-Smtp-Source: AK7set+dBGPH7Zh2aASDi62aiXDj5E6Kk2hT53wPUuV4rRATIrC51OctRSqvwRuqGQL2nZH4MmPcRA==
X-Received: by 2002:a05:622a:649:b0:3bf:e2ff:4c2f with SMTP id a9-20020a05622a064900b003bfe2ff4c2fmr25289581qtb.51.1678740799196;
        Mon, 13 Mar 2023 13:53:19 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05620a808e00b0073b967b9b35sm383684qkb.106.2023.03.13.13.53.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 13:53:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5445009c26bso40057307b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:53:16 -0700 (PDT)
X-Received: by 2002:a81:ed06:0:b0:540:e6c5:5118 with SMTP id
 k6-20020a81ed06000000b00540e6c55118mr6945254ywm.2.1678740794346; Mon, 13 Mar
 2023 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
 <20230307073155.2.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
In-Reply-To: <20230307073155.2.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Mar 2023 13:53:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
Message-ID: <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: uart_poll_init() should power on the UART
To:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 7:32=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> On Qualcomm devices which use the "geni" serial driver, kdb/kgdb won't
> be very happy if you use it but the resources of the port haven't been
> powered on. Today kdb/kgdb rely on someone else powering the port
> on. This could be the normal kernel console or an agetty running.
> Let's fix this to explicitly power things on when setting up a polling
> driver.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/serial_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Just in case it's not obvious, even though we ended up going with
Johan's series [1] instead of patch #1 of my series, patch #2 and #3
of my series are still relevant. I can repost the series without patch
#1 if it's helpful.

[1] https://lore.kernel.org/r/20230307164405.14218-1-johan+linaro@kernel.or=
g

-Doug
