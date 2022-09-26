Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD65EA6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiIZNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiIZNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:09:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC801C26DE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664192368; x=1695728368;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=l8cJZ5nZRG0uHz3Sa9OLQ1/1gGRqKclgPkG6e83e0a8=;
  b=Gh+5OtAc7djaFGWGiV7yFSK2E/YaqeU08qaqz+PYhVSodZDOjy5iNwvc
   Uwg3oeeKdpLOAwwhOgJwRBSIoJVi0FUEqImb4Aeb0IMGmKJP0MoN9L2Sn
   QJb2GR+VyTYjB0Hlqxy0ww3jf6Za4pBDWGMPq56hKsX/c3cChE0g3CQGt
   epjjkfcQ6i0657TvpWLWMfDkb73lIMHb3ZP9czd3LpuhyhRSow2M8qSEQ
   aY6jTTPidjyJnmH8yAU8BGUxNC+5yE7+k5V3ihEu1VQKYEuAZjYwVE3Ij
   VBeir592+tvPegjyxsMERICynDbeFaZrt+tNPY7fqXU+McJ7xKUKRfcGJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="302473253"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="302473253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 04:37:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="651794097"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="651794097"
Received: from lsabisze-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 04:37:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH RESEND] drm/display: Don't assume dual mode adaptors
 support i2c sub-addressing
In-Reply-To: <20220926124017.529806df@computer>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220926124017.529806df@computer>
Date:   Mon, 26 Sep 2022 14:36:41 +0300
Message-ID: <87edvy2wqe.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022, Simon Rettberg <simon.rettberg@rz.uni-freiburg.de> wrote:
> Current dual mode adaptor ("DP++") detection code assumes that all adaptors
> support i2c sub-addressing for read operations from the DP-HDMI adaptor ID
> buffer.  It has been observed that multiple adaptors do not in fact
> support this, and always return data starting at register 0.  On
> affected adaptors, the code failed to read the proper registers that
> would identify the device as a type 2 adaptor, and handled those as
> type 1, limiting the TMDS clock to 165MHz.
> Fix this by always reading the ID buffer starting from offset 0, and
> discarding any bytes before the actual offset of interest.
>
> Signed-off-by: Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
> Reviewed-by: Rafael Gieschke <rafael.gieschke@rz.uni-freiburg.de>
> ---
> (Resend because of no response, probably my fault since I ran
> get_maintainers on a shallow clone and missed a bunch of people)
>
> We had problems with multiple different "4k ready" DP++ adaptors only
> resulting in 1080p resolution on Linux. While one of them turned out to
> actually just be a type1 adaptor, the others, according to the data
> retreived via i2cdump, were in fact proper type2 adaptors, advertising a
> TMDS clock of 300MHz. As it turned out, none of them supported
> sub-addressing when reading from the DP-HDMI adaptor ID buffer via i2c.
> The existing code suggested that this is known to happen with "broken"
> type1 adaptors, but evidently, type2 adaptors are also affected.
> We tried finding authoritative documentation on whether or not this is
> allowed behavior, but since all the official VESA docs are paywalled,
> the best we could come up with was the spec sheet for Texas Instruments'
> SNx5DP149 chip family.[1] It explicitly mentions that sub-adressing is
> supported for register writes, but *not* for reads (See NOTE in
> section 8.5.3). Unless TI blatantly and openly decided to violate the
> VESA spec, one could take that as a strong hint that sub-addressing is
> in fact not mandated by VESA.
>
> [1] https://www.ti.com/lit/ds/symlink/sn75dp149.pdf

Cc: Ville. Also bounced to intel-gfx list to get CI results.

We'll probably want to have the above details included in the commit
message too.

BR,
Jani.



>
>  .../gpu/drm/display/drm_dp_dual_mode_helper.c | 52 ++++++++++---------
>  1 file changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> index 3ea53bb67..6147da983 100644
> --- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> @@ -63,23 +63,42 @@
>  ssize_t drm_dp_dual_mode_read(struct i2c_adapter *adapter,
>  			      u8 offset, void *buffer, size_t size)
>  {
> +	int ret;
> +	u8 zero = 0;
> +	char *tmpbuf;
> +	/*
> +	 * As sub-addressing is not supported by all adaptors,
> +	 * always explicitly read from the start and discard
> +	 * any bytes that come before the requested offset.
> +	 * This way, no matter whether the adaptor supports it
> +	 * or not, we'll end up reading the proper data.
> +	 */
>  	struct i2c_msg msgs[] = {
>  		{
>  			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
>  			.flags = 0,
>  			.len = 1,
> -			.buf = &offset,
> +			.buf = &zero,
>  		},
>  		{
>  			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
>  			.flags = I2C_M_RD,
> -			.len = size,
> -			.buf = buffer,
> +			.len = size + offset,
> +			.buf = NULL,
>  		},
>  	};
> -	int ret;
>  
> +	tmpbuf = kmalloc(size + offset, GFP_KERNEL);
> +	if (!tmpbuf)
> +		return -ENOMEM;
> +
> +	msgs[1].buf = tmpbuf;
>  	ret = i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret == ARRAY_SIZE(msgs))
> +		memcpy(buffer, tmpbuf + offset, size);
> +
> +	kfree(tmpbuf);
> +
>  	if (ret < 0)
>  		return ret;
>  	if (ret != ARRAY_SIZE(msgs))
> @@ -208,18 +227,6 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_detect(const struct drm_device *dev,
>  	if (ret)
>  		return DRM_DP_DUAL_MODE_UNKNOWN;
>  
> -	/*
> -	 * Sigh. Some (maybe all?) type 1 adaptors are broken and ack
> -	 * the offset but ignore it, and instead they just always return
> -	 * data from the start of the HDMI ID buffer. So for a broken
> -	 * type 1 HDMI adaptor a single byte read will always give us
> -	 * 0x44, and for a type 1 DVI adaptor it should give 0x00
> -	 * (assuming it implements any registers). Fortunately neither
> -	 * of those values will match the type 2 signature of the
> -	 * DP_DUAL_MODE_ADAPTOR_ID register so we can proceed with
> -	 * the type 2 adaptor detection safely even in the presence
> -	 * of broken type 1 adaptors.
> -	 */
>  	ret = drm_dp_dual_mode_read(adapter, DP_DUAL_MODE_ADAPTOR_ID,
>  				    &adaptor_id, sizeof(adaptor_id));
>  	drm_dbg_kms(dev, "DP dual mode adaptor ID: %02x (err %zd)\n", adaptor_id, ret);
> @@ -233,11 +240,10 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_detect(const struct drm_device *dev,
>  				return DRM_DP_DUAL_MODE_TYPE2_DVI;
>  		}
>  		/*
> -		 * If neither a proper type 1 ID nor a broken type 1 adaptor
> -		 * as described above, assume type 1, but let the user know
> -		 * that we may have misdetected the type.
> +		 * If not a proper type 1 ID, still assume type 1, but let
> +		 * the user know that we may have misdetected the type.
>  		 */
> -		if (!is_type1_adaptor(adaptor_id) && adaptor_id != hdmi_id[0])
> +		if (!is_type1_adaptor(adaptor_id))
>  			drm_err(dev, "Unexpected DP dual mode adaptor ID %02x\n", adaptor_id);
>  
>  	}
> @@ -343,10 +349,8 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
>   * @enable: enable (as opposed to disable) the TMDS output buffers
>   *
>   * Set the state of the TMDS output buffers in the adaptor. For
> - * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register. As
> - * some type 1 adaptors have problems with registers (see comments
> - * in drm_dp_dual_mode_detect()) we avoid touching the register,
> - * making this function a no-op on type 1 adaptors.
> + * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register.
> + * Type1 adaptors do not support any register writes.
>   *
>   * Returns:
>   * 0 on success, negative error code on failure

-- 
Jani Nikula, Intel Open Source Graphics Center
