Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAC6B0748
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjCHMho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCHMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:37:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80449C0831
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 407BDB81C17
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD21C433A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678279045;
        bh=afV4xYi5TNCX7JpH1YzgMaSJghScQpbkjafW6ILOCug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g4150NZAyCIVfj7M70VcHM6cAunm7M1oETRG3ZgRteUzsnsMjpQlg63gXjT2uP+gp
         /9G8XN68lMhBj3W0eujjTADJWc9yU0zX/4dhsfmiM3N7S+vWzEsT0Rm5Q9yfZb5G19
         eFh9kaXa6YKnyhHsnA7PGGoBI6CDVjmgdYVZb8QYS5TyacgQg0OCv1E9zoPRsYRZqk
         Xt4nvWKC/YH++rE7t3UshIjYHmc5lcM/9f5Qj3u/sh4C7xEC1HlvSblowIpO0siyJt
         rt+ZtkzuyjsQBv/TW7XkedaRfN26pUUclk0s0fc9rNtEyp7EWpf0OOXx3vgZqENdfc
         9qTWvLYrc7nVA==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536bbef1c5eso301864917b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:37:25 -0800 (PST)
X-Gm-Message-State: AO0yUKWglAa5udEPg6Q+dz2dVRqjKhKENzHbe+MozipPIbuzNsJ+4gs9
        oMA5sIsy+cFpHsOm5DMSU2N2bko5x62mxxX82fk=
X-Google-Smtp-Source: AK7set8O6XklutlryzK34XXFcjDIGF9lKfboVIbKUquYz0C9SQ70QXkNQd6EYhIzmmvVhvAzJHnlb58454CZpOduoQ8=
X-Received: by 2002:a81:ac65:0:b0:530:9fa8:74ab with SMTP id
 z37-20020a81ac65000000b005309fa874abmr11757678ywj.3.1678279044071; Wed, 08
 Mar 2023 04:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20230307202729.881391-1-helgaas@kernel.org>
In-Reply-To: <20230307202729.881391-1-helgaas@kernel.org>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 8 Mar 2023 14:36:57 +0200
X-Gmail-Original-Message-ID: <CAFCwf10qpYpZjycdaZN5+yvxg9Ata5Sg3YTpfqsvvA4BCgC_DA@mail.gmail.com>
Message-ID: <CAFCwf10qpYpZjycdaZN5+yvxg9Ata5Sg3YTpfqsvvA4BCgC_DA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Drop redundant pci_enable_pcie_error_reporting()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 10:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER =
is
> native"), the PCI core does this for all devices during enumeration, so t=
he
> driver doesn't need to do it itself.
>
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
>
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on th=
e
> AER Root Error Command register managed by the AER service driver.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/accel/habanalabs/common/habanalabs_drv.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/a=
ccel/habanalabs/common/habanalabs_drv.c
> index 03dae57dc838..26f65aa21079 100644
> --- a/drivers/accel/habanalabs/common/habanalabs_drv.c
> +++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
> @@ -12,7 +12,6 @@
>  #include "../include/hw_ip/pci/pci_general.h"
>
>  #include <linux/pci.h>
> -#include <linux/aer.h>
>  #include <linux/module.h>
>
>  #define CREATE_TRACE_POINTS
> @@ -550,8 +549,6 @@ static int hl_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>
>         pci_set_drvdata(pdev, hdev);
>
> -       pci_enable_pcie_error_reporting(pdev);
> -
>         rc =3D hl_device_init(hdev, hl_class);
>         if (rc) {
>                 dev_err(&pdev->dev, "Fatal error during habanalabs device=
 init\n");
> @@ -562,7 +559,6 @@ static int hl_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         return 0;
>
>  disable_device:
> -       pci_disable_pcie_error_reporting(pdev);
>         pci_set_drvdata(pdev, NULL);
>         destroy_hdev(hdev);
>
> @@ -585,7 +581,6 @@ static void hl_pci_remove(struct pci_dev *pdev)
>                 return;
>
>         hl_device_fini(hdev);
> -       pci_disable_pcie_error_reporting(pdev);
>         pci_set_drvdata(pdev, NULL);
>         destroy_hdev(hdev);
>  }
> --
> 2.25.1
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next
Thanks,
Oded
