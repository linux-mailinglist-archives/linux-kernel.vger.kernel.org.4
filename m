Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95DE5F06CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiI3Ip5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiI3Ipv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:45:51 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22967114738
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:45:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j10so2268413qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=zGxDgMgW0IDegMxOKAwjscGt795hY9qTbQ4WdBlz61s=;
        b=ksu0lJieeXwfMfEvdsT0OObRGEEPXciAPO/Z5tHMRvyHTpnlw1EaIQ4+5PkWW/pugB
         d+xoKO+tPZ3vuv3DMPqDEKxhAvDN4U1j/gnmDpjzW8C+1rNMv1h78aWPBA8uyktswym8
         sAiTFig9+67i3gdgw24bakCu7VQVmAoPj+2jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zGxDgMgW0IDegMxOKAwjscGt795hY9qTbQ4WdBlz61s=;
        b=V6sguYvyMGd7fIiFuUq2PayeJaPwJEhS7VtESiy8rTWiDroZbeRQqDsKFXv31xVlP1
         lYzSSHk5+Cb3mn2XI4N3XrA8MVEfn8gMZnRp/08hZH99VGR4It2z8IdmzRxLI8t7qQTI
         8Eztqm4MVl7yl+a+3UTpj7XS4t8rPflyWNbZGzfXrevrYP21ynppNdc6KGEaM8txmLzW
         3/n0JvHv0lvtwWO8snwwySgaRs7S5YdnR8Sjbf+torRb6IKXTFKCjP6+xXGcM0DbICSf
         Zy/A8/Yz2tueYWDrsPn8Gc6Y8ayhvH5W1kxNB7mcyyl1oUrcjS10dbWfFTCo5QuYsh5v
         up/w==
X-Gm-Message-State: ACrzQf01oH25jEOahjlAT6Xc7DSN/PyAxGBRQ9THXfapOVuGDJT9Rvk8
        j2dOmXSgmQvXyNuWN0jGM1tLbXGMDv7l/9CQ/KU=
X-Google-Smtp-Source: AMsMyM5kS6f4oMp5HO3N2oUDvfpGnTpOt72c4/v9C+j2LdSK/G0Z2xGazNSOoPu5uQr9CahKCpxpZA==
X-Received: by 2002:a05:622a:14cc:b0:35d:1214:99e8 with SMTP id u12-20020a05622a14cc00b0035d121499e8mr5707951qtx.205.1664527549099;
        Fri, 30 Sep 2022 01:45:49 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a449600b006cf3592cc20sm2079000qkp.55.2022.09.30.01.45.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:45:48 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 203so4466817ybc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:45:48 -0700 (PDT)
X-Received: by 2002:a25:71c2:0:b0:681:63ae:4c48 with SMTP id
 m185-20020a2571c2000000b0068163ae4c48mr7624055ybc.578.1664527547933; Fri, 30
 Sep 2022 01:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826074430.1333272-1-mani@chromium.org> <20220929174334.44d3e6d9@endymion.delvare>
 <YzYHF5qPMEMZu6WB@shikoro>
In-Reply-To: <YzYHF5qPMEMZu6WB@shikoro>
From:   Mani Milani <mani@chromium.org>
Date:   Fri, 30 Sep 2022 18:45:36 +1000
X-Gmail-Original-Message-ID: <CAEfrLckfRq99nShHgE5-2P0Wn7keprkR6W7SDa1FFna9e7Qmuw@mail.gmail.com>
Message-ID: <CAEfrLckfRq99nShHgE5-2P0Wn7keprkR6W7SDa1FFna9e7Qmuw@mail.gmail.com>
Subject: Re: [PATCH] i2c: i801: Prefer async probe
To:     Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

No, there is nothing special about the 190ms. It is just what I
measured on my device under test. I decided to include it in the
commit message to give a rough idea on how much delay this driver
probe can be adding to boot time.

Thank you Jean and Wolfram for reviewing.

P.S:   Apologies for sending this twice! My previous message was
rejected by the mailing list due to containing HTML subparts. (fingers
crossed this time)
