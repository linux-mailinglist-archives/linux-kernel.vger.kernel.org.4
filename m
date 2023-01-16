Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33F66D1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjAPWQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjAPWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:15:58 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C6279A9;
        Mon, 16 Jan 2023 14:15:47 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 8D61D1B00229;
        Tue, 17 Jan 2023 00:15:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673907345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Spx/m+y6IQTXG2/ImI2Ltvhjm/XLr6qXWNR6waNDMSU=;
        b=FJZFBTcBJuV4qVjDaaJSme2TO70+BVoLo9ooMiDCwbf0GBUeX1J0qUe9qLlwwVLMCs18A1
        IEad29ZieP/wXyeq6KtSy6VEgee6DXn2xlYcuHTte6v+ocdfx6ezJFWSb9ulC5UbE/4/nv
        sY+jbFxdYz+HBC4Rk3C/vrxsHOUcOrzWRdnU+xdu0o7gcQbnmdKsCi8WCGVRw/NOeY2Og2
        XJfxMvQ7uw8T3o6+hi1739fIJCdneBxvmtDaPIsVVkl1rZsCXw1tIYrkUuSjVI2tQ5Amxw
        QKomR9+awMiP65OQsQweRTbDBGgxxFWNKrjMk1IpraJsYXesr3NpSnryiya2WQ==
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 1FF2720174;
        Tue, 17 Jan 2023 00:14:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1673907264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Spx/m+y6IQTXG2/ImI2Ltvhjm/XLr6qXWNR6waNDMSU=;
        b=lic720AH2W9TQd3tzimJlTprlQe0RglzVlrXqvLSe1V8INI4bMFdA9Vhy0MISszx8hfCu3
        gk6LkiPBQdN6LSDKudoYGwoyS7mDz2kZJtBRu+cHtiFtj6m816z+ikH45MK0fYNZc07KWq
        Jd8kFnH/KHF+mzaW3EFiqGw//3jWhyA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1673907264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Spx/m+y6IQTXG2/ImI2Ltvhjm/XLr6qXWNR6waNDMSU=;
        b=YNHPecA5uhPtoWK+SbGvIiJ9EqmqsVw8T6z/1CMkW00a64+VC9t9IlbI8doLp4qpGnnrnt
        UcgtcKR7Kqryh/lsVS2BEWDthaJ7IsZlzwW+/ynOwxnXPeJfvSO/86tEdtTccN5QELYxOQ
        Dh541ngLiqiJKvo2ZQtiMw+dfQOLw3I=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1673907264; a=rsa-sha256; cv=none;
        b=MkIPuGznRw0iD7dbhb/lBe1ScveNqP1y/HcziCWU+07kywNeubk9P3ExoWFaymp//PS7DA
        OXgPQCqOyAWlgYUzdERSVUmOc3ET07xqV5zt1/ixqeRPMF1LeOD2W7RxUXaXcQYSa0QPsW
        kCFOkkw48pcRS2ulx3CK5vNwbThIkgk=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8C8F9634C92;
        Tue, 17 Jan 2023 00:14:23 +0200 (EET)
Date:   Tue, 17 Jan 2023 00:14:23 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, mchehab@kernel.org,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <Y8XMP7+HrABQCaMR@valkosipuli.retiisi.eu>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
 <20220822075426.qjgxue7sjehazga4@pengutronix.de>
 <YwNJ8RpSR+oVxnS/@paasikivi.fi.intel.com>
 <20220823144450.ctjmby53prjw5qis@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823144450.ctjmby53prjw5qis@pengutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Aug 23, 2022 at 04:44:50PM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 22-08-22, Sakari Ailus wrote:
> > On Mon, Aug 22, 2022 at 09:54:26AM +0200, Marco Felsch wrote:
> > > Hi Sakari,
> > > 
> > > On 22-08-22, Sakari Ailus wrote:
> > > > Hi Marco,
> > > > 
> > > > On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > > > > Currently the driver turn off the power after probe and toggle it during
> > > > > .stream by using the .s_power callback. This is problematic since other
> > > > > callbacks like .set_fmt accessing the hardware as well which will fail.
> > > > > So in the end the default format is the only supported format.
> > > > 
> > > > It'd be much better to add runtime PM support to the driver instead.
> > > 
> > > I got your point, but didn't have the time for it right now, I will drop
> > > the patch from my v2.
> > 
> > The API is different but generally involves doing more or less the same
> > what this and the 4th patch do together.
> 
> I know :) as soon as I got feedback on my TC35 series [1] I give it a
> try and change it to dev-pm.

What's the status of this set?

These are nice improvements but I was expecting v2.

Thanks.

-- 
Sakari Ailus
