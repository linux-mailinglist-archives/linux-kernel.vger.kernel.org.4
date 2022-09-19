Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90115BD5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISU4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580A4B497;
        Mon, 19 Sep 2022 13:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04AA861DDD;
        Mon, 19 Sep 2022 20:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B3EC433C1;
        Mon, 19 Sep 2022 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663620995;
        bh=RMPDWz9rmgHZcfSMIbHo/eTIi42VrNwpeHzpIffLT6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJGUFtV1Q/kgnoUVQ6D8q/385Oa09VWeGQRAfkW8UisZIfZCYzBnAkreJtLX51sWF
         lo2CdaQ283I1X3rBLL8ocSLBsbG/f4mkSO8PWMrmvqJUgKfh4KbSF6Ro9apXPjKVOM
         M+/SzKJcgO6v5l9C0KqAEK6ai52jqr2ztUj+J5gqgLW2wZJbQ6Kcllsz2s/qskKsqF
         SMrGYWWU9WDTY9QcUsQkDfcygtXY5MpWwWBsYgLZvKLndSbs1v8aksLptTHv2Ubq51
         r1HZjWHDwI+s1QA5AJlZ734xz6n7L3SOFzIjj2cWhXskygKbxY7J9pQRkJk0QayV8H
         xe/dBnDI/c6Mw==
Date:   Mon, 19 Sep 2022 15:56:33 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: llcc: Move struct llcc_slice_config to
 header
Message-ID: <20220919205633.qw5ucwjtyt4vjsro@builder.lan>
References: <1663384000-8097-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663384000-8097-1-git-send-email-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:06:40PM -0700, Guru Das Srinagesh wrote:
> Move struct llcc_slice_config to header so that it can be reused by
> other kernel modules.

Can you please continue this sentence to provide some concrete examples?
Will we see those other users posted upstream?

Thanks,
Bjorn

> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 44 --------------------------------------
>  include/linux/soc/qcom/llcc-qcom.h | 44 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 38d7296..3e7326f 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -55,50 +55,6 @@
>  #define LLCC_VERSION_2_0_0_0          0x02000000
>  #define LLCC_VERSION_2_1_0_0          0x02010000
>  
> -/**
> - * struct llcc_slice_config - Data associated with the llcc slice
> - * @usecase_id: Unique id for the client's use case
> - * @slice_id: llcc slice id for each client
> - * @max_cap: The maximum capacity of the cache slice provided in KB
> - * @priority: Priority of the client used to select victim line for replacement
> - * @fixed_size: Boolean indicating if the slice has a fixed capacity
> - * @bonus_ways: Bonus ways are additional ways to be used for any slice,
> - *		if client ends up using more than reserved cache ways. Bonus
> - *		ways are allocated only if they are not reserved for some
> - *		other client.
> - * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
> - *		be used by any other client than the one its assigned to.
> - * @cache_mode: Each slice operates as a cache, this controls the mode of the
> - *             slice: normal or TCM(Tightly Coupled Memory)
> - * @probe_target_ways: Determines what ways to probe for access hit. When
> - *                    configured to 1 only bonus and reserved ways are probed.
> - *                    When configured to 0 all ways in llcc are probed.
> - * @dis_cap_alloc: Disable capacity based allocation for a client
> - * @retain_on_pc: If this bit is set and client has maintained active vote
> - *               then the ways assigned to this client are not flushed on power
> - *               collapse.
> - * @activate_on_init: Activate the slice immediately after it is programmed
> - * @write_scid_en: Bit enables write cache support for a given scid.
> - * @write_scid_cacheable_en: Enables write cache cacheable support for a
> - *			     given scid (not supported on v2 or older hardware).
> - */
> -struct llcc_slice_config {
> -	u32 usecase_id;
> -	u32 slice_id;
> -	u32 max_cap;
> -	u32 priority;
> -	bool fixed_size;
> -	u32 bonus_ways;
> -	u32 res_ways;
> -	u32 cache_mode;
> -	u32 probe_target_ways;
> -	bool dis_cap_alloc;
> -	bool retain_on_pc;
> -	bool activate_on_init;
> -	bool write_scid_en;
> -	bool write_scid_cacheable_en;
> -};
> -
>  struct qcom_llcc_config {
>  	const struct llcc_slice_config *sct_data;
>  	int size;
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 9ed5384..e84cd87 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -106,6 +106,50 @@ struct llcc_drv_data {
>  	u32 version;
>  };
>  
> +/**
> + * struct llcc_slice_config - Data associated with the llcc slice
> + * @usecase_id: Unique id for the client's use case
> + * @slice_id: llcc slice id for each client
> + * @max_cap: The maximum capacity of the cache slice provided in KB
> + * @priority: Priority of the client used to select victim line for replacement
> + * @fixed_size: Boolean indicating if the slice has a fixed capacity
> + * @bonus_ways: Bonus ways are additional ways to be used for any slice,
> + *		if client ends up using more than reserved cache ways. Bonus
> + *		ways are allocated only if they are not reserved for some
> + *		other client.
> + * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
> + *		be used by any other client than the one its assigned to.
> + * @cache_mode: Each slice operates as a cache, this controls the mode of the
> + *             slice: normal or TCM(Tightly Coupled Memory)
> + * @probe_target_ways: Determines what ways to probe for access hit. When
> + *                    configured to 1 only bonus and reserved ways are probed.
> + *                    When configured to 0 all ways in llcc are probed.
> + * @dis_cap_alloc: Disable capacity based allocation for a client
> + * @retain_on_pc: If this bit is set and client has maintained active vote
> + *               then the ways assigned to this client are not flushed on power
> + *               collapse.
> + * @activate_on_init: Activate the slice immediately after it is programmed
> + * @write_scid_en: Bit enables write cache support for a given scid.
> + * @write_scid_cacheable_en: Enables write cache cacheable support for a
> + *			     given scid (not supported on v2 or older hardware).
> + */
> +struct llcc_slice_config {
> +	u32 usecase_id;
> +	u32 slice_id;
> +	u32 max_cap;
> +	u32 priority;
> +	bool fixed_size;
> +	u32 bonus_ways;
> +	u32 res_ways;
> +	u32 cache_mode;
> +	u32 probe_target_ways;
> +	bool dis_cap_alloc;
> +	bool retain_on_pc;
> +	bool activate_on_init;
> +	bool write_scid_en;
> +	bool write_scid_cacheable_en;
> +};
> +
>  #if IS_ENABLED(CONFIG_QCOM_LLCC)
>  /**
>   * llcc_slice_getd - get llcc slice descriptor
> -- 
> 2.7.4
> 
