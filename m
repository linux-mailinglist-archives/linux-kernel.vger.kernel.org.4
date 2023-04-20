Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975F6E9512
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjDTMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjDTMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:52:19 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8446E91;
        Thu, 20 Apr 2023 05:52:06 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2974640006;
        Thu, 20 Apr 2023 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681995124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSvkVShDg2ogaaxh+qhZHwOBGnoML0lh9gLtFf0aYJY=;
        b=K3NraIj0bS9d2Ti9kkDjrdUnGd5Vvl/H4l2VnJrcbWQBF35iNR1tne4vvmzKC50ehtfOnv
        Lsy5pl7nk09AurzhQFsU/l069qzTDJVv5jyfQJqHeMcT+TgmkBZWzIg6BJ+95OLkQ8eC8F
        c4aFDnEtkuZvSztyCp/ifxAvgEDsxyMo4GYY4WxZO7Zv9hpU4dREDRkwnaC9z58aGPEMBe
        FKzuNaLV9K3xz7EUhO7l3wBEIzrMBkFPTns6DknzBLDw/XaGvLcEL1QddQoT3OdDYRAD5G
        YVY7RN4OH1eEvWC/b70AG4MHSqBbmTAeZ26WA59htBOYIJH3BTyXA7ZofApklQ==
Date:   Thu, 20 Apr 2023 14:52:02 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 2/7] mfd: core: Ensure disabled devices are skiped
 without aborting
Message-ID: <20230420145202.4e21b51d@bootlin.com>
In-Reply-To: <20230420122955.GA996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
        <20230417171601.74656-3-herve.codina@bootlin.com>
        <20230420122955.GA996918@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
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

On Thu, 20 Apr 2023 13:29:55 +0100
Lee Jones <lee@kernel.org> wrote:

> On Mon, 17 Apr 2023, Herve Codina wrote:
> 
> > The loop searching for a matching device based on its compatible
> > string is aborted when a matching disabled device is found.
> > This abort avoid to add devices as soon as one disabled device
> > is found.
> > 
> > Continue searching for an other device instead of aborting on the
> > first disabled one fixes the issue.
> > 
> > Fixes: 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are ignored without error")
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/mfd/mfd-core.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 16d1861e9682..7c47b50b358d 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -176,6 +176,7 @@ static int mfd_add_device(struct device *parent, int id,
> >  	struct platform_device *pdev;
> >  	struct device_node *np = NULL;
> >  	struct mfd_of_node_entry *of_entry, *tmp;
> > +	bool not_available;
> >  	int ret = -ENOMEM;
> >  	int platform_id;
> >  	int r;
> > @@ -211,13 +212,13 @@ static int mfd_add_device(struct device *parent, int id,
> >  		goto fail_res;
> >  
> >  	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> > +		not_available = false;  
> 
> Why not do:
> 
> 		bool disabled = false;
> 
> ... here instead?

Yes, I can change to 'disabled'.

> 
> >  		for_each_child_of_node(parent->of_node, np) {
> >  			if (of_device_is_compatible(np, cell->of_compatible)) {
> > -				/* Ignore 'disabled' devices error free */
> > +				/* Skip 'disabled' devices */
> >  				if (!of_device_is_available(np)) {
> > -					of_node_put(np);  
> 
> Why are you removing the put?

The of_node_put() is done internally by for_each_child_of_node() calling
of_get_next_child().
As the for_each_child_of_node() loop is not break, the of_node_put() must
not be called here as it will be called by of_get_next_child().

> 
> > -					ret = 0;
> > -					goto fail_alias;
> > +					not_available = true;
> > +					continue;
> >  				}
> >  
> >  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> > @@ -227,10 +228,17 @@ static int mfd_add_device(struct device *parent, int id,
> >  				if (ret)
> >  					goto fail_alias;
> >  
> > -				break;
> > +				goto match;
> >  			}
> >  		}
> >  
> > +		if (not_available) {
> > +			/* Ignore 'disabled' devices error free */
> > +			ret = 0;
> > +			goto fail_alias;
> > +		}
> > +
> > +match:
> >  		if (!pdev->dev.of_node)
> >  			pr_warn("%s: Failed to locate of_node [id: %d]\n",
> >  				cell->name, platform_id);
> > -- 
> > 2.39.2
> >   
> 

Best regards,
Hervé

