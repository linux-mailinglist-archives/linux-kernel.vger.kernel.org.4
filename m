Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC5648D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 07:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLJGPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 01:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLJGPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 01:15:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD64877B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 22:15:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f9so4915147pgf.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 22:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/mv2Vg6Tzosm4w7o11AI02f3YAHuOGz8Cx+xd6EkE8=;
        b=YCCZ9nYGZ5pLRjJxQlJoTZ//MaI6SdbV2DievHgAtVpXVa9yhNhipu8PNRACyP354o
         ThdBlo7PQdQMlG9XqV1SZmKRJ6yF2erWcnggtXx+dl89DtDk/XFy344Hg5f+kyAcL5U/
         fiUX/61AamVgz3so6qeP5znjqybi9Xb0gaaqndFbAR02XUHtiBgYFpxBB8LScC64tQlY
         PKNbjAjbhlfJobDKst8BEZgSduANFEtlOZ6yB4XnFV/QHnY6biy8droMSQCv6B5Ur5ab
         pVrVQc8n4Z+htWhEMEb4Troyq4VcE38xl5ReRwKsajzxjYwgNVR68lS8jo7Tuc7GejOb
         C4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/mv2Vg6Tzosm4w7o11AI02f3YAHuOGz8Cx+xd6EkE8=;
        b=jApNes0cY4uuC9SaPYJQ4LzW+qbu7vrCub/C6goPb0fymW81uycu6wHUtFRc1Q8bvs
         2HwD+RNKV7zhardBoOBdwk8QO7wzxtpsVDPPkwlvd4Zt8OYzwlFLffEBGsbiC2LXqX4w
         mVMV2KVnC4Ve6mmcVKxjJdtZKd+jsJRezc3wiN2FDzkKTxeMiDwuvUIDfO1bXVgyp0s2
         nPdvrinf3xCjh25bjR48/+wlXCyNgvbaYR3NDGRcspLb4TlZrtSl2JhryLiv4LKypyI0
         Hz9vfBv90eZtdBLPzLokTz6siiAo3VBR9ifSnU3XzvsGTobDYc0Y9DEq/Jh+CPr1XYKA
         vt0g==
X-Gm-Message-State: ANoB5pkRq4uhB2krElJuIHQhoxaL87u2boFgbhOhiSMetkgafq6HF6uq
        BtruGBMdyYVx/INdf9Ejk33gSB3hUFaTzMn0tnmxuw==
X-Google-Smtp-Source: AA0mqf7KW2moqJ2D5+4GvNf0FbMFxrIR1TVu0iN71/nJcN/WRC6kZvYquXp0vNxRtoYIhbYtEXhNMU0uYGxuISiy5Lc=
X-Received: by 2002:a62:168b:0:b0:574:a82b:d290 with SMTP id
 133-20020a62168b000000b00574a82bd290mr65034732pfw.42.1670652909067; Fri, 09
 Dec 2022 22:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20221210060119.944931-1-badhri@google.com> <20221210060119.944931-2-badhri@google.com>
In-Reply-To: <20221210060119.944931-2-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 9 Dec 2022 22:14:32 -0800
Message-ID: <CAPTae5LrX1uLb5sFUma9LN0bzSvN2GFKA-nURP_7AjrdGN=X0A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] usb: typec: tcpci: Add callback for evaluating
 contaminant presence
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard. Messed up versions. Version 9 is what it is.

On Fri, Dec 9, 2022 at 10:01 PM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> This change adds callback to evaluate presence of contaminant in
> the TCPCI layer.
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v6:
> * Removed is_potential_contaminant callback
> Changes since v5:
> * None
> Changes since v4:
> * None
> Changes since v3:
> * None
> Changes since v2:
> * Added tcpci_is_potential_contaminant to offload
> * disconnect_while_debounce logic
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
>  include/linux/usb/tcpci.h      | 7 +++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index fe781a38dc82..c8e78c13c9c4 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -403,6 +403,14 @@ static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
>                 tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
>  }
>
> +static void tcpci_check_contaminant(struct tcpc_dev *dev)
> +{
> +       struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +
> +       if (tcpci->data->check_contaminant)
> +               tcpci->data->check_contaminant(tcpci, tcpci->data);
> +}
> +
>  static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
>  {
>         struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -777,6 +785,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>         tcpci->tcpc.enable_frs = tcpci_enable_frs;
>         tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>         tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
> +       tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
>
>         if (tcpci->data->auto_discharge_disconnect) {
>                 tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 17657451c762..85e95a3251d3 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -188,6 +188,12 @@ struct tcpci;
>   *             Optional; The USB Communications Capable bit indicates if port
>   *             partner is capable of communication over the USB data lines
>   *             (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> + * @check_contaminant:
> + *             Optional; The callback is invoked when chiplevel drivers indicated
> + *             that the USB port needs to be checked for contaminant presence.
> + *             Chip level drivers are expected to check for contaminant and call
> + *             tcpm_clean_port when the port is clean to put the port back into
> + *             toggling state.
>   */
>  struct tcpci_data {
>         struct regmap *regmap;
> @@ -204,6 +210,7 @@ struct tcpci_data {
>         void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
>         void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
>                                              bool capable);
> +       void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
>  };
>
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>
