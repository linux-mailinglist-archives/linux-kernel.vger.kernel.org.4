Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1400370CCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEVVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEVVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B20DB;
        Mon, 22 May 2023 14:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 546816241D;
        Mon, 22 May 2023 21:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AFEC433EF;
        Mon, 22 May 2023 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684792195;
        bh=bk+0bpMnoVQcE+GPrhxsvgXsK2kP9pMa49S8uTwGy5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEXS02ppHFJkO4Z1vb3+jCFGDmmQzVaMNFX9Fvn6VQinVGo7t5UIyMgQEf45v9Svh
         qcVx9AjINU8QG4XYh+1EX1R4wTcE5jSJc5E5Te4z/wysibDTdDLppuUjEwk1v8Fi12
         btwVjNzuxc//lLb1m6bd0Occ8AgWGMorpjMhHNpMtAoz791P1CRs8FvjQ2hcBkJVPA
         5BwCEBs3xohxHL683VKhGewzfV8o8W/xQgkmdwKQ2TE3qEDoJpincZ1N8/TWQ2lJN8
         pY3mJTJQgM0ObIiRNh5xMV2lncPBAaqp4ekbAOe+FcILE7pkvEJTWksCJtg+1FnUlK
         0ZtcgP7oW3CYA==
Date:   Mon, 22 May 2023 14:53:48 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Prashant Malani <pmalani@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vara Reddy <varar@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
Message-ID: <20230522215348.uoyboow26n2o3tel@ripper>
References: <CAD=FV=W9uKq00wXn4H1ax0u2D=R8Wn3J-Je43uxcPyDtk7AK7Q@mail.gmail.com>
 <YVyMwsvLl6XalJxB@ripper>
 <CAD=FV=WY+g38p7--QKZCaQnSqx7VvdwC36jH-VKnrEWoxK=XHQ@mail.gmail.com>
 <YV0KBWxVtKgOp2Cj@ripper>
 <CAD=FV=X5JFE3u9BtxxocaUrYNSpYXJN90UJ8HOvXZE6oYiVsDQ@mail.gmail.com>
 <CACeCKac4b_ej87cQD692TNwpsoFsmBwDcSeLy5fp+pvLX1si7g@mail.gmail.com>
 <YV7JNH9QvI4cBz5s@kuha.fi.intel.com>
 <YV8dEKMhNKKl20j6@ripper>
 <YWA7vXp+4QbKWU1S@kuha.fi.intel.com>
 <do5veo5axxbvmcddpqf7u5rfer6soxzy5selfnjv5sn6n57h47@q3hfznslndba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <do5veo5axxbvmcddpqf7u5rfer6soxzy5selfnjv5sn6n57h47@q3hfznslndba>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:51:01PM -0500, Bjorn Andersson wrote:
> On Fri, Oct 08, 2021 at 03:38:21PM +0300, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Thu, Oct 07, 2021 at 09:15:12AM -0700, Bjorn Andersson wrote:
> > > The one thing that I still don't understand though is, if the typec_mux
> > > is used by the typec controller to inform _the_ mux about the function
> > > to be used, what's up with the complexity in typec_mux_match()? This is
> > > what lead me to believe that typec_mux was enabling/disabling individual
> > > altmodes, rather just flipping the physical switch at the bottom.
> > 
> > Ah, typec_mux_match() is a mess. I'm sorry about that. I think most of
> > the code in that function is not used by anybody. If I remember
> > correctly, all that complexity is attempting to solve some
> > hypothetical corner case(s). Probable a case where we have multiple
> > muxes per port to deal with.
> > 
> > I think it would probable be best to clean the function to the bare
> > minimum by keeping only the parts that are actually used today
> > (attached).
> > 
> 
> Sorry for not replying to this in a timely manner Heikki. I've been
> ignoring this issue for a long time now, just adding "svid" to our dts
> files. But, this obviously shows up in DT validation - and I'd prefer
> not defining these properties as valid.
> 
> The attached patch works as expected.
> 

Sorry, I must have failed at applying the patch - it doesn't work...

> Could you please spin this as a proper patch, so we can get it merged?
> 
> Regards,
> Bjorn
> 
> > thanks,
> > 
> > -- 
> > heikki
> 
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > index c8340de0ed495..44f168c9bd9bf 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -193,56 +193,15 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
> >  static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> >  			     void *data)
> >  {
> > -	const struct typec_altmode_desc *desc = data;
> >  	struct device *dev;
> > -	bool match;
> > -	int nval;
> > -	u16 *val;
> > -	int ret;
> > -	int i;
> >  
> >  	/*
> > -	 * Check has the identifier already been "consumed". If it
> > -	 * has, no need to do any extra connection identification.
> > +	 * The connection identifier will be needed with device graph (OF graph).
> > +	 * Device graph is not supported by this code yet, so bailing out.
> >  	 */
> > -	match = !id;
> > -	if (match)
> > -		goto find_mux;
> > -
> > -	/* Accessory Mode muxes */
> > -	if (!desc) {
> > -		match = fwnode_property_present(fwnode, "accessory");
> > -		if (match)
> > -			goto find_mux;
> > -		return NULL;
> > -	}
> > -
> > -	/* Alternate Mode muxes */
> > -	nval = fwnode_property_count_u16(fwnode, "svid");
> > -	if (nval <= 0)
> > -		return NULL;
> > -
> > -	val = kcalloc(nval, sizeof(*val), GFP_KERNEL);
> > -	if (!val)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> > -	if (ret < 0) {
> > -		kfree(val);
> > -		return ERR_PTR(ret);
> > -	}
> > -
> > -	for (i = 0; i < nval; i++) {
> > -		match = val[i] == desc->svid;
> > -		if (match) {
> > -			kfree(val);
> > -			goto find_mux;
> > -		}
> > -	}
> > -	kfree(val);
> > -	return NULL;
> > +	if (id)

We pass id as "mode-switch", so this will never be NULL. But we also only
want to consider endpoints with "mode-switch", otherwise we'll fail if
any of the referred endpoints is not implementing a typec_mux...

So this needs the same snippet we find in typec_switch_match():

	/*
	 * Device graph (OF graph) does not give any means to identify the
	 * device type or the device class of the remote port parent that @fwnode
	 * represents, so in order to identify the type or the class of @fwnode
	 * an additional device property is needed. With typec switches the
	 * property is named "orientation-switch" (@id). The value of the device
	 * property is ignored.
	 */
	if (id && !fwnode_property_present(fwnode, id))
	        return NULL;

With that, this works as expected!

Regards,
Bjorn

> > +		return ERR_PTR(-ENOTSUPP);
> >  
> > -find_mux:
> >  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
> >  				mux_fwnode_match);
> >  
> 
