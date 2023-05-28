Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775A713A3B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjE1O4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1O4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27C9B;
        Sun, 28 May 2023 07:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9947560D2E;
        Sun, 28 May 2023 14:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8421C433D2;
        Sun, 28 May 2023 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685285797;
        bh=dYRUdw6cd80d3tuK/aTvNjJCPgSv66gl3Tan1xRID+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ozKYerTIdU290Z5Ru5InZuObVJvZ7SRayUrYO6E1jm9GIjlKx3UL9+UkVSR2HwPkT
         PV2nBCOF0IxrDlwqVWNPBRFsmHFVbpBo5jt+zl46YKbuaxCkA+hcnzAZJ/BJMgZNEZ
         /iyhprd7ImIz+xH69Up6SKvCtRjuMo447Mz8DZmvpfr9DEIzJfzOBruUkXUNSGjFnC
         aR9+7VzVF2F6VE1PBRHddvYZmCXoszln5131uQjS4D0AfAsVDw0FMygMpsU2tEU4uA
         gMlndYp1VsE//TbFheeT+c7/cT52tKYKwcYVLld5bpe1dSCAUbbsmxnAdpwLropBic
         beBWU9vY3JUfQ==
Date:   Sun, 28 May 2023 16:12:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     George Stark <gnstark@sberdevices.ru>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch
 channel 7 mux
Message-ID: <20230528161255.216fee6f@jic23-huawei>
In-Reply-To: <ZHMzGHsGEylDdgg7@smile.fi.intel.com>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
        <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
        <ZHMzGHsGEylDdgg7@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 13:55:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, May 28, 2023 at 01:46:37PM +0300, Andy Shevchenko wrote:
> > On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:  
> 
> ...
> 
> > > +static const char * const chan7_vol[] = {
> > > +	"gnd",
> > > +	"vdd/4",
> > > +	"vdd/2",
> > > +	"vdd*3/4",
> > > +	"vdd",
> > > +	"ch7_input",
> > > +};  
> 
> One more thing to discuss (Jonathan, what's your opinion?) I think the
> following easier to understand and has less problematic characters in the names
> (in case of sysfs direct use from shelll):

I suspect no one would use these particulary inputs directly from the shell,
but agreed that avoiding / where not absolutely necessary is a good idea.

Jonathan
> 
> static const char * const chan7_vol[] = {
> 	"gnd", // alternatively GND
> 	"0.25vdd", // alternatively 0.25_vdd, 0.25Vdd, 0.25_Vdd
> 	"0.5vdd",
> 	"0.75vdd",
> 	"vdd", // Vdd
> 	"ch7_input",
> };
> 
> That said, my personal preference:
> 
> static const char * const chan7_vol[] = {
> 	"GND",
> 	"0.25Vdd",
> 	"0.5Vdd",
> 	"0.75Vdd",
> 	"Vdd",
> 	"ch7_input",
> };
> 

