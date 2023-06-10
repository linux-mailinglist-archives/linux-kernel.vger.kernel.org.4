Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F672AE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjFJTBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:01:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E93D30F8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:01:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso5742214276.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686423695; x=1689015695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM+qubxwEUOMq3TvmNZKSOIB4E6pfQOK/UfK6GmsEtI=;
        b=i5Du6R+LrifxAu/L0KPvPnpED5A/YRXwo1rnUhdSvooPZzS/wsJ+1fNtY4S+WiM//5
         U4UJ1ZuNm3itfoE5kgofedqqXBMd3/mR0A/jEdRpZJBAlT3FxDL3iys0nOJrQu1Xt3Dw
         K6da1jpG0N4M/iiljf0l+hUTsAq4lJh3qYP5m8zp50swJH0btgyROo2UuaPiDfL6wiki
         gYVU+j8VtqUD0g6mph1A81n2WKUyIoRzPwXKiN26LZyxC9nC5DWkz21nWlA6MuJLiRCe
         +FaPGuEc2PZL6yGZ5dDGvUOIj2/xiN2d4Ml63xF2oYn6IfJo2JJtJfV4IEJZH9au/CJZ
         p3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686423695; x=1689015695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM+qubxwEUOMq3TvmNZKSOIB4E6pfQOK/UfK6GmsEtI=;
        b=c0aY1ZKynob5kBXyo82leYhYoPm3ipT+CQVba6iZOOGW40+dKq7sQuMzwQRYN4qZy8
         GPa+VPCw+Pbz5uNknYKAvgropZ6oQodDhBL0XULs5w9zT3ergKpSqz/4NAtmAh9MSBeU
         2dY/w4D/Q9um7T3Dg+zPOdZKlW2RCNOJbMofQSuNVbDm2dRSYIPGdSwanUsJepkXVysO
         zBAvQkUVEbc2K2ApHrly5EDQOQqXlBirDxNlNYfvRkcFzXgGaNjxrEIf1s+RFM3LD4cn
         1LPUOQXdvk1U+I9/B4q9z7M3E233/zMlxB1E+6QuR0mUWEDGCUGoyJ24j1+GDjBQln2z
         B04Q==
X-Gm-Message-State: AC+VfDzNZF5WCYNSvyR5STrqHTtNGDVVHwiEOJuUSif0xMZVbQKoEpbd
        UniyxrgAwvYluEGyDMgkqvGdhN738R4MOpvrUQo9gQ==
X-Google-Smtp-Source: ACHHUZ5jiVtmkmCy4sFz1pagiPDkIrsy9yyOv/D/0lPbnaimbT/mN/8MLy1wvQfBzCeyd11+Gs965qZxZxcL4AoztfQ=
X-Received: by 2002:a25:1e54:0:b0:bad:6997:be19 with SMTP id
 e81-20020a251e54000000b00bad6997be19mr6503307ybe.1.1686423695390; Sat, 10 Jun
 2023 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <202301191721230148862@zte.com.cn>
In-Reply-To: <202301191721230148862@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Jun 2023 21:01:24 +0200
Message-ID: <CACRpkdY+T8VnqPqKhHMCpqdougo2_spnzaqCthkBvxTAzwrxKQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: versatile: Use devm_platform_get_and_ioremap_resource()
To:     ye.xingchen@zte.com.cn
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:21=E2=80=AFAM <ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
