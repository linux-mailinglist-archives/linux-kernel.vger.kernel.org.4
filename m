Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA936462F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLGVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLGVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:08:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C355AAB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:08:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c140so24309461ybf.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwDWcN9owuZJs09WFthlVYFZXHoUW46i6bINqQyIAvY=;
        b=vpbqNkTXD8MjDifxCc6rBxe/TOwdIp8cwUe8WkOb6Zv2M0nUhPH1E7pSBL3fAqhUWW
         oizMsx+jqjY3bWGgNKeCUsluLANd+SkuUr6CPbOXhQCiSSDipdeeOMtZ1aCpxjrPxCs0
         s+g1qXGatM+7JuTpRiKdJ55zvq5rL8injVM5XUpEo3hBAuaPUkg+IP87SdVeDP1gxUeH
         36M7xmOwbdLNK0X+UamKBKY1LnE6b0Uo5VDaQx9Ms+g/U5hBwj50ol4j3AP/A6JxB7PP
         bpDvkaBnthKmcuxJq7TXozFvcr+MOaGU2HETTpiUCUW+z5mfuYjr2ldu7OBlnHtnhBqR
         Ocaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwDWcN9owuZJs09WFthlVYFZXHoUW46i6bINqQyIAvY=;
        b=CJIDvGF+//Rnc1IzLXny5EOhFMDUtEK190xqLM2IWvppYGavCt4zylHcr0By4NE2WK
         KlV//5zV75+ABTZmxTBGpSwSSmM0ptllho1YQeZ+9WVAeBhJ19++atknvLmXezQrVM4l
         ew4jRdHBiGz5cwfmlLaDP6pDA4WBRf1xerPptro55vNQ7s4mRcr1thsvoooH5LmdDtvz
         22/yy9hYSfc+6ZmNCUzAHR0L8IBWr3XujzgH9MC2C31Wb7QzAPkD8SjUoz/ulTKlST9r
         39cX09Mqi1ygbjjMTfrAA+CctdAfikdEEHIvgtHeRGfw7Dd1HJO/lPGmT6FJrYSuUuUi
         1V4w==
X-Gm-Message-State: ANoB5pliH3/5mROUMiFwRjkY7ySx12/RNiqvSXDcCjMw2SgXbvPVfu8P
        PZGl4fHR33DcrKgnRT5bvzrDO4lya3E8dL+SK6E7UA==
X-Google-Smtp-Source: AA0mqf5wljzQYDSt6wezxa7SXx7zvfJyYWr9YBYHL5ne2QihnGHSb/sukRbkVVoKKagMGx73IcMFkhEkGrusW7Li5RA=
X-Received: by 2002:a5b:7c7:0:b0:702:7a86:31e with SMTP id t7-20020a5b07c7000000b007027a86031emr10784457ybq.506.1670447299498;
 Wed, 07 Dec 2022 13:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
In-Reply-To: <20221207163359.26564-1-larry.lai@yunjingtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Dec 2022 22:09:35 +0100
Message-ID: <CACRpkdYk=dN8P9X=t0JhRuSVormm5fTeAT1Zwy98Q+F0XFTEpQ@mail.gmail.com>
Subject: Re: [RFC 0/3] Add support control UP board CPLD/FPGA pin control
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, andriy.shevchenko@linux.intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 5:36 PM larry.lai <larry.lai@yunjingtech.com> wrote:

> The UP board <http://www.upboard.com> is the computer board for
> Professional Makers and Industrial Applications. We want to upstream
> the UP board 40-pin GP-bus Kernel driver for giving the users better
> experience on the software release. (not just download from UP board
> github)
>
> These patches are generated from the Linux kernel mainline tag v6.0.

Why are these patches tagged RFC now? Weird.

Came to think of this:
Shouldn't the subdrivers for pin control LED etc have:
default MFD_INTEL_UPBOARD_FPGA
i.e become y if the core driver is y, becomes m if the core driver is m.
Of course it is possible to run around in menuconfig and activate them
all manually interactively and be frustrated that something is missing
still but setting them default like this saves everybody's time. Activate
the MFD core driver and everything else comes with it, then it can
be turned off at request.

Yours,
Linus Walleij
