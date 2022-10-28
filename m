Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BF6106EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiJ1AlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiJ1AlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A034E60A;
        Thu, 27 Oct 2022 17:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EEA66255E;
        Fri, 28 Oct 2022 00:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88078C433C1;
        Fri, 28 Oct 2022 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666917672;
        bh=ppmtY7LtsXtOE0Tu82bTFljW5h5jmKFRbXlzY6mSSRc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fZwa0wu8kngOAvkpJDLYXMhLu2VlibkjLd8PW71+I1VY+PPr5SdTypeHyFBYCQ2aL
         P/T8l5y5i/Kim4Xpx6pA/kGwPEXRLJEUIrOwo1SIMTTJW6I8ZIRomnbyB4QeFTXLAK
         D8pNnNY2QANF42lGMg4pahbiiouh2l4Ywlm+pUXoH4L78bZJYkuJBxIiKo55sUsqsj
         Q2lWbt9ise5/+HC96aekxB5dd0tGYi99Z8AgWjOTP1q89KAFXprll0pOFsUdTNht8a
         9cWSE4H6d6Qeu3oEZwvOy9phDNkPdxr/B8dnvkjDe9VUlttIjaVsX8GafAwCJ+llBL
         iitQ4/aIws+Ew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221017164646.4193618-1-dario.binacchi@amarulasolutions.com>
References: <20221017164646.4193618-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] clk: ti: mux: don't free `parent_names' on kzalloc() failure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 17:41:09 -0700
User-Agent: alot/0.10
Message-Id: <20221028004112.88078C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-10-17 09:46:46)
> Although no operation is performed by kfree() on a NULL pointer, it's
> however suboptimal and semantically wrong doing it.

Passing NULL to kfree() is fine. This is trying to optimize an error
path as well. No thanks.
