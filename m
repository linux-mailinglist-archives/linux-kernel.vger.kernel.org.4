Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAF6B6868
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCLQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B42594D;
        Sun, 12 Mar 2023 09:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FEB60F58;
        Sun, 12 Mar 2023 16:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A030C433EF;
        Sun, 12 Mar 2023 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678639855;
        bh=hPzcJThCdsn360QBSnBHKSMxI56LwWBFsVsg49Nj5Q0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ICPnV+9q65APqi03nYFJYg2+Qv0EWT4xBajUHbIFCsqkWfMty9ATj9rT6DHyXBOs4
         Pjt/V5ghFzUYUpVR5XEJs5D+cZc2AqDBphMCYEfa0DqL1DUw0pWSBrDWWx0tKBRw1h
         keG1frEuxKFftRPwvF3A+9KL7/JjJp5IIzRUOdm/ysboVtYRL2k2kYqZ6VFoWLCz8U
         yqrQMBVaJHgxrWSBeZXpNbMWpQm1qaMCAqQoka1vweTTgvXbnRAf6619FcqPYrojtS
         yqwcGSEgY99SaJZeUcu++Ms1lwacdr7l5OODYfKuDGls+c7BBGh7s00zIwligbtvi/
         bG0EfR78+vupA==
Date:   Sun, 12 Mar 2023 16:51:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230312165100.45de0c9b@jic23-huawei>
In-Reply-To: <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
        <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 6 Mar 2023 14:52:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
> > Some light sensors can adjust both the HW-gain and integration time.
> > There are cases where adjusting the integration time has similar impact
> > to the scale of the reported values as gain setting has.
> > 
> > IIO users do typically expect to handle scale by a single writable 'scale'
> > entry. Driver should then adjust the gain/time accordingly.
> > 
> > It however is difficult for a driver to know whether it should change
> > gain or integration time to meet the requested scale. Usually it is
> > preferred to have longer integration time which usually improves
> > accuracy, but there may be use-cases where long measurement times can be
> > an issue. Thus it can be preferable to allow also changing the
> > integration time - but mitigate the scale impact by also changing the gain
> > underneath. Eg, if integration time change doubles the measured values,
> > the driver can reduce the HW-gain to half.
> > 
> > The theory of the computations of gain-time-scale is simple. However,
> > some people (undersigned) got that implemented wrong for more than once.
> > 
> > Add some gain-time-scale helpers in order to not dublicate errors in all
> > drivers needing these computations.  
> 
> ...
> 
> > +/*  
> 
> If it's deliberately not a kernel doc, why to bother to have it looking as one?
> It's really a provocative to some people who will come with a patches to "fix"
> this...

Just make it kernel-doc.

> 
> > + * iio_gts_get_gain - Convert scale to total gain
> > + *
> > + * Internal helper for converting scale to total gain.
> > + *
> > + * @max:	Maximum linearized scale. As an example, when scale is created
> > + *		in magnitude of NANOs and max scale is 64.1 - The linearized
> > + *		scale is 64 100 000 000.
> > + * @scale:	Linearized scale to compte the gain for.
> > + *
> > + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> > + *		is invalid.
> > + */

> ...
> 
> > +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);  
> 
> I would say _HELPER part is too much, but fine with me.

Hmm. I think I like the HELPER bit as separates it from being a driver.
Of course I might change my mind after a few sleeps.





> > +++ b/drivers/iio/light/iio-gts-helper.h  
> 
> Is it _only_ for a Light type of sensors?

I'd move it up a directory and allow for other users.

Jonathan
