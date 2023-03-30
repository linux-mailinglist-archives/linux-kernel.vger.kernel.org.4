Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCD6D0D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjC3SR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjC3SRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:17:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D1EF9F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:17:18 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hwphptLXW6OWihwphpVejs; Thu, 30 Mar 2023 20:17:16 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 30 Mar 2023 20:17:16 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d14d668b-f351-f6d3-fe85-aac0fcbfb11b@wanadoo.fr>
Date:   Thu, 30 Mar 2023 20:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Content-Language: fr
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
References: <20230329100107.8181-1-13916275206@139.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230329100107.8181-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/03/2023 à 12:01, Shenghao Ding a écrit :
> Create tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v10:

[...]

Hi,

> +static void tasdevice_select_cfg_blk(void *pContext, int conf_no,
> +	unsigned char block_type)
> +{
> +	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
> +	struct tasdevice_rca *rca = &(tas_dev->rcabin);
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	struct tasdev_blk_data **blk_data;
> +	int j, k, chn, chnend;
> +
> +	if (conf_no >= rca->ncfgs || conf_no < 0 || !cfg_info) {
> +		dev_err(tas_dev->dev, "conf_no should be not more than %u\n",
> +			rca->ncfgs);
> +		return;
> +	}
> +	blk_data =  cfg_info[conf_no]->blk_data;
> +
> +	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
> +		unsigned int length = 0, rc = 0;
> +
> +		if (block_type > 5 || block_type < 2) {
> +			dev_err(tas_dev->dev,
> +				"block_type should be in range from 2 to 5\n");
> +			break;
> +		}
> +		if (block_type != blk_data[j]->block_type)
> +			continue;
> +
> +		for (k = 0; k < (int)blk_data[j]->n_subblks; k++) {
> +			if (cfg_info[conf_no]->blk_data[j]->dev_idx) {

Just use "blk_data[j]->dev_idx"?

> +				chn = blk_data[j]->dev_idx - 1;
> +				chnend = blk_data[j]->dev_idx;
> +			} else {
> +				chn = 0;
> +				chnend = tas_dev->ndev;
> +			}

[...]

> +	/* Several kinds of dsp/algorithm firmwares can run on tas2781,
> +	 * the number and size of blk are not fixed and different among
> +	 * thest firmwares.

these?

CJ
