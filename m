Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B96175D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKCE6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCE6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:58:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4F17E1A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:58:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A34w3Tj104573;
        Wed, 2 Nov 2022 23:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667451483;
        bh=4iQp2SQBUEk5ytWus0w+Z76aptO8qBE/W1pEv83Jcic=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dsRDT8YkE9DTPiUGjpbH79k4PCs4zsEmGgQE89Y44KSyaRQ7TtNxF0SM3/0IeUc0U
         ZGkGctdnZi2rM6DBGOJsA0bjT2rwLgjkwJoLPdnMp1D8z7702hGyH8Q8YEMQ7t4aIf
         MDFcFECP/Kk6lPy8BBilNf5ZM0GeYeB5J/V77VOI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A34w3ib007369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 23:58:03 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 23:58:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 23:58:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A34w2TT036424;
        Wed, 2 Nov 2022 23:58:02 -0500
Date:   Wed, 2 Nov 2022 23:58:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <zhang.songyi@zte.com.cn>
CC:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jiang.xuexin@zte.com.cn>,
        <xue.zhihong@zte.com.cn>
Subject: Re: [PATCH linux-next] firmware: ti_sci: Use
 of_device_get_match_data()
Message-ID: <20221103045802.xtjiclljnficcmxc@bulginess>
References: <202211021657454006946@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202211021657454006946@zte.com.cn>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:57-20221102, zhang.songyi@zte.com.cn wrote:
> From 18dbde082d02c871453c5be8c762b6383a2f9641 Mon Sep 17 00:00:00 2001
> From: zhang songyi <zhang.songyi@zte.com.cn>
> Date: Wed, 2 Nov 2022 16:17:54 +0800
> Subject: [PATCH linux-next] firmware: ti_sci: Use of_device_get_match_data()
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/firmware/ti_sci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 6d2fd0ff7ff3..7db7d840fbb2 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3340,7 +3340,6 @@ MODULE_DEVICE_TABLE(of, ti_sci_of_match);
>  static int ti_sci_probe(struct platform_device *pdev)
>  {
>     struct device *dev = &pdev->dev;
> -   const struct of_device_id *of_id;
>     const struct ti_sci_desc *desc;
>     struct ti_sci_xfer *xfer;
>     struct ti_sci_info *info = NULL;
> @@ -3351,12 +3350,11 @@ static int ti_sci_probe(struct platform_device *pdev)
>     int reboot = 0;
>     u32 h_id;
> 
> -   of_id = of_match_device(ti_sci_of_match, dev);
> -   if (!of_id) {
> +   desc = of_device_get_match_data(dev);
> +   if (!desc) {
>         dev_err(dev, "OF data missing\n");
>         return -EINVAL;
>     }
> -   desc = of_id->data;
> 
>     info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>     if (!info)
> --
> 2.15.2


Could you please use git send-email to post patch following guidelines?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
