Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C76B0229
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCHI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:58:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE8898CD;
        Wed,  8 Mar 2023 00:58:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o12so62674269edb.9;
        Wed, 08 Mar 2023 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyDxTUkqT1QypYuABfqldH2UkT8vCS493/a2H3Z5+PA=;
        b=L5UN5szr2gCCzAYLpDJVu97N5+niUcZ21kL6KiPDQsPq1bgXy54Szuee0hilQ7gSVa
         zE+YN7A4Q7vH2BVyJV2JvwMjPdEeNmHE1JfMuJxzM+TxYd6emMn/xhWU4UWQNVp24LPM
         Bk1OeycihLvh3hKE/3yYpiN9Ea+LdBq+XKrmgb9JYm2VD8M4rpytX1YDAvbIlewkg7WC
         DgEgAqyHdnwxdugNV0v+JT9s6t5mVq33F8wwLm1yFGSyNmZZgfydJ/bQz2czJRiHw2AY
         wY/Slwuh2QYWta+fEF/q/nBlCZf1Fi/ZZK5HVfqk8+uCAKpZgRflh5KbftpOt1RnxEQu
         jRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyDxTUkqT1QypYuABfqldH2UkT8vCS493/a2H3Z5+PA=;
        b=n9NqKKZeP3Qab4Quw3yLOsRseDIxAPIHk5KDtvT8jyCJQLLpX4j2gjl+5yx+p+GeSZ
         HIBFESM8uJZv+XRkCAxT6MQHeJOp7dIBEYWBMzMjcgtPUE4DTJmzaUPnIPM4xWKQi9WK
         NJrv8TmcNRaKXFAV/NC7W4Eh8506hFSikRofNCblWnqgbtbFRWoH1le53SUIz7XjrrgJ
         aCYOORxhWtbFa5NHG98/SfBvTz4seiiuyWSF/52ZWLj12L0btiBD9S/3KzJwF8lMwH8t
         h8F3LMmicpcqthXm+CIxZ2Hc6LR700CvS2auzCIK7KwWgnZ1rSFTzKR2ivCe8YFMRmtO
         x6qg==
X-Gm-Message-State: AO0yUKXUGpSuv8fENSVSlSJbQqoW1dlFLF4bUTx4+XlXGG5scSMkAmt5
        I+Irdu/xOzVSm/nHGqC+syoqmXkZaiq6Bj8Vr4lQd6j1O1o=
X-Google-Smtp-Source: AK7set+Wr59uGqaqN9VvnsDI7d55cXglMImv9XFTRXHplUDjFfAtfU+48B4O52euOb1OaMrTqN1cdrNlrdFQrcrCQ8E=
X-Received: by 2002:a17:906:3090:b0:878:b86b:de15 with SMTP id
 16-20020a170906309000b00878b86bde15mr8962683ejv.11.1678265917431; Wed, 08 Mar
 2023 00:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20230308083759.11692-1-clamor95@gmail.com> <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
In-Reply-To: <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 10:58:26 +0200
Message-ID: <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would love to, but max77663 uses max77686 rtc
https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L123
how to handle this?

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 10:54 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 09:37, Svyatoslav Ryhel wrote:
> > MAX77663 PMIC can have RTC on both 0x63 i2c address (like grouper)
> > which is main address but on some devices RTC is located on 0x48
> > i2c address (like p880 and p895 from LG). Lets add property to be
> > able to use alternative address if needed without breaking existing
> > bindings.
>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>
> Anyway this is not max77663 driver.
>
> The property does not make sense in the context of max77686. Maybe for
> max77802/77620 and 77714 would have... but still max77663 is not there.
> Don't add properties for unrelated and unsupported devices.
>
> Best regards,
> Krzysztof
>
