Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C326729A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjARUpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:44:50 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC65F3AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:44:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d62so23536181ybh.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxN0ifRPJLWymSPxr4LmL30NaXej0tc2KddBtHP7xgk=;
        b=o/L/KAVnrxKsg6wfxIIKKTthzenbBpd8Yyjgu45Qrq8xfHYi9SJZ4WC3ePKrhqyRNg
         0YWgPVF65SgQmhgKuSIT8Z35J7QzxNWKbJ7Mch1d4dIbub2+03oxAQhJ3OzwtUGbSDu6
         IeONYzFGg8zICe9wX7jtU34Q+HHNzy3/mSlT0m9BQdc2iwNhYeYVxLOpuafpOJl8J6bV
         es/KDYitXm0tt3HDdtiL2CEMzzYymJFNp2e1nyvq1m7OWfjdXl6a93j+FNHDWO6yHfx+
         NjPLHNd1ZZULF1ATwHQ8s0jR0DUFaww5AQ+dNZmrpw04Vc/hiUi9H2jaK1McDF3hyape
         MYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxN0ifRPJLWymSPxr4LmL30NaXej0tc2KddBtHP7xgk=;
        b=C6ROPYIDiMNYn6r7klPyrI+cphVlfVTtLvZ/y8Ciu6lMgSzmXs8L+amjoxc18KN8d8
         G5/+LkMW00139U+1eORlo5e9eVv2NQdGGs6iyvcfeCEnKF/R7sXm/T2cdSmqLodptxx7
         2WgJZjpNc7MFJ75op0tEO63L5c4yY2McRPr+icfCmhqXCc5QM9ONCsB4GIxSXv5soCeo
         7IQyWlkaM4R6yDuPsgPwz8Pa1jbhMDoY3AH6s3ZGY5rDIMSNWk2rEYJ85PyQXABWgRXd
         fq0M2kpH9DpsAMbPnZxcYANGof3J+xArQdt6rC/cTQGRqOKpd0m3ksLYAJuM3qBt9zuZ
         Y7SA==
X-Gm-Message-State: AFqh2ko8fYtDzJnNdaulIod7npkTBcDDBL9Hci1oMBWfqDSh3DTRGfkj
        /aSF3Or19R7dRe0gdi5jxmeEWK3pT/Ioyv5Gi/UTJg==
X-Google-Smtp-Source: AMrXdXsmCi/frVC6VtreQlaKByYSty9vXl8uhPqMcWmgUNLPIBdL7eylfPOfYiXjvhn0Wg/c/y6sw3UwLYqAp0TyoEk=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr858664ybp.520.1674074689110; Wed, 18 Jan
 2023 12:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20230116193702.31356-1-mario.limonciello@amd.com> <20230116193702.31356-3-mario.limonciello@amd.com>
In-Reply-To: <20230116193702.31356-3-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 21:44:37 +0100
Message-ID: <CACRpkdaX+ZVA7zQDnADEi5KPpfd-gwsxPsKaZo5FxEmgjv4S3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        regressions@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 8:37 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> However on Clevo NL5xRU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.

Now that is what I call proper root cause analysis. Hats off for this patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
