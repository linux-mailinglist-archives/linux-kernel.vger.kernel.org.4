Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E414062FA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiKRQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiKRQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:42:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779166204A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39115B82404
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA7C433C1;
        Fri, 18 Nov 2022 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668789726;
        bh=Mrc50lPM60BwQ65uEo8Q4lFKJKU3glA1OU9cGpr63hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9EjFCIHJuV9Q11pMGbSaVSlRSE0nwi0EHnlojSS/c2Hd4qzcy7reu4OkgjnD5hmD
         Q0+Rwu1RK5QgUVNzlvPoGwlWHaTIgOnU3RvTHSWjFiGmQCwpxIPtjazTgpwBRCeO3O
         9aMBgFaCWOLAksdoo9DjgVBnci2DOpnyjZIXvzdvpX4m01IO1utmreHGwENMk+kuls
         1cIrGxVCV3Vd4pDGzsrEnvfyvc2sqw2SsIKJbY1UPD7y4s4fJMoTfGYcHg10Xxp6ZF
         yCI9CK6B3AUx96qDo3MuJ9xMjgPPQueo+iJW4t+NN8jZgvffo0ow1Fqj+TeoOKD/kc
         S/343k0kGVdsw==
Date:   Fri, 18 Nov 2022 16:41:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amzon.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v11 1/3] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Message-ID: <20221118164157.GA4802@willie-the-truck>
References: <20221117083419.2084264-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117083419.2084264-1-jiucheng.xu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:34:15PM +0800, Jiucheng Xu wrote:
> Add support for Amlogic Meson G12 Series SOC - DDR bandwidth PMU driver
> framework and interfaces. The PMU can not only monitor the total DDR
> bandwidth, but also individual IP module bandwidth.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> Tested-by: Chris Healy <healych@amzon.com>

amzon.com?

> +static umode_t meson_ddr_perf_format_attr_visible(struct kobject *kobj,
> +						  struct attribute *attr,
> +						  int n)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
> +	const u64 *capability = ddr_pmu->info.hw_info->capability;
> +	struct device_attribute *dev_attr;
> +	int id;
> +	char value[20]; // config1:xxx, 20 is enough
> +
> +	dev_attr = container_of(attr, struct device_attribute, attr);
> +	dev_attr->show(NULL, NULL, value);
> +
> +	if (sscanf(value, "config1:%d", &id) == 1)
> +		return capability[0] & (1 << id) ? attr->mode : 0;
> +
> +	if (sscanf(value, "config2:%d", &id) == 1)
> +		return capability[1] & (1 << id) ? attr->mode : 0;

Should these be '(1ULL << id)' to avoid shifting beyond the side of the
32-bit type?

Will
