Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B025EACDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIZQon convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIZQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:44:20 -0400
Received: from smtp2.uni-freiburg.de (smtp2.uni-freiburg.de [IPv6:2001:7c0:2500:4::25:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F795F7D9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:32:17 -0700 (PDT)
Delivery-date: Mon, 26 Sep 2022 17:32:17 +0200
Received: from fe2.uni-freiburg.de ([132.230.2.222] helo=uni-freiburg.de) port 40012 
        by smtp2.uni-freiburg.de with esmtp
        ( Exim )
        id 1ocq5f-0003uV-1w
        for linux-kernel@vger.kernel.org;
        Mon, 26 Sep 2022 17:32:15 +0200
Received: from [132.230.8.113] (account simon.rettberg@rz.uni-freiburg.de HELO computer)
  by mail.uni-freiburg.de (CommuniGate Pro SMTP 6.3.14)
  with ESMTPSA id 96367591; Mon, 26 Sep 2022 17:32:15 +0200
Date:   Mon, 26 Sep 2022 17:32:14 +0200
From:   Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH RESEND] drm/display: Don't assume dual mode adaptors
 support i2c sub-addressing
Message-ID: <20220926173214.5af2cd8f@computer>
In-Reply-To: <YzG969k/ipFwAKWA@intel.com>
References: <20220926124017.529806df@computer>
        <YzGdU50ttykco1QV@intel.com>
        <20220926163408.110bbc97@computer>
        <YzG969k/ipFwAKWA@intel.com>
Organization: Rechenzentrum Uni Freiburg
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 26 Sep 2022 17:57:47 +0300
schrieb Ville Syrjälä <ville.syrjala@linux.intel.com>:

> On Mon, Sep 26, 2022 at 04:34:08PM +0200, Simon Rettberg wrote:
> > On Mon, 26 Sep 2022 15:38:43 +0300
> >  Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> >   
> > > On Mon, Sep 26, 2022 at 12:40:17PM +0200, Simon Rettberg wrote:  
> > > > Current dual mode adaptor ("DP++") detection code assumes that
> > > > all adaptors support i2c sub-addressing for read operations
> > > > from the DP-HDMI adaptor ID buffer.  It has been observed that
> > > > multiple adaptors do not in fact support this, and always
> > > > return data starting at register 0.  On affected adaptors, the
> > > > code failed to read the proper registers that would identify
> > > > the device as a type 2 adaptor, and handled those as type 1,
> > > > limiting the TMDS clock to 165MHz. Fix this by always reading
> > > > the ID buffer starting from offset 0, and discarding any bytes
> > > > before the actual offset of interest.
> > > > 
> > > > Signed-off-by: Simon Rettberg
> > > > <simon.rettberg@rz.uni-freiburg.de> Reviewed-by: Rafael
> > > > Gieschke <rafael.gieschke@rz.uni-freiburg.de> ---
> > > > (Resend because of no response, probably my fault since I ran
> > > > get_maintainers on a shallow clone and missed a bunch of people)
> > > > 
> > > > We had problems with multiple different "4k ready" DP++ adaptors
> > > > only resulting in 1080p resolution on Linux. While one of them
> > > > turned out to actually just be a type1 adaptor, the others,
> > > > according to the data retreived via i2cdump, were in fact proper
> > > > type2 adaptors, advertising a TMDS clock of 300MHz. As it turned
> > > > out, none of them supported sub-addressing when reading from the
> > > > DP-HDMI adaptor ID buffer via i2c. The existing code suggested
> > > > that this is known to happen with "broken" type1 adaptors, but
> > > > evidently, type2 adaptors are also affected. We tried finding
> > > > authoritative documentation on whether or not this is allowed
> > > > behavior, but since all the official VESA docs are paywalled,
> > > > the best we could come up with was the spec sheet for Texas
> > > > Instruments' SNx5DP149 chip family.[1] It explicitly mentions
> > > > that sub-adressing is supported for register writes, but *not*
> > > > for reads (See NOTE in section 8.5.3). Unless TI blatantly and
> > > > openly decided to violate the VESA spec, one could take that as
> > > > a strong hint that sub-addressing is in fact not mandated by
> > > > VESA.    
> > > 
> > > I don't think that would pass the dual mode CTS for type2 adaptors
> > > since it explicitly calls for reading individual bytes from
> > > various offsets.
> > > 
> > > The actual dual mode spec specifies things rather poorly.
> > > Technically it doesn't even specify the write protocol, and the
> > > read protocol is only specified in the form of an example read of
> > > the HDMI ID buffer. There it says the offset write is optional
> > > for the master, but mandatory for the slave to ack. It neither
> > > explicitly allows nor disallows the ack+ignore behaviour, but
> > > IIRC there is some text in there that suggests that type1
> > > adaptors might ignore it.  
> > 
> > Interesting, but poor spec would explain why it's not implemented by
> > at least three such chips. That's the TI one (we don't actually have
> > it, but the data sheet above seems quite clear), and the two we
> > confirmed it with: the PS8409(A), and the LT8611.
> > So either way it might make sense to handle this. Since the first
> > submission of this patch I also took the time to check it on
> > Windows 10, and both adaptors make Windows list 4k resolutions with
> > both the intel iGPU and an nvidia card.
> > 
> > Here are the two dumps for completeness:
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 0123456789abcdef 00: 44 50 2d 48 44 4d 49 20 41 44 41 50 54 4f 52
> > 04    DP-HDMI ADAPTOR? 10: a0 00 1c f8 50 53 38 34 30 39 a2 00 00
> > 78 08 ff    ?.??PS8409?..x?.
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 0123456789abcdef 00: 44 50 2d 48 44 4d 49 20 41 44 41 50 54 4f 52
> > 04    DP-HDMI ADAPTOR? 10: a0 ff ff ff 4c 54 38 36 31 31 a2 00 00
> > 78 0f 00    ?...LT8611?..x?. 
> > >   
> > > > 
> > > > [1] https://www.ti.com/lit/ds/symlink/sn75dp149.pdf
> > > > 
> > > >  .../gpu/drm/display/drm_dp_dual_mode_helper.c | 52
> > > > ++++++++++--------- 1 file changed, 28 insertions(+), 24
> > > > deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> > > > b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c index
> > > > 3ea53bb67..6147da983 100644 ---
> > > > a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c +++
> > > > b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c @@ -63,23
> > > > +63,42 @@ ssize_t drm_dp_dual_mode_read(struct i2c_adapter
> > > > *adapter, u8 offset, void *buffer, size_t size)
> > > >  {
> > > > +	int ret;
> > > > +	u8 zero = 0;
> > > > +	char *tmpbuf;
> > > > +	/*
> > > > +	 * As sub-addressing is not supported by all adaptors,
> > > > +	 * always explicitly read from the start and discard
> > > > +	 * any bytes that come before the requested offset.
> > > > +	 * This way, no matter whether the adaptor supports it
> > > > +	 * or not, we'll end up reading the proper data.
> > > > +	 */
> > > >  	struct i2c_msg msgs[] = {
> > > >  		{
> > > >  			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
> > > >  			.flags = 0,
> > > >  			.len = 1,
> > > > -			.buf = &offset,
> > > > +			.buf = &zero,
> > > >  		},
> > > >  		{
> > > >  			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
> > > >  			.flags = I2C_M_RD,
> > > > -			.len = size,
> > > > -			.buf = buffer,
> > > > +			.len = size + offset,
> > > > +			.buf = NULL,
> > > >  		},
> > > >  	};
> > > > -	int ret;
> > > >  
> > > > +	tmpbuf = kmalloc(size + offset, GFP_KERNEL);
> > > > +	if (!tmpbuf)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	msgs[1].buf = tmpbuf;
> > > >  	ret = i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
> > > > +	if (ret == ARRAY_SIZE(msgs))
> > > > +		memcpy(buffer, tmpbuf + offset, size);
> > > > +
> > > > +	kfree(tmpbuf);    
> > > 
> > > Could optimize a bit here and avoid the temp buffer when
> > > the original offset is 0.  
> > 
> > Was thinking about that too while writing the patch, but decided
> > to keep it as straight forward as possible for the initial
> > submission; it's also not really performance critical, should be
> > called a few times when the adaptor is plugged in, and probably
> > just once with offset 0.  
> 
> Would avoid the extra failure point.
> 
> Looks like all you really need to do is make the tmpbuf 
> allocation (+ msg mangling) conditional, and check that
> tmpbuf was allocated before calling memcpy().

Right, that sounds good.

> 
> > It also didn't feel nice to have the "if (ret == ARRAY_SIZE(msgs))"
> > check duplicated for the memcpy, to avoid copying potentially
> > uninitialised memory into the output buffer. I didn't see how this
> > would lead to an information leak to user space with the current
> > code base, but better safe than sorry? :)
> > The alternative is to move the memcpy down and merge it with the
> > other if-block, but then we'd need a cleanup label at the bottom
> > to do the kfree in the error case that comes before that...  
> 
> kfree(NULL) is perfectly legal.

This was regarding the conditional for the memcpy(). In the current
patch, it's not copying anything from tmpbuf into the output buffer
if the i2c_transfer() call fails, because maybe there is some
sensitive information in tmpbuf from a previous allocation. But
it's not strictly necessary for correctness, as drm_dp_dual_mode_read()
would return nonzero in this case and the output buffer is ignored
at all current call sites. This was along the lines of "what if later
on, someone adds a sysfs interface that calls drm_dp_dual_mode_read()
and returns the data without checking the return value". Or maybe just
make it a kzalloc instead? I'm probably overthinking this.

So, a rough prototype:

	char *tmpbuf = NULL;
	struct i2c_msg msgs[] = {
		{
			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
			.flags = 0,
			.len = 1,
			.buf = &zero,
		},
		{
			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
			.flags = I2C_M_RD,
			.len = size + offset,
			.buf = buffer,
		},
	};

	if (offset) {
		tmpbuf = kzalloc(size + offset, GFP_KERNEL);
		if (!tmpbuf)
			return -ENOMEM;
		msgs[1].buf = tmpbuf;
	}

	ret = i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
	if (tmpbuf)
		memcpy(buffer, tmpbuf + offset, size);
	kfree(tmpbuf);

	if (ret < 0)
		return ret;
	if (ret != ARRAY_SIZE(msgs))
		return -EPROTO;
	return 0;


> 
> > But I'll happily refine that further and submit a v2 if desired.
> >   
> > >   
> > > > +
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >  	if (ret != ARRAY_SIZE(msgs))
> > > > @@ -208,18 +227,6 @@ enum drm_dp_dual_mode_type
> > > > drm_dp_dual_mode_detect(const struct drm_device *dev, if (ret)
> > > >  		return DRM_DP_DUAL_MODE_UNKNOWN;
> > > >  
> > > > -	/*
> > > > -	 * Sigh. Some (maybe all?) type 1 adaptors are broken
> > > > and ack
> > > > -	 * the offset but ignore it, and instead they just
> > > > always return
> > > > -	 * data from the start of the HDMI ID buffer. So for a
> > > > broken
> > > > -	 * type 1 HDMI adaptor a single byte read will always
> > > > give us
> > > > -	 * 0x44, and for a type 1 DVI adaptor it should give
> > > > 0x00
> > > > -	 * (assuming it implements any registers). Fortunately
> > > > neither
> > > > -	 * of those values will match the type 2 signature of
> > > > the
> > > > -	 * DP_DUAL_MODE_ADAPTOR_ID register so we can proceed
> > > > with
> > > > -	 * the type 2 adaptor detection safely even in the
> > > > presence
> > > > -	 * of broken type 1 adaptors.
> > > > -	 */
> > > >  	ret = drm_dp_dual_mode_read(adapter,
> > > > DP_DUAL_MODE_ADAPTOR_ID, &adaptor_id, sizeof(adaptor_id));    
> > > 
> > > Another optimization opportunity here to maybe combine the HDMI ID
> > > buffer read with this one. Could perhaps just read the full 32
> > > bytes static capabilities section. But this one should probably
> > > be left for a separate patch. Ideally I guess we'd also combine
> > > the max TMDS clock read with this one. But for that we'd need to
> > > return more than the single enum drm_dp_dual_mode_type from this
> > > function.  
> > 
> > Pretty much same as above, keep v1 simple, but I noticed that too.
> > If that's going to be another patch anyways, it might make sense
> > if that's done by someone more familiar with that code in general
> > (basically had to research all this DP++/i2c stuff from scratch).
> > But I could give it a spin.  
> 
> I think this one will need a bit more restructuing so better
> done as a separate patch. Might not really be worth the hassle
> unless we go all in and try to do just a single 32byte read
> for everything including the max TMDS clock.

ack!

> 
> >   
> > >   
> > > >  	drm_dbg_kms(dev, "DP dual mode adaptor ID: %02x (err
> > > > %zd)\n", adaptor_id, ret); @@ -233,11 +240,10 @@ enum
> > > > drm_dp_dual_mode_type drm_dp_dual_mode_detect(const struct
> > > > drm_device *dev, return DRM_DP_DUAL_MODE_TYPE2_DVI; }
> > > >  		/*
> > > > -		 * If neither a proper type 1 ID nor a broken
> > > > type 1 adaptor
> > > > -		 * as described above, assume type 1, but let
> > > > the user know
> > > > -		 * that we may have misdetected the type.
> > > > +		 * If not a proper type 1 ID, still assume
> > > > type 1, but let
> > > > +		 * the user know that we may have misdetected
> > > > the type. */
> > > > -		if (!is_type1_adaptor(adaptor_id) &&
> > > > adaptor_id != hdmi_id[0])
> > > > +		if (!is_type1_adaptor(adaptor_id))
> > > >  			drm_err(dev, "Unexpected DP dual mode
> > > > adaptor ID %02x\n", adaptor_id); 
> > > >  	}
> > > > @@ -343,10 +349,8 @@
> > > > EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
> > > >   * @enable: enable (as opposed to disable) the TMDS output
> > > > buffers *
> > > >   * Set the state of the TMDS output buffers in the adaptor. For
> > > > - * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register. As
> > > > - * some type 1 adaptors have problems with registers (see
> > > > comments
> > > > - * in drm_dp_dual_mode_detect()) we avoid touching the
> > > > register,
> > > > - * making this function a no-op on type 1 adaptors.
> > > > + * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register.
> > > > + * Type1 adaptors do not support any register writes.
> > > >   *
> > > >   * Returns:
> > > >   * 0 on success, negative error code on failure
> > > > -- 
> > > > 2.35.1    
> > >   
> 

