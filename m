Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322A67E5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjA0Mxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjA0Mxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:53:40 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6F3644C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:53:37 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 123so5834287ybv.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YynEOg+K6RbWzyM6XAOBrJN3Q2/A/JbQ0f/sBD639As=;
        b=hqaROeNmkKRP82fcMJre3KL8bmY7WJhpLWbYvS7AeAMbRPHUHuTqE+IUYitW+bl7AD
         iaHWCen3ZX6qiE+vOwpPy1BdDdDf92WqVfJf/EUJWIp8uomVTLIu0M6nN0WoLDBH5Bqo
         s2+vvTI+0932inzv1luNEbOJd2+/j5HZBFfFWsIYoN8sRMOEGDXSRzpRAZA/KanOqF/U
         Cn/0Mg19GJSmQlL5+EqnmVY02/8eTuqkRHm9jnpBS1fS32pkyMA09aVPXGMb6bPv35mS
         znuQMrNJa6che8cyKSLRJ9+1lYhrDuR8tLn1Fa7UGeNlKwjaagRreQ4AIHKzR2jGGly2
         Cz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YynEOg+K6RbWzyM6XAOBrJN3Q2/A/JbQ0f/sBD639As=;
        b=SRsUtKHGMbe/R1W90SVC12FZCaNVCn1AoMvLeCEUBgv0OPDAF49xL/cnMG3Q+aEXga
         ZIcXKTr8GztEKgnyLuIGVMBIdzppDKn0ZM2RU3fykchKQZ7ilGEj/SdOZ2CsyW/K+gv7
         RgVcDLJYFdXTCcQwrWl3LjiDtjX0zWZT25e3emc7bk55d54sg2gb017/xK+LvT+8D9kZ
         JVf9Cj5IfbOfWfkNIpDSG+Ph8YUUUn4MWZ5iOvMPP+UxjSRdtYRj9Ltw398pKV+Vj92P
         CIwinZmirCvc11B97MXlk3Pf6VdwViZyDZEa3GttEloxzz6KQwwHCeC167/DnMPObL42
         mE5w==
X-Gm-Message-State: AO0yUKXIU4qrwLTtPFozoGvx8zLkjX/AnRAXku9nxxgD0M1Ukz5fBpfe
        c3rH1IZ/zBSR2U4gernSPked2WXN16BH/VS5A/C5pTrCHh1nMg==
X-Google-Smtp-Source: AK7set9TAmymbQAdiPnX5z4gu+KlZg4IvEcJpmTrFUYwQrhwiX4GjjYUBQJ3q67pAJ+Mr4rFigk80zclsLMC+ML4ErU=
X-Received: by 2002:a5b:c1:0:b0:80b:c9d0:c676 with SMTP id d1-20020a5b00c1000000b0080bc9d0c676mr901383ybp.341.1674824016210;
 Fri, 27 Jan 2023 04:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com> <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:53:25 +0100
Message-ID: <CACRpkda1Dn8D7DRd8FcRmz0LesTvvGgJ-njSeG9GrnWB0N-VzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: mmio: Use new flag BGPIOF_NO_INPUT
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
> Use the existing shadow data register 'bgpio_data' to allow
> the last written value to be returned by the read operation
> when BGPIOF_NO_INPUT flag is set.
>
> Signed-off-by: Niall Leonard <nl250060@ncr.com>

Weird hardware, but given these restrictions it makes perfect sense
to have this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
