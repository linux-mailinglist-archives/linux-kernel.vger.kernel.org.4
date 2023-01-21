Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54B676555
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAUI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:57:24 -0500
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC456C125
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PMku9Ie1l3L3qO6PU2vQCU4slZtEiI5gya10fYincsk=;
        b=NB7XK+7t6EwJmM4IvdwibIBfqtusl1AHiDAo6WgjBhArhnNcAwPmVRZLB5OH993CLp4zyxJDDnI9t
         RehRO0Wr/jm4NsrQs+HMCHp3ww7x1/jIY020uEkhpW5iFQt07rxOwz3Hwtgi/Wt+fCNlQ3ErhLiW2m
         7MMDQVg4dF68hSZcRJY3tdBkWL6ia6EMpvpqY0llf1P/YFwbn/AYZF/0KQZpyWZmI7Z5EnovxOFGqb
         8tFR4qqApuF7Yd0rTTCuPn0od5vWwJwtR+c12PIHyT6ZjXNpA05oQiaOgqn+Vf+juMsli8ZBy7NgOk
         zOo2z811CVPHMzeIOaWAhY+e907HAtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PMku9Ie1l3L3qO6PU2vQCU4slZtEiI5gya10fYincsk=;
        b=MDx0FrRzUs/XS2boi3BgiXRfEotq4sSTAD3kH9N/OzOjWO/ADxVd3LlClBEMrWmYA2xZux1wEJwIi
         3cT8qTXCg==
X-HalOne-ID: 9bb0cfb3-9969-11ed-8286-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 9bb0cfb3-9969-11ed-8286-cde5ad41a1dd;
        Sat, 21 Jan 2023 08:57:19 +0000 (UTC)
Date:   Sat, 21 Jan 2023 09:57:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     John Keeping <john@metanate.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] drm/bridge: panel: Set orientation on panel_bridge
 connector
Message-ID: <Y8uo7vIcQ6caH9pu@ravnborg.org>
References: <20230120114313.2087015-1-john@metanate.com>
 <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John/Douglas.

On Fri, Jan 20, 2023 at 01:44:38PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jan 20, 2023 at 3:43 AM John Keeping <john@metanate.com> wrote:
> >
> > Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
> > it") added a helper to set the panel panel orientation early but only
> > connected this for drm_bridge_connector, which constructs a panel bridge
> > with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.
> >
> > When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
> > panel_bridge creates its own connector the orientation is not set unless
> > the panel does it in .get_modes which is too late and leads to a warning
> > splat from __drm_mode_object_add() because the device is already
> > registered.
> >
> > Call the necessary function to set add the orientation property when the
> > connector is created so that it is available before the device is
> > registered.
> 
> I have no huge objection to your patch and it looks OK to me. That
> being said, my understanding is that:
> 
> 1. DRM_BRIDGE_ATTACH_NO_CONNECTOR is "the future" and not using the
> flag is "deprecated".
Correct.
Could we take a look at how much is required to move the relevant driver
to use DRM_BRIDGE_ATTACH_NO_CONNECTOR?

If this is too much work now we may land this simple patch, but the
preference is to move all drivers to the new bridge handling and thus
asking display drivers to create the connector.

What display driver are we dealing with here?

	Sam
