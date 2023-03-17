Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7396BEBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCQOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCQOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4030664F9;
        Fri, 17 Mar 2023 07:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 521EF60301;
        Fri, 17 Mar 2023 14:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B129FC433A1;
        Fri, 17 Mar 2023 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679064750;
        bh=RemW7D3ij2yOrB+ogcaXKniVsacHQNaAVK4rBDGYz4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IozllazTbZyyaYXT3amI+U3cYXoYTfyN3j05jbPfb654yzF7uucPlpYjfhbDPDf0m
         e7lFNEzhyCEqImHAHTCTZl/9dHd+wNW2o69FXwJ+CFXOfAbHSee1DddG1SHVePFmik
         6pS1mB99n4NHNlZUDWO0GWqfFL/EdpHe+9wDPUGNUT7p4EuXZkLJ9wP0KpNhn2WwWK
         w4G1JRm8BSxTPNyIyZnjzF9zS6laNb0am5V1Zj772puADvXYqqxQHQihKBVuqUWiQr
         hf/+ahZ8xfsqLK3aUhebsboArCF7Anp0EBw9cRjNhvmFtNyCaShvHoQxB5niawtwqi
         ZjTpF54428zrg==
Received: by mail-ua1-f50.google.com with SMTP id g23so3501215uak.7;
        Fri, 17 Mar 2023 07:52:30 -0700 (PDT)
X-Gm-Message-State: AO0yUKWFQxBIDxTdYi/pfBQsf3a7duv4t1LlzvjhuPK2Q4nncP5b36a7
        6omOzUrQpv1QTt/Ayo1remBb8hLWeu1456gwCg==
X-Google-Smtp-Source: AK7set9DTA37RQ8MLUsuBcTMmfhuaSeaXAnHDyapP11GtUcP5QrFKPElA5Ajcksn57LAkYRXZ1Q3oo+iw0evcfnULlQ=
X-Received: by 2002:ab0:4a1a:0:b0:68b:8665:a73b with SMTP id
 q26-20020ab04a1a000000b0068b8665a73bmr29789667uae.1.1679064749554; Fri, 17
 Mar 2023 07:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230317030501.1811905-1-anshuman.khandual@arm.com> <20230317030501.1811905-7-anshuman.khandual@arm.com>
In-Reply-To: <20230317030501.1811905-7-anshuman.khandual@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Mar 2023 09:52:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
Message-ID: <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
Subject: Re: [PATCH 6/7] of/platform: Skip coresight etm4x devices from AMBA bus
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, scclevenger@os.amperecomputing.com,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 16, 2023 at 10:06=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Allow other drivers to claim a device, disregarding the "priority" of
> "arm,primecell". e.g., CoreSight ETM4x devices could be accessed via MMIO
> (AMBA Bus) or via CPU system instructions.

The OS can pick which one, use both, or this is a system integration
time decision?

> The CoreSight ETM4x platform
> driver can now handle both types of devices. In order to make sure the
> driver gets to handle the "MMIO based" devices, which always had the
> "arm,primecell" compatible, we have two options :
>
> 1) Remove the "arm,primecell" from the DTS. But this may be problematic
>  for an older kernel without the support.
>
> 2) The other option is to allow OF code to "ignore" the arm,primecell
> priority for a selected list of compatibles. This would make sure that
> both older kernels and the new kernels work fine without breaking
> the functionality. The new DTS could always have the "arm,primecell"
> removed.

3) Drop patches 6 and 7 and just register as both AMBA and platform
drivers. It's just some extra boilerplate. I would also do different
compatible strings for CPU system instruction version (assuming this
is an integration time decision).

>
> This patch implements Option (2).
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Co-developed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/of/platform.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b2bd2e783445..59ff1a38ccaa 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -325,6 +325,13 @@ static const struct of_dev_auxdata *of_dev_lookup(co=
nst struct of_dev_auxdata *l
>         return NULL;
>  }
>
> +static const struct of_device_id of_ignore_amba_table[] =3D {
> +#ifdef CONFIG_CORESIGHT_SOURCE_ETM4X
> +       { .compatible =3D "arm,coresight-etm4x" },
> +#endif
> +       {}    /* NULL terminated */
> +};
> +
>  /**
>   * of_platform_bus_create() - Create a device for a node and its childre=
n.
>   * @bus: device node of the bus to instantiate
> @@ -373,7 +380,8 @@ static int of_platform_bus_create(struct device_node =
*bus,
>                 platform_data =3D auxdata->platform_data;
>         }
>
> -       if (of_device_is_compatible(bus, "arm,primecell")) {
> +       if (of_device_is_compatible(bus, "arm,primecell") &&
> +           unlikely(!of_match_node(of_ignore_amba_table, bus))) {

of_match_node is going to take orders of magnitude longer than any
difference unlikely() would make. Drop it.

>                 /*
>                  * Don't return an error here to keep compatibility with =
older
>                  * device tree files.
> --
> 2.25.1
>
