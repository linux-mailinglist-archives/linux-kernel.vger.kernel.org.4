Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684C5F4FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJEGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJEGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7E53D30;
        Tue,  4 Oct 2022 23:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90761B81C77;
        Wed,  5 Oct 2022 06:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3169C433D6;
        Wed,  5 Oct 2022 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664950875;
        bh=Kq4gcz5R4LOlRKyPItd/K64WIZHUieGWE3R5FkDlrGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=og9RHtmP5t3S1cEYgFdc1xyqBNaV93o+0U+YJvmhFVZ1ogFpv5WIotSMFPI2uqkcg
         zFdUD6fNJ/FLRDM7XsFAfPn2SJczVszTDdl0BHGZ21VObYguokTEx9Mm2cv93cMGim
         8BCE9bImULVzqHLV0+5ad/lH7tHBvwxVJ4YZ9LQo=
Date:   Wed, 5 Oct 2022 08:21:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
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
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/14] gunyah: rsc_mgr: Add auxiliary devices for
 console
Message-ID: <Yz0ig/Dnp4ovHjeN@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-14-quic_eberman@quicinc.com>
 <Yzbev2mZodsZhFY3@kroah.com>
 <1db27cda-356e-bae2-3c6a-b7916123a269@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db27cda-356e-bae2-3c6a-b7916123a269@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 04:49:27PM -0700, Elliot Berman wrote:
> On 9/30/2022 5:19 AM, Greg Kroah-Hartman wrote:
> > On Wed, Sep 28, 2022 at 12:56:32PM -0700, Elliot Berman wrote:
> > > Gunyah resource manager exposes a concrete functionalities which
> > > complicate a single resource manager driver.
> > 
> > I am sorry, but I do not understand this sentance.  What is so
> > complicated about individual devices being created?  Where are they
> > created?  What bus?
> 
> There's no complexity here with using individual devices, that's why I
> wanted to create secondary (auxiliary devices).
> 
> IOW -- "I have a platform device that does a lot of different things. Split
> up the different functionalities of that device into sub devices using the
> auxiliary bus."

Why not just have multiple platform devices?  You control them, don't
make it more complex than it should be.

And why are these platform devices at all?

As you say:

> A key requirement for utilizing the auxiliary bus is that there is no
> dependency on a physical bus, device, register accesses or regmap support.
> These individual devices split from the core cannot live on the platform bus
> as they are not physical devices that are controlled by DT/ACPI.

These are not in the DT.  So just make your own bus for them instead of
using a platform device.  Don't abuse a platform device please.

thanks,

greg k-h
