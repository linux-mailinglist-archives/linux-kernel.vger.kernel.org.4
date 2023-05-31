Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A9717F84
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjEaMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjEaMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:05:19 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA081AD;
        Wed, 31 May 2023 05:05:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1313007276.1;
        Wed, 31 May 2023 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685534702; x=1688126702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90EYsaaut8Hp0lsfigX/jDM1gZJQqV5otkFZlFhJNrc=;
        b=LO9z7akObMs+flCvgEiN7Ww9vOe4EGy6hwFM09vjWA4Fm3RRZFO/eKxe+kO5RB2Cfc
         c69aVw0P8hWiaP+AssKqJNpPQiiEnV6jcycCQT3yZ84uzKjwzzuzKPU7qnKUZAZTn4f8
         87S6yF9S+G3bRJZj8RopHm2zeyA4MINRoOt2QfGRtVlawGI9j4MzLzBUk0jiej4xP9x4
         Jc7fqqv7IJeQIyedpIhCRagSNEYZfGOfGBHefkOIIwbdOMOlvH+6/Pv1zUAWh/nRyv6/
         GLW7KGexR1gyMIso4d1+WPd+QLmHrp0Eo6uCOwnBOhKvuMh0uiyNsCgH/NyVCpFsFLMO
         7Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685534702; x=1688126702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90EYsaaut8Hp0lsfigX/jDM1gZJQqV5otkFZlFhJNrc=;
        b=KSWVLIiomQXCujN+Wua6/MbUoT4BoP6Uboe+KmWSOvY/o8DaDMl3EmT0sNDy13M9fz
         JUQ6iQa6IZSz5gJ7oH5oRMh9M5Y2o3chtxbtLIhzGEW5t2w1ZhGFE17MPQ8AVQgK279V
         T7mliHoiEkpQCK64UJvwibH/5IvNjdBpYm70kqV8RqqKU/jRIACmvrOQLFgPFKR4KOYr
         74mTcj7TRekzzu5vNwuftOvfwfbZACKmVsDllHpVrb4eWThFjl9dOsDa4srKmGa0Gz0h
         KlryIZ17D8OYbv6GJVme8LlMkpYArDL+OB77s4sHjo3skYOpdAp2vykFrKIU6CZNP4le
         QB/A==
X-Gm-Message-State: AC+VfDwHQJJ/L3ZQUg3ewYWNrmq+H3PWHJ7qVs3hTwDIahPUkgcdq+Za
        evme/cNzj/g6tArqBNBYd6zJCf8u96qpV6Fl3ue3RwN/
X-Google-Smtp-Source: ACHHUZ55R8CtsEj+7X29bkdOuuVetNFI1MoEEvPsUsgG3RjGiPmflERC1G9L+kWBQa8t/0i3JO+qJsnUQH4MlCQdlfM=
X-Received: by 2002:a25:508c:0:b0:b94:bbf2:19a3 with SMTP id
 e134-20020a25508c000000b00b94bbf219a3mr6284726ybb.18.1685534702013; Wed, 31
 May 2023 05:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230527012206.133464-1-samsagax@gmail.com> <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
In-Reply-To: <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Wed, 31 May 2023 09:04:51 -0300
Message-ID: <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This attribute is a no-go. It is not even remotely related to hardware
> monitoring, and thus must not be attached to the hwmon device.
>
> I don't know exactly where it belongs, but it appears to be related
> to the keyboard. Its natural place therefore seems to be a keyboard drive=
r.
> We could possibly also attach it to the platform device, but there would
> have to be some precedence of other drivers doing the same. Question
> in that case though would be if this is just the first of many attributes
> to come. If so, we would need to find a different solution.
>
> Guenter

Sure! Should this driver with those changes go into a platform driver?
Seems a better fit to me. The case against keyboard driver is the
switch changes behaviour of the key but both the behaviour with the
switch on and off is device defined. Some use the key as part of an AT
Translated Keyboard and others just operate on the EC itself to grab
the fan and set a special TDP for "Silent mode".
For now this is the first such attribute found by the community and
some talks with the manufacturer but it doesn't mean there wouldn't be
others. Specially with such new form factors adding some "control
panels" on Windows to set some hardware behaviour via EC writes. My
goal is to allow those same functions to be available to linux users
in a way some other userspace tools can serve as front ends.

Would taking this same driver to the platform side be a solution to
that going forward? It would be a combination of hwmon monitoring
attributes and some other special functions with custom attributes.
Seems a better fit to me.
--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
