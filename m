Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFF738891
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFUPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjFUPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00B1FC9;
        Wed, 21 Jun 2023 08:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE41E615BE;
        Wed, 21 Jun 2023 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC82C433C0;
        Wed, 21 Jun 2023 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687359380;
        bh=ln2lWCijb2V4mFtJBQotSwtqT0uvIw8cIIaLNs8TBV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDjz09CpApkkd08SxYoRrpdpQAfOz2L+/IjSDTWC5mwYrPpO6rjL02A2gakb5TGor
         odIiypj5ogfEYDfE5Y6yCsiJl+FgV02kiVD4ntFaMSXTZ/pKyjLIP6f9tXGfh8Urey
         HxoYfAbYc3tX85ec14PaVXemjsI87fsd3c7gXyqhTbh+1d65ZhxSEepqQ1nPzGaWWg
         +fna6f7Bt80m4FnpSRn6c9gGWKqXWZj6eFFWTaualuKq3viMnq7HPdp0KhmrZuWNfC
         d9nQ/25S9tzSxNgC6UaA7HIIRwaO5CniGH5yr1WN40MxAFn1rpDX5rGG6t7wJ0ZVnA
         /Xt1elswPC8VQ==
Date:   Wed, 21 Jun 2023 15:56:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/3] leds: trigger: netdev: add additional
 modes
Message-ID: <20230621145615.GD10378@google.com>
References: <20230617115355.22868-1-ansuelsmth@gmail.com>
 <20230619104030.GB1472962@google.com>
 <dd82d1bd-a225-4452-a9a6-fb447bdb070e@lunn.ch>
 <20230620102629.GD1472962@google.com>
 <0462a658-8908-4b8c-9859-8d188f794283@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0462a658-8908-4b8c-9859-8d188f794283@lunn.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Andrew Lunn wrote:

> > > If you do decided to wait, you are going to need to create another
> > > stable branch to pull into netdev. I know it is not a huge overhead,
> > > but it is still work, coordination etc.
> > 
> > Can you clarify you last point for me please?
> 
> This patchset extends the conditions on which the trigger blinks the
> LED. It adds a couple more values to enum led_trigger_netdev_modes in
> include/linux/leds.h. Once it gets merged, i will have a followup
> patch extending the Marvell PHY driver to make us of them. It will
> need these additional enum values. I also expect other PHY drivers to
> gain support for them. Probably the dp83867.c driver since Alexander
> Stein already has a patch merged adding support for what the current
> API supports.
> 
> If we merge this patchset now via netdev, -rc1 should have everything
> we need for this continuing development work. If we wait to merge
> these patches until -rc1, only the LED tree has the needed patches, so
> these network drivers will need a stable branch we can pull into
> netdev.
> 
> Both ways work, we can do either. But it is probably easier for
> everybody to merge now via netdev.

Got it, thanks.

-- 
Lee Jones [李琼斯]
