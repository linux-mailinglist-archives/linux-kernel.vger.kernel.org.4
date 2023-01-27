Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427667E5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjA0My4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjA0Myy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:54:54 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8DE69B26
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:54:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id u72so5838098ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4Duo7yTzdZxkEabRt0qmMTKlLlA46+PK96iVypqY7A=;
        b=cnuDPpD11hReq0XyNmFeCIx0b71bNk3NBx2rc8MD/xYMkHo4pLNNQmxH9++VBVD7oj
         bsJIrj4d5urCgLj/cdTXIjda5ILxvQ2Ype/F9M6IeSUwFb/aZO4WXd3tipytf3cTJpWr
         0m79NhsHNN7gkVrnPwXCbq/hVPXCUuqG0T84peeM9Zx/AL/Z1lZHj89HEWoannelPCYb
         t5dxyR+4SJQQ9Y8gXbvuJfedQB0ETTi0eKx8h91inE5OEN928rvX2a7FFQFaYf9PLHNq
         5R998c/SyZpeaoKrPE6g8MPzUGZ45NK1OyqDY5vRL8j4xxXjqGryYGFHVlWpfj7Xwgj5
         q0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4Duo7yTzdZxkEabRt0qmMTKlLlA46+PK96iVypqY7A=;
        b=ubANYg+bJG5Yl5kf0NtC6T5CdT892GWQIqyMbQ1Z2ebJv662gLd4QHRGuPzKGAjy5q
         n734yDBLmeBf2fHBsVkpGabejCbMsbUkW7WNk+R/nsFkIpR/lowEgu0KAid2eOIa48IV
         agkBntvdj2751fAxP7B61BC2AE15SSpdJZSWAbYEa9uAzwhH0G8w2Go9QC627uPJDs1Y
         HV4jx4Et5HDZOASHpLo6Z6AYCF5aLyOS8rI1VeVa0kkBnmMsdDcy39uXujN59nOAGGYD
         TMLnqa3Ir6emvMmLqOpBDgOwwPk6GMYxkHB4JJbKQsheyGKq7OzTLzDuRVUUC/jtB6f4
         atZA==
X-Gm-Message-State: AO0yUKX6qXSie7TOGEKPG1FBNNxLwW0hpqt5VETtn/PQnBklt7NeXfNS
        rZsQ8AHj+ZKkwQKoZoyJ24Najb0IHgmkZuOYM+Fxgw==
X-Google-Smtp-Source: AK7set9NQq5JuQtFwNkB5SlRJX2gRGCTkuUQknVc+coffsEH8XXGbiklpR+j7zD4R+i12cXNb5MrWCvbOp0J8iuKdxc=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr1743762ybg.210.1674824085818; Fri, 27
 Jan 2023 04:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com> <20230126-gpio-mmio-fix-v1-2-8a20ce0e8275@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v1-2-8a20ce0e8275@ncr.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:54:34 +0100
Message-ID: <CACRpkda57wNMO20ZGtjm7zOKMk=1D2g6ZBq5aRKnPp=1z5Pr+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: Add new flag BGPIOF_NO_INPUT
To:     nl250060@ncr.com
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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

On Thu, Jan 26, 2023 at 11:18 AM Niall Leonard via B4 Submission
Endpoint <devnull+nl250060.ncr.com@kernel.org> wrote:

> From: Niall Leonard <nl250060@ncr.com>
>
> Signed-off-by: Niall Leonard <nl250060@ncr.com>

I would squash this with the other patch adding it to the MMIO driver
per the principle one patch = one technical step.

Anyway:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
