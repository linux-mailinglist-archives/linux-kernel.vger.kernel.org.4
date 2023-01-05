Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE165EB1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjAEMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAEMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:52:34 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22895BA3C;
        Thu,  5 Jan 2023 04:51:55 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8395C61;
        Thu,  5 Jan 2023 13:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672923113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ox2AHpCozB9D2AA+DmLS+FQ8YK9yjntjf01mZPEqQQ=;
        b=CbTHCYy/PpHg9tnJL40N0QyKfSBPMEuWodnDHIS2Q7bnFFNSiBHUO8kGYkCu4CqzxlvpMN
        OD4EUMcJSjPq9EfPoSPo9i5yFs8YqU91BDNZV584H0em1c0Pwhx2G9e3YjETGgGeCtJ+xM
        QQraL2B4cfCIigOQJMsKIgFWxhDzsvI9TrBAxlPDonU1Z2fHXehQ1J1ze2mHfg8DyYowJp
        N/dYi3TdxeyV2uoBowyNYdNWPNJ7fOTD4IO8b1IjyE/H0GhaWegBc+q969OAQ5Nd9GBtdZ
        L35+YPXFm/qu7vt8J20PtJANmzQOKqvDnkBeuQ/mIP96ETVkIs5j8n6m52NgsA==
MIME-Version: 1.0
Date:   Thu, 05 Jan 2023 13:51:53 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
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
In-Reply-To: <5906091.UjTJXf6HLC@steina-w>
References: <20221206200740.3567551-1-michael@walle.cc>
 <20230105123534.38a70640@xps-13> <34cddc1aa4f8a55c752a9565d1726127@walle.cc>
 <5906091.UjTJXf6HLC@steina-w>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <13fca55324d55f9d4e30ca7fcc930e15@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-01-05 13:21, schrieb Alexander Stein:
> Am Donnerstag, 5. Januar 2023, 13:11:37 CET schrieb Michael Walle:
>> thanks for debugging. I'm not yet sure what is going wrong, so
>> I have some more questions below.
>> 
>> >> This causes the following errors on existing boards (imx8mq-tqma8mq-
>> >> mba8mx.dtb):
>> >> root@tqma8-common:~# uname -r
>> >> 6.2.0-rc2-next-20230105
>> >>
>> >> > OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/
>> >>
>> >> efuse@30350000/soc-uid@4
>> >>
>> >> > OF: /soc@0/bus@30800000/ethernet@30be0000: could not get
>> >> > #nvmem-cell-cells
>> >>
>> >> for /soc@0/bus@30000000/efuse@30350000/mac-address@90
>> >>
>> >> These are caused because '#nvmem-cell-cells = <0>;' is not explicitly
>> >> set in
>> >> DT.
>> >>
>> >> > TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get nvmem
>> >> > cell
>> >>
>> >> io_impedance_ctrl
>> >>
>> >> > TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22
>> >>
>> >> These are caused because of_nvmem_cell_get() now returns -EINVAL
>> >> instead of -
>> >> ENODEV if the requested nvmem cell is not available.
>> 
>> What do you mean with not available? Not yet available because of 
>> probe
>> order?
> 
> Ah, I was talking about there is no nvmem cell being used in my PHY 
> node, e.g.
> no 'nvmem-cells' nor 'nvmem-cell-names' (set to 'io_impedance_ctrl'). 
> That's
> why of_property_match_string returns -EINVAL.

Ahh I see. You mean ENOENT instead of ENODEV, right?

>> > Should we just assume #nvmem-cell-cells = <0> by default? I guess it's
>> > a safe assumption.
>> 
>> Actually, that's what patch 2/21 is for.
>> 
>> Alexander, did you verify that the EINVAL is returned by
>> of_parse_phandle_with_optional_args()?
> 
> Yep.
> 
> --8<--
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1b61c8bf0de4..f2a85a31d039 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1339,9 +1339,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct 
> device_node
> *np, const char *id)
>         if (id)
>                 index = of_property_match_string(np, 
> "nvmem-cell-names", id);
> 
> +       pr_info("%s: index: %d\n", __func__, index);
>         ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
>                                                   "#nvmem-cell-cells",
>                                                   index, &cell_spec);
> +       pr_info("%s: of_parse_phandle_with_optional_args: %d\n", 
> __func__,
> ret);
>         if (ret)
>                 return ERR_PTR(ret);
> --8<--
> 
> Results in:
>> [    1.861896] of_nvmem_cell_get: index: -22
>> [    1.865934] of_nvmem_cell_get: of_parse_phandle_with_optional_args: 
>> -22
>> [    1.872595] TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: 
>> failed to
> get nvmem cell io_impedance_ctrl
>> [    2.402575] TI DP83867: probe of 30be0000.ethernet-1:0e failed with 
>> error
> -22
> 
> So, the index is wrong in the first place, but this was no problem 
> until now.

Thanks, could you try the following patch:

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1b61c8bf0de4..1085abfcd9b1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1336,8 +1336,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct 
device_node *np, const char *id)
         int ret;

         /* if cell name exists, find index to the name */
-       if (id)
+       if (id) {
                 index = of_property_match_string(np, "nvmem-cell-names", 
id);
+               if (index < 0)
+                       return ERR_PTR(-ENOENT);
+       }

         ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
                                                   "#nvmem-cell-cells",

Before patch 6/21, the -EINVAL was passed as index to of_parse_phandle()
which then returned NULL, which caused the nvmem core to return ENOENT.
I have a vague memory, that I made sure, that
of_parse_phandle_with_optional_args() will also propagate the
wrong index to its return code. But now, it won't be converted
to ENOENT.

-michael
