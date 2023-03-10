Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190B6B4968
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjCJPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjCJPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD35ADD1;
        Fri, 10 Mar 2023 07:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046BF61A36;
        Fri, 10 Mar 2023 14:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE97C433EF;
        Fri, 10 Mar 2023 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460153;
        bh=YFc8z7PQrEiEAVk+eNCyyUkbwe5xhAM4AB5u7PX894E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmODi+ZUV7ygP8CclaAu/JvmuFtnqy4ppZtZvHyO2pbWumGoWLAzS0DLfBj73OaBd
         kkHfuKQggU+1uo4jdOcCcM14ZaV0PQbYnwjJUG6TX/4hIATz/1mCtTr1QaVJefnV8k
         FFG1et/AKbZVioaDy3+dL6lRhiZkefvWcoGcRuLQr3In3AWiLiF2F57hutJG1fRAFp
         gSPM7Z5Ju+cvWZjwQGEAXMOZJ8/Gf1F4EkHiToANd/VRGUM9P6nIIXQ+ooaU6RQSS6
         rBwEpnNsYK8aNOA/xLotDtPerGuS2n97WnbNHc/BAW4XYX04PU/qN3/Vbr9KAgFwcd
         nirmLwZyB8wNw==
Date:   Fri, 10 Mar 2023 20:25:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: qcom: Use of_property_present() for testing
 DT property presence
Message-ID: <20230310145545.GE6838@thinkpad>
References: <20230310144715.1543926-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310144715.1543926-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:15AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 198a44794d2d..6b52ed8c6178 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -3054,7 +3054,7 @@ static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nan
>  	struct device *dev = nandc->dev;
>  	int partitions_count, i, j, ret;
>  
> -	if (!of_find_property(dn, "qcom,boot-partitions", NULL))
> +	if (!of_property_present(dn, "qcom,boot-partitions"))
>  		return 0;
>  
>  	partitions_count = of_property_count_u32_elems(dn, "qcom,boot-partitions");
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
