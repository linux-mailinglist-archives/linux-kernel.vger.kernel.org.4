Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2660046E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJPXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJPXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:50:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E341CB06;
        Sun, 16 Oct 2022 16:50:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r13so15999782wrj.11;
        Sun, 16 Oct 2022 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=hqOSIJYANytRgjreYBbHhrU6O3a0X+o3akj1sgVCeIg=;
        b=PglFXOXth5k4R5xVSOxmYKOF0Hlkc1mvgZPlm3QC3dFnfHxmCijpO8b++RsH/WeUj4
         mgQN+eP1uTn1wR7Kd+1WyoUBuTHXEZoVDZhs8hgfkQiWQY2QSxCp/qDI019pTcJs9Ghw
         CPwC6TxgMLJ3tjdzSg0Gogg6LwTALMgbSSAVEDjGhWPnB6Fxs2HjJE9Xsp3slsCVqiJ0
         sZYb2NxewbMIFEtTtD/WEOCbxWXQiZnln/iDSoXtSzMhSC+L8kNNBhlRrwMONFv7ARv3
         A+ZdtU++tITX4YOr0WIyMlmH3ReuUsg0Pb7THD6f0H3VUeDmdrN4vYicYZ3jEH7BIzv5
         WSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqOSIJYANytRgjreYBbHhrU6O3a0X+o3akj1sgVCeIg=;
        b=Vrii43qzTgXXGDeIKda9see8VcHMWruDHRMzKClloaFrAcqTjB/9i2jSRQN7v0j/Z/
         C7T1xorjSCEu8+OAVuFKS4WwhD6m4mqbQtIe8XhkMbicNjr6zvrwz0kCnGujrsLBh6y9
         HF9u4xWnhNFc7qUoLe9P/QcMa8P/yNPngeS78gEjo2Cjplq1C0k+H8Ft/ZLvENygX48m
         uu2Rb4fth601sY9WzBGsxK2jh4iuFjKZXT2j9rG5+XtiEVuVBYg2dg9lpae1wZAP2lsS
         oUpK5AdmqoJ854XmU55Rb+plWgiJTa4+CO5g0TvtYjvAsW19iRwMYioUvJohgRFXLKzt
         /GrA==
X-Gm-Message-State: ACrzQf3q/DdFO12BbUQpOF4kFZJU8hQxCDs6uLuoXteNEJOyZslPz8Zb
        kOitEBKhbA7f+t7DCIEyiOs=
X-Google-Smtp-Source: AMsMyM7gwYq0L/dGmCChh7k/MqaoK5BVP38VC5+6H41ZEoCwrtqJoRpUc95LAC/AbeRuPp3LfRADSw==
X-Received: by 2002:a5d:5149:0:b0:22e:8b85:3d7d with SMTP id u9-20020a5d5149000000b0022e8b853d7dmr4664169wrt.55.1665964199395;
        Sun, 16 Oct 2022 16:49:59 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0022abcc1e3cesm7099822wrw.116.2022.10.16.16.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:49:58 -0700 (PDT)
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Add support for AXP192 PMIC
Date:   Mon, 17 Oct 2022 00:48:17 +0100
In-reply-to: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
Message-ID: <K1COyeb13LQEOP5ZE6KtxH963IahQXav@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Aidan MacDonald <aidanmacdonald.0x0@gmail.com> writes:

> This series adds support for the AXP192 PMIC to the AXP20x MFD driver
> framework, including support for regulators, ADCs, and AC/USB/battery
> power supplies.
>
> v6 is a resend of v5 from July -- the patches haven't changed at all
> but I've rebased them on the latest git master branch.

Whoops, forgot the link to v5. Here it is:

https://lore.kernel.org/linux-iio/20220706101902.4984-1-aidanmacdonald.0x0@gmail.com/
