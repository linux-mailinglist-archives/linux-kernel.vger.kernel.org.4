Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F424619BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiKDPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiKDPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD8F2E6AA;
        Fri,  4 Nov 2022 08:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDEA62269;
        Fri,  4 Nov 2022 15:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C8BC433D7;
        Fri,  4 Nov 2022 15:31:10 +0000 (UTC)
Message-ID: <74f2c9cc-4856-4985-5b37-13ee20411b32@xs4all.nl>
Date:   Fri, 4 Nov 2022 16:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 00/11] media: cedrus: Format handling improvements and
 10-bit HEVC support
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On 02/11/2022 19:07, Jernej Skrabec wrote:
> While my first intention was to just add 10-bit HEVC handling, I noticed
> a few format handling issues and a bit of redundancy in some cases. Final
> result is that driver now sticks to stateless decoder rules better.
> 
> Format handling improvements:
> 1. Default format selection is now based on HW capabilities. Before, MPEG2
>    was hardcoded but some Cedrus variants don't actually support it.
> 2. Controls are registered only if related codec is supported by HW.
> 3. Untiled output format is preferred, if supported, over tiled one. All
>    display engine cores support untiled format, but only first generation
>    supports tiled one.
> 
> I hope this makes Cedrus eligible for destaging.
> 
> Best regards,
> Jernej
> 
> Changes from v1:
> - collected acks, except for patch 5, which was changed
> - use cedrus_is_capable() for cedrus_find_format() too (patch 4)
> - tightly pack control pointers in ctx->ctrls[] (patch 5)
> 
> Jernej Skrabec (11):
>   media: cedrus: remove superfluous call
>   media: cedrus: Add format reset helpers
>   media: cedrus: use helper to set default formats
>   media: cedrus: Add helper for checking capabilities
>   media: cedrus: Filter controls based on capability
>   media: cedrus: set codec ops immediately
>   media: cedrus: Remove cedrus_codec enum
>   media: cedrus: prefer untiled capture format
>   media: cedrus: initialize controls a bit later

I'm going to merge the first 9 patches, but leave out the last
two. It's weird what happens there, and I think those two need a
bit more work.

Regards,

	Hans

>   media: cedrus: Adjust buffer size based on control values
>   media: cedrus: h265: Support decoding 10-bit frames
> 
>  drivers/staging/media/sunxi/cedrus/cedrus.c   | 102 +++++----
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  22 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |   4 +-
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  |   2 +-
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  |  37 +++-
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    |  18 +-
>  .../staging/media/sunxi/cedrus/cedrus_hw.h    |   2 +-
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |   2 +-
>  .../staging/media/sunxi/cedrus/cedrus_regs.h  |  16 ++
>  .../staging/media/sunxi/cedrus/cedrus_video.c | 200 ++++++++++--------
>  .../staging/media/sunxi/cedrus/cedrus_video.h |   2 +
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   |   2 +-
>  12 files changed, 244 insertions(+), 165 deletions(-)
> 
> --
> 2.38.1
> 

