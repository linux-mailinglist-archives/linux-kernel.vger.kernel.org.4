Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63A675A31
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjATQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjATQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:40:20 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93FA40E9;
        Fri, 20 Jan 2023 08:40:18 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id mg12so15396148ejc.5;
        Fri, 20 Jan 2023 08:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csi4POQTNrwGOEhk2ixGemwP2nNjAXiSiCcAdPhdTRQ=;
        b=bHlbi46ChsuTYuiuBurzTfYbs13WkYQjQMVa16wlnSrphvlRZE3EQ9vTRetsUhI3Nb
         dvzgFKV1rqoHWzebIuKqMHuU6XYG2UwQRiIhtLNmZAHM8GP3xxfuyWqzqfPJj4BuU1Cl
         uyeEhlmEY/k5TtaAsIB0PUB6MngsffkNCDj7h8D8WLaIowZ7W0a3N+T28qAniU721MIb
         bqgXNC9J3bSeEUNQcPA2IkTDFJ3momOk0dLTybNDQznTKGEmnX1SzTFjZ5zW+8eyxOPl
         ZSVA/z27oJhMkiK0L0s14BU/5RW3hodIyA8UnSwFDqiJoyxo7yCtvEt9kEr/wVQPEVN6
         jMqQ==
X-Gm-Message-State: AFqh2kqjtymfyBmp5bxBMe+5h5O5JUFF17KVhM98BhHPgdosXkM7ppQQ
        vt9pHfXXb1s5LRonKsgLPu7SJ+KjEsJi1n8Ap0A=
X-Google-Smtp-Source: AMrXdXtpPdy6MsSqnbjmEa5Sd5dQV23sws9Ah6n4RaZklieDTar+9aUOWK5AiksS9zwNzb60mWWv6+exwxXt/k4JIC0=
X-Received: by 2002:a17:907:7855:b0:855:63bb:d3cb with SMTP id
 lb21-20020a170907785500b0085563bbd3cbmr1587945ejc.532.1674232817416; Fri, 20
 Jan 2023 08:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20230107192513.118172-1-tim@linux4.de>
In-Reply-To: <20230107192513.118172-1-tim@linux4.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:40:06 +0100
Message-ID: <CAJZ5v0jYUmDHn6ati=zOU6JyYYAuc6CUtV2eomPWWa2aBoKdSA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: pch: Add support for Wellsburg PCH
To:     Tim Zimmermann <tim@linux4.de>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 8:42 PM Tim Zimmermann <tim@linux4.de> wrote:
>
> This adds the PCI ID for the Wellsburg C610 series chipset PCH. The
> driver can read the temperature from the Wellsburg PCH with only the PCI
> ID added and no other modifications.
>
> Signed-off-by: Tim Zimmermann <tim@linux4.de>

Rui, Srinivas, any objections to this one?

> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> index dabf11a687a1..9e27f430e034 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -29,6 +29,7 @@
>  #define PCH_THERMAL_DID_CNL_LP 0x02F9 /* CNL-LP PCH */
>  #define PCH_THERMAL_DID_CML_H  0X06F9 /* CML-H PCH */
>  #define PCH_THERMAL_DID_LWB    0xA1B1 /* Lewisburg PCH */
> +#define PCH_THERMAL_DID_WBG    0x8D24 /* Wellsburg PCH */
>
>  /* Wildcat Point-LP  PCH Thermal registers */
>  #define WPT_TEMP       0x0000  /* Temperature */
> @@ -350,6 +351,7 @@ enum board_ids {
>         board_cnl,
>         board_cml,
>         board_lwb,
> +       board_wbg,
>  };
>
>  static const struct board_info {
> @@ -380,6 +382,10 @@ static const struct board_info {
>                 .name = "pch_lewisburg",
>                 .ops = &pch_dev_ops_wpt,
>         },
> +       [board_wbg] = {
> +               .name = "pch_wellsburg",
> +               .ops = &pch_dev_ops_wpt,
> +       },
>  };
>
>  static int intel_pch_thermal_probe(struct pci_dev *pdev,
> @@ -495,6 +501,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
>                 .driver_data = board_cml, },
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
>                 .driver_data = board_lwb, },
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WBG),
> +               .driver_data = board_wbg, },
>         { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
> --
> 2.39.0
>
