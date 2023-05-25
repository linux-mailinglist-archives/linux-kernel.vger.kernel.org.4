Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCD710B49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjEYLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbjEYLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71B1A8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99266451E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA18C433D2;
        Thu, 25 May 2023 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014946;
        bh=l9nq5SBnZuzxt+PrkHf7uCzl3M1koYayHH2SwJsx0Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czFIhOlwtPQnH9FxcSZXitx3n1y+63xcg/JzZ5nR67Tx+X4Fh+BkEkUKrarcX9E72
         7Oo6Ww/odnVlgLVyXbR1tm3sZwn08PsYXVkqzh7FesrbK5n+WjUOuEW7Qe5wzv/Epm
         sA5K7Hg6o8hYsyUFdlfGdXc3LH7Z3/JrtKgvqPnsEY0u2ubbjJUKwAtpkhEsFRElkE
         SPlQNmhR/95oQ5VZADaG9ViCGxBnQSUMkTMsKsfjz2tynFCP3UVwsTx8I4zrAkgOvx
         B43n0JhgBiwUWZaBU6Iw+RAIrQhym7hGWqMp3dU8N+tq5N9DkfnYfV9EbzmLr/0n1A
         AwlsEB9rhYw9w==
Date:   Thu, 25 May 2023 12:42:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/3] mfd: axp20x: Add support for AXP313a PMIC
Message-ID: <20230525114220.GH423913@google.com>
References: <20230524000012.15028-1-andre.przywara@arm.com>
 <20230524000012.15028-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524000012.15028-2-andre.przywara@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Andre Przywara wrote:

> From: Martin Botka <martin.botka@somainline.org>
> 
> The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
> an I2C bus.
> The name AXP1530 seems to appear as well, and this is what is used in
> the BSP driver. From all we know it's the same chip, just a different
> name. However we have only seen AXP313a chips in the wild, so go with
> this name.
> 
> Compared to the other AXP PMICs it's a rather simple affair: just three
> DCDC converters, three LDOs, and no battery charging support.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Aside from the various regulators, also describe the power key
> interrupts, and adjust the shutdown handler routine to use a different
> register than the other PMICs.
> Eventually advertise the device using the new compatible string.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 78 +++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h | 32 ++++++++++++++++
>  3 files changed, 111 insertions(+), 1 deletion(-)

Applied (pull-request pending - waiting on build tests).

-- 
Lee Jones [李琼斯]
