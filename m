Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D296FC484
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjEILFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjEILFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:05:06 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC291100FD;
        Tue,  9 May 2023 04:04:59 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 9750EFF806;
        Tue,  9 May 2023 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1683630298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDT0BtDNWazrZ4uv2nOgwA/L/iBlds6MCiBQoDX01O8=;
        b=nSHUVWeB/sHhhhKvC0ANQeATJy/AYsdWCoxH6/rR0iq/mzZY5b0etDsw0+/CMFVtiUQ3Ov
        xjmj4eLNviD5ppjGWTJjtUBeXTmJ8RT6p2h+pCQAqVdM71f1CHBzdM8yVsjMwxGreTxhiu
        2dgJaAq3XqNjRd4sQN/cH18YXNgfZUYSvf4u8fa4EC/96ssNFlZYM3/nD383t2AOlbMn1w
        zI3KMUaYMg9ZlR1SYVeHQHEpi6eBaFEjPToakJ28UeUKS0mzkXXMtn5XD/2v4gNQQrNDTE
        TDBj073uecqHyipjvbp3JZPPVwAQ1wetsx+Taa0ZlgNQEzMS+hweEMFlQiGVNQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 09 May 2023 13:04:50 +0200
Message-Id: <CSHP4M31IC80.2WGQC75I3PX71@void.crly.cz>
Cc:     "Maxime Ripard" <mripard@kernel.org>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Icenowy Zheng" <icenowy@aosc.io>, "Ondrej Jirman" <megi@xff.cz>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] drm: sun4i: set proper TCON0 DCLK rate in DSI
 mode
From:   "Roman Beranek" <me@crly.cz>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
X-Mailer: aerc 0.15.1
References: <20230505052110.67514-1-me@crly.cz>
 <87jzxjp5tp.fsf@oltmanns.dev>
In-Reply-To: <87jzxjp5tp.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank,

On Mon May 8, 2023 at 10:47 AM CEST, Frank Oltmanns wrote:
> I tested this on my pinephone on drm-next, using additional patches for
> the pinephone's panel. [1] [2] [3]

Thank you for testing this and all the previous version of this
patchset. I appreciate your help.

> I played back a 60 fps video (10 seconds) and recorded the panel's
> output with a 240 fps camera. I noticed only 2 dropped frames, that I
> account to the imperfect data rate of 107.8MHz instead of 108 MHz due to
> pll-video0's rate being 294MHz instead of the 297 MHz for reasons I
> described in the thread on your v2 of this patch [4]).

Yes. That's what should happen, right? Or do you report this as a
defect?

Roman
