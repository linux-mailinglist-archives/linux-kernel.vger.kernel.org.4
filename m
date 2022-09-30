Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A905F0F48
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiI3Pwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiI3Pw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:52:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D2C103FF9;
        Fri, 30 Sep 2022 08:52:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r62so4493530pgr.12;
        Fri, 30 Sep 2022 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2T8Z+8mq8mSUbSxtx0J9KasGVC/gpl3JV2RqSGlE0ik=;
        b=pszkwON9cE4UJtIuzKTMZnAKyB2/0cDq0yOGOh7PSVwctH4KEbsF66tt0A1XkrRmV6
         b+4AcggEzv3kLFBPZEIVFv6Y3aSV2X278OBNqHJ76jTwbqZnMWltd8Dx3Yc4kCaTdae0
         cmMFZ1LV+IaLBkztg5WFMLXCiF5hsnAO8maQVQDm8T69w/s2FCbde91YW4b4l7cBTP+m
         RZa4WDDca2wIuj7YTSyvikMLSjh4WUxrgEvQotydT4Q9oOwy/ioh1Ank0ztawV+0kdwD
         aVESTT/kMQaoBet+BSQCWP90vuVwF7oQ0SY47xWTVRhGiQ0B2gglTTTSGJWuGJ5cfAPm
         uhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2T8Z+8mq8mSUbSxtx0J9KasGVC/gpl3JV2RqSGlE0ik=;
        b=ff4sjBDfF7ZjNx00r/mYUeYSo3+7PqicWnOlcGIMx8sno+KozPWk3onqIIqeuSB377
         SfpKRqTgXTaQIdyaeurTInmK1HSp/DjYPzOmDHXPhcnjYWz92+WUAUN+KNUfRHvNGDTi
         o037BohatyGHiRhTb2hXQNMmcd9kjfDe+0itwsFlXaD+jUx4q534w7eKb+GvRfA0cdCZ
         lyWsuLU8TOqy6u1WkeWC87geP9RigvW87kh3d+w013RVlm+WAGfJ7EykUtWSNinBVeRG
         gWWW7O16xbdKhwyy0/Ql6/69D2QpiPXdc1QuFxFL/+Tcc5tWqlJcoYnuq1Py4D54Ifbr
         0nUw==
X-Gm-Message-State: ACrzQf0SN8d0pThv0B83s/Ds8Q+E0EvC5qLRDrT5TZkzho+OWLal5Dqn
        nEP3lBc30KSI3SQ69re/NRg=
X-Google-Smtp-Source: AMsMyM6m/zZ6R3cv74My3+B5P49eTZfRXiYe+dSoiwo4mApsFYjVR5f0XfJ1OX2nLwbZ5S+NN6tfQw==
X-Received: by 2002:a05:6a00:16c8:b0:53b:3b9f:7283 with SMTP id l8-20020a056a0016c800b0053b3b9f7283mr9878617pfc.46.1664553147725;
        Fri, 30 Sep 2022 08:52:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id k81-20020a628454000000b0053e2b61b714sm1936554pfd.114.2022.09.30.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:27 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:52:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH v2] MIPS: pci: lantiq: switch to using gpiod API
Message-ID: <YzcQuBqbQ03PbCVs@google.com>
References: <YzE9E+Esv/rqO0MA@google.com>
 <YzKDFCq3M2gxlJ2e@google.com>
 <20220930151525.GC12989@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930151525.GC12989@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 05:15:25PM +0200, Thomas Bogendoerfer wrote:
> On Mon, Sep 26, 2022 at 09:59:00PM -0700, Dmitry Torokhov wrote:
> > This patch switches the driver from legacy gpio API to the newer
> > gpiod API.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > v2 - actually compiles.
> 
> I have some doubts...

You are right, I am very sorry as I am not sure how that happened. I did
indeed have a version with the exact errors you pointed out, and I fixed
them. I am not sure how I managed to send the wrong one to you...

I will send out the right one as v3, in the meantime here is what I see
on my end with it:

dtor@dtor-ws:~/kernel/cross-tmp ((b4938080955f...))$ date
Fri Sep 30 08:46:26 AM PDT 2022
dtor@dtor-ws:~/kernel/cross-tmp ((b4938080955f...))$ git log -1 --abbrev --oneline HEAD
b4938080955f (HEAD) MIPS: pci: lantiq: switch to using gpiod API
dtor@dtor-ws:~/kernel/cross-tmp ((b4938080955f...))$ git show HEAD | git patch-id
2f4c9e4f56e674980122ce426c9ca9281eb393a1 b4938080955f015ffd1a8f778ce57b2a8e50c7ba
dtor@dtor-ws:~/kernel/cross-tmp ((b4938080955f...))$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross -j1 O=./build_dir_mips ARCH=mips SHELL=/bin/bash arch/mips/pci/pci-lantiq.o
Compiler will be installed in /usr/local/google/home/dtor/0day
make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/usr/local/google/home/dtor/0day/gcc-12.1.0-nolibc/mips-linux/bin/mips-linux- -j1 O=./build_dir_mips ARCH=mips SHELL=/bin/bash arch/mips/pci/pci-lantiq.o
make[1]: Entering directory '/usr/local/google/home/dtor/kernel/cross-tmp/build_dir_mips'
  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  CC      arch/mips/pci/pci-lantiq.o
  CC      arch/mips/pci/pci-lantiq.o
make[1]: Leaving directory '/usr/local/google/home/dtor/kernel/cross-tmp/build_dir_mips'

Thanks.

-- 
Dmitry
