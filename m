Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD760722D91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjFERWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjFERWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:22:52 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6C91;
        Mon,  5 Jun 2023 10:22:49 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685985768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Berwdtb2uXHQbSksaaVPK3mZrvObJ1lWrE4UzrcIf8M=;
        b=J7ev+niTsg1xzPdC/Z0LVxKv4Z42cGvd9zc2KeBD1xxv+tqyeHe/4J8ImQTFJ1AoRgwgFN
        6ojrllCzR4ja6qcd8Etya0M3KkgPxP7cdNUzzM1mBqdz0+9jfeouUaa6+qH29biRkSjfrN
        DEIv/KSc/UuFrVmO58z9vm5utSERq6eCX49QApf1GYrUKVvHRTAtTYXX/eis3QNiXJMu6m
        unP5K6zs/HR9ux7R15lM8AbrvRMKbugnYtaMO8wRVXXYMabKWLmZaZTrLy4l+nDei2D3CH
        yOnw8Ft+VslMGLTB3zGn7OVLUIwcfgiqpz9hy1ufyO1B+48vf2k025F3lQLDcw==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30441240009;
        Mon,  5 Jun 2023 17:22:46 +0000 (UTC)
Date:   Mon, 5 Jun 2023 19:22:45 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230605192245.4132e0ae@bootlin.com>
In-Reply-To: <20230528183855.0c95d308@jic23-huawei>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-8-herve.codina@bootlin.com>
 <20230528183855.0c95d308@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, 28 May 2023 18:38:55 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 23 May 2023 17:12:21 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Industrial I/O devices can be present in the audio path.
> > These devices needs to be used as audio components in order to be fully
> > integrated in the audio path.
> > 
> > This support allows to consider these Industrial I/O devices as auxliary
> > audio devices and allows to control them using mixer controls.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---  
> 
> > diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
> > new file mode 100644
> > index 000000000000..21575c4b35fd
> > --- /dev/null
> > +++ b/sound/soc/codecs/audio-iio-aux.c
> > @@ -0,0 +1,302 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// audio-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components
> > +//
> > +// Copyright 2023 CS GROUP France
> > +//
> > +// Author: Herve Codina <herve.codina@bootlin.com>
> > +
> > +#include <linux/iio/consumer.h>
> > +#include <linux/module.h>  
> 
> #include <linux/mod_devicetable.h> ideally to pick up
> the of_device_id definition without bouncing through some non 
> obvious header path.

Right, <linux/module.h> will be replaced by <linux/mod_devicetable.h> in the
next iteration.

Thanks for the review,
Hervé

> 
> 
> > +#include <linux/slab.h>
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>  
> 
> Otherwise, the IIO elements of this look good.  So for those at least
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I don't have enough knowledge of the snd stuff to review those
> parts.
> 
> Jonathan
> 
> 
