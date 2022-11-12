Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE240626A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiKLQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:15:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A5B7EE;
        Sat, 12 Nov 2022 08:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D55FDCE09B6;
        Sat, 12 Nov 2022 16:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1754DC433C1;
        Sat, 12 Nov 2022 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668269707;
        bh=+yY8VWmr5oG/wcPckVmlmWdGPcJ6L9XIl3WO5KeARlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=COJZ8JsrdbqL3HocmgkOr9NG61vQpxF9Jh577oc06PL/qLnW7YAftB9BGU2E69eAu
         Z9qTLjj4cEmf4Phiex7yzoy7B8ZpvxMwCh9Sbt4USuTzIG6FUSFRtQ1qS3i+K+zy3C
         6+VyWW7s8NoVwT5Ra1buvZloce76yAeckN1F3NDBI/Q4fJDmkrpm6aQI8mDEFFteuG
         tJO82ucgKEWCbvemXLb4VG1EEWICk/inLdQvujkn7h3Icbn3DmIsnir11L6XtlbPtB
         4lrYUhEG4biMqUCda+2weejGj4QW0WpjeSdN+OUrb34rLMueICHk3ODm8BI2bnG/XI
         An61wabOUc9Iw==
Date:   Sat, 12 Nov 2022 16:27:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RFC PATCH] iio: adc: qcom-spmi-vadc: Propagate fw node
 name/label to extend_name
Message-ID: <20221112162719.0ac87998@jic23-huawei>
In-Reply-To: <20221106202445.fkobsyc3mohmzqod@SoMainline.org>
References: <20221106193018.270106-1-marijn.suijten@somainline.org>
        <20221106202445.fkobsyc3mohmzqod@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 21:24:45 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> Adding Krzysztof to CC for the DT bindings discussion.
>=20
> On 2022-11-06 20:30:18, Marijn Suijten wrote:
> > Much like the ADC5 driver iio_chan_spec::extend_name has to be set for
> > friendly/useful names to show up in sysfs, allowing users to correlate
> > readout values with the corresponding probe. This name is read from
> > firmware, taking both the node name and - if set - node label into
> > account.  This is particularly useful for custom thermistors being
> > attached to otherwise-generically-named GPIOs.
> >=20

If you are attaching thermistors to an ADC channel, then you should have
a driver for that thermistor.  It will be a consumer of the ADC channel
in question and any labels etc should apply there (along with scaling
/ non linear transforms to get to a temperature), not at the ADC
level.

> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >=20
> > ---
> >=20
> > This RFC may seem a bit controversial as there are multiple patches
> > going around in DT-land changing how nodes are labeled [1] (or
> > introducing new ones: [2]), seemingly to appease binding conventions
> > without considering how the driver propagates them to IIO (and in turn
> > what userspace sees in sysfs).  I hope we can put together the right
> > conventions with this RFC.

> >=20
> > Before getting started, note that ADC5 provides this DT/FW node
> > name/label in *both* extend_name *and* datasheet_name;
> > adc5_channels::datasheet_name provided by the macros remains *unread*
> > (except for a non-null check).

There was some history here if I recall correctly.  Until recently(ish) we =
didn't
have the "label" attribute for channels so the only route was to use
extended_name. That makes a mess for userspace developers however because
it is harder to write a parser that is happy with free form sections
of an attribute name.  So extended_name is more or less deprecated with the
exception of a few legacy cases that we might carry forwards into very simi=
lar
drivers.

datasheet_name was introduced to allow binding the channels to consumers
in a human readable form. Note that this dates back to predevice tree
days - so mostly you'll see it used when an mfd registers its own
consumers.  They weren't at the time intended to be used directly by the
drivers at all.


> > Since the names hardcoded in the driver seem to be somewhat
> > "datasheet"-y, and the names in DT typically take the form of a more
> > friendly "<device>-therm" indicating where the thermistor (or voltage
> > probe) is located on the board or attached to, I have opted to persist
> > the original use of vadc_channels::datasheet_name in
> > iio_chan_spec::datasheet_name, and only propagate the data from DT/FW
> > into extend_name.

To clarify datasheet_name is the name on the datasheet of the provider part
not the naming on the board datasheet - basically it's meant to be the pin =
name.

If you modify extend_name at all you break userspace ABI.
So that's pretty much a non starter (and one reason why we added the label
attribute).

Also, if the ADC channel is labelled with what it is consumed by that feels
backwards.  The thermistor could be connected to any channel.  Any nice
naming should be at the thermistor driver end.  So say I put a thermistor
on input 8.  It should just bind to input 8. The bit of the binding for
the ADC just provides the consumer services for that input 8.

> > (We should likely rename vadc_channel_prop::datasheet_name to
> > extend_name to this end.)
> >=20
> > Back when I submitted patches for pm6125 [3] (utilizing ADC5)
> > 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > didn't yet land, and these patches use the node name to convey a
> > useful/friendly name (again, the string literals in ADC5 are unused).
> > fwnode_get_name() however includes the `@xx` reg suffix, making for an
> > unpleasant reading experience in sysfs.
> >=20
> > With all that context in mind, I feel like we should answer the
> > following questions:
> >=20
> > 1. Should we propagate names from DT/FW at all?

This question needs to make it clear - which name?  Propagating channel
labels to sysfs is often useful via the in_voltageX_label type attributes.
Whether it is useful in this specific driver depends on whether we have
information to convey that isn't provided by channel numbers alone.

> > 2. If so, how should a node be represented in DT?  Should it use generic
> >    node names (which we might not want to use anyway considering the
> >    `@xx` suffix highlighted above) or labels exclusively?

I would suggest only labels.  Though in the case you give of a thermistor a=
ttached
this handling is wrong anyway.

> > 3. If only labels are going to be used in conjunction with generic node
> >    names, should ADC5 be changed to ignore the node name?
=46rom a quick search, I'm only seeing the node name used in debug prints cur=
rently.
That feels fine to me as it's telling us where the binding parsing went wro=
ng...
Am I missing some use outside of vadc_get_fw_channel_data()?

> > 4. If a label (or node name) is not set, do we fall back to
> >    datasheet_name hardcoded in the driver?

Hmm. Probably not.

> > 5. What do we use for datasheet_name vs extend_name?
Expand that to include label.
datasheet_name : When you want to have human readable pin names from the ADC
  datasheet, used as part of provide services to consumer drivers. Doesn't
  work with DT though as it wasn't part of the binding for consumers.
  So largely irrelevant unless you have an MFD where the ADC consumers are
  also part of the MFD children and so the map is set up in the way we used
  to do it for board files.
extended_name: Short answer is don't use it today.  It was a bad design dec=
ision
  a long time back.
label: This is the one you should info from DT through to today.  As it is =
freeform
  and comes from the bindings - we don't encode this in the const iio_chan_=
spec array
  but rather use the iio_info->read_label() callback.  It is provided to us=
erspace
  as a per channel _label attribute.

> > 6. Any other vadc drivers that need the same treatment, when we come to
> >    a resolution?
Any resolution can only 'add' ABI to userspace.  So adding labels is fine.
extend_name never is.

Hope that helps.

Jonathan

> >=20
> > [1]: https://lore.kernel.org/linux-arm-msm/20221031181022.947412-1-luca=
@z3ntu.xyz/T/#u
> > [2]: https://lore.kernel.org/linux-arm-msm/20221101161801.1058969-2-luc=
a@z3ntu.xyz/
> > [3]: https://lore.kernel.org/linux-arm-msm/20220926190148.283805-1-mari=
jn.suijten@somainline.org/T/#u
> >=20
> > Thanks for considering this!
> > - Marijn
> >=20
> >  drivers/iio/adc/qcom-spmi-vadc.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-sp=
mi-vadc.c
> > index bcff0f62b70e..8c6c7fa13cfe 100644
> > --- a/drivers/iio/adc/qcom-spmi-vadc.c
> > +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> > @@ -84,6 +84,7 @@
> >   *	that is an average of multiple measurements.
> >   * @scale_fn_type: Represents the scaling function to convert voltage
> >   *	physical units desired by the client for the channel.
> > + * @datasheet_name: Channel name used in device tree.
> >   */
> >  struct vadc_channel_prop {
> >  	unsigned int channel;
> > @@ -93,6 +94,7 @@ struct vadc_channel_prop {
> >  	unsigned int hw_settle_time;
> >  	unsigned int avg_samples;
> >  	enum vadc_scale_fn_type scale_fn_type;
> > +	const char *datasheet_name;
> >  };
> >=20
> >  /**
> > @@ -652,7 +654,7 @@ static int vadc_get_fw_channel_data(struct device *=
dev,
> >  				    struct vadc_channel_prop *prop,
> >  				    struct fwnode_handle *fwnode)
> >  {
> > -	const char *name =3D fwnode_get_name(fwnode);
> > +	const char *name =3D fwnode_get_name(fwnode), *channel_name;
> >  	u32 chan, value, varr[2];
> >  	int ret;
> >=20
> > @@ -670,6 +672,12 @@ static int vadc_get_fw_channel_data(struct device =
*dev,
> >  	/* the channel has DT description */
> >  	prop->channel =3D chan;
> >=20
> > +	ret =3D fwnode_property_read_string(fwnode, "label", &channel_name);
> > +	if (ret)
> > +		channel_name =3D name;
> > +
> > +	prop->datasheet_name =3D channel_name;
> > +
> >  	ret =3D fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> >  	if (!ret) {
> >  		ret =3D qcom_vadc_decimation_from_dt(value);
> > @@ -771,6 +779,7 @@ static int vadc_get_fw_data(struct vadc_priv *vadc)
> >=20
> >  		iio_chan->channel =3D prop.channel;
> >  		iio_chan->datasheet_name =3D vadc_chan->datasheet_name;
> > +		iio_chan->extend_name =3D prop.datasheet_name;
> >  		iio_chan->info_mask_separate =3D vadc_chan->info_mask;
> >  		iio_chan->type =3D vadc_chan->type;
> >  		iio_chan->indexed =3D 1;
> > --
> > 2.38.1
> >  =20

