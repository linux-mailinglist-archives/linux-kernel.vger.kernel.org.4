Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A436D04EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC3MiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjC3MiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:38:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4D76A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C87B828A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39438C4339B;
        Thu, 30 Mar 2023 12:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680179878;
        bh=Rz5jdL0fwhPMzX2/0YZvGF07uAWfnZV5XYASum4cWDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouVSV8UuttOz1kMyM02GVxQp+MPWOiZv/BigqlwLlFWPwIp6eI3dN1EvtgKyPVzhP
         7i+CtTDFVveK0llw0fnotdJfWvvl4mTJLMexu/1l16HpRrhiEY4BnJu9HnMcOjNWx/
         AvsJK8Q3U36D62ey9kNQovmzKmdTDKtb2HlgXJI4dTmw7P7L0BK/rTwMVKO86G+km2
         cfyFKsqpnkHgIm5uqWEzm5CJH46EFqgQVV6EHHY3QPG71GrFVB/z/1G6AOEOZeVIV/
         OkwJiyaWv+/vXVuty54/mLbD7NZ+6K4VFVlW2jz7wyiqUJ6WL/7lau/qVWF405l41X
         rBXk+LgXcL1kg==
Date:   Thu, 30 Mar 2023 13:37:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v1 mfd] mfd: ocelot-spi: fix bulk read
Message-ID: <20230330123753.GI434339@google.com>
References: <20230322141130.2531256-1-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322141130.2531256-1-colin.foster@in-advantage.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Colin Foster wrote:

> Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) don't support bulk read
> operations over SPI.
>
> Many SPI buses have hardware that can optimize consecutive reads.
> Essentially an address is written to the chip, and if the SPI controller
> continues to toggle the clock, subsequent register values are reported.
> This can lead to significant optimizations, because the time between
> "address is written to the chip" and "chip starts to report data" can often
> take a fixed amount of time.
>
> When support for Ocelot chips were added in commit f3e893626abe ("mfd:
> ocelot: Add support for the vsc7512 chip via spi") it was believed that
> this optimization was supported. However it is not.
>
> Most register transactions with the Ocelot chips are not done in bulk, so
> this bug could go unnoticed. The one scenario where bulk register
> operations _are_ performed is when polling port statistics counters, which
> was added in commit d87b1c08f38a ("net: mscc: ocelot: use bulk reads for
> stats").
>
> Things get slightly more complicated here...
>
> A bug was introduced in commit d4c367650704 ("net: mscc: ocelot: keep
> ocelot_stat_layout by reg address, not offset") that broke the optimization
> of bulk reads. This means that when Ethernet support for the VSC7512 chip
> was added in commit 3d7316ac81ac ("net: dsa: ocelot: add external ocelot
> switch control") things were actually working "as expected".
>
> The bulk read opmtimization was discovered, and fixed in commit
> 6acc72a43eac ("net: mscc: ocelot: fix stats region batching") and the
> timing optimizations for SPI were noticed. A bulk read went from ~14ms to
> ~2ms. But this timing improvement came at the cost of every register
> reading zero due the fact that bulk reads don't work.
>
> The read timings increase back to 13-14ms, but that's a price worth paying
> in order to receive valid data. This is verified in a DSA setup (cpsw-new
> switch tied to port 0 on the VSC7512, after having been running overnight)
>
>      Rx Octets: 16222055 # Counters from CPSW switch
>      Tx Octets: 12034702
>      Net Octets: 28256757
>      p00_rx_octets: 12034702 # Counters from Ocelot switch
>      p00_rx_frames_below_65_octets: 0
>      p00_rx_frames_65_to_127_octets: 88188
>      p00_rx_frames_128_to_255_octets: 13
>      p00_rx_frames_256_to_511_octets: 0
>      p00_rx_frames_512_to_1023_octets: 0
>      p00_rx_frames_over_1526_octets: 3306
>      p00_tx_octets: 16222055
>
> Fixes: f3e893626abe ("mfd: ocelot: Add support for the vsc7512 chip via spi")
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  drivers/mfd/ocelot-spi.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
