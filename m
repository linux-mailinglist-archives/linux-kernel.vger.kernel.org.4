Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14B6EE856
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjDYThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbjDYTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:36:46 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E56A4C;
        Tue, 25 Apr 2023 12:36:42 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-14-243-nat.elisa-mobile.fi [85.76.14.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Q5XLZ64GVz49Q1p;
        Tue, 25 Apr 2023 22:36:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1682451399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGy2QBjXXOXxgYHJIAtsdMoypJDn9P67QK6JeYyevLI=;
        b=F9tf2aSCiHq9IZpX0fZUuDOFv1tNBtbTgPEEntHE/PgD+mH/KwzSOBgeGwf5KwOhQJ4rtq
        8wWs1NqOp4sfpc5V3EuGcv49RvFrtk+bCYajyOG4xRUfTZ5Kcdia+PCtdMV6dg1Lj2HwGF
        UsLcEAMvevuRGTzaBJqalE1ZroFQ4SH2ObX6po8p2lfNfUltskBuwLbaV5hrsgnziIcuED
        i9Lpi99B9PCDO/g7TAfiaZY9obdqIa0Adh+UIL7Kz6E9dCc2PNuSfOEStlKL8kKZMA9Fjg
        7M9Gha2tcN6o8ysJNPBL5PbGfmye48GsTVilTFTr3GWhfEHAJJnAL5l5ZtO6Eg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1682451399; a=rsa-sha256;
        cv=none;
        b=LSz8fWN9PhZxSDYtsfGpLjV83nnEgNPLbrJ4Fx6qLLAKAGdP2RLDYNKY0SSXBHqsDwuftl
        G4AQLVDYzTLlCUYdoAFisMZYBlD3Sqw+rm9IL+LkzDkS6enCnj2W76YRye63aV77FjQAIs
        Qn/ENZ96sNSe6vKpIkeoTwWuZZXiM/fKjficpjnNPuCz3nJFXGLfQmXkj5a7NQBGvDgfYm
        w/hEuzUnidFRcyshfGLg2MIPIO0g0VSl3aATGBprxd2ELBWpksABxxC4eKh1mBjm3LYIeF
        HMCyNn7ymnqINfd/sM/uC1tNEYM4/3vkAvde/G74hMK8QO+us9Na0D6Wepiivg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1682451399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGy2QBjXXOXxgYHJIAtsdMoypJDn9P67QK6JeYyevLI=;
        b=jx+US4jthAMMpQ27/SJR2GYjsEj7E0f6T3ROzA15te5AYw9tAIcun7uNvCi75DhwdFnbce
        Z0NujQtTFSU2rTyNKTXSnF6QvUQqY/KtAznVRZktYKEETamr31z5c/ar74cLkQ74AWhVHN
        tN4duwz+t/KZenfqa8e0ujRmMBDG80ynbrxk097a8jFZw3csDEkBw7oFZOWhrfyaLLZAXG
        Cu6iBgauGXvg5dm46OXRBPrVYLWRac9vxzHijS8EFm9+6x1GIYrQ/y6ZXN7hd2b2WiEAnl
        8fI977MwYydvCE0op5TydcCCzoQuCWgN0q1wezsaGsWFquTfOqD3GzF7jHeB5w==
Date:   Tue, 25 Apr 2023 22:36:37 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425212040.5a4d5b09@aktux>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:
> Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Which commit introduced that regression? Also, the changelog mentions
> > it happens only with "unusual" probe order. Now, all the ordinary cases
> > for OMAP1 are broken.
> > 
> did not bisect that to an exact commit.
> Unusual probe order: on the device where I tested it,
> I did not see a completely successful probe.

If you cannot point out a working past commit, there was no regression. If
you fix something that hasn't worked before or has been long time broken,
it must not cause breakage to other current users.

> > And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> > and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> > well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> > stopped now working.
> > 
> so we break every non-devicetree user of omap-gpio? 

It seems so.

A.
