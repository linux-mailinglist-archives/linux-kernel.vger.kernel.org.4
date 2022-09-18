Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7A5BBD5F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIRKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:06:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF101CB3D;
        Sun, 18 Sep 2022 03:06:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g3so21823737wrq.13;
        Sun, 18 Sep 2022 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=o4PKrtOV3hjZ2HciWVNIW8JEQ2vqAcG4T6c1ePMa+qI=;
        b=R0jgj/WbIk7Z2FU7IsoyaKmcgP+KLGEE4wA6hbE/kHxKM7o4ymeqUJKYa8TNSMsaNS
         wush0w73fVn/Q6NnV4WQ1YgH6ZimRdz64umXuIQrd6CTZBnfMG/cWhokwUWaqeQJuTBB
         Krmj/aIk2nnTsxOHREiUW87mAGI4tvYczei0lw8fEmD2AUh23UoxgXTVAfCyEHGVVGDY
         h2+zpPdFKZXqA3SGSyPuIPmlDwm6V/rVBhRj6JRPRk94RUfyoQ0esjA3c+7C3qm6xq7X
         opArCWIXAt+ClMY1Ev07X5poo1TRBHt/EHD2VyrWzpZDfdbdR/VfsiOm0IAOCeZUfpqH
         bosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o4PKrtOV3hjZ2HciWVNIW8JEQ2vqAcG4T6c1ePMa+qI=;
        b=iLYWyI054jqcIO9RyEDFEZP4AxxbV9qculcxQSJ89hu+yPGADeUtMjmS3eiQ5Lsgc0
         J4rxufG5hSbrdTlRIAocztBqSGgbMhDvGwZzfr4LDW5vgQznH3zXnw5BPo78vJ7t1NeJ
         Xu1/SYnJcR+CADBHCjTDfSyShP5edyAC4AdAWvsYW+cBIHbaSqMGEPIBxEBvdD/EeUmq
         PAIFkCXyoYu9iosUCKW8nHg+sgnjFp+Klm4Ac781i5K2EYMToV1w6CcI1dZLXb8lP5gY
         IvuzG7jQHfVsYLjLR9nT6ItNqMwl7P0l/lsyPEOZRevSkjNFXILWzGKEUlS04kwOyxwY
         FT9Q==
X-Gm-Message-State: ACrzQf0ABF7MbB98PYWQo9aFEUCGLBBWQim/luWFDemQVnHs1soE0+kT
        Rfq5WFyXndZ9D+IiiiOz+mXbguNDslI=
X-Google-Smtp-Source: AMsMyM65sxGvvK6izucDWRcbwfmARi57unwdhE65miZvGQTlbgQmngF2v54PiVmH9J/zUl31TwhR7w==
X-Received: by 2002:a05:6000:1548:b0:22a:c113:c9d0 with SMTP id 8-20020a056000154800b0022ac113c9d0mr8015829wry.653.1663495607871;
        Sun, 18 Sep 2022 03:06:47 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6a45000000b00229e0def760sm9883580wrw.88.2022.09.18.03.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 03:06:47 -0700 (PDT)
Message-ID: <2d7334210b41b256f6d7dc2cfd34036375ebf755.camel@gmail.com>
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 18 Sep 2022 12:06:45 +0200
In-Reply-To: <20220917142516.3fc145b6@jic23-huawei>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
         <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
         <20220917142516.3fc145b6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
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

On Sat, 2022-09-17 at 14:25 +0100, Jonathan Cameron wrote:
> On Tue, 13 Sep 2022 01:52:13 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>=20
> > Adds compatibility with the new generation of this sensor, the BMP380.
> >=20
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> >=20
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API.
> >=20
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> There is one place (around the reset handing) in here where I
> suspect we'll end up revisiting it because the matching by
> device ID is not particularly extensible to new devices.

Yeah, after the first time you raised that concern I've been thinking that =
maybe
it would be better to add a new "init" or "preinit" callback executing firs=
t
boot tasks for a sensor, such as this reset. Please, let me know how I can =
help
with this matter. On the other hand, I'll have the BMP390 and BMP581 on my =
hands
in a week or two. The BMP390 is almost the same regmap and operations as th=
e
BMP380, so I think it will be an easy addition. The BMP581 is a new beast t=
hat
brings in lots of changes, but still has a good bunch of similarities.

> Anyhow, can handle that at the time.
>=20
> I had to hand apply parts of this because of the clash Andy
> raised.=C2=A0 As a general rule it's better to keep one linear
> flow of patches unless they are on well separate parts of
> a driver.=C2=A0 Saves me effort :)=C2=A0 Here it was just one line to
> cut and paste, but you still get to now check I didn't mess
> that up ;)

Sorry about that. Thanks to you and Andy for the extra patience with my mes=
sy
patches.

> Applied - please check result in testing branch of iio.git.
>=20
> Note I plan to rebase that branch after the first pull request
> is accepted as I have some dependencies blocking other
> patches and a fast forward rebase is the easiest way to deal
> with those cleanly.
>=20
> Jonathan

With kind regards,
Angel

