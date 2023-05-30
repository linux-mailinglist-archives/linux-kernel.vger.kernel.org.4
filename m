Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDA7156D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjE3HdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjE3Hc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0FFA;
        Tue, 30 May 2023 00:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F57626F8;
        Tue, 30 May 2023 07:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45893C4339B;
        Tue, 30 May 2023 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685431917;
        bh=Y1cumOGcWbCEjzGUG/6ltidpNwm2fGZvgprc96SngPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8/7KG6l2rkllhSgyEtiXGCrBc6eUT8eUgS0m2nBBCUg0sr3L4VZjm6Wb1MIE0pW1
         94RjH6yRTYBlur75IuOyzDDzDCSV6f+bshblivkTI9jRaM8f23z5lHIMoXVtpTX0U1
         NPxzO36wDBKvi8ah0F5w1V7SXOe3qJEHmZ2e4tvo=
Date:   Tue, 30 May 2023 08:31:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ray Chi <raychi@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0/3.0 PHY
Message-ID: <2023053041-cane-jokester-d433@gregkh>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-2-stanley_chang@realtek.com>
 <2023052915-repurpose-partner-20a8@gregkh>
 <1dfa6d4026364fb99eeffa548cda0cfc@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dfa6d4026364fb99eeffa548cda0cfc@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:50:51AM +0000, Stanley Chang[昌育德] wrote:
> Hi Greg,
> 
> > On Thu, May 25, 2023 at 10:26:03AM +0800, Stanley Chang wrote:
> > > Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> > > 2.0/3.0 controller. Added two drivers to drive the  USB 2.0/3.0 PHY
> > transceivers.
> > > For USB 3.0 transceivers, a driver phy-rtk-usb3 is provided.
> > > The driver phy-rtk-usb2 is used to support USB 2.0 transceivers.
> > >
> > > Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The kernel test robot did not report that a new driver was needed :(
> > 
> 
> This report is based on v1 patch.
> https://patchwork.kernel.org/project/linux-usb/patch/20230519045825.28369-2-stanley_chang@realtek.com/
> 
> The original driver is at drivers/usb/phy/
> If this report is not appropriate, I will remove it.

Does it make sense to include it?
