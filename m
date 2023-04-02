Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516E46D35BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDBGKe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Apr 2023 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:10:32 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDEB762
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 23:10:30 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id b20so105379156edd.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680415829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHYI+tO3hAeuqhb1MWG4+RQipbR23BelUx1lrPVeCNE=;
        b=xWoUsxr/2fWv+d1Na8lA1WHWW41521gVIHkpkXU3Hl086WRXLJvsCdtN3XKYt6QToo
         2P87qBRhLP4O7kH2WmnI0A1QvdJ1p3eP8QDINboZco4AjR1Zdt5cC44elh7GtSxglMOH
         5RvH9cF/G1/qEph40vNKeAxb2FZb/iUJmyW46hkQr2eWiNGyZt8hXToBM3fWswCWBLcC
         eFMeSSkvCMgW2koVyg5ej+O2nS/Q13oucMEPnMxsjd1DW4PhxKdR/aUTOH0gKRczNJZF
         f7LV0rJpSoTZvaZiB4Hq9h+kWvDn5jqvsXlFXcFj3YYeeMyP4qmBU72Xg1RbnRHO39oB
         46tA==
X-Gm-Message-State: AAQBX9f6uvcDf8DTlEmz8gQ70vO1/X6Tr/lJHmSm8gZAHadW5du96hwX
        yJlEGy7X7LmMuFYAPytLSZry2tt7c2HG3w==
X-Google-Smtp-Source: AKy350Y9GnC9ZwX0YMilkGJnLBywzLHSQsCxWptFmWHOgNYT2D7hdIjLz8QiRrIImU34232SvKn0dQ==
X-Received: by 2002:a17:907:6c11:b0:92b:e1ff:be30 with SMTP id rl17-20020a1709076c1100b0092be1ffbe30mr32689855ejc.4.1680415828960;
        Sat, 01 Apr 2023 23:10:28 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b0093341746105sm2871876ejs.117.2023.04.01.23.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 23:10:28 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id r29so26159511wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:10:28 -0700 (PDT)
X-Received: by 2002:adf:efc8:0:b0:2e6:e4df:a7bd with SMTP id
 i8-20020adfefc8000000b002e6e4dfa7bdmr646296wrp.7.1680415828140; Sat, 01 Apr
 2023 23:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230401001850.4988-1-andre.przywara@arm.com> <20230401001850.4988-3-andre.przywara@arm.com>
In-Reply-To: <20230401001850.4988-3-andre.przywara@arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 2 Apr 2023 14:10:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v65QUs1d_F9jTeeHThaWv6Ai28JBHnFgw1ObycN9_C6rKw@mail.gmail.com>
Message-ID: <CAGb2v65QUs1d_F9jTeeHThaWv6Ai28JBHnFgw1ObycN9_C6rKw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] mfd: axp20x: Add support for AXP313a PMIC
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 8:19 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Martin Botka <martin.botka@somainline.org>
>
> The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
> an I2C bus.
> The name AXP1530 seems to appear as well, and this is what is used in
> the BSP driver. From all we know it's the same chip, just a different
> name. However we have only seen AXP313a chips in the wild, so go with
> this name.
>
> Compared to the other AXP PMICs it's a rather simple affair: just three
> DCDC converters, three LDOs, and no battery charging support.
>
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Aside from the various regulators, also describe the power key
> interrupts, and adjust the shutdown handler routine to use a different
> register than the other PMICs.
> Eventually advertise the device using the new compatible string.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
