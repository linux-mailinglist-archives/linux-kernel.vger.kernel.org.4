Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E57673B93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjASOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjASOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:22:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F783ABA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:22:12 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F8CA4192E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674138130;
        bh=cgpSJDuhoHdYNyebTdBDMFK/DhdY7FLUq4k1xDyDUX0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NW+0ytyxk4R7hhM0JakPaXXCh3FAC0GTt8kTSZa2CJ1m0YhljRBgKnr54pOe5Gw94
         lYVUnO14gieEiBSOOMMXLrYsB1ex9X1UVs1ACoOSPSmIglxYbhwYgIGUr9TyFIY4NS
         ZF6VdFQVxvoHJOzd6TnLoldIYrpvVQlv1oqLYtf/xVCFOquYDyKuW91Km4Ja6Cgwi4
         Aw228H97JYcr6jPLIkPEfYfrUv9N2gp7x0TkXMSeoK81ijaFcKy1Zyy6y5wPRanxw1
         Ubiix3qwhx7MD3AKgLL7oFGoabgZ/ona5c2d3Ryq5btwOr5xyFm77x+DGH193mtYUu
         qzYqsot2nkyww==
Received: by mail-pl1-f197.google.com with SMTP id x10-20020a170902ec8a00b001949f64986bso1444096plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgpSJDuhoHdYNyebTdBDMFK/DhdY7FLUq4k1xDyDUX0=;
        b=7Ywb6TADurhxE/ud4k9/SBDZOeSldegrQqkhvjF46Aa24VjPrWTJk/80dh+gcoFqUa
         CoRUyJ1lQF+6KPH5G2LU2Ld4JYbaDu2pj20xe2dHoR9X3121A45jeQb1qXF0eAup26Y6
         or2p9IS/D4TvFC6rNpdFMl0ODAi+BB7O5W+HK3dP8vVHuOWlrw5TbMIBBkuIxdNTebAF
         IFCZnfggkuPMtBe+ym+ig5LUVxhMZpdfUT0CZSk3Slqn/2FFmHyYsvaXIu/b2mXk3Xgz
         GbeLKsS0KOoc9hLHSz8pEnxcOjynJWXZjidlqheefS3oWwg3QkCKq3RwZJW5/9R/bwTE
         YCsw==
X-Gm-Message-State: AFqh2kpFyZ4KYtFSvmrElRZgYc1wT5Jw9JzOYXPMcOCtcVGr4W/72NMp
        SvB+xwRlx3T/1dbhbvm3WB1qvd8anFgaQimD49TtUWeHu18dOFygFLYjyVee6onWAQPrzoT+Zkp
        HYwHrv/0uAHkoFTUoM58m0IzGB/F/oRKs0zHbxYva/CRxw2QLraUo5ex+kQ==
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id g23-20020a62e317000000b00588cb819221mr1089724pfh.69.1674138128686;
        Thu, 19 Jan 2023 06:22:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsC4VqSbP6q7GcLRsSobmOhfD0wGXev/8fvUb7iRmApAcePDZET6T0MXxQUkEqNtvXxMmo3r5VRnX+ZyxXyci8=
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id
 g23-20020a62e317000000b00588cb819221mr1089712pfh.69.1674138128350; Thu, 19
 Jan 2023 06:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20230119094913.20536-1-vidyas@nvidia.com>
In-Reply-To: <20230119094913.20536-1-vidyas@nvidia.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 19 Jan 2023 22:21:57 +0800
Message-ID: <CAAd53p5R9BHoYpHq6WNgwtUAXmvNQnk6gA=C27JTfqeozRKCzQ@mail.gmail.com>
Subject: Re: [PATCH V1] PCI/ASPM: Skip L1SS save/restore if not already enabled
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, enriquezmark36@gmail.com,
        tasev.stefanoska@skynet.be, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vidya,

On Thu, Jan 19, 2023 at 5:49 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Skip save and restore of ASPM L1 Sub-States specific registers if they
> are not already enabled in the system. This is to avoid issues observed
> on certain platforms during restoration process, particularly when
> restoring the L1SS registers contents.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pcie/aspm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..5d3f09b0a6a9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -757,15 +757,29 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>                                 PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>
> +static bool skip_l1ss_restore;

Maybe move it inside "struct pci_dev"?

Kai-Heng

> +
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>  {
>         struct pci_cap_saved_state *save_state;
>         u16 l1ss = dev->l1ss;
> -       u32 *cap;
> +       u32 *cap, val;
>
>         if (!l1ss)
>                 return;
>
> +       /*
> +        * Skip save and restore of L1 Sub-States registers if they are not
> +        * already enabled in the system
> +        */
> +       pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
> +       if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
> +               skip_l1ss_restore = 1;
> +               return;
> +       }
> +
> +       skip_l1ss_restore = 0;
> +
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>         if (!save_state)
>                 return;
> @@ -784,6 +798,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>         if (!l1ss)
>                 return;
>
> +       if (skip_l1ss_restore)
> +               return;
> +
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>         if (!save_state)
>                 return;
> --
> 2.17.1
>
