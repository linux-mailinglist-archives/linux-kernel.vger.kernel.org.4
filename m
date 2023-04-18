Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8136E6976
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjDRQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjDRQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:26:43 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0EC650;
        Tue, 18 Apr 2023 09:26:38 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6a5e905e15aso328401a34.1;
        Tue, 18 Apr 2023 09:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835198; x=1684427198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjH/hStSCiVLtQLuqVajFztpwIunoyCsP3iwDrSgpHg=;
        b=id+wvDaalHa4jJQ1J8tfp9eh87aKsyryEOjwdfmwBvpfBNJd2UG8EANuK+IdqG9M4L
         a0udVM6lgX1yG2qt1dBqY+VobT+452iiqR4eOt3RAPkA6ReT9BBkR+QtpwncSTfaidpx
         3Htg3omq3iyQ3nWTJ6nWolmWP0+mgg8NkaC2SIJTGDZb00cyBJgbgV/9K6dN9QnRc7El
         eUAU+xSKv3+n/ofFiwUIt05uU+MNR1kvWAAT72HrCa68ISfF8nbBJCDRuOGh37grqql6
         F+Fk7KIblkU/zGQ9wtoxJihfIl/Uky89urF3s2oFwGaVuaPjkbqhozy72HLY8cOcpH4U
         iljQ==
X-Gm-Message-State: AAQBX9chi5qOMpfryVllPICd6sTzWP9p/2NZ6vprMkoZkOMAS3RlmV7B
        biKVmzPLCDD9/meJ+WTZ7Q==
X-Google-Smtp-Source: AKy350bEpph6yuJMXQ4ijSo0Yo4pU5RYjIe5g/2kLLvB2C5rB5LOQKRaMTTBKZ7Fy10XJv3tGSVurw==
X-Received: by 2002:a9d:7454:0:b0:6a5:f8b6:cccf with SMTP id p20-20020a9d7454000000b006a5f8b6cccfmr1548078otk.16.1681835197867;
        Tue, 18 Apr 2023 09:26:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t27-20020a0568301e3b00b0069436b64bb1sm5639720otr.79.2023.04.18.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:26:37 -0700 (PDT)
Received: (nullmailer pid 1809366 invoked by uid 1000);
        Tue, 18 Apr 2023 16:26:35 -0000
Date:   Tue, 18 Apr 2023 11:26:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: st: Use of_property_present() for testing DT
 property presence
Message-ID: <20230418162635.GE1764573-robh@kernel.org>
References: <20230310144736.1546972-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144736.1546972-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:35AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/remoteproc/st_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

> 
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index a3268d95a50e..50ef40671652 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -379,7 +379,7 @@ static int st_rproc_probe(struct platform_device *pdev)
>  		clk_set_rate(ddata->clk, ddata->clk_rate);
>  	}
>  
> -	if (of_get_property(np, "mbox-names", NULL)) {
> +	if (of_property_present(np, "mbox-names")) {
>  		ddata->mbox_client_vq0.dev		= dev;
>  		ddata->mbox_client_vq0.tx_done		= NULL;
>  		ddata->mbox_client_vq0.tx_block	= false;
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
