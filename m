Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5FB6EA4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDUHdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDUHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AFE9034;
        Fri, 21 Apr 2023 00:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A2364E64;
        Fri, 21 Apr 2023 07:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E43C433D2;
        Fri, 21 Apr 2023 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682062340;
        bh=LupbggItcXQ6NTf6z/Xh7ZMsrzDnQEBz/D9rsNfGSjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxONRrLNwqSTkCtReNhTdhpbB3QudDltcy6Y6L0XpsG32u92bept0TvbEuFIwjo0J
         U3EzNmEBiOF+tieHoaeeeU9JuQx1+DG3lMwQTtkZDJXqG2pcvpnmu4ET4XOaLV2eji
         o85qocDsfjDpOrtnWC+2gnxKDZXJttqamGIUxjjxtrF4KIRotMm+T9fKwLkS8TvGAa
         /JCyJXr67opDXdKH/WP3P0JNBMhyP/ZnKCNK/yWtsACCF6K+nm+J7FjtXcykzbrrrk
         TcNcm6Z/DRH4TJng1nnwazQ/Xw7Vjrwjt6lH2f8jW9mqwswKl0xnEJRMscJ//jPvaN
         t6pSOdBqAucFw==
Date:   Fri, 21 Apr 2023 08:32:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 0/3] regulator: Add X-Powers AXP313a PMIC support
Message-ID: <20230421073214.GN996918@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230401001850.4988-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Apr 2023, Andre Przywara wrote:

> This patch series adds support for the X-Powers AXP313a PMIC, which is
> often bundled with Allwinner H616 or H313 SoCs.
> It's my turn again for this revision of the series, after Martin did
> v7 and v8.
> After some more significant changes in v9, this is fixing some nits,
> and builds on Krzysztof's patch to simplify the DT binding document
> (patch ID at the end of this email). For a complete changelog see below.
> 
> Up to v5 this was speaking of the AXP1530, which seems to be some internal
> name. The chips we have seen in the wild are all labeled AXP313a, so we
> go with this name here, from now on. This is supported by the fact that
> there is an AXP313a datasheet, but none for the AXP1530.
> 
> Patch 1 is the binding documentation (just the new compatible string),
> patch 2 adds the MFD bits (mostly describing the extent of the regmap),
> while patch 3 describes the actual AXP313a register definitions.
> Since this ties neatly into the existing AXP and generic regulator
> framework, the patches are indeed only structure definitions, there is
> little new code.
> 
> For now we papered over this "fixed customizable" RTC-LDO regulator in the
> same way this was done before for other PMICs (AXP803, for instance), We
> think we can fix this properly with a follow-up patch, for all instances.

MFD patches applied.  PR for Mark to follow.

-- 
Lee Jones [李琼斯]
