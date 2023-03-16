Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A958D6BD1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCPOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCPOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0F5A6EB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD08C62055
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C289C4339B;
        Thu, 16 Mar 2023 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678975218;
        bh=Wy1YeU4Af6um5zbVszQJjl+XU9CoAoiu+iC89zqovxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AH6V5kal2tNK0IhcyV56/hE3Ea8JdlcaBa3dmgi7O8JFjIoBGW7Cn7OMPu8eNlkWL
         3x4zp7/FYjbY8BZ4ZHIQfPiFGolvC6KgQKl9TyMo3v+fO88Td1qk9yTEBnPdjFvlgS
         hxuB+qkmREKaPYS2QRKc/NHHNda98U7uEy8kza8mh+mqCKJNFMexwo7t0Rg4Jo9B5U
         XZ54levmdwA24t35HaaA/LhfNpC7D8/ERWKw+9aOrF3ijkUXLhqxsAOe393mIOX6Xd
         4f9oxjiuDC6vtNl+0J3VhoifwfWrogR5MSsu/n/etZw1D+txwVwi22NjEc9QOojuVR
         oh1ir86FtVVSw==
Date:   Thu, 16 Mar 2023 14:00:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/3] mfd: da9062: Remove IRQ requirement
Message-ID: <20230316140013.GE9667@google.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-2-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309092254.56279-2-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Christoph Niedermaier wrote:

> This patch removes the requirement for an IRQ, because for the core
> functionality IRQ isn't needed. So this makes the DA9061/62 chip
> usable for designs which haven't connected the IRQ pin.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rebase on current next 20230209
>     - Add Lee Jones to Cc list
> V3: - Rebase on current next 20230307
>     - Use macro MFD_CELL_OF
>     - Refactoring the code for use without IRQ
> V4: - Rebase on current next 20230309
>     - Add Acked-by tag
> ---
>  drivers/mfd/da9062-core.c | 84 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 29 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
