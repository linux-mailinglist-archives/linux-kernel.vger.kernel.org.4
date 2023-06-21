Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFFB7380E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjFUK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFUK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA89B6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02500614C0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD08C433C8;
        Wed, 21 Jun 2023 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345153;
        bh=XGqVwPV972bAofKq7Ii+BNgpn8zMgGdyFdhMEb7bJ0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nl1pyQ0PaXumCuGFHcKPQwtVTpyKlQgbw42RYLBQbmmK7vzjRYOe8mnCvGNCVujH5
         afER4UF24JrV29TMZfHL1kQYo4PDe0SAgfcvD8wIKHldrsShKM1Ev3dZCqW8QyH7Rj
         PS6fxqDqD8lZr/7Nen+0JxLvYk5WXkB+uRQJtlxqgIHM49pREJhQ6+lM94Dxj700cn
         ch2uE79VSRXokOG5OMBV1N1pTvwxdSv9KG98ZMXm3BT54Qcy3d1D9Eu7lfAZL5ySDN
         zQKSKClODeJA3sPZl1YJSbX+JgWUh2iUbLQZPL0pFzYX+TKduQ/dC7f34AcBDYlb24
         jtHqe2LuuPY6A==
Date:   Wed, 21 Jun 2023 16:29:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
Subject: Re: [PATCH 3/4] soundwire: extend parameters of
 new_peripheral_assigned() callback
Message-ID: <ZJLX/fPM1FbBxM2X@matsya>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
 <ZIF+G1mbis/lb8Po@matsya>
 <e07d507e-57bf-a2b7-2ab1-f5f45ff5399b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07d507e-57bf-a2b7-2ab1-f5f45ff5399b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-23, 08:24, Pierre-Louis Bossart wrote:
> 
> >> -static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
> >> +static void generic_new_peripheral_assigned(struct sdw_bus *bus,
> >> +					    struct sdw_slave *slave,
> >> +					    int dev_num)
> >>  {
> >>  	struct sdw_cdns *cdns = bus_to_cdns(bus);
> >>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
> >> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> >> index 8a7541ac735e..41a856bedf1e 100644
> >> --- a/include/linux/soundwire/sdw.h
> >> +++ b/include/linux/soundwire/sdw.h
> >> @@ -861,7 +861,9 @@ struct sdw_master_ops {
> >>  	int (*pre_bank_switch)(struct sdw_bus *bus);
> >>  	int (*post_bank_switch)(struct sdw_bus *bus);
> >>  	u32 (*read_ping_status)(struct sdw_bus *bus);
> >> -	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
> >> +	void (*new_peripheral_assigned)(struct sdw_bus *bus,
> >> +					struct sdw_slave *slave,
> > 
> > maybe better, drop the bus and pass slave (which contains bus)
> 
> I kept it for consistency, all callbacks for sdw_master_ops start with
> the bus parameter.

That is a valid point, since this is sdw_master_ops() and not slave,
this looks better

-- 
~Vinod
