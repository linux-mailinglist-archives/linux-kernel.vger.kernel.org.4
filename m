Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8F697995
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjBOKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjBOKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:13:17 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C4933479
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:13:14 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-52f1b1d08c2so131594837b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TChxARwnI0lpB/SBhETxB4OwsG83QsJzGDQ5SFDuIHI=;
        b=YnA5Um2G6jRmV2vPq6yTc+f3qCg8bJxLYu0M00iWtnL85aZ5NMUQcFoyvhlq5xVscT
         g/FxUgYK3nZrVcqBMq01M0/gGCKbOcbXgv+qqiMKM/kmW6c5tLNSuRBtBO9NPrV4Dfkv
         qtu2/GRfCCRqXIATR7QzjRsD0Udxh40USkDw1qXVoGrxYLj6rdex8MJ2vBOB1nVQJjFh
         4RrFqcGYGrg5mGbLsRrkcsByOUuuDgqUE/L4bvrtcAY4mgNI66TjQXZSEcYGZW/EnCTb
         Y9BPKr7dM7+ATFt1rVGWp9ZKCZMoQE2mKcGNRyRAMI+koTTOIYDIWr6kGg2PWrFmXKrs
         cU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TChxARwnI0lpB/SBhETxB4OwsG83QsJzGDQ5SFDuIHI=;
        b=2UK9c5ilCSYF+Er7f2zWnc+YWfbZmYqobqud5RHJCk+oWavWM/0gUgObw6I7Mrrtq3
         IjVq4xeNQgsHSC1atL2Q5h5xla+UDz69kYo8EiByrWbbECvF+hCwobbe6ho7LwmcySGo
         CgZbkGu6PXWWJUSZRtKULs7Wccf8O5AUit+9tP0pFGFd/d5PQ5S45j2irS5jDRNAAOtN
         A39K/qLJ4gFL8B4/awsT9ZEjgt5Z5BIuzDNQ1DvdiVpkqDGuq5Nmw0gY0VGAj6MZ8xZN
         cr6PXFtpNng6CBfwwK0naUqLDSR0phBFm08gpi1F4YN4cpWBMuup+UKC7ovoH8MlMPSR
         1L1w==
X-Gm-Message-State: AO0yUKVjtsPpG0qW7EbkBjNKS7PcukRtE/0CWRPBDQXnttjS4Gmf7BSB
        xzTu4dhv1kRHWFkFzL1rug6cjC+2h2ymIeKKOeRWdQ==
X-Google-Smtp-Source: AK7set/ERxZzW3KNVrEUjAzdskHBB0Sb13W2voFJQCEl0GcMl9AuDWEND5R+eHJNT6p08hYHRxzc2W9S3PJRV7hbj7k=
X-Received: by 2002:a81:a103:0:b0:52e:b3df:cae4 with SMTP id
 y3-20020a81a103000000b0052eb3dfcae4mr144282ywg.128.1676455993332; Wed, 15 Feb
 2023 02:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20230214080034.3828-1-marcan@marcan.st> <20230214080034.3828-2-marcan@marcan.st>
In-Reply-To: <20230214080034.3828-2-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Feb 2023 11:13:01 +0100
Message-ID: <CACRpkdaeuUuKow2AZPi66gFpDVBB0kqvFJAJNmWB7Mn5gtDG7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] brcmfmac: acpi: Add support for fetching Apple ACPI properties
To:     Hector Martin <marcan@marcan.st>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
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

On Tue, Feb 14, 2023 at 9:01 AM Hector Martin <marcan@marcan.st> wrote:

> On DT platforms, the module-instance and antenna-sku-info properties
> are passed in the DT. On ACPI platforms, module-instance is passed via
> the analogous Apple device property mechanism, while the antenna SKU
> info is instead obtained via an ACPI method that grabs it from
> non-volatile storage.
>
> Add support for this, to allow proper firmware selection on Apple
> platforms.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

It looks like a horrible Apple-ism but I don't know much about ACPI.

The ACPI people are working on device properties to abstract away
all device properties no matter if they come from ACPI, device tree or,
ehm Apple-ACPI, but for now I think it is more important to get
this hardware working upstream and we can think about refactoring
this into device properties for the longer term.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
