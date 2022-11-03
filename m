Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685E617358
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCAWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E727AE6B;
        Wed,  2 Nov 2022 17:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F00B8257E;
        Thu,  3 Nov 2022 00:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A9EC433D6;
        Thu,  3 Nov 2022 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667434923;
        bh=NwgGWuXDoJ/N2xA4iOMxJoFQXwgYWNNpaY65FQ6JJys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBWSsDcXybP1tP3PQGxE/ItyJlvLU6be32w5TRFltAz0EjEhRGzGlRXRZLH39jRIq
         uQAsFTzJjStXbCs9L/kx9c5Awp3oDaIX4gH1ZsSUsWJgdhhm+ICQVlEhjMzRz90qdi
         Q2TQidYGWS9VjJ49c94tR6chUmeX1/lrD7VtlHwQ=
Date:   Thu, 3 Nov 2022 01:22:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/21] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <Y2MJ43oVYfNgBZsQ@kroah.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-11-quic_eberman@quicinc.com>
 <Y2FfKCKZ3N8rOqcT@kroah.com>
 <3d2858fe-ea3e-159c-faff-5052cba1e08c@quicinc.com>
 <Y2Hbl4y9Hioybxmq@kroah.com>
 <28eaa4bd-a9ee-c415-57c4-a9a56ffeef18@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28eaa4bd-a9ee-c415-57c4-a9a56ffeef18@quicinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:04:45AM -0700, Elliot Berman wrote:
> > > > > +/* Resource Manager Header */
> > > > > +struct gh_rm_rpc_hdr {
> > > > > +	u8 version : 4, hdr_words : 4;
> > > > > +	u8 type : 2, fragments : 6;
> > > > 
> > > > Ick, that's hard to read.  One variable per line please?
> > > 
> > > Ack.
> > > 
> > > > And why the bit packed stuff?  Are you sure this is the way to do this?
> > > > Why not use a bitmask instead?
> > > > 
> > > 
> > > I felt bit packed implementation is cleaner and easier to map to
> > > understanding what the fields are used for.
> > 
> > Ah, so this isn't what is on the "wire", then don't use a bitfield like
> > this, use a real variable and that will be faster and simpler to
> > understand.
> > 
> 
> This is what's on the "wire". Whether I use bitfield or bit packed would be
> functionally the same and is just a cosmetic change IMO.

Ah, that wasn't obvious at all.

Usually using bitfields like this for "wire" protocols is not a good
idea (endian issues and all of that.)  Please use a bitmask instead, as
that way you know exactly what is happening, and the compiler can
usually generate much better code overall.

And as this is on the wire, please specify the endian values, _AND_ use
the proper kernel types for stuff that goes between user/kernel or
kernel/hardware, as you are not doing that here.

thanks,

greg k-h
