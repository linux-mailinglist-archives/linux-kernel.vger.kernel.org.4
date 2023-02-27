Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3079D6A47AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjB0RPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjB0RPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:15:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020341F93E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677518105; x=1709054105;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1OcPQbo8ePg+DLDJ2lHGXCZf3gRhxG8iTP1M5TYKjZA=;
  b=GG5yeWI0g6CRwGq2eggImrdamzrw9Y6lsm+96WmmGXHghhAOxDQtHf8Y
   aSZhTF2rjycbGHJELuTaFPKE6Ig3sj/Q4l81CTMjjdGmKtIhQIyI++H/M
   1u+uVZxJhxsXw35fEzoW7Yt8CmhN+cnFWzniB/s8ijoKMmfx29vp8D+qk
   dP3A9pHgFPTQ8MdmfU4pJyp8slUxci+mJWuzmN4tuXCirD62o1O/+Tu9L
   YtSBP5nkLPG0l9irpURrj8I2hh1zr+AVy/T0ByhuzxNkXQ2OQD3PTFO6W
   8jLeCWfh8JUtG6ICdcikjEVFY9yBWN68AhT/QgWMl9qqB7i5KMd4vSi8g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313585175"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313585175"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:13:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651302683"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="651302683"
Received: from jkaisrli-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:12:57 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Yaroslav Bolyukin <iam@lach.pw>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>
Subject: Re: [PATCH v3 1/2] drm/edid: parse DRM VESA dsc bpp target
In-Reply-To: <bed5e04a-a0e3-fb80-d75e-cdcd85efe7ab@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230226141051.21767-1-iam@lach.pw>
 <20230226141051.21767-2-iam@lach.pw>
 <bed5e04a-a0e3-fb80-d75e-cdcd85efe7ab@amd.com>
Date:   Mon, 27 Feb 2023 19:12:54 +0200
Message-ID: <87356r117t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2/26/23 09:10, Yaroslav Bolyukin wrote:
>> As per DisplayID v2.0 Errata E9 spec "DSC pass-through timing support"
>> VESA vendor-specific data block may contain target DSC bits per pixel
>> fields
>> 
>
> According to the errata this should only apply to VII timings. The way
> it is currently implemented will make it apply to everything which is
> not what we want.
>
> Can we add this field to drm_mode_info instead of drm_display_info and
> set it inside drm_mode_displayid_detailed when parsing a type_7 timing?

That's actually difficult to do nicely. I think the patch at hand is
fine, and it's fine to add the information to drm_display_info. It's a
dependency to parsing the modes.

How the info will actually be used is a different matter, and obviously
needs to follow the spec. As it is, *this* patch doesn't say anything
about that. But whether it's handled in VII timings parsing or
elsewhere, I still think this part is fine.


BR,
Jani.

>
> Harry
>
>
>> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
>> ---
>>  drivers/gpu/drm/drm_edid.c  | 38 +++++++++++++++++++++++++------------
>>  include/drm/drm_connector.h |  6 ++++++
>>  include/drm/drm_displayid.h |  4 ++++
>>  3 files changed, 36 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 3d0a4da661bc..aa88ac82cbe0 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -6338,7 +6338,7 @@ static void drm_parse_vesa_mso_data(struct drm_connector *connector,
>>  	if (oui(vesa->oui[0], vesa->oui[1], vesa->oui[2]) != VESA_IEEE_OUI)
>>  		return;
>>  
>> -	if (sizeof(*vesa) != sizeof(*block) + block->num_bytes) {
>> +	if (block->num_bytes < 5) {
>>  		drm_dbg_kms(connector->dev,
>>  			    "[CONNECTOR:%d:%s] Unexpected VESA vendor block size\n",
>>  			    connector->base.id, connector->name);
>> @@ -6361,24 +6361,37 @@ static void drm_parse_vesa_mso_data(struct drm_connector *connector,
>>  		break;
>>  	}
>>  
>> -	if (!info->mso_stream_count) {
>> -		info->mso_pixel_overlap = 0;
>> -		return;
>> -	}
>> +	info->mso_pixel_overlap = 0;
>> +
>> +	if (info->mso_stream_count) {
>> +		info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
>> +
>> +		if (info->mso_pixel_overlap > 8) {
>> +			drm_dbg_kms(connector->dev,
>> +				    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
>> +				    connector->base.id, connector->name,
>> +				    info->mso_pixel_overlap);
>> +			info->mso_pixel_overlap = 8;
>> +		}
>>  
>> -	info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
>> -	if (info->mso_pixel_overlap > 8) {
>>  		drm_dbg_kms(connector->dev,
>> -			    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
>> +			    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
>>  			    connector->base.id, connector->name,
>> -			    info->mso_pixel_overlap);
>> -		info->mso_pixel_overlap = 8;
>> +			    info->mso_stream_count, info->mso_pixel_overlap);
>> +	}
>> +
>> +	if (block->num_bytes < 7) {
>> +		/* DSC bpp is optional */
>> +		return;
>>  	}
>>  
>> +	info->dp_dsc_bpp = FIELD_GET(DISPLAYID_VESA_DSC_BPP_INT, vesa->dsc_bpp_int) * 16
>> +		+ FIELD_GET(DISPLAYID_VESA_DSC_BPP_FRACT, vesa->dsc_bpp_fract);
>> +
>>  	drm_dbg_kms(connector->dev,
>> -		    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
>> +		    "[CONNECTOR:%d:%s] DSC bits per pixel %u\n",
>>  		    connector->base.id, connector->name,
>> -		    info->mso_stream_count, info->mso_pixel_overlap);
>> +		    info->dp_dsc_bpp);
>>  }
>>  
>>  static void drm_update_mso(struct drm_connector *connector,
>> @@ -6425,6 +6438,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
>>  	info->mso_stream_count = 0;
>>  	info->mso_pixel_overlap = 0;
>>  	info->max_dsc_bpp = 0;
>> +	info->dp_dsc_bpp = 0;
>>  
>>  	kfree(info->vics);
>>  	info->vics = NULL;
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index 7b5048516185..1d01e0146a7f 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -719,6 +719,12 @@ struct drm_display_info {
>>  	 */
>>  	u32 max_dsc_bpp;
>>  
>> +	/**
>> +	 * @dp_dsc_bpp: DP Display-Stream-Compression (DSC) timing's target
>> +	 * DST bits per pixel in 6.4 fixed point format. 0 means undefined
>> +	 */
>> +	u16 dp_dsc_bpp;
>> +
>>  	/**
>>  	 * @vics: Array of vics_len VICs. Internal to EDID parsing.
>>  	 */
>> diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
>> index 49649eb8447e..0fc3afbd1675 100644
>> --- a/include/drm/drm_displayid.h
>> +++ b/include/drm/drm_displayid.h
>> @@ -131,12 +131,16 @@ struct displayid_detailed_timing_block {
>>  
>>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>> +#define DISPLAYID_VESA_DSC_BPP_INT	GENMASK(5, 0)
>> +#define DISPLAYID_VESA_DSC_BPP_FRACT	GENMASK(3, 0)
>>  
>>  struct displayid_vesa_vendor_specific_block {
>>  	struct displayid_block base;
>>  	u8 oui[3];
>>  	u8 data_structure_type;
>>  	u8 mso;
>> +	u8 dsc_bpp_int;
>> +	u8 dsc_bpp_fract;
>>  } __packed;
>>  
>>  /* DisplayID iteration */
>

-- 
Jani Nikula, Intel Open Source Graphics Center
