Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0166D0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjAPVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjAPVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:18:50 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B13A9D;
        Mon, 16 Jan 2023 13:18:49 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4D9B31F8F3;
        Mon, 16 Jan 2023 22:18:47 +0100 (CET)
Date:   Mon, 16 Jan 2023 22:18:46 +0100
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
Message-ID: <20230116211846.qe52ysw53qswvogw@SoMainline.org>
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
 <20221221223432.si2aasbleiicayfl@SoMainline.org>
 <20221223174445.7c607ebc@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223174445.7c607ebc@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-23 17:44:45, Jonathan Cameron wrote:

<snip>

> > As in, as long as we don't touch extend_name which would affect sysfs
> > names, changing the label returned by read_label is fine? 
> 
> Sticky corner, but I think we should be fine doing so on basis of changing
> ABI we don't think anyone will notice. In lots of cases the label is effected
> by DTS files that may change under the kernel anyway so hopefully no one is
> relying on the value too much *crossed fingers*

Not sure I'd go as far as implementing read_label in adc5 (just queued
that up locally for vadc though and it's simple) only to get around
extend_name, but we could do so.  That still leaves @xx in the filename
and makes for general inconsistency when read_label (returned label name
from sysfs) and extend_name (filename in sysfs) use different codepaths
to determine their value.

> > And changing
> > datasheet_name to only ever use the datasheet_name provided by the
> > driver and never the name provided in DTS is also okay?
> 
> datasheet_name is internal to kernel only so can definitely change that
> as long as we don't have any upstream users (I'm fairly sure there aren't any)

Ack, queued up for RFC v2.

> > I am unfortunately completely unfamiliar with iio_map, and hope it
> > doesn't distract too much from trying to add label files to QCom's SPMI
> > VADC driver :)
> 
> Just think of it as the board file way of doing equivalent of what we have
> to set up IIO consumers in DT. It's also used in driver that hard code
> relationships with their consumers - not including this one so we should
> be fine.

Guess QCOM is all DT, so this shouldn't matter.

<snip>

> > > Ok. May make sense to use the datasheet name if noting better provided
> > > for the label.  Assuming the datasheet names are them selves somewhat
> > > useful information for a user.  
> > 
> > They're generated from the macro (hence capitalized) in VADC, manually
> > written in ADC5.  Would it make sense to add handwritten string
> > literals for this?
> 
> Not sure. I've rather lost track of where we are on this.

I'll send a v2 RFC shortly with what we've accumulated thus far, and
will make sure to mention this.  In short, in qcom-spmi-vadc.c there is:

    .datasheet_name = __stringify(_dname),

Which gives us a full-caps DIE_TEMP, for example, instead of a more
friendly "die_temp" string literal in qcom-spmi-adc5.c.  Not a
requirement for my patches, this should all go in separate bits.

<snip>

> > Feed into read_label when no label was otherwise provided in DTS, but
> > always feed into iio_chan_spec::datasheet_name since we discussed that
> > this should represent the name of the part (e.g. PMIC), not the board
> > and way in which it consumes the channel.
> 
> Should be the name of the pin on the part, but otherwise agreed.

Ack, I think that's what we have in the qcom-spmi-vadc/adc5 drivers
currently.

<snip>

> I hate it when we break ABI and don't notice, precisely because it then
> becomes guessing game on which one people might be relying on.
> 
> Let's take the view it is the older one without the @xx? 
> So strip that off as a fix that we backport.

I was intending to send a patch that falls back to
adc5_channels::datasheet_name when no label is supplied (and ignoring
fwnode_name for use in extend_name altogether) but that's breaking ABI
in a slightly different way... and depends on my "arm64: dts: qcom: Use
labels with generic node names for ADC channels" [1] RFC being resent
and actually landing.

[1]: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/

Will probably be shot down but I'll give it a try anyway.

<snip>

> I agree that a cross reference for that 'other' use of extend_name
> would make sense and that it can be overridden.  Though the override is
> kind of the common case, if you are looking at extend_name docs you
> are presumably in the case where such docs would help.
> Patches for docs welcome :) 

I'll see what I can add :)

> > Regardless of that VADC/ADC5 do some _really confusing_ things, passing
> > strings around in various weird ways (or not), and it took some time to
> > keep the various similar structs apart :)
> 
> I'm feeling a bit guilty I never noticed this insanity at the time.
> I blame my younger self.

Don't worry, we live and learn; just ABI (for something I doubt anyone
uses / cares about...) biting us every once in a while.

> Have a good break if you are having one.

Hope you had a good one; mine was filled with hardly any free time for
hobbies like the mainline kernel :)

- Marijn
