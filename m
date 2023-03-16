Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4E6BD623
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCPQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCPQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F914223;
        Thu, 16 Mar 2023 09:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1634762071;
        Thu, 16 Mar 2023 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64545C433D2;
        Thu, 16 Mar 2023 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678985074;
        bh=yfx4iiucYGIUOEIaNe/Ybg77Apth21Lr71vscJTJmnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XE+bKJewW8yN3Sbjp9vsvxlMkgKiA8UP1lu/rPOiFJ1ot1S+Q5yW+RbWxgLqS9wm+
         oHaimwJphGUcJWzgf+b6ZkqmG1cR7KMDqSlTBl6MTP45jrs++dITnej253R+MM+cop
         ixw+FWVouml+2bMnyrdHP2UIF8Wvmir55NMp/0AFhyuzdvFDf7y8+15zccnl/m4RDp
         Qhaex5OPg7QDaKQPhoa9qY/HRjAGq4SE9puythuzkoU2wL3pbuqejsH9Mia3g0Gqzr
         2ltD9oQZ6k9veA1kjuVvKix09uz/C25If9nm6++t87qSRZ8mfSYcEMFoUmEkydWski
         YMoyEV+N0QMIQ==
Date:   Thu, 16 Mar 2023 16:44:28 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Message-ID: <20230316164428.GY9667@google.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023, Arnd Bergmann wrote:

> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
> > +	mem: memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
> > +	};
> > +};
>
> In most machines, the memory size is detected by the boot loader
> and filled in the dtb in memory before starting the kernel, so
> you should not need two separate files here for the two common
> memory configurations.
>
> Since the machine is called 'som', I would assume that this is a
> module that is integrated on another board, so more commonly one
> would have a dtsi file for the som in addition to the one for the
> soc, and have all the components of the module listed in this
> file, while the dts file that includes the som.dtsi lists the
> devices on the carrier board and enables the on-chip devices
> that are connected to the outside.

It's using syscon and simple-mfd by the looks of it.

--
Lee Jones [李琼斯]
