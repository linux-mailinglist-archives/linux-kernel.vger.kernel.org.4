Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E0629F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKOQcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiKOQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:31:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF72B489
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668529915; x=1700065915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jS/YAyEH8uDvtuhHcy/3+/RGGpn8PTSzs5xMFFHtKWI=;
  b=nF+jNnD6Hrnyv3HBJJZ9T/2CFsntTbNLf48EKkc/t1zI7F3qF1ERG+ty
   vptiLKV++WxrhukplBVT4P9G13xHBu9xhqh4XaNLlnmLolIVgv5khk/zg
   QNbNjgDllIN+mNI0NLmd28aZj1VoRHkpmxqcdk9qQPAW4fn+OnNy6eY9s
   HZK83ceRmcUUbZmsHHGFemhuGjUUrrEX394VV835gHw899adt3dCyNNh1
   dllB0elIaEcI/oECeCODczAvDNyW7hDK7w9bW7t7XSxJLYVtPsLXShepJ
   c6IqqUAVFCWy22Bj4CygMp1Jb/0z3JD2UVNmZ3ZfNR48NfCU/3IdmL8G9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292692140"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292692140"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:31:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641267133"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="641267133"
Received: from golubevv-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:31:53 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/display: Don't assume dual mode adaptors support
 i2c sub-addressing
In-Reply-To: <Y0BbKr10gUO/xjZ/@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221006113314.41101987@computer> <Yz7wKZnJeUzbz4Dw@intel.com>
 <Y0BbKr10gUO/xjZ/@intel.com>
Date:   Tue, 15 Nov 2022 18:31:31 +0200
Message-ID: <87fsek2n8c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Thu, Oct 06, 2022 at 06:11:37PM +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
>> On Thu, Oct 06, 2022 at 11:33:14AM +0200, Simon Rettberg wrote:
>> > Current dual mode adaptor ("DP++") detection code assumes that all
>> > adaptors support i2c sub-addressing for read operations from the
>> > DP-HDMI adaptor ID buffer.  It has been observed that multiple
>> > adaptors do not in fact support this, and always return data starting
>> > at register 0.  On affected adaptors, the code fails to read the proper
>> > registers that would identify the device as a type 2 adaptor, and
>> > handles those as type 1, limiting the TMDS clock to 165MHz, even if
>> > the according register would announce a higher TMDS clock.
>> > Fix this by always reading the ID buffer starting from offset 0, and
>> > discarding any bytes before the actual offset of interest.
>> >=20
>> > We tried finding authoritative documentation on whether or not this is
>> > allowed behaviour, but since all the official VESA docs are paywalled,
>> > the best we could come up with was the spec sheet for Texas Instrument=
s'
>> > SNx5DP149 chip family.[1]  It explicitly mentions that sub-addressing =
is
>> > supported for register writes, but *not* for reads (See NOTE in
>> > section 8.5.3).  Unless TI openly decided to violate the VESA spec, one
>> > could take that as a hint that sub-addressing is in fact not mandated
>> > by VESA.
>> > The other two adaptors affected used the PS8409(A) and the LT8611,
>> > according to the data returned from their ID buffers.
>> >=20
>> > [1] https://www.ti.com/lit/ds/symlink/sn75dp149.pdf
>> >=20
>> > Signed-off-by: Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
>> > Reviewed-by: Rafael Gieschke <rafael.gieschke@rz.uni-freiburg.de>
>> > ---
>> >=20
>> > v2 changes form last submission's feedback (thanks for taking the time=
):
>> > - Added a shortened version of our "background story" to the commit me=
ssage
>> > - Only use tmpbuf if the read offset is !=3D 0
>>=20
>> Bounced to intel-gfx to get the i915 CI to check it...
>
> CI didn't blow up, and I also gave this a quick smoking on my end
> with both type 1 HDMI and type 2 HDMI adaptors.=20
>
> I'm thinking we want a cc:stable on this? I can slap that on
> when pushing if there are no objections?

I guess this fell between the cracks? :(

Ville, r-b? Going to push?

BR,
Jani.






>
>>=20
>> >=20
>> >  .../gpu/drm/display/drm_dp_dual_mode_helper.c | 51 +++++++++++--------
>> >  1 file changed, 29 insertions(+), 22 deletions(-)
>> >=20
>> > diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drive=
rs/gpu/drm/display/drm_dp_dual_mode_helper.c
>> > index 3ea53bb67d3b..bd61e20770a5 100644
>> > --- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
>> > +++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
>> > @@ -63,23 +63,45 @@
>> >  ssize_t drm_dp_dual_mode_read(struct i2c_adapter *adapter,
>> >  			      u8 offset, void *buffer, size_t size)
>> >  {
>> > +	u8 zero =3D 0;
>> > +	char *tmpbuf =3D NULL;
>> > +	/*
>> > +	 * As sub-addressing is not supported by all adaptors,
>> > +	 * always explicitly read from the start and discard
>> > +	 * any bytes that come before the requested offset.
>> > +	 * This way, no matter whether the adaptor supports it
>> > +	 * or not, we'll end up reading the proper data.
>> > +	 */
>> >  	struct i2c_msg msgs[] =3D {
>> >  		{
>> >  			.addr =3D DP_DUAL_MODE_SLAVE_ADDRESS,
>> >  			.flags =3D 0,
>> >  			.len =3D 1,
>> > -			.buf =3D &offset,
>> > +			.buf =3D &zero,
>> >  		},
>> >  		{
>> >  			.addr =3D DP_DUAL_MODE_SLAVE_ADDRESS,
>> >  			.flags =3D I2C_M_RD,
>> > -			.len =3D size,
>> > +			.len =3D size + offset,
>> >  			.buf =3D buffer,
>> >  		},
>> >  	};
>> >  	int ret;
>> >=20=20
>> > +	if (offset) {
>> > +		tmpbuf =3D kmalloc(size + offset, GFP_KERNEL);
>> > +		if (!tmpbuf)
>> > +			return -ENOMEM;
>> > +
>> > +		msgs[1].buf =3D tmpbuf;
>> > +	}
>> > +
>> >  	ret =3D i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
>> > +	if (tmpbuf)
>> > +		memcpy(buffer, tmpbuf + offset, size);
>> > +
>> > +	kfree(tmpbuf);
>> > +
>> >  	if (ret < 0)
>> >  		return ret;
>> >  	if (ret !=3D ARRAY_SIZE(msgs))
>> > @@ -208,18 +230,6 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_detec=
t(const struct drm_device *dev,
>> >  	if (ret)
>> >  		return DRM_DP_DUAL_MODE_UNKNOWN;
>> >=20=20
>> > -	/*
>> > -	 * Sigh. Some (maybe all?) type 1 adaptors are broken and ack
>> > -	 * the offset but ignore it, and instead they just always return
>> > -	 * data from the start of the HDMI ID buffer. So for a broken
>> > -	 * type 1 HDMI adaptor a single byte read will always give us
>> > -	 * 0x44, and for a type 1 DVI adaptor it should give 0x00
>> > -	 * (assuming it implements any registers). Fortunately neither
>> > -	 * of those values will match the type 2 signature of the
>> > -	 * DP_DUAL_MODE_ADAPTOR_ID register so we can proceed with
>> > -	 * the type 2 adaptor detection safely even in the presence
>> > -	 * of broken type 1 adaptors.
>> > -	 */
>> >  	ret =3D drm_dp_dual_mode_read(adapter, DP_DUAL_MODE_ADAPTOR_ID,
>> >  				    &adaptor_id, sizeof(adaptor_id));
>> >  	drm_dbg_kms(dev, "DP dual mode adaptor ID: %02x (err %zd)\n", adapto=
r_id, ret);
>> > @@ -233,11 +243,10 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_dete=
ct(const struct drm_device *dev,
>> >  				return DRM_DP_DUAL_MODE_TYPE2_DVI;
>> >  		}
>> >  		/*
>> > -		 * If neither a proper type 1 ID nor a broken type 1 adaptor
>> > -		 * as described above, assume type 1, but let the user know
>> > -		 * that we may have misdetected the type.
>> > +		 * If not a proper type 1 ID, still assume type 1, but let
>> > +		 * the user know that we may have misdetected the type.
>> >  		 */
>> > -		if (!is_type1_adaptor(adaptor_id) && adaptor_id !=3D hdmi_id[0])
>> > +		if (!is_type1_adaptor(adaptor_id))
>> >  			drm_err(dev, "Unexpected DP dual mode adaptor ID %02x\n", adaptor_=
id);
>> >=20=20
>> >  	}
>> > @@ -343,10 +352,8 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
>> >   * @enable: enable (as opposed to disable) the TMDS output buffers
>> >   *
>> >   * Set the state of the TMDS output buffers in the adaptor. For
>> > - * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register. As
>> > - * some type 1 adaptors have problems with registers (see comments
>> > - * in drm_dp_dual_mode_detect()) we avoid touching the register,
>> > - * making this function a no-op on type 1 adaptors.
>> > + * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register.
>> > + * Type1 adaptors do not support any register writes.
>> >   *
>> >   * Returns:
>> >   * 0 on success, negative error code on failure
>> > --=20
>> > 2.35.1
>>=20
>> --=20
>> Ville Syrj=C3=A4l=C3=A4
>> Intel

--=20
Jani Nikula, Intel Open Source Graphics Center
