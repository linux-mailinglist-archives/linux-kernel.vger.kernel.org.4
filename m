Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9937C6B269F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCIOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjCIOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED01388D86
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678371546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A46Usveb628ihXLGsrPj6WsAbS9+1+0iaKdpYzar86s=;
        b=Q3tlZAgYYM/59izFBPyz2/7s9Jjlwyi+o4HY0h1Pn/18aPM/3f3yIKlTG/s03YMP+00cej
        pnmxLPCq4fkp5ey/ElUQ0cpvLSfyu0vBV+iSOdzyKBXS+5f8u9IjRjsTMNffoWVBkkJk2j
        SJZJZzwrZpfXAWpvfrI/PRwExnBHvu0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-D02bp1zSOpKkuVkjufx8Sg-1; Thu, 09 Mar 2023 09:19:03 -0500
X-MC-Unique: D02bp1zSOpKkuVkjufx8Sg-1
Received: by mail-vs1-f72.google.com with SMTP id w9-20020a67f749000000b0041ec573a9a4so675824vso.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A46Usveb628ihXLGsrPj6WsAbS9+1+0iaKdpYzar86s=;
        b=YGQAP4c7DdvG//Mi3V39vIaNTtWd4eu7jCtuQ4CKLsFwn1sG6rkumaA1YBM3cui4Pr
         zwSHYow5v4FKhInr/1iUmD/ePCMlRsGOyP799qBISagLYwnnoF8x00O2YKh3b5W68xyv
         zCSBBzR2ReifXxnKoOnoLR/zGQR/lzITYcwmg97eZAKsxz6K3iEaVVf4gKw8zYb8/9wI
         SqvS6KNQPl/gn+hMjhsXFzZPm5Toux9rc5zLO7/G7vlDDzDbXXUJNXrN/iyRWgieKJDP
         wtz5k7HwREH+Q1/dSst/uOJkGdPQQCHKBsEc9ZjLrV9Qh19+cBMXmBxI4c3L7iN1s//l
         XK9g==
X-Gm-Message-State: AO0yUKWtmN+pi8Y0JHaydGAFjGBhwLYux7M94GLdgxNLrHYE4WFwAtyN
        kMDC76yW4RSAVvE2agzAclmp2Zr4jBwAV7g9h6m2QO5LdEnII3iekgyjU9cY30OST3Z7HrzvBW3
        HIGtsPUEPlBfiaeNr4kv3A9p7V68zN0Xwq2Lt5t+q
X-Received: by 2002:a67:e04d:0:b0:421:edef:20d3 with SMTP id n13-20020a67e04d000000b00421edef20d3mr6995859vsl.7.1678371542419;
        Thu, 09 Mar 2023 06:19:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+GbGL371KUHWTmORXbHN7Tjs6YLLY5zKR/W6HgrEkQUazVrbBuPXLus+wPFvbQmfj/LAVNLJcgkQoUVm3BAxw=
X-Received: by 2002:a67:e04d:0:b0:421:edef:20d3 with SMTP id
 n13-20020a67e04d000000b00421edef20d3mr6995836vsl.7.1678371542065; Thu, 09 Mar
 2023 06:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307-apple_pcie_disabled_ports-v2-1-c3bd1fd278a4@jannau.net>
In-Reply-To: <20230307-apple_pcie_disabled_ports-v2-1-c3bd1fd278a4@jannau.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Thu, 9 Mar 2023 14:18:45 +0000
Message-ID: <CAOgh=FzWgjr+3YzF9u1k2ReKEgeoLykPc83RbGqDDXZ_PnGmnQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: apple: Set only available ports up
To:     Janne Grunau <j@jannau.net>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 13:43, Janne Grunau <j@jannau.net> wrote:
>
> Fixes following warning inside of_irq_parse_raw() called from the common
> PCI device probe path.
>
>   /soc/pcie@690000000/pci@1,0 interrupt-map failed, using interrupt-controller
>   WARNING: CPU: 4 PID: 252 at drivers/of/irq.c:279 of_irq_parse_raw+0x5fc/0x724
>   ...
>   Call trace:
>    of_irq_parse_raw+0x5fc/0x724
>    of_irq_parse_and_map_pci+0x128/0x1d8
>    pci_assign_irq+0xc8/0x140
>    pci_device_probe+0x70/0x188
>    really_probe+0x178/0x418
>    __driver_probe_device+0x120/0x188
>    driver_probe_device+0x48/0x22c
>    __device_attach_driver+0x134/0x1d8
>    bus_for_each_drv+0x8c/0xd8
>    __device_attach+0xdc/0x1d0
>    device_attach+0x20/0x2c
>    pci_bus_add_device+0x5c/0xc0
>    pci_bus_add_devices+0x58/0x88
>    pci_host_probe+0x124/0x178
>    pci_host_common_probe+0x124/0x198 [pci_host_common]
>    apple_pcie_probe+0x108/0x16c [pcie_apple]
>    platform_probe+0xb4/0xdc
>
> This became apparent after disabling unused PCIe ports in the Apple
> silicon device trees instead of deleting them.
>
> Use for_each_available_child_of_node instead of for_each_child_of_node
> which takes the "status" property into account.
>
> Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
> Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Cc: stable@vger.kernel.org
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Janne Grunau <j@jannau.net>

Makes sense.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
> Changes in v2:
> - rewritten commit message with more details and corrections
> - collected Marc's "Reviewed-by:"
> - Link to v1: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v1-1-b32ef91faf19@jannau.net
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 66f37e403a09..f8670a032f7a 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -783,7 +783,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>         cfg->priv = pcie;
>         INIT_LIST_HEAD(&pcie->ports);
>
> -       for_each_child_of_node(dev->of_node, of_port) {
> +       for_each_available_child_of_node(dev->of_node, of_port) {
>                 ret = apple_pcie_setup_port(pcie, of_port);
>                 if (ret) {
>                         dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
>
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230307-apple_pcie_disabled_ports-0c17fb7a4738
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

