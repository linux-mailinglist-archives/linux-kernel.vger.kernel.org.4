Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DC6538B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiLUWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiLUWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:34:38 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA92AF7;
        Wed, 21 Dec 2022 14:34:36 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 06B1A2041E;
        Wed, 21 Dec 2022 23:34:34 +0100 (CET)
Date:   Wed, 21 Dec 2022 23:34:32 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RFC PATCH] iio: adc: qcom-spmi-vadc: Propagate fw node
 name/label to extend_name
Message-ID: <20221221223432.si2aasbleiicayfl@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221106193018.270106-1-marijn.suijten@somainline.org>
 <20221106202445.fkobsyc3mohmzqod@SoMainline.org>
 <20221112162719.0ac87998@jic23-huawei>
 <20221130205414.6m4rfufc25hfzxmf@SoMainline.org>
 <20221203170656.7b65142b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203170656.7b65142b@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Apologies for another late reply; we really shouldn't make these
messages this long and I'll try to only reply to the most relevant
points and cull out the rest.

On 2022-12-03 17:06:56, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 21:54:14 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2022-11-12 16:27:19, Jonathan Cameron wrote:
> > > On Sun, 6 Nov 2022 21:24:45 +0100
> > > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> > >   
> > > > Adding Krzysztof to CC for the DT bindings discussion.
> > > > 
> > > > On 2022-11-06 20:30:18, Marijn Suijten wrote:  
> > > > > Much like the ADC5 driver iio_chan_spec::extend_name has to be set for
> > > > > friendly/useful names to show up in sysfs, allowing users to correlate
> > > > > readout values with the corresponding probe. This name is read from
> > > > > firmware, taking both the node name and - if set - node label into
> > > > > account.  This is particularly useful for custom thermistors being
> > > > > attached to otherwise-generically-named GPIOs.
> > > > >   
> > > 
> > > If you are attaching thermistors to an ADC channel, then you should have
> > > a driver for that thermistor.  It will be a consumer of the ADC channel
> > > in question and any labels etc should apply there (along with scaling
> > > / non linear transforms to get to a temperature), not at the ADC
> > > level.  
> > 
> > This is what happens in the ADC5 driver, though.  In /sys/bus/iio names
> > show up for ADC channels that aren't otherwise consumed by (thermistor)
> > drivers.  There are also voltage readings.  The IIO driver seems to be
> > aware of both the unit and (linear iirc) scaling.
> 
> There were cases where we did that but my understanding of what was going
> on at the time may have been wrong. I was assuming there was specific
> hardware on the SOC side of things that did 'special' stuff for the
> thermistor rather than just being an ADC channel.

There is, it's the thermal monitor driver but I don't think it binds to
every ADC channel, and the ADC channels provided by VADC/ADC5 provide
useful information on their own in sysfs.

<snip>

> > This is how these drivers are describing their channels though, except
> > for a few freely assignable GPIO channels?
> 
> My assumption was that the inputs were not general purpose.  With the exception
> of external temperature sensors, many SoC ADCs have some channels wired
> to internal voltage lines and temperature sensors, so seemed reasonable
> to label them as such.  If that's wrong then it was my misunderstanding when
> reading the original code.

These drivers seem to support both.  Internal PMIC channels, probably a
couple that go off-chip but are for a "specific" usecase, and a few
"GPIO" channels that appear to be multipurpose (per General Purpose...
IO).

> Lack of easy availability of suitable datasheets means we have to rely
> on submitters distinguishing internally wired, from board wiring based
> associations.

And submitters typically rely on copy-pasting downstream - at least with
the read_label callback contributors should have an easier way of
correlating sysfs file readings back to the mapping they described in
DTS, and ballpark-guesstimate that the reading is correct (e.g. on
pm6125 I found that I was missing some pinctrl biases this way resulting
in extraneous temperature readings).

<snip>

> > Ack, the node name is a mess nowadays.  That means ADC5 shouldn't use it
> > as fallback either when a DT label is not set (and instead use the
> > currently-unused adc5_channels::datasheet_name field).
> > 
> > Can I remove it (use of fwnode_get_name() as datasheet_name)?
> 
> Ah. That's indeed a mess. From an ABI point of view you can indeed break the
> connection between datasheet_name and the "label", but you can't
> change the use for extend_name (ABI breakage) unless you are very very sure
> it won't break existing userspace code.

As in, as long as we don't touch extend_name which would affect sysfs
names, changing the label returned by read_label is fine?  And changing
datasheet_name to only ever use the datasheet_name provided by the
driver and never the name provided in DTS is also okay?

> Now from a potential consumers point of view, it's possible someone is relying
> on the datasheet name to get the right channel. Given those are only
> used if a driver is directly registering an iio_map, should be easy enough
> to fix..

I am unfortunately completely unfamiliar with iio_map, and hope it
doesn't distract too much from trying to add label files to QCom's SPMI
VADC driver :)

<snip>

> In some drivers we have older code that squashes the thermistor handling
> into the driver.  That can be necessary if there is handling to do on the
> ADC side of things. From a quick glance, I'm not sure there is any to do
> here (an example where this gets complex is the more sophisticated
> touchscreen controllers, where there is a lot of sequencing involved
> alongside reading particular ADC channels).

Seems this works OOTB already (as in, when reading sysfs I see values
that could be sensibly interpreted as "room temperature" in celsius).
And not something I intend to look into, again, only labels.

> > > > > 3. If only labels are going to be used in conjunction with generic node
> > > > >    names, should ADC5 be changed to ignore the node name?  
> > >
> > > From a quick search, I'm only seeing the node name used in debug prints currently.
> > > That feels fine to me as it's telling us where the binding parsing went wrong...
> > > Am I missing some use outside of vadc_get_fw_channel_data()?  
> > 
> > That's the VADC driver.  Look at adc5_get_fw_channel_data, specifically
> > where it calls fwnode_property_read_string() to overwrite
> > prop->datasheet_name.
> 
> Ah. Thanks for the pointer, though I'm still confused.
> 
> 	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
> 	if (ret)
> 		channel_name = name;
  		             ^ here ^

> 	prop->datasheet_name = channel_name;
> 
> That's reading the label property, not the node name.

The node name sits in `name`, and that's used if there's no "label"
property in wich case ret is non-zero and we end up in `if (ret)
channel_name = name;`.

> > > > > 4. If a label (or node name) is not set, do we fall back to
> > > > >    datasheet_name hardcoded in the driver?  
> > > 
> > > Hmm. Probably not.  
> > 
> > Then we might as well remove this useless data from the kernel driver
> > altogether...
> 
> Ok. May make sense to use the datasheet name if noting better provided
> for the label.  Assuming the datasheet names are them selves somewhat
> useful information for a user.

They're generated from the macro (hence capitalized) in VADC, manually
written in ADC5.  Would it make sense to add handwritten string
literals for this?

> > > > > 5. What do we use for datasheet_name vs extend_name?  
> > > Expand that to include label.
> > > datasheet_name : When you want to have human readable pin names from the ADC
> > >   datasheet, used as part of provide services to consumer drivers. Doesn't
> > >   work with DT though as it wasn't part of the binding for consumers.
> > >   So largely irrelevant unless you have an MFD where the ADC consumers are
> > >   also part of the MFD children and so the map is set up in the way we used
> > >   to do it for board files.  
> > 
> > ... or this could remain to feed into datasheet_name?
> Now I'm confused.  Feed into label perhaps?

Feed into read_label when no label was otherwise provided in DTS, but
always feed into iio_chan_spec::datasheet_name since we discussed that
this should represent the name of the part (e.g. PMIC), not the board
and way in which it consumes the channel.

<snip>

> > Do we then remove extend_name from qcom-spmi-adc5 and give it the same
> > treatment, since it would now use DT node names as filenames unless a
> > label is set?  I can only imagine it having been set because the ADC5
> > author(s) didn't see a name nor label in sysfs either, without knowing
> > about the existence of read_label.
> 
> Sadly we can't remove it because of the ABI change that would result and
> potential userspace breakage.

The change to fwnode_get_name is already breaking this sysfs ABI though,
as discussed in a DTS series where I replaced all node names with labels
to support (the followup of) this iio series.

We could unbreak it by either stripping @xx off of it, or setting
extend_name to a label (if it exists) instead, but the latter is
breaking :(

<snip>

> > > Hope that helps.  
> > 
> > A lot, now knowing that read_label is the part of the puzzle I
> > previously missed.  Thanks!
> 
> When I let the extend_name fallback in for the labels
> it didn't occur to me that it would make it more confusing for
> people looking at older code.  Long shot, but would a comment
> in iio.h for extend_name to say something to this effect be likely
> to have been something you'd have seen?  If it would, let's add
> one to potentially make this less confusing for the next person!

Yes, I think I visited the documentation/definition of extend_name at
some point and would have been been helped if that pointed me right over
to read_label.  Right in ADC5 (and other drivers) would be even better
but may be overly verbose.

Regardless of that VADC/ADC5 do some _really confusing_ things, passing
strings around in various weird ways (or not), and it took some time to
keep the various similar structs apart :)

- Marijn
