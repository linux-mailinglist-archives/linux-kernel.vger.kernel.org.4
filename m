Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC265ECD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjAENWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjAENWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:22:17 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3EC392D0;
        Thu,  5 Jan 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672924931; x=1704460931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ye/7kCxTq0n5xXytrE3cFeS2TfEQI3g45COmEC/N+hs=;
  b=iquiZsp068RjteFbKDwGgRTl+i86jiVC9vBIsKpim2HY5tTufnNPTTMo
   yS35Z6S5dAzcdqk9rRKxNzcMBhOTlD/pEZRzgeUjpXCd3a3iLqdFTVYhq
   xFiTRejsJp6W6g6Pi2vVrB9dM6tmvyQ6FNTrVMYFp79hug5F40HIe3ZHY
   V+++U2AAhTeWQHnhMa93U9LTod6JcwULQqJcQtEhyTuBxBHom0CVv5D+6
   FZPw1v/25BeGBdSSuuV84ErTv9hhriJzW0rd0yRI7fIaTJfu3F/OBCo1G
   4HOWZV7MI/52Z94G2Rh0rDVChHoO7BLr/nycDiZbDD5cHG/fIYpNBof77
   g==;
X-IronPort-AV: E=Sophos;i="5.96,303,1665439200"; 
   d="scan'208";a="28260605"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Jan 2023 14:22:09 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 05 Jan 2023 14:22:09 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 05 Jan 2023 14:22:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672924929; x=1704460929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ye/7kCxTq0n5xXytrE3cFeS2TfEQI3g45COmEC/N+hs=;
  b=Yl3RXbZABfVHFXEe36gmY2YuiJABUYF4gQ0yFmOLIfIo+3AYn8VIkwEg
   jTOVg97V77A65wsyardkcpXK6Nin810sHvgygGaOMRcHr+9iXy2pZhcsF
   f6uX6hGdVpmgcE1PTi/uy9YR5O+FyBNjSNUESH0MK5Lb1daJ8wEZrGmfH
   unrN9FUrbPJHd8aFok4v3mMXqT1NsCPdmplCayamQPPbtc9nwCWij5Xo0
   AFrEfczzyFSy0SQu0wUv7vZQRqlstDF9Eto/dzPMGiREFzFIlMVJ27wG6
   GXBnYnnYZs/KU+rLxczzp1rigvteERbyETl9ainiZGRcumgHnDuLii1ty
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,303,1665439200"; 
   d="scan'208";a="28260604"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jan 2023 14:22:09 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 32AC9280056;
        Thu,  5 Jan 2023 14:22:09 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Date:   Thu, 05 Jan 2023 14:22:06 +0100
Message-ID: <20668918.0c2gjJ1VT2@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <13fca55324d55f9d4e30ca7fcc930e15@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc> <5906091.UjTJXf6HLC@steina-w> <13fca55324d55f9d4e30ca7fcc930e15@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Donnerstag, 5. Januar 2023, 13:51:53 CET schrieb Michael Walle:
> Hi,
> 
> Am 2023-01-05 13:21, schrieb Alexander Stein:
> > Am Donnerstag, 5. Januar 2023, 13:11:37 CET schrieb Michael Walle:
> >> thanks for debugging. I'm not yet sure what is going wrong, so
> >> I have some more questions below.
> >> 
> >> >> This causes the following errors on existing boards (imx8mq-tqma8mq-
> >> >> mba8mx.dtb):
> >> >> root@tqma8-common:~# uname -r
> >> >> 6.2.0-rc2-next-20230105
> >> >> 
> >> >> > OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/
> >> >> 
> >> >> efuse@30350000/soc-uid@4
> >> >> 
> >> >> > OF: /soc@0/bus@30800000/ethernet@30be0000: could not get
> >> >> > #nvmem-cell-cells
> >> >> 
> >> >> for /soc@0/bus@30000000/efuse@30350000/mac-address@90
> >> >> 
> >> >> These are caused because '#nvmem-cell-cells = <0>;' is not explicitly
> >> >> set in
> >> >> DT.
> >> >> 
> >> >> > TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get
> >> >> > nvmem
> >> >> > cell
> >> >> 
> >> >> io_impedance_ctrl
> >> >> 
> >> >> > TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22
> >> >> 
> >> >> These are caused because of_nvmem_cell_get() now returns -EINVAL
> >> >> instead of -
> >> >> ENODEV if the requested nvmem cell is not available.
> >> 
> >> What do you mean with not available? Not yet available because of
> >> probe
> >> order?
> > 
> > Ah, I was talking about there is no nvmem cell being used in my PHY
> > node, e.g.
> > no 'nvmem-cells' nor 'nvmem-cell-names' (set to 'io_impedance_ctrl').
> > That's
> > why of_property_match_string returns -EINVAL.
> 
> Ahh I see. You mean ENOENT instead of ENODEV, right?

Yeah you are right here, ENOENT is the one missing.

> >> > Should we just assume #nvmem-cell-cells = <0> by default? I guess it's
> >> > a safe assumption.
> >> 
> >> Actually, that's what patch 2/21 is for.
> >> 
> >> Alexander, did you verify that the EINVAL is returned by
> >> of_parse_phandle_with_optional_args()?
> > 
> > Yep.
> > 
> > --8<--
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 1b61c8bf0de4..f2a85a31d039 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -1339,9 +1339,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> > device_node
> > *np, const char *id)
> > 
> >         if (id)
> >         
> >                 index = of_property_match_string(np,
> > 
> > "nvmem-cell-names", id);
> > 
> > +       pr_info("%s: index: %d\n", __func__, index);
> > 
> >         ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
> >         
> >                                                   "#nvmem-cell-cells",
> >                                                   index, &cell_spec);
> > 
> > +       pr_info("%s: of_parse_phandle_with_optional_args: %d\n",
> > __func__,
> > ret);
> > 
> >         if (ret)
> >         
> >                 return ERR_PTR(ret);
> > 
> > --8<--
> > 
> > Results in:
> >> [    1.861896] of_nvmem_cell_get: index: -22
> >> [    1.865934] of_nvmem_cell_get: of_parse_phandle_with_optional_args:
> >> -22
> >> [    1.872595] TI DP83867 30be0000.ethernet-1:0e: error -EINVAL:
> >> failed to
> > 
> > get nvmem cell io_impedance_ctrl
> > 
> >> [    2.402575] TI DP83867: probe of 30be0000.ethernet-1:0e failed with
> >> error
> > 
> > -22
> > 
> > So, the index is wrong in the first place, but this was no problem
> > until now.
> 
> Thanks, could you try the following patch:
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1b61c8bf0de4..1085abfcd9b1 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1336,8 +1336,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id)
>          int ret;
> 
>          /* if cell name exists, find index to the name */
> -       if (id)
> +       if (id) {
>                  index = of_property_match_string(np, "nvmem-cell-names",
> id);
> +               if (index < 0)
> +                       return ERR_PTR(-ENOENT);
> +       }
> 
>          ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
>                                                    "#nvmem-cell-cells",
> 
> Before patch 6/21, the -EINVAL was passed as index to of_parse_phandle()
> which then returned NULL, which caused the nvmem core to return ENOENT.
> I have a vague memory, that I made sure, that
> of_parse_phandle_with_optional_args() will also propagate the
> wrong index to its return code. But now, it won't be converted
> to ENOENT.

Yes, this does the trick. Thanks

Best regards,
Alexander



