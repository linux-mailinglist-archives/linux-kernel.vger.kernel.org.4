Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2166D38FD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjDBQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDBQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1A3CC37;
        Sun,  2 Apr 2023 09:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91B66127C;
        Sun,  2 Apr 2023 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FEBC433EF;
        Sun,  2 Apr 2023 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680453108;
        bh=qJeZ5uDyEeQaZcj4Q81noYNElzTzq/Y3eW1UJP6DIF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uqQIUBqEnMt25KlGU3fSrHKonEIX2ToZt58RDQj4a3U+scmq69TikS0QNlQI5/OT4
         rwny0Bw16lLqlbwnQuutBtfE55CQnKp2fJVCpYPIa2Hn71+ZBcI7NQvmtciKVQE3sr
         r3MyDXnB9BKOO6+wepXSBdGM4XidoMNaPhGa5rXvAOyrfqQYVmQ+n294CpGvHe3Eg2
         S2mWhetoKMvbgKitlTCPzikANH2sskvAoGC4/xTzEOJCLbdDeDZdJ+CJRg11enE4bZ
         KeMqkqoid7Flj3fT5EK099ROy6DygZqdfTWFuzUZAxFF2pJheYy8wvrG4yRVT+6Kp3
         2GHXj9wXhothQ==
Date:   Sun, 2 Apr 2023 17:46:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <20230402174657.55159879@jic23-huawei>
In-Reply-To: <ZCg6bhkxGKmkMloM@fedora>
References: <cover.1679867815.git.william.gray@linaro.org>
        <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
        <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
        <ZCg6bhkxGKmkMloM@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > +	.wr_table = &aio_ctl_wr_table,
> > > +	.rd_table = &aio_ctl_rd_table,
> > > +	.volatile_table = &aio_ctl_volatile_table,
> > > +	.cache_type = REGCACHE_FLAT,
> > > +};  
> > 
> > Do we need regmap lock?  
> 
> I think the regmap lock is opt-out, so I don't think we need to set an
> custom lock callback for the regmaps in this driver.
> 
> Jonathan, do read_raw() and write_raw() require explicit locking?

The don't provide their own locking.  Depending on the access pattern the
underlying bus locking may be sufficient.  If you have read modify write
cycles though you'll want locking at the appropriate level for that
which might well be at the level of regmap.

Jonathan
