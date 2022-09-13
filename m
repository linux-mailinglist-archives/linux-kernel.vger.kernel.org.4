Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F085B7AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIMTTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIMTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:19:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C86A486;
        Tue, 13 Sep 2022 12:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EC25B80EA9;
        Tue, 13 Sep 2022 19:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CFC433D7;
        Tue, 13 Sep 2022 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663096743;
        bh=hbJ+jt8q2MX1Qmvb46Ox1mB5sa41Mzpir1mnoZIlGsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbOPdpHi1WwYG+kmgbESyRlGWOw5quFAgyj2821DYSnp14NhEGw8o9T5uE5xwkGJe
         nueeMJD91Xz5zOqvIm16PSEv6QDb1CnuAKOeDjmJv3/zyFHiI8zL4WJZvzUPSeI/vX
         edqFrMZ4/dFfMVk9uO14WUp0ZNRuTdfys6rzdRwch9QLI54bpS3KiwvUtprPtCo8FW
         foKlYx6orb7/1mZEm7+PQTX0IJAlilW+vLm3RLxUCHvAYrRo672DrjyDgKcgp/dhnc
         Gfqw9M/3Giw2gMiZFyadig0y1MQOnFz/nHWVsrmnX4s6yJtLH2ggB04rzMfvMT69C0
         sc14ARSrQdICQ==
Date:   Tue, 13 Sep 2022 14:19:01 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v4 2/4] thermal: qcom: tsens: Add hooks for supplying
 platform specific reinit quirks
Message-ID: <20220913191901.s5s3zz77ycsrye4q@builder.lan>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
 <20220901105414.1171813-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901105414.1171813-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:24:12PM +0530, Bhupesh Sharma wrote:
> Add hooks inside platform specific data which can be
> used by Qualcomm tsens controller(s) which might need
> reinitialization via trustzone.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index ba05c8233356..92787017c6ab 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -513,6 +513,7 @@ struct tsens_features {
>   * @num_sensors: Number of sensors supported by platform
>   * @ops: operations the tsens instance supports
>   * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + * @needs_reinit_wa: tsens controller might need reinit via trustzone

What does "_wa" mean, and what value does it add?

needs_reinit captures the intent pretty well in my view.

Regards,
Bjorn

>   * @feat: features of the IP
>   * @fields: bitfield locations
>   */
> @@ -520,6 +521,7 @@ struct tsens_plat_data {
>  	const u32		num_sensors;
>  	const struct tsens_ops	*ops;
>  	unsigned int		*hw_ids;
> +	bool			needs_reinit_wa;
>  	struct tsens_features	*feat;
>  	const struct reg_field		*fields;
>  };
> @@ -542,6 +544,7 @@ struct tsens_context {
>   * @srot_map: pointer to SROT register address space
>   * @tm_offset: deal with old device trees that don't address TM and SROT
>   *             address space separately
> + * @needs_reinit_wa: tsens controller might need reinit via trustzone
>   * @ul_lock: lock while processing upper/lower threshold interrupts
>   * @crit_lock: lock while processing critical threshold interrupts
>   * @rf: array of regmap_fields used to store value of the field
> @@ -559,6 +562,7 @@ struct tsens_priv {
>  	struct regmap			*tm_map;
>  	struct regmap			*srot_map;
>  	u32				tm_offset;
> +	bool				needs_reinit_wa;
>  
>  	/* lock for upper/lower threshold interrupts */
>  	spinlock_t			ul_lock;
> -- 
> 2.37.1
> 
