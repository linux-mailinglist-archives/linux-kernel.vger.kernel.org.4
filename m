Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DC6EA48E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDUHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDUHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A74E69;
        Fri, 21 Apr 2023 00:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D236A64E34;
        Fri, 21 Apr 2023 07:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D160C433EF;
        Fri, 21 Apr 2023 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682061566;
        bh=TwURzmdKdOLJrTJUjIHJtvNBCCXhpuGR1PKZmBeayak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAsx3wC65hjJPXgHVKdM+WY5xuKvVrv06hu+I6Reao6eQcDjZqm1x6fC/wV567ymA
         Hvv1rtpFBB6rGHNHrYkm37XoLqW5SwGo6p5eFzbOGT/aPKTmFtBMwd9lcxe+Akpt6r
         R1Rpae+lsJH6lSmVAAumg0NNU3QtPWz35pcGJvIfMSWzjTuPQ74VJVX/uOZ8AgKNcj
         O0GHDATEdxhNxmqOrAa0l7AdivbfaTIABJGdVEBRwbYbxwrsnb/bKwpEkaQ/EzKmbM
         uGxIlkQSVsu7OSMekz17Y2JYMepZ1YZv9lk5zvM9GckOgk8SOp3AOQXcdchCp+nCOj
         kLSduA3Vw6y+Q==
Date:   Fri, 21 Apr 2023 08:19:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5] leds: max597x: Add support for max597x
Message-ID: <20230421071921.GI996918@google.com>
References: <20230417094035.998965-1-Naresh.Solanki@9elements.com>
 <20230420115035.GE970483@google.com>
 <079eca63-54f5-7a4b-3b1c-e2515ceae9cc@9elements.com>
 <20230420135428.GD996918@google.com>
 <40b72025-16a8-1af5-d69f-659d37cdeab9@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40b72025-16a8-1af5-d69f-659d37cdeab9@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023, Naresh Solanki wrote:

> Hi Lee,
> 
> On 20-04-2023 07:24 pm, Lee Jones wrote:
> > On Thu, 20 Apr 2023, Naresh Solanki wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 20-04-2023 05:20 pm, Lee Jones wrote:
> > > > On Mon, 17 Apr 2023, Naresh Solanki wrote:
> > > > 
> > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > 
> > > > > max597x is hot swap controller with indicator LED support.
> > > > > This driver uses DT property to configure led during boot time &
> > > > > also provide the LED control in sysfs.
> > > > > 
> > > > > DTS example:
> > > > >       i2c {
> > > > >           #address-cells = <1>;
> > > > >           #size-cells = <0>;
> > > > >           regulator@3a {
> > > > >               compatible = "maxim,max5978";
> > > > >               reg = <0x3a>;
> > > > >               vss1-supply = <&p3v3>;
> > > > > 
> > > > >               regulators {
> > > > >                   sw0_ref_0: sw0 {
> > > > >                       shunt-resistor-micro-ohms = <12000>;
> > > > >                   };
> > > > >               };
> > > > > 
> > > > >               leds {
> > > > >                   #address-cells = <1>;
> > > > >                   #size-cells = <0>;
> > > > >                   led@0 {
> > > > >                       reg = <0>;
> > > > >                       label = "ssd0:green";
> > > > >                       default-state = "on";
> > > > >                   };
> > > > >                   led@1 {
> > > > >                       reg = <1>;
> > > > >                       label = "ssd1:green";
> > > > >                       default-state = "on";
> > > > >                   };
> > > > >               };
> > > > >           };
> > > > >       };
> > > > 
> > > > Where is the DT binding document for this?
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml?h=for-mfd-next

You need to update it.  It is different to the one you supplied here.

> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > ...
> > > > > Changes in V5:
> > > > > - Update commit message
> > > > > - Fix comments
> > > > > - Add necessary new line
> > > > > Changes in V4:
> > > > > - Remove unwanted preinitialise
> > > > > - Remove unneeded line breaks
> > > > > - Fix variable name to avoid confusion
> > > > > - Update module description to mention LED driver.
> > > > > Changes in V3:
> > > > > - Remove of_node_put as its handled by for loop
> > > > > - Print error if an LED fails to register.
> > > > > - Update driver name in Kconfig description
> > > > > - Remove unneeded variable assignment
> > > > > - Use devm_led_classdev_register to reget led
> > > > > Changes in V2:
> > > > > - Fix regmap update
> > > > > - Remove devm_kfree
> > > > > - Remove default-state
> > > > > - Add example dts in commit message
> > > > > - Fix whitespace in Kconfig
> > > > > - Fix comment
> > > > > ---
> > > > >    drivers/leds/Kconfig        |  11 ++++
> > > > >    drivers/leds/Makefile       |   1 +
> > > > >    drivers/leds/leds-max597x.c | 115 ++++++++++++++++++++++++++++++++++++
> > > > >    3 files changed, 127 insertions(+)
> > > > >    create mode 100644 drivers/leds/leds-max597x.c

[...]

> > > > +	led_node = of_get_child_by_name(np, "leds");
> > > > > +	if (!led_node)
> > > > > +		return -ENODEV;
> > 
> > It's odd for a device to be referring to itself as the "child".
> As this is leaf driver, LED specific info is present in "leds" node in DT.

I'm aware of the architecture.

If you give the LEDs driver it's own compatible you don't need to keep
doing this self->parent->child level-jumping craziness to obtain
resources.

-- 
Lee Jones [李琼斯]
