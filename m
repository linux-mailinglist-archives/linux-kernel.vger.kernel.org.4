Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D16417EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLCQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLCQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:55:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E721800;
        Sat,  3 Dec 2022 08:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F38460A6A;
        Sat,  3 Dec 2022 16:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB0C433D6;
        Sat,  3 Dec 2022 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670086452;
        bh=bKa1Lt82WuZnya1l3tv93T+u2SKxmYg9n6lE6RqySnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oqu4IX86mQI4KgvwhAoyjkV6Dec/QZZyk5EcodTbx1mo2//9OlhHKLw5MudbMrIKf
         SPPzoOiRs602EEU2LHSUCl7kXY/q5lPv6eY5XenJokU9hzqGY5k0HefVgGvb5lLPkT
         +XbXbTHlPZ+fuzHW6uY1c+RyB0M/uek4f+HJwsuz7uW2XYOj08edUxhLp7J7wF/nng
         uq3I5U2BcIhQ1TEZUOfxW9Dp2c+mPe4JU+jfRAaM0tWMn40rrokJruOQSKVXIsMmUZ
         1V0FEiP7GwblkbxF2/jMC1djHGPy0uX9PNlSR2H8aztDHCTw6YdXRzPZLIq9CnaZoU
         570UbSLHJjcFg==
Date:   Sat, 3 Dec 2022 17:06:56 +0000
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
Message-ID: <20221203170656.7b65142b@jic23-huawei>
In-Reply-To: <20221130205414.6m4rfufc25hfzxmf@SoMainline.org>
References: <20221106193018.270106-1-marijn.suijten@somainline.org>
        <20221106202445.fkobsyc3mohmzqod@SoMainline.org>
        <20221112162719.0ac87998@jic23-huawei>
        <20221130205414.6m4rfufc25hfzxmf@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 21:54:14 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2022-11-12 16:27:19, Jonathan Cameron wrote:
> > On Sun, 6 Nov 2022 21:24:45 +0100
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > Adding Krzysztof to CC for the DT bindings discussion.
> > > 
> > > On 2022-11-06 20:30:18, Marijn Suijten wrote:  
> > > > Much like the ADC5 driver iio_chan_spec::extend_name has to be set for
> > > > friendly/useful names to show up in sysfs, allowing users to correlate
> > > > readout values with the corresponding probe. This name is read from
> > > > firmware, taking both the node name and - if set - node label into
> > > > account.  This is particularly useful for custom thermistors being
> > > > attached to otherwise-generically-named GPIOs.
> > > >   
> > 
> > If you are attaching thermistors to an ADC channel, then you should have
> > a driver for that thermistor.  It will be a consumer of the ADC channel
> > in question and any labels etc should apply there (along with scaling
> > / non linear transforms to get to a temperature), not at the ADC
> > level.  
> 
> This is what happens in the ADC5 driver, though.  In /sys/bus/iio names
> show up for ADC channels that aren't otherwise consumed by (thermistor)
> drivers.  There are also voltage readings.  The IIO driver seems to be
> aware of both the unit and (linear iirc) scaling.

There were cases where we did that but my understanding of what was going
on at the time may have been wrong. I was assuming there was specific
hardware on the SOC side of things that did 'special' stuff for the
thermistor rather than just being an ADC channel.

We have plenty of other cases with explicit analog sensors drivers.
see drivers/thermal/thermal-generic-adc.c or hwmon/ntc_thermistor.c
for example.

Looking at the example you have in adc5 that you mention below
which is rather odd I can see where confusion came from!

> 
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > 
> > > > ---
> > > > 
> > > > This RFC may seem a bit controversial as there are multiple patches
> > > > going around in DT-land changing how nodes are labeled [1] (or
> > > > introducing new ones: [2]), seemingly to appease binding conventions
> > > > without considering how the driver propagates them to IIO (and in turn
> > > > what userspace sees in sysfs).  I hope we can put together the right
> > > > conventions with this RFC.  
> >   
> > > > 
> > > > Before getting started, note that ADC5 provides this DT/FW node
> > > > name/label in *both* extend_name *and* datasheet_name;
> > > > adc5_channels::datasheet_name provided by the macros remains *unread*
> > > > (except for a non-null check).  
> > 
> > There was some history here if I recall correctly.  Until recently(ish) we didn't
> > have the "label" attribute for channels so the only route was to use
> > extended_name. That makes a mess for userspace developers however because
> > it is harder to write a parser that is happy with free form sections
> > of an attribute name.  So extended_name is more or less deprecated with the
> > exception of a few legacy cases that we might carry forwards into very similar
> > drivers.  
> 
> Making sure we're talking about the same thing: it's extend_name, not
> extendED_name.

Sure.  I remembered it wrong.

> 
> > datasheet_name was introduced to allow binding the channels to consumers
> > in a human readable form. Note that this dates back to predevice tree
> > days - so mostly you'll see it used when an mfd registers its own
> > consumers.  They weren't at the time intended to be used directly by the
> > drivers at all.  
> 
> It is unfortunate that I don't see these in sysfs then; vadc only
> assigns datasheet_name but not extend_name.

You can provide a read_label callback to expose that if it makes sense
for a particular device to provide those as the labels.  Cleverer things like
using those as a default that can be over ridden by a board specific naming
are fine as well.

> 
> > > > Since the names hardcoded in the driver seem to be somewhat
> > > > "datasheet"-y, and the names in DT typically take the form of a more
> > > > friendly "<device>-therm" indicating where the thermistor (or voltage
> > > > probe) is located on the board or attached to, I have opted to persist
> > > > the original use of vadc_channels::datasheet_name in
> > > > iio_chan_spec::datasheet_name, and only propagate the data from DT/FW
> > > > into extend_name.  
> > 
> > To clarify datasheet_name is the name on the datasheet of the provider part
> > not the naming on the board datasheet - basically it's meant to be the pin name.  
> 
> Right; it may not have come across but that is what I assumed (datsheet
> name of the part, which would be the names hardcoded in the adc5/vadc
> driver), and then have the labels - assigned in /board/ dts specialize
> that where it is not a hardwired reading within the part.

yes.

> 
> > If you modify extend_name at all you break userspace ABI.
> > So that's pretty much a non starter (and one reason why we added the label
> > attribute).  
> 
> The sysfs filenames will change, but they currently don't carry an
> in_{voltage,temp}X_label attribute.  Only when I set extend_name to
> something sensible.  But then X changes from an index to that same name
> too.

Add the label in that case by providing the read_label callback.
There is a fallback related to extend_name that is intended to help with
problem of writing userspace code against the legacy use of extend_name.
As a result, when no read_label callback is provided the label attribute
provides the extend_name.  Intent is that provides the information that
allows userspace code to know how to parse the naming.

That path is there as a fallback, not as how new code should do it.

> 
> Note that this is already the case for ADC5.

Best practice changes over time.  Because of the feedback we have had
from userspace developers we now very very rarely use extend_name.
Obviously we can't 'fix' old drivers thought without breaking the ABI.

> 
> > Also, if the ADC channel is labelled with what it is consumed by that feels
> > backwards.  The thermistor could be connected to any channel.  Any nice
> > naming should be at the thermistor driver end.  So say I put a thermistor
> > on input 8.  It should just bind to input 8. The bit of the binding for
> > the ADC just provides the consumer services for that input 8.  
> 
> This is how these drivers are describing their channels though, except
> for a few freely assignable GPIO channels?

My assumption was that the inputs were not general purpose.  With the exception
of external temperature sensors, many SoC ADCs have some channels wired
to internal voltage lines and temperature sensors, so seemed reasonable
to label them as such.  If that's wrong then it was my misunderstanding when
reading the original code.

Lack of easy availability of suitable datasheets means we have to rely
on submitters distinguishing internally wired, from board wiring based
associations.

> 
> > > > (We should likely rename vadc_channel_prop::datasheet_name to
> > > > extend_name to this end.)
> > > > 
> > > > Back when I submitted patches for pm6125 [3] (utilizing ADC5)
> > > > 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > > > didn't yet land, and these patches use the node name to convey a
> > > > useful/friendly name (again, the string literals in ADC5 are unused).
> > > > fwnode_get_name() however includes the `@xx` reg suffix, making for an
> > > > unpleasant reading experience in sysfs.
> > > > 
> > > > With all that context in mind, I feel like we should answer the
> > > > following questions:
> > > > 
> > > > 1. Should we propagate names from DT/FW at all?  
> > 
> > This question needs to make it clear - which name?  Propagating channel
> > labels to sysfs is often useful via the in_voltageX_label type attributes.  
> 
> Note that X here gets replaced by the value of extend_name, it seems.

You talk about this below, so I've removed what I wrote that said the
same thing

> 
> > Whether it is useful in this specific driver depends on whether we have
> > information to convey that isn't provided by channel numbers alone.  
> 
> The driver contains channel names for the purpose of clarifying what the
> channel is, which isn't easily deducible (nor very user-friendly) when
> only having access to channel indices/numbers.

In that case sounds like you should provide the read_label() callback.

> 
> > > > 2. If so, how should a node be represented in DT?  Should it use generic
> > > >    node names (which we might not want to use anyway considering the
> > > >    `@xx` suffix highlighted above) or labels exclusively?  
> > 
> > I would suggest only labels.  
> 
> Ack, the node name is a mess nowadays.  That means ADC5 shouldn't use it
> as fallback either when a DT label is not set (and instead use the
> currently-unused adc5_channels::datasheet_name field).
> 
> Can I remove it (use of fwnode_get_name() as datasheet_name)?

Ah. That's indeed a mess. From an ABI point of view you can indeed break the
connection between datasheet_name and the "label", but you can't
change the use for extend_name (ABI breakage) unless you are very very sure
it won't break existing userspace code.

Now from a potential consumers point of view, it's possible someone is relying
on the datasheet name to get the right channel. Given those are only
used if a driver is directly registering an iio_map, should be easy enough
to fix..

> 
> > Though in the case you give of a thermistor attached
> > this handling is wrong anyway.  
> 
> Not sure I follow you here.  The driver defines when a channel is a
> thermistor or a voltage, and even gives it a name/label.  The values are
> readable through /sys/bus/iio.  Not sure if they're all correct
> readings, and some (but not all) are later routed into a "thermal
> manager", but having at least a _label for these would be useful.

Fine to have a label as those are intended to provide useful info to
userspace.
Assuming there is nothing magic set in hardware dependent on thermistor
vs voltage then... If we were doing this today, we'd have them all as ADC
channels.  Board specific labels are fine, but used as part of the consumer
side of things.
Each thermistor would be a separate 'device' consuming an ADC channel.
Anything that needed that thermal info would then consumer that thermistor
device (which would have done relevant scaling etc depending on the analog
component). Advantage of this approach is that it allows for much wider
variety of external temperature sensors without having to code up the
temperature to voltage functions in every ADC driver.

In some drivers we have older code that squashes the thermistor handling
into the driver.  That can be necessary if there is handling to do on the
ADC side of things. From a quick glance, I'm not sure there is any to do
here (an example where this gets complex is the more sophisticated
touchscreen controllers, where there is a lot of sequencing involved
alongside reading particular ADC channels).

> 
> > > > 3. If only labels are going to be used in conjunction with generic node
> > > >    names, should ADC5 be changed to ignore the node name?  
> >
> > From a quick search, I'm only seeing the node name used in debug prints currently.
> > That feels fine to me as it's telling us where the binding parsing went wrong...
> > Am I missing some use outside of vadc_get_fw_channel_data()?  
> 
> That's the VADC driver.  Look at adc5_get_fw_channel_data, specifically
> where it calls fwnode_property_read_string() to overwrite
> prop->datasheet_name.

Ah. Thanks for the pointer, though I'm still confused.

	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
	if (ret)
		channel_name = name;

	prop->datasheet_name = channel_name;

That's reading the label property, not the node name.

> 
> > > > 4. If a label (or node name) is not set, do we fall back to
> > > >    datasheet_name hardcoded in the driver?  
> > 
> > Hmm. Probably not.  
> 
> Then we might as well remove this useless data from the kernel driver
> altogether...

Ok. May make sense to use the datasheet name if noting better provided
for the label.  Assuming the datasheet names are them selves somewhat
useful information for a user.

> 
> > > > 5. What do we use for datasheet_name vs extend_name?  
> > Expand that to include label.
> > datasheet_name : When you want to have human readable pin names from the ADC
> >   datasheet, used as part of provide services to consumer drivers. Doesn't
> >   work with DT though as it wasn't part of the binding for consumers.
> >   So largely irrelevant unless you have an MFD where the ADC consumers are
> >   also part of the MFD children and so the map is set up in the way we used
> >   to do it for board files.  
> 
> ... or this could remain to feed into datasheet_name?
Now I'm confused.  Feed into label perhaps?

> 
> > extended_name: Short answer is don't use it today.  It was a bad design decision
> >   a long time back.
> > label: This is the one you should info from DT through to today.  As it is freeform
> >   and comes from the bindings - we don't encode this in the const iio_chan_spec array
> >   but rather use the iio_info->read_label() callback.  It is provided to userspace
> >   as a per channel _label attribute.  
> 
> Thanks, I have been looking for this and scanning through
> iio_read_channel_label() now.  It'll use ->read_label() and only defer
> to extend_name if the getter isn't available.
yup.  The extend_name fallback was added to solve complex parsing for
legacy drivers.  I guess that added confusion here.

> 
> I'll insert a getter here in the vadc driver that returns the DT label
> if set, otherwise the hardcoded driver name (which'll still feed into
> iio_chan_spec::datasheet_name).

I guess that's safe enough as long as no one registers an iio_map in
one of these drivers. grep suggests no one does :)

> 
> Do we then remove extend_name from qcom-spmi-adc5 and give it the same
> treatment, since it would now use DT node names as filenames unless a
> label is set?  I can only imagine it having been set because the ADC5
> author(s) didn't see a name nor label in sysfs either, without knowing
> about the existence of read_label.

Sadly we can't remove it because of the ABI change that would result and
potential userspace breakage.

Not sure how age of this driver matches up with the 'change of plan'
but we 'used' to use extend_name for this purpose before I got moaned
at a lot by the userspace folk. They were right of course, that encoding
free form data in filenames isn't the best idea I ever had.  


> 
> > > > 6. Any other vadc drivers that need the same treatment, when we come to
> > > >    a resolution?  
> > Any resolution can only 'add' ABI to userspace.  So adding labels is fine.
> > extend_name never is.  
> 
> Saying the above in a different way: would removing extend_name
> assignment from qcom-spmi-adc5 be fine?

Sadly not.  We are stuck with that.

> 
> > Hope that helps.  
> 
> A lot, now knowing that read_label is the part of the puzzle I
> previously missed.  Thanks!

When I let the extend_name fallback in for the labels
it didn't occur to me that it would make it more confusing for
people looking at older code.  Long shot, but would a comment
in iio.h for extend_name to say something to this effect be likely
to have been something you'd have seen?  If it would, let's add
one to potentially make this less confusing for the next person!

Jonathan


> 
> - Marijn

