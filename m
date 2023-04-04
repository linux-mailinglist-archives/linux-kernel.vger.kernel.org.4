Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123146D60E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjDDMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjDDMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:37:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3A26A2;
        Tue,  4 Apr 2023 05:36:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so2042323wmb.3;
        Tue, 04 Apr 2023 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611802;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LPisD1g8fF1PkVibNy64HeK9w+XONYQHU5C+h/IWUs=;
        b=pfCnm9UEDOlfMEbjo6usXGtg4l+s5STT98F4BiLoN8XQVdAf3C2GoPM4x2RXhdgVXB
         qZxcSzJvG7pP3cABy9VxDqLM4J/f6yUrOcQRNYpzXBwDjRdJFma2QU1dFU55rfP6MLYQ
         j48s92BT3GUBts0IZ0gunLn8hHXDV86ihYISRURREjjKg9t1PSqgtOjMA+gK+nx3DqZ1
         J/eINiXfmne5crYwq8FXfChocyhZ8ZYxDC31T7Nhq8Hu8JgsKDerqjHmfiazPq/kJKJD
         pKvsvrGv8e3rofX8V3S3z4CFuXFHhaNHtT4H5vCmwVhBi9A4aWfWj4OmbCABdl45vKAW
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611802;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LPisD1g8fF1PkVibNy64HeK9w+XONYQHU5C+h/IWUs=;
        b=xoZRmtq/QNr+g04h8ACfd/oR+5V49fIqDW6jGMgL44RljK9CPaG+BJwyAqplWMK6nw
         6rNVpT2th2i8ncTBp9LkB0DXnNXvD5+/Wcr94bC/zNMvxbtsZ7XCc7IIj2/UG23bxrum
         hH7vUa8oehj5zTWeEQpOlfqAyEi0GQbMKsdr+hBWGwu+lehym4pP8uAjTGVkBOoksiUm
         yplGEcvkCaBEz+d5hUljimBzFW6ZiO8jgvVFmndQnmDCEKrmF7/itQF3zv8CDqBUghIx
         5gjJucLDiBcu9L0zn6sQMmHQXQ2mqA7UYspWP73h0UMefJY+PCgTb53RARtgTrxl8RE9
         dTIw==
X-Gm-Message-State: AAQBX9f3tX9KOZkiQVqm1umSbREX6mOhOqm/y+BalsJnN1j9WcqwUwwy
        T0qye6NwEPr8epeEYdxSrEfCgA5c51w=
X-Google-Smtp-Source: AKy350YFxwIbgK4/j1p6zdwmfAYafk+ZwRsfe4jU/xv3M587tCXyxukganyTA0syL9DORcqcJD5Wpg==
X-Received: by 2002:a7b:c41a:0:b0:3f0:4428:94fa with SMTP id k26-20020a7bc41a000000b003f0442894famr2097627wmi.26.1680611801910;
        Tue, 04 Apr 2023 05:36:41 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u17-20020a7bcb11000000b003ef5db16176sm15150553wmj.32.2023.04.04.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:36:41 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:36:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, JC Kuo <jckuo@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH v5] usb: xhci: tegra: fix sleep in atomic call
Message-ID: <ZCwZ169Ix7R4aPbx@orome>
References: <20230327095548.1599470-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qnhHWXaap8DkTg8Q"
Content-Disposition: inline
In-Reply-To: <20230327095548.1599470-1-haotienh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qnhHWXaap8DkTg8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 05:55:48PM +0800, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
>=20
> When we set the dual-role port to Host mode, we observed the following
> splat:
> [  167.057718] BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:229
> [  167.057872] Workqueue: events tegra_xusb_usb_phy_work
> [  167.057954] Call trace:
> [  167.057962]  dump_backtrace+0x0/0x210
> [  167.057996]  show_stack+0x30/0x50
> [  167.058020]  dump_stack_lvl+0x64/0x84
> [  167.058065]  dump_stack+0x14/0x34
> [  167.058100]  __might_resched+0x144/0x180
> [  167.058140]  __might_sleep+0x64/0xd0
> [  167.058171]  slab_pre_alloc_hook.constprop.0+0xa8/0x110
> [  167.058202]  __kmalloc_track_caller+0x74/0x2b0
> [  167.058233]  kvasprintf+0xa4/0x190
> [  167.058261]  kasprintf+0x58/0x90
> [  167.058285]  tegra_xusb_find_port_node.isra.0+0x58/0xd0
> [  167.058334]  tegra_xusb_find_port+0x38/0xa0
> [  167.058380]  tegra_xusb_padctl_get_usb3_companion+0x38/0xd0
> [  167.058430]  tegra_xhci_id_notify+0x8c/0x1e0
> [  167.058473]  notifier_call_chain+0x88/0x100
> [  167.058506]  atomic_notifier_call_chain+0x44/0x70
> [  167.058537]  tegra_xusb_usb_phy_work+0x60/0xd0
> [  167.058581]  process_one_work+0x1dc/0x4c0
> [  167.058618]  worker_thread+0x54/0x410
> [  167.058650]  kthread+0x188/0x1b0
> [  167.058672]  ret_from_fork+0x10/0x20
>=20
> The function tegra_xusb_padctl_get_usb3_companion eventually calls
> tegra_xusb_find_port and this in turn calls kasprintf which might sleep
> and so cannot be called from an atomic context.
>=20
> Fix this by moving the call to tegra_xusb_padctl_get_usb3_companion to
> the tegra_xhci_id_work function where it is really needed.
>=20
> Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
> V4 -> V5: Update commit message and code layout with 100 columns
> V3 -> V4: Remove copyright change from this patch
> V2 -> V3: Add version information
> V1 -> V2: Add "Fixes" and "Cc:" lines and update copyright years
> ---
>  drivers/usb/host/xhci-tegra.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--qnhHWXaap8DkTg8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQsGdUACgkQ3SOs138+
s6Gu2RAAmzYhi+6Q+40Z2gSV1KR50Yz0lE7E1BcmUNQNLFcDrfZYvKgXErcaBXIb
lLOz4ZmWwVCy5t7CsqVwn8zJ8XZvUXQPjp4+j1iUdJOf4yHAU2ZTaL86bugiBTm1
/T/Ing42b1bjMsGH3ndJHhzHp29zV9BFYKZy/syVikZqwyUlRHv/cn72OZ5jXnPz
3M9RNERfc/Telp0dte3FgZKus/4TxzOx0kkw2IqpePajvf2kWYcUnDul1AIgN60A
5tZbp40usNGqM//xZ/IdAlnMMBwcaZf4UqihqoNOxj8EuC9b/jFwO0f0pUHNy6ST
tI6X2aiSq0OSfLlkim0ChcLY+G0IcHZ0cEbXuVVQHFkub9P7C7IsTp5SPmI1M3ui
5kVMZXlthTvaAP/ccj28euHhPlgE34V3paEv/z5eqLatByTfprVrrFfQ7qe3jSCF
N23ZKSos+kDFVImVZFYzbknyExXQA5Zs87O/cHZNLjLho59X41C9pTLtT2J4enF/
leQu8wPU3UdCDTGwfWQji27to1ya5ZFvL1u3+Ilk8PGQZbkY9dkbjvFn3c2XWpYQ
fR14w1p+ls7+YJEbNcyN+LvjGKWQAZzujhdoHU+VoBIMnQ8iCXWFGm6QdrCiqOab
vwoKdJOMYzlvhOrVsqfYeAw4wjCjoYO8XrbdgHgy95v6kn10rpk=
=sHhN
-----END PGP SIGNATURE-----

--qnhHWXaap8DkTg8Q--
