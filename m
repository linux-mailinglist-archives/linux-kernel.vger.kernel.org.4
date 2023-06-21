Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43B737A97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFUFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUFXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7519810E6;
        Tue, 20 Jun 2023 22:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DAF161418;
        Wed, 21 Jun 2023 05:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B5C433C0;
        Wed, 21 Jun 2023 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687325003;
        bh=D+a2fIP+FvcRNUy0gwO96/Y9cbIf48GeaSC+CFwrUpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HisZojYCZBzljKy0VjOa+EoQ1/I7zC99q8ha39jZkpNiVLIZ/Gnu5bX2g7g+mnxzL
         lsya92qHek4tX0OagUd/qAOAFVEWfQK0/QZEWE7UzUHSnyMkrutYysrsu4LNrqw+CW
         IepQp421GjTNwMMbq7eNgM6XZbXC4P/k5kGrubUvvtvrUaN9QFTjBomATLpxwwJR6A
         JMN+UQ3dSlYBtmHIZQ7BogzhP0MpHXwE7dLPWXx9u0pN+OY28+Tq1KozNljJCn1MHT
         SH3OeXTYe+1zf83ICvzJT7Vs8dPCHeSdDS1DFIYwS43+F2vsbV/3O2gG7Q+58bCKYU
         WaDBsHlWj94VA==
Date:   Wed, 21 Jun 2023 10:53:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
        quic_mohs@quicinc.com
Subject: Re: [PATCH v3] ALSA: compress: allow setting codec params after next
 track
Message-ID: <ZJKJRnMuYvy7GrsD@matsya>
References: <20230619092805.21649-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619092805.21649-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-23, 10:28, Srinivas Kandagatla wrote:
> For gapless playback it is possible that each track can have different
> codec profile with same decoder, for example we have WMA album,
> we may have different tracks as WMA v9, WMA v10 and so on
> 
> Or if DSP's like QDSP have abililty to switch decoders on single stream
> for each track, then this call could be used to set new codec parameters.
> 
> Existing code does not allow to change this profile while doing gapless
> playback.
> 
> Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
> some additional checks to enforce proper state machine.
> 
> With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
> anytime after setting next track and additional check in write should
> also ensure that params are set before writing new data.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
