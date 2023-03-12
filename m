Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199876B643E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCLJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:42:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B074FAA2;
        Sun, 12 Mar 2023 01:42:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (85-76-49-20-nat.elisa-mobile.fi [85.76.49.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5D30814;
        Sun, 12 Mar 2023 10:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678614135;
        bh=2ZEVl5rsK5H4zvdfeUpUGY8WalO/tOcjHbf6ZixUYTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uW96zgPhEyFUlg4cwx9U8aHK5ydpIh7K+GzgaU9BL/vhdw/+zL9BwsVRIklgwy83n
         znnzlWCsVkBmtHm+lRiw3bEhYFZhWAax0IaEGUVALEnD+uuJxSGkkm7T2ZqG7LsoeF
         i/JJlR0QZobdvA1oeaCuik3cfnIoI/l0HyEqwgro=
Date:   Sun, 12 Mar 2023 11:42:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/9] regulator: max20086: Mark OF related data as maybe
 unused
Message-ID: <20230312094216.GC707@pendragon.ideasonboard.com>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
 <20230310214553.275450-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310214553.275450-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Fri, Mar 10, 2023 at 10:45:46PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/regulator/max20086-regulator.c:289:34: error: ‘max20086_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/regulator/max20086-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
> index b8bf76c170fe..c98a72f43935 100644
> --- a/drivers/regulator/max20086-regulator.c
> +++ b/drivers/regulator/max20086-regulator.c
> @@ -286,7 +286,7 @@ static const struct i2c_device_id max20086_i2c_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
>  
> -static const struct of_device_id max20086_dt_ids[] = {
> +static const struct of_device_id max20086_dt_ids[] __maybe_unused = {

The following change would also work, as the of_match_table field of
struct device_driver isn't conditioned by CONFIG_OF:

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index b8bf76c170fe..ad92f84b4abb 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -320,7 +320,7 @@ MODULE_DEVICE_TABLE(of, max20086_dt_ids);
 static struct i2c_driver max20086_regulator_driver = {
 	.driver = {
 		.name = "max20086",
-		.of_match_table = of_match_ptr(max20086_dt_ids),
+		.of_match_table = max20086_dt_ids,
 	},
 	.probe_new = max20086_i2c_probe,
 	.id_table = max20086_i2c_id,

Your patch should reduce the module size without any real drawback as
far as I can see, so that's probably best. I'm fine with either
approach, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	{
>  		.compatible = "maxim,max20086",
>  		.data = &(const struct max20086_chip_info) {

-- 
Regards,

Laurent Pinchart
