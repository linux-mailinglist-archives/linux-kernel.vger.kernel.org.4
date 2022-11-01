Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E36154DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKAWTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF34193C6;
        Tue,  1 Nov 2022 15:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57EC60FAA;
        Tue,  1 Nov 2022 22:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22252C433C1;
        Tue,  1 Nov 2022 22:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667341184;
        bh=oRP7g+ZDDYszSibvvA5FgoFpJlVOf5XIE6A0JYpcsIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKTDDZFNmuD/A6cF+K+Y8uAFNlxKp7OfKIhGMYZ0Sm6lImu/HOdm/PlC1T5oqrhk5
         /2lr0EoCvbT5i7xhWPngLc9QyJviN+MSUo9LY561doPU5mF4yhtlpp9LTLFtJyTchL
         5W3RHNmncM3Z1RcUGEakEegnuxtxv41zz8FqJRIrt0RgVuxMObAWzyrotz0Rd/M3Bc
         QM5eAjNtcrHinEWbkzQoQv6cy0H4Qz7+S7qqgXzJ29eIccXyICTqAzWIEzhPPNTAAN
         kiIcXfMoNzcfS3JOJeCYbjzruc4+VITXaPfgjVpDekBee6aoSk2OFTZ/5eBtBQmvTg
         gmcgsC206ubtg==
Received: by pali.im (Postfix)
        id BF6167F8; Tue,  1 Nov 2022 23:19:41 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:19:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH 0/6] ARM: dts: pci-mvebu: Fix assigned-addresses for
 every PCIe Root Port
Message-ID: <20221101221941.ttrh3zgepqu6v2nn@pali>
References: <20220817223053.31141-1-pali@kernel.org>
 <20221009111529.2eo2mwca3ywfkajy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009111529.2eo2mwca3ywfkajy@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Sunday 09 October 2022 13:15:29 Pali Rohár wrote:
> Gregory, ping?
> 
> On Thursday 18 August 2022 00:30:47 Pali Rohár wrote:
> > Per IEEE Std 1275-1994 bindings documentation (to which kernel DT
> > bindings refers), DT property assigned-addresses contains BDF address
> > of resource. Currently more PCIe Root Port nodes have BDF address in
> > assigned-addresses which points to different PCIe Root Port nodes. This
> > obviously does not make sense as the address resource specified in
> > assigned-addresses of every PCIe Root Port describes address range of
> > internal registers which are specific for corresponding Marvell PCIe
> > Root Port. Fix this issue and align all BDF addresses in
> > assigned-addresses DT property to specify correct BDF address of the
> > current PCIe Root Port.
> > 
> > Note that current version of pci-mvebu.c controller driver, which
> > registers Marvell PCIe Root Ports, ignores BDF value in DT property
> > assigned-addresses. It expects that Root Port's assigned-addresses
> > contains address range of that root port. That is why driver currently
> > works without any issue and nobody spotted it. But if driver or
> > something else would do device tree validation then this issue should be
> > spotted and throws error. Also device tree files may be used by other
> > projects where drivers may require correct values.
> > 
> > This patch series aligns BDF address of every Marvell PCIe Root Port in
> > node name, config space in reg property and mem in assigned-address
> > property of internal registers resource.
> > 
> > Pali Rohár (6):
> >   ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
> >   ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root Port
> >   ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Port
> >   ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root Port
> >   ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root Port
> >   ARM: dts: armada-39x: Fix assigned-addresses for every PCIe Root Port
> > 
> >  arch/arm/boot/dts/armada-370.dtsi        |  2 +-
> >  arch/arm/boot/dts/armada-375.dtsi        |  2 +-
> >  arch/arm/boot/dts/armada-380.dtsi        |  4 ++--
> >  arch/arm/boot/dts/armada-385.dtsi        |  6 +++---
> >  arch/arm/boot/dts/armada-39x.dtsi        |  6 +++---
> >  arch/arm/boot/dts/armada-xp-mv78230.dtsi |  8 ++++----
> >  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 ++++++++--------
> >  arch/arm/boot/dts/dove.dtsi              |  2 +-
> >  8 files changed, 23 insertions(+), 23 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
