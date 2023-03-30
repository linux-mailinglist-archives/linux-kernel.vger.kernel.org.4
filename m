Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0476D0A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjC3QFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjC3QFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AA900D;
        Thu, 30 Mar 2023 09:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4644662110;
        Thu, 30 Mar 2023 16:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26820C433D2;
        Thu, 30 Mar 2023 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680192316;
        bh=viaViRHbOUE2fhuaH9npts1s3lqVVfNzJID7p/qGxNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6OZfS5Z2VvyJAEylOF2nv/gh9VcA5FP+BQRkidlgpB/DisvueL3Sd/6WTynINVHl
         +n7axNxIfrchWxNOAnb1Ej6EVtw4BaFq0Sdnqmopp1uO5TBTiiqE+l7OeYcJJCkxrr
         MDCQUrjfXukhfzXX+LeDpypxjeMOUAs/lPFCBJ93hmMbD2L13rdvW2zawmYSLP5OQ6
         wOdrM08QFaR3WJPoVfXxiUSLOVZO2b1ELtzeVPh+Y0bFea+2RQg6QIHuriF0h5WAME
         61J3oK4B7sxLfoeMZIy9ssFDi3CEgSEnWEwN859ZDCv+fxpHc4SarvuLZZa1suYQVW
         P36jrUUrMRJBQ==
Date:   Thu, 30 Mar 2023 17:05:10 +0100
From:   Lee Jones <lee@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230330160510.GB489249@google.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
 <20230328092645.634375-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328092645.634375-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023, Herve Codina wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.

My goodness!

It's been a long time since I've seen anything quite like this.

My suggestion to you:

* Split this up into components that fit functional subsystems
* Run checkpatch.pl
* Remove all of the debug prints
* Move all of the defines out to a header file
* Be more verbose in your documentation / comments
* Consider using simple-mfd to probe child devices.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/mfd/Kconfig         |   17 +
>  drivers/mfd/Makefile        |    1 +
>  drivers/mfd/pef2256.c       | 1355 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/pef2256.h |   28 +
>  4 files changed, 1401 insertions(+)
>  create mode 100644 drivers/mfd/pef2256.c
>  create mode 100644 include/linux/mfd/pef2256.h

--
Lee Jones [李琼斯]
