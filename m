Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CDA646F86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLHMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7127060A;
        Thu,  8 Dec 2022 04:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3D3961EEC;
        Thu,  8 Dec 2022 12:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AE3C433D7;
        Thu,  8 Dec 2022 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670502239;
        bh=A8xhLuEbo8yuIcWIHqJJ3U5345cbtdIGtchmgXpObHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCn7WJhNLKv20YUQZ78+OWrAuzPL2Cadb+nUtOVCH5+FGkknzuYnLBr1njxsc5jyB
         uNz1y7tiO6IgkaGGYoik1bQv4a4+sk76TXvzXY+M3LrpnAIWMt/B5f8JMV/yvF7d9J
         iKrXbed0djgjRI6dgQ84D+/fkhx0oeZ5cxXaafjaeBPzKzmG2BcqAcM1uDo99gWXrM
         8qgpDG/h9cCByOiUhr0an/AWaD0LNzWMloCKjqPPMbeGU5w6+s/A0airYlnyWioZtp
         x+WnkQ+q787eVrRpmqMD8HGVr7shck6gskuE1r+Je+QtkN9xyc3MFbhA9s03xy/OeL
         Xw5AG3E2PVSUw==
Date:   Thu, 8 Dec 2022 12:23:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <Y5HXWk4d5J9VgFBV@google.com>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
 <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Naresh Solanki wrote:

> 
> 
> On 17-11-2022 03:45 pm, Lee Jones wrote:
> > On Wed, 16 Nov 2022, Naresh Solanki wrote:
> > 
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > 
> > > Implement a regulator driver with IRQ support for fault management.
> > > Written against documentation [1] and [2] and tested on real hardware.
> > > 
> > > Every channel has its own regulator supplies nammed 'vss1-supply' and
> > > 'vss2-supply'. The regulator supply is used to determine the output
> > > voltage, as the smart switch provides no output regulation.
> > > The driver requires the 'shunt-resistor-micro-ohms' property to be
> > > present in Device Tree to properly calculate current related
> > > values.
> > > 
> > > Datasheet links:
> > > 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> > > 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> > > 
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > >   drivers/mfd/Kconfig         |  12 +++++
> > >   drivers/mfd/Makefile        |   1 +
> > >   drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 207 insertions(+)
> > >   create mode 100644 drivers/mfd/max597x.c
> > >   create mode 100644 include/linux/mfd/max597x.h
> > 
> > Ignoring my comments won't make them go away. :)
> > 
> > Please tell me why you need a whole new driver, instead of adding
> > support to simple-mfd-i2c?
> > 
> I felt current implementation to be simpler, clearer & straight forward.

If you can make it work with simple-mfd-i2c, please do so.

No need to submit an entirely new driver for these simple use-cases.

-- 
Lee Jones [李琼斯]
