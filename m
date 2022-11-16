Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053D62C705
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKPR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiKPR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:58:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44561BBF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:58:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21CEBB81E4B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CDEC433C1;
        Wed, 16 Nov 2022 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621527;
        bh=+X4h0tnXqsCDnjUgkpHcRbNmv3eV5BVXgFlXwVHOACk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9O3Q1Pu5tf8kAo/z7rhbgHurKNAvB9rPham3YBNRIV2Q7Yn+nroURujrgh8QqZI5
         cTYv87NfiSzKkF07GnEueWbfBw5PyHeNbBV7k8II/k6f8RFIghcvVKSX8u22d4Ufr+
         8iDZF3Bg7fX2KaJaWUxeGR2EoQm9fDS+iynFnhmVOCvdFaAoZkIoTaIjdt4UcQsACI
         1bjD4HBrNEDBPgbeYkwRlAZwy0m4mOZuBvEguNxzDkaRUkIG5TubiTZCiSeaLh10om
         1DXDjiZOBooDWsh/q5sJdz4+XgpWMF/qI/CSLxhpja3VP1XO33UsUodn8HBTz8ryde
         vAr2xUqOFPuAg==
Date:   Wed, 16 Nov 2022 17:58:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 15/18] mfd: stpmic1: Fix swapped mask/unmask in irq chip
Message-ID: <Y3Uk0eNhZBsfx6wn@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-16-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-16-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Aidan MacDonald wrote:

> The usual behavior of mask registers is writing a '1' bit to
> disable (mask) an interrupt; similarly, writing a '1' bit to
> an unmask register enables (unmasks) an interrupt.
> 
> Due to a longstanding issue in regmap-irq, mask and unmask
> registers were inverted when both kinds of registers were
> present on the same chip, ie. regmap-irq actually wrote '1's
> to the mask register to enable an IRQ and '1's to the unmask
> register to disable an IRQ.
> 
> This was fixed by commit e8ffb12e7f06 ("regmap-irq: Fix
> inverted handling of unmask registers") but the fix is opt-in
> via mask_unmask_non_inverted = true because it requires manual
> changes for each affected driver. The new behavior will become
> the default once all drivers have been updated.
> 
> The STPMIC1 has a normal mask register with separate set and
> clear registers. The driver intends to use the set & clear
> registers with regmap-irq and has compensated for regmap-irq's
> inverted behavior, and should currently be working properly.
> Thus, swap mask_base and unmask_base, and opt in to the new
> non-inverted behavior.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/stpmic1.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
