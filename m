Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DE5BD364
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiISRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiISRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:11:38 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCA3BC6A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:09:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12c8312131fso342385fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OIqO/S1ZFD6/odc/wEltJmiEsZnCmMo93C19sjkWsXo=;
        b=RvBt3uTxTki34wA/VB78rduPnbaxzkopyCiw7zrpkU3nPFt8Yob2CLzdTD/RLTMyWt
         tljPvrefcBZUm7gEArLfzQ0UGMDWDfbsVu1A+CjPZNlBxwPJqsijk+zWqrdtG6WZIydm
         NhMTZIY/VK9t5IXeyMeU9jx2KjqNKhNhJaHz53KxNAxndJjzKODeKfLO5bYn0HSKrf1K
         2+euU+llhno4ea78cD/CaBzlgfxT5eTWh6xhJp1njc1CzPrmHPciyjdwzmWdYa9eWDk0
         9LMk3Zwu4kClZcW3rbJJKPMx05efDWwyKbJYoTz6CmgMWSt7HjGv6QwqYWrqx6i6iQY7
         iHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OIqO/S1ZFD6/odc/wEltJmiEsZnCmMo93C19sjkWsXo=;
        b=nIqK93QvrTzU6dJ9HzuOd6qUSQBnMR+uNWygX/c6Z4QJpDliqCMJmXjmArdH+Lp0rA
         AWWdzKrwZr+KgROGVwKPDnocLJatqZEsHlijxeYBrPhDngJDRtGKwL5XCc0RJrMpbScV
         Elg/Y+GoSO0BMJe2+pX16Gu8YPUT9k6a82MttPAijQb/vbk3wkp3nwxrIcmXbsV0ALhT
         uLezxz097pSoX8lr8tzNmMCYxrmXSo85ieKn15dBRiyBJOiGzR2hXzzhRh/kx4879A6d
         2+qyme7jf3y+7tWvfCgA6iU09KYieoktXro8yeZh+EPgPLjS3tC+Vdb2hvjlHm7/o0Rd
         2e7A==
X-Gm-Message-State: ACrzQf2TEc3/StLef3DK9YvUC+FhwR3mnpAwBp6vm971LrNE3jagLqiK
        tNS1bVT4gMU2CpPvHNdBa8oI8uTO2G4SAn+cu+erYw==
X-Google-Smtp-Source: AMsMyM5s2Fkzx1sLXzuTUpg7sC/6WO9mkkBto/5rRckBP+2iU8rE8d5WQ2oWHcWh5tCj5vmea4VBBPF9GtnfGUdtwKY=
X-Received: by 2002:a05:6870:d6a9:b0:127:fb20:c5c0 with SMTP id
 z41-20020a056870d6a900b00127fb20c5c0mr10495664oap.175.1663607389082; Mon, 19
 Sep 2022 10:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663577091.git.cmo@melexis.com> <dadcba138c48286944cc03563967de9b4daddaaa.1663577091.git.cmo@melexis.com>
 <20220919172420.1a6fd52f@jic23-huawei>
In-Reply-To: <20220919172420.1a6fd52f@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 19 Sep 2022 19:09:13 +0200
Message-ID: <CAKv63usAjTh9b-HuVdikbtdPKeyFYPy0kENQpkGo6jWXkE_Quw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 18:24, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 19 Sep 2022 10:48:16 +0200
> cmo@melexis.com wrote:
>
> > From: Crt Mori <cmo@melexis.com>
> >
> > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > rate (2 seconds).
> Hi Crt,
>
> I'm a little nervous about one change in the flow from earlier versions.
> I'm assuming you are sure it is always fine though!
>
> Previously before calling the _sleep() in remove we ensured the device
> was powered up. Now that's no longer true. If runtime pm has it in
> a low power state it will remain in that state at the point where we call
> _sleep().
>
> One note/question on original code...  Why bother marking regcache dirty when
> we are going down anyway?  It's not wrong as such, just probably not
> that useful unless I'm missing something.  Same in the *_wakeup()
> that puts the cache back but is only called in probe now.

Previously when powered on the device the cache was not updated, so I
added the marking of regcache at wakeup and saw that the same thing
happens when in resume after powering on. I should keep this
assumption still, so I will re-add the wakeup to resume (not runtime
resume). I did not test this part as I focused on runtime resume so
thanks for noticing.

>
> Which then raises question of why we don't need to deal with the regcache
> any more when we turn power off in suspend?
>

It just did not work properly without this. Not correct EEPROM
coefficients were used for calculations.

> So either we need a statement of why the register state is maintained,
> or add the maintenance for that.  Also probably makes sense to drop
> the left over maintenance from the probe() and remove() (via devm) paths.
>
I thought I did that by completely removing _remove() and using
devm_actions for cleanup. Do you see a spot I missed?

> Jonathan
>
> >
> > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > +static int mlx90632_pm_resume(struct device *dev)
> >  {
> > -     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > -     struct mlx90632_data *data = iio_priv(indio_dev);
> > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > +
> > +     return mlx90632_enable_regulator(data);
> > +}
> > +
> > +static int mlx90632_pm_runtime_suspend(struct device *dev)
> > +{
> > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> >
> > -     return mlx90632_wakeup(data);
> Previously we called wakeup here which writes the regcache back to
> the device. Now I'm not seeing that happening anywhere in new code.
> Why is it not needed?
>
I had the same question before, why cache was needed to be marked
dirty, but without it, CPU did not properly obtain the calculation
coefficients. What happens now is that we are in step_sleep mode so
measurements are triggered and it also takes the 2 seconds before they
are updated. I did not check the line with scope, but I have yet to
see the strange temperature output which would indicate that not
proper EEPROM data is used. But I did focus on sleep mostly, so deeper
sleep I did not retest.

> > +     return mlx90632_pwr_set_sleep_step(data->regmap);
> >  }
>
