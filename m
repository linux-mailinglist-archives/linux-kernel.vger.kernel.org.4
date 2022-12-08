Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D86470A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLHNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLHNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:17:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1BC2A969
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:17:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AADB61F1D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B64BC433D7;
        Thu,  8 Dec 2022 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670505477;
        bh=v1AMqLkYh7fKICo7N8T2Hn8qWxCuvv9yWp5eOf/ObEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UycRB4/6G28HcMycky9G1W5e0c3IvNPlsbZgdBOx5xAuLu73sIFPpAsEBMEe/3igg
         jti72o0Adr7o2oB6qmn8d9vlOe5KQBo8zCtrsth8jdUdFQvCI0///yGuR78x8H+MCO
         5vaNtQsY8vMEBPa2Cbg3wdVbddnAa9j1FlF20x8V9tRIXsXHaV1trWUINlDxIt82IA
         nsEzMqYE+tNu0S/x0Ay8ypdPJFrx6veijEbV5zVD1oi6Al5jbRTbnCM9ZBZMunk+Oe
         avKiBBMZhqfXsxnOu3NNVeJYvSaDDEkK29oAk2AqSWM245agrx9N6mu8wgCI68lbam
         ccaRMAI5b5Pcg==
Date:   Thu, 8 Dec 2022 13:16:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] mfd: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <Y5HjkaWNF5/nTVTQ@google.com>
References: <20221122154134.58a7a18b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122154134.58a7a18b@endymion.delvare>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, Jean Delvare wrote:

> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> As a minor optimization, this also lets us drop of_match_ptr(), as we
> now know what it will resolve to, we might as well save cpp some work.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: "Jonathan Neuschäfer" <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/Kconfig          |   16 ++++++++--------
>  drivers/mfd/motorola-cpcap.c |    2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
