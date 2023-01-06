Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F566021A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjAFO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAFO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:28:10 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730213DC7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:28:09 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o63so1579718vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMM1OY74tfbGddQUb6ZKJePw4/6yed/og9l1W9H7JVA=;
        b=Yw2ih4DCRRNQOx2RNzOUzWndLvFAZP8G0HRaPqmfGYcZCSoIjGOufaNdLYhp1dPKaQ
         9OaUtRi9D8e+WdaQffSJUiWpH1VMACYlgmMYQWwZpJDcKiEipUKqcUl85rQrfFVenE7e
         oG9haiuJhty0GRRhSSWo85yTVRKJcf+7m8V9LrV4OPyc44hzLaVAm3xodkn5/Q1MopX+
         O/jEVZvABOuaIkxBXnvUFp3soQM35/nR3FPXceQf1r63oP/szBw0TBydJ2ExIFhkNvyc
         WXMvc/1ZuOtbOoneV5z+j2VtrxX8FAo9vewSYpa155wpf3Qra/y2Y2WTaVCoqwnw43pj
         fR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMM1OY74tfbGddQUb6ZKJePw4/6yed/og9l1W9H7JVA=;
        b=gLpMvpJP9uTjoLtYaI/jHuiGdJRr2ZwfGRc1tMKZNC5EuvCrpjEnsI3QG4/bvHtAaZ
         Dil5bOV27yz5PdHH9sbNHPOrHeVBj/0zAGFZ7vNf6xyER/AFmdfd9TAXCjSM056wEJJw
         Vy2BsCY7BccgKdGx0O/+GMep4MliTO1vWgvKEogn3fY/qxB9ZS3Pz6a7wP3vrcC6BCq4
         wnAmP9ytjBoKGc7btGAf414HkBO4smNLPRDGBJdSa2iWIh4BtdWOOGwDoB6fFzstlpGf
         wowM1PE6YfiRciejxqG6XefgthjTK+P5tQ73cOzpoLT3YExNbp9proaZ4VA4p5yfRQFl
         /FFw==
X-Gm-Message-State: AFqh2kphOYeCMu09fOhF9zdl+fyg70T0MBKPwMZ41SU1H9zpemQI80lV
        mWCRs/KwMdXqMce2TES5P5qWTpla118HScZMOYpa7OpetvXNDw==
X-Google-Smtp-Source: AMrXdXuIXCCXkcH+l3mnFoJpDaYRjAVNk+SVVnWU1LUbZ5m8pTLFcWofhciLCqpCAWswg0RmxrbjdwHNpCNApTUGUrs=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr5516214vsv.9.1673015288732; Fri, 06 Jan
 2023 06:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20230106100719.196243-1-brgl@bgdev.pl> <Y7gsiW6lAsz/krsV@sirena.org.uk>
In-Reply-To: <Y7gsiW6lAsz/krsV@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Jan 2023 15:27:57 +0100
Message-ID: <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing spidev->spi
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 3:13 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 11:07:18AM +0100, Bartosz Golaszewski wrote:
>
> > - use a mutex instead of an RW semaphore (but for the record: I believe that
> >   the semaphore is the better solution here)
>
> Why?  Like I said in my original reply I'm not clear what the extra
> complication is buying us.

Typically, we'd want to keep locking as fine-grained as possible.
Logically, there's no reason to exclude concurrent execution of
file_operations callbacks. There's a bunch of code in there that could
run at the same time that we're now covering by the mutex' critical
section. We should only be protecting spidev->spi here so any other
locking should be handled elsewhere.

IMO the complication of using an RW semaphore is insignificant and
maybe a comment next to its declaration in struct spidev would
suffice?

Bart
