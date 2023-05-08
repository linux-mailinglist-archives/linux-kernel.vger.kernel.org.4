Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD86F9F76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEHGND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjEHGNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:13:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB8150E7
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:12:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55dc3431c64so14244827b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683526378; x=1686118378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU9FyvCnc3K02sqd3AW4zFCJ93z+cNWrJtnSGwlspk8=;
        b=qzrE3P+TucwajxqKPt/lb30T/TrNxFBjLfBJYL7TKHDIRzPSbTG0SKombf9kzqkXxS
         u9lWCR49E18TD+zZmVZDyWtM7PGVpLdDmrSI5LpAjTbq1Vm7xavwDb3xHwqHaUsZdaSv
         KkxPUkMoIvInjBgk70vvClGsy05n9LJ4EvU6V+hwS10WaUzlKhnoIvk6Kc+oagh4FdaM
         TD1jy/V9GISD4zmruGJgcfvqTtF8wUm5v3SXV1vw68rWIxGl1wvPFy34G8kWgThP3y6I
         qN32CjohVzW5ghAzPkSL5yUVA1kyosO1yljEWv2/sLY1zHY/QD/9eNmFEYR0T9iRcxhy
         pQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526378; x=1686118378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wU9FyvCnc3K02sqd3AW4zFCJ93z+cNWrJtnSGwlspk8=;
        b=gpw2I7/NbZzGEztOH7NW8W7ITTDr4ud8MmA5ZRFaq2SPUdpBZsnPfVHMj8iUJmqtWr
         3wwbVJcyqKbMCMvjpHnsDTO/XUibBjun0CmbW4+hKNw8nDifShTuSZwFBmXGxTRzampv
         sBYHjaQQD4dNm6zUtgrqUkzDPuyiGlGNAghMhiFkgNPIxGesi0qjAmKue/wO4E200rCY
         hbLlTTo1JUFesVkDNr7jSUNGpNQ4hTf4cygg3XPtqtrvTQskDP0cVSwcE5M948/PT1Sh
         2nxSzVG7HmWNzD2vKaYN3hvHXeCf6GJNEMDaFTzF2oNrwek99b9eyHc1RZRz2FB8wVn2
         z8BA==
X-Gm-Message-State: AC+VfDwxzxfRdFStCmkhthb5KuDytejfxCVphaU8lGH2ntbyvbi6lKS4
        ZmEcjrha5NxpKljt7v3dK/kz6HDnoNzPwLupqBGJ3Q==
X-Google-Smtp-Source: ACHHUZ7DFt2uuH6oBEQmIJZ6XgrjJWEYsIZY9UzZQXIURKb/nboL2BxgICwjlJPawtW50oYyzt8yuuLnLTA6SysJmvE=
X-Received: by 2002:a25:25c3:0:b0:ba1:9c87:113f with SMTP id
 l186-20020a2525c3000000b00ba19c87113fmr9780325ybl.28.1683526377900; Sun, 07
 May 2023 23:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230508043641.23807-1-yejunyan@hust.edu.cn>
In-Reply-To: <20230508043641.23807-1-yejunyan@hust.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 08:12:46 +0200
Message-ID: <CACRpkdb=dB2y_AtmMWOt0FAyLBFrJNCSqZrWGn97ciVTwLnbBw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: controller: pci-ftpci100: Release the clock resources
To:     Junyan Ye <yejunyan@hust.edu.cn>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 6:41=E2=80=AFAM Junyan Ye <yejunyan@hust.edu.cn> wro=
te:

> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'clk' from clk_prepare_enable() not released on lines: 442,451,462,478,51=
2,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'p->bus_clk' from clk_prepare_enable() not released on lines: 451,462,478=
,512,517.
>
> The clock resource is obtained by devm_clk_get(), and then
> clk_prepare_enable() makes the clock resource ready for use. After that,
> clk_disable_unprepare() should be called to release the clock resource
> when it is no longer needed. However, while doing some error handling
> in faraday_pci_probe(), clk_disable_unprepare() is not called to release
> clk and p->bus_clk before returning. These return lines are exactly 442,
> 451, 462, 478, 512, 517.
>
> Fix this warning by replacing devm_clk_get() with devm_clk_get_enabled(),
> which is equivalent to devm_clk_get() + clk_prepare_enable(). And with
> devm_clk_get_enabled(), the clock will automatically be disabled,
> unprepared and freed when the device is unbound from the bus.
>
> Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()=
")
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()=
")
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI H=
ost Bridge driver")
> Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config=
 accessors")
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
> ---
> v2 -> v3: Rebase to v6.4-rc1 and modify commit message.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
It's a fine fix since it saves lots of code.

I would merge it as a non-urgent fix.

Yours,
Linus Walleij
