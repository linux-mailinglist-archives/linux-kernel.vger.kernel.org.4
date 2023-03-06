Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262276AC0F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCFNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCFNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:30:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB62A6F2;
        Mon,  6 Mar 2023 05:30:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so38643498eda.1;
        Mon, 06 Mar 2023 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678109420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlUIZeGKWllbgJ8I0debpUyJbB/h2BZZK7zfLl+T+sw=;
        b=JDGDyESZLrKV4bbADwCK/CkVk5mWHbYgn45N/lZG4Fh9dy1jtaa8LDP1uPSM1maEvg
         mv+JoSG/l1iq5uQb/jLx4vpTMu4lDwWKVrjlSmQpaZbKV1CdPMenpq6fNee0KgYBf2ds
         lvNORzWfPyu9OQNj8I+NRVPeqVSLmhn9v0K5dtqRJlTXIGfwmNQ7X717POL3QkCkXbYQ
         +aa2+2TdC+Xty7f844ZOfQmMUHfZ33N5D+5YmNyHpEpfin2riYM73UwagUQT4Tu/6Oye
         1gWNtH1lKOa5zEQGcwA7L/tp5I3BU1nWI22XGeBDmRqXDCTKILBcVaytIHs+h5fyrpyW
         xMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678109420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlUIZeGKWllbgJ8I0debpUyJbB/h2BZZK7zfLl+T+sw=;
        b=UJLHc4JrtgJqSKM9EBbSXRbcnWNoW6APtrpEEz3Est9edgsjcOdAn99vrvAZEv5TMO
         G/Nf4JhYugaOnuP06S66ZJTyI1gdTXCfekMCb9FD3RB5Vd7r/DnehGRgK290ArX4s0MT
         lx8iCyPw4YfI+VdSAZEGGnL8aSoTn/VDYfi19pM4fcFxGMVAkQNLMKuv3CLWtvAuaczc
         P1q1CA4eDE5U/1nrrRb2Xas5C7GiBnDD0+uJC+ciRye226d65ErJZBjdWVCdlqayUP+z
         vmhkjtOXtApjmPJAVYs7yPoAmjO7YtrB4l1pJDhMcMhXj9MmnCTjhd4MknTIVwhchOmX
         WawA==
X-Gm-Message-State: AO0yUKWd9ny8kVykzU3wIS+ao7mT2GEB/5sCzrlskBgvzbPbv6pEB0um
        CVjrp9ZuxXtTDBj9zyrx/gLxmRu2Dug=
X-Google-Smtp-Source: AK7set/G2hQg8fRoZARn35+XEBYXA+yPVfpiIMJpRFYoZgbAOVgnNNIyS7EEMlBAHZZ2ZQEJn1dbZg==
X-Received: by 2002:aa7:d385:0:b0:4ac:d8a1:7385 with SMTP id x5-20020aa7d385000000b004acd8a17385mr10737354edq.3.1678109420395;
        Mon, 06 Mar 2023 05:30:20 -0800 (PST)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id t26-20020a508d5a000000b004a9b5c957bfsm5149564edt.77.2023.03.06.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 05:30:19 -0800 (PST)
Message-ID: <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
Subject: Re: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Mar 2023 14:32:18 +0100
In-Reply-To: <20230306044737.862-1-honda@mechatrax.com>
References: <20230306044737.862-1-honda@mechatrax.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 13:47 +0900, Masahiro Honda wrote:
> ADC using ad7793.ko, such as AD7794, may read incorrect data.
> Extra interrupt is pending if the data on DOUT contains a falling
> edge.
> Therefore, wait_for_completion_timeout returns immediately.
> This patch fixes the issue by setting IRQ_DISABLE_UNLAZY flag.
>=20
> Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> ---
> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index d8570f620..364051809 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -584,6 +584,7 @@ static int devm_ad_sd_probe_trigger(struct device
> *dev, struct iio_dev *indio_de
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_completion(&sigma_de=
lta->completion);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sigma_delta->irq_dis =3D =
true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_set_status_flags(sigma_del=
ta->spi->irq,
> IRQ_DISABLE_UNLAZY);

Hmmm this looks to be a very likely issue for any device having to
brute force IRQ disabling by disabling the line (disable_irq()). That
said, I think the commit message can (needs) to be improved. The
message feels a bit confusing to me. Also, having a reference to

commit e9849777d0e2 ("genirq: Add flag to force mask in
disable_irq[_nosync]()")=20

would be nice to give some background on why this can be an issue.

Another thing that came to my mind is if the data is totally
garbage/wrong or is it just some outstanding sample?


Some research on this also seems to point that we should (need?) call
irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.

I also wonder if we should keep this out of the library and have a per
device config? Sure, this won't make anything wrong but it will hurt
performance. OTOH, even though no one else ever reported this before,
it looks like this can be an issue for all of the supported sigma delta
ADCs.

- Nuno S=C3=A1
