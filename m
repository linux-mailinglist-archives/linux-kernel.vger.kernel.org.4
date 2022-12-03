Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5D641588
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLCKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLCKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:04:00 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4184DE9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:03:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e141so8849565ybh.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6E8CnP3iI5t13RtsJQQcTXnbZ3ZGPTmoPz8kIfTx4U=;
        b=k0vaNbXpIr1SS/R+YqWWkyExuOQIYt3c8XfhEfqDa9Z2UuX4cdm9VdUn/4gHGMUxtH
         5FyGA8rU9sdTo1UFjoFc5JgDdVGmXSAMsZY35MJUnaSncVbVYJXR5j+p4TrjstZjq8xz
         JCOEDr9BdvQQTTPf+fFgcjUCv9YGPv4mVcHvxJXJ93CWUynMjTGe4Blq/e83y+RDFEbV
         XMjN1RKwqXqIe+4mElvNvFbFzfFjRxyuttUTmR4wfjxopzy3yay/5qCYu1jvusRq7z6t
         DH2pwodZDL90KwVCuHcpmsO0+iSnBUNAUL3svPVBSnVusbSa4QZJnaqVQwCqoNaXBs8x
         3gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6E8CnP3iI5t13RtsJQQcTXnbZ3ZGPTmoPz8kIfTx4U=;
        b=XwqO11DWvhfSquLN6iMklSUOPmSaWdjQcBWXLk78rn+NlyvhCFyVfFCaLAWyb5URDW
         GHDCnU6NeAvuRifYrmfbYZ5z1HzyfVn5f0aceOPdfrbDpVPdVxyryb6raciPyWpys7qt
         ZkiwX3BWnLjQ07xl9KLtt81BsdZ2EBE8bnlIk3AU7y6QkwJH8W3s4XEhgPBWVyRwkzP1
         Z3awUohWHpXqG62mj2PrOD8jxrxZ6nlGn19MAZ7IsTB1uo+d0YZcEQdOdvCQXVsYLh6S
         kFTHrhMRQsI+j6src9LE2rXmXwoYzXecjH3RdofyY/B5Tnk8ipmmV9D5r5jy/Ah/GeDE
         BcPQ==
X-Gm-Message-State: ANoB5pklOdyb+TUQmlI0ogrCvnoOoFE1H6Fg9KqeN9yd7PTrjjhPzbrq
        qrLUQGTaMSdhl+nzqiCsPwipeBhu2s3WL9bffawZUw==
X-Google-Smtp-Source: AA0mqf6D4lrppamEcD0PVhGEQxhIID44UmELO3zkV8dlr+HoqpZTBr+TgBXi4XgTOEHh0lS6bXQVtURTpgndyWewC8k=
X-Received: by 2002:a25:d8d4:0:b0:6f0:36e2:5fc2 with SMTP id
 p203-20020a25d8d4000000b006f036e25fc2mr46503178ybg.52.1670061837556; Sat, 03
 Dec 2022 02:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221201123220.7893-1-zhuyinbo@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 11:03:46 +0100
Message-ID: <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
(...)
> +config GPIO_LOONGSON_64BIT
> +       tristate "Loongson 64 bit GPIO support"
> +       depends on LOONGARCH || COMPILE_TEST
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP

If the kernelbots start complaining you might need to add a:

select IRQ_DOMAIN_HIERARCHY

here.

Yours,
Linus Walleij
