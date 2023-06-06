Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D881724C06
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbjFFTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjFFTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:02:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B810D5;
        Tue,  6 Jun 2023 12:02:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543d32eed7cso882733a12.2;
        Tue, 06 Jun 2023 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686078125; x=1688670125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zorJynEf8LptTjq6m+OnDgS8VLEV9nuJA4KmkfWWNG8=;
        b=ZbWuK61Uqo6PeYq7Bqzwio2drMqyWcH/IU2N3d6E16gOmNN2z9maqpqUr81gt9atwP
         vdudEdOr0jhihTNZUDVlJQjuSBMz94I61e+oo1aIW89fVgXImvD2DCoyDJXX3cz2+2n8
         I+KPuiETAaL501bjYz9VWmKCeHdEAHt/BjEp5h38jH5883WJNBSvNiKuGMmywKjoN9nS
         uw7O6OA4b1EjZBklW/AE3WzHARGy0G2W4jo7WTfPTPjP5hqOnnothhFXW5AyYSiL3cXN
         pd76lvwLfWHKylBmGefA1n1ikkBl09LCeqYGKqWyIrmNd813dBqT7RktiglAZdo/i8fs
         /tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078125; x=1688670125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zorJynEf8LptTjq6m+OnDgS8VLEV9nuJA4KmkfWWNG8=;
        b=G5x3vSqnTEjK2W4s23NaFjI0iHXVMkCWqIoL1AwAI64Zmqx885nNOOpU8DMomAvsJg
         +U+AHHd7FmjvlNtaa9gHP6FPJ3Gd29tgz66/00TsSLaJWHjEpHREF1XsCh3iEKuR5zm5
         61l2RkJZhCCf6Ypd76GSwKGW/Pmb1TnQitQO+c8QrNYj9WuZj6QzHA/jgSrWbM/Vv2+9
         5xLxxbSlgm75yjp+ZRK4zTPlAmUuTUOzcG1d2Gf/e5H6LZHk8VdXHH+sBYnrq18FArEu
         rOASW68azrdI3GmAg33DuPG5lSo9oQxGQ9X532wEa+alAmhHVmFAuSwJidO3z3TJaJCp
         IUpA==
X-Gm-Message-State: AC+VfDwiVyKXprF+hBlwQj30bWJz/AOaz99dh8iR0bwv/yl/1MCIJaZO
        2KPb/OMMt8STlGB+ZIoQwlM=
X-Google-Smtp-Source: ACHHUZ6Qk17vBLxhsvAUdKKB6ZljlKIyCDj81ro9Z7d7yrElU6XmjFTVfl6sjofEU7M+iFnoUn1mJA==
X-Received: by 2002:a17:903:1110:b0:1a6:74f6:fa92 with SMTP id n16-20020a170903111000b001a674f6fa92mr1952737plh.19.1686078124951;
        Tue, 06 Jun 2023 12:02:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b00199193e5ea1sm8899234plh.61.2023.06.06.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:02:04 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:02:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
Message-ID: <ZH+CqXOFt6WsdZ8L@google.com>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
 <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
 <ZH9+ndrF0RIgFhnI@google.com>
 <665c9aa5-ef70-65ce-7d9c-4b3b93874934@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665c9aa5-ef70-65ce-7d9c-4b3b93874934@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:55:35PM +0200, Neil Armstrong wrote:
> Hi Dmitry,
> 
> On 06/06/2023 20:44, Dmitry Torokhov wrote:
> > On Tue, Jun 06, 2023 at 08:12:04PM +0200, Neil Armstrong wrote:
> > > Hi,
> > > 
> > > On 06/06/2023 17:31, Hans de Goede wrote:
> > > > Hi Neil,
> > > > 
> > > > On 6/6/23 16:31, Neil Armstrong wrote:
> > > > > These touchscreen ICs support SPI, I2C and I3C interface, up to
> > > > > 10 finger touch, stylus and gestures events.
> > > > > 
> > > > > This initial driver is derived from the Goodix goodix_ts_berlin
> > > > > available at [1] and [2] and only supports the GT9916 IC
> > > > > present on the Qualcomm SM8550 MTP & QRD touch panel.
> > > > > 
> > > > > The current implementation only supports BerlinD, aka GT9916.
> > > > > 
> > > > > Support for advanced features like:
> > > > > - Firmware & config update
> > > > > - Stylus events
> > > > > - Gestures events
> > > > > - Previous revisions support (BerlinA or BerlinB)
> > > > > is not included in current version.
> > > > > 
> > > > > The current support will work with currently flashed firmware
> > > > > and config, and bail out if firmware or config aren't flashed yet.
> > > > 
> > > > What I'm missing here / in the commit msg of
> > > > "input: touchscreen: add core support for Goodix Berlin Touchscreen IC"
> > > > 
> > > > is an explanation why this is a new driver instead of adding
> > > > support to the existing goodix.c code.
> > > > 
> > > > I assume you have good reasons for this, but it would be good
> > > > if you can write the reasons for this down.
> > > 
> > > Sure, should I write it down here and/or update the commit message in a new revision ?
> > > 
> > > Anyway, here's the reasons:
> > > - globally the event handling "looks like" the current goodix.c, but again the offsets
> > > are again different and none of the register address are the same, and unlike the current
> > > support all registers are provided by the "ic_info" structure
> > > - while with the current code it *could* be possible to merge it, with a lot of changes,
> > > the firmware management looks really different, and it would be really hard to merge.
> > > 
> > > But I may be wrong, and may be misleaded by the goodix driver structure (even if it
> > > went through a really heavy cleaning process).
> > > 
> > > Globally it seems they tried to match the "event handling" process of the previous
> > > generations, but the firmware interface is completely different.
> > 
> > It is not unprecedented for drivers to share event processing and
> > implement several ways/generations of firmware update mechanisms.
> 
> Thanks for your reply, I'm perfectly aware of that, this is why I posted
> this as RFC.
> 
> If the event handling is vaguely similar, I'm not sure it's worth refactoring the
> current driver since I do not have the old and current IC datasheet nor
> HW to check for current support non-regression.
> 
> What I'm sure is that not a single register address, flag or struct is even close
> to the current upstream defined ones.

OK, it looks like Hans' preference is also to have a separate driver, so
let's keep them separate.

Thanks.

-- 
Dmitry
