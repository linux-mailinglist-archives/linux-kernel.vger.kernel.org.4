Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6C6281E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiKNODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiKNODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:03:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F92B60A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:03:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319E2611AD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D14AC433D6;
        Mon, 14 Nov 2022 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434586;
        bh=ZQFKFIqIqP3t6Xzc4YPRbr4vAQmSmgIvh8UjHkOiHMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/GNe/Y9M+dpo3wX6AvTwWNpVVaZRCMe4iLLhI7VfWfRlgv8NNFSHSi0kPq97ze78
         aw3QxaSl1VeIDYGxpCJbq+LRjOLMM85DbFyWuQYCNQ12kSGrc+cEiSKJ9MitOdxpgt
         hSzZG7AyvzhAPld5kAhJuLOwO185Udu7UEKEhKSMO54bH6eapSe05Z0t9zeXKHq2iv
         mQgGqZ7/s0zcQSXU9YlCu02FvdupLHzpisDSZuJUL9UzmOVUFTKZOSwOGjFY2NYGh9
         Tmo5KpghqCCnOHNuUuA79Vc3ZPdPlhOQRUrj+EmPzs4S+BjJTHMSOMnfWMdfnQ0mCK
         AHGF6FEpgwG9A==
Date:   Mon, 14 Nov 2022 14:02:58 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 05/18] mfd: max14577: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3JKkmd9FRnwTg91@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-6-aidanmacdonald.0x0@gmail.com>
 <03b94d20-05a6-71fb-61e4-00889f5aa64d@linaro.org>
 <KGy5eAsJh4YwYjYVTvnohmym61EBqJX5@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KGy5eAsJh4YwYjYVTvnohmym61EBqJX5@localhost>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022, Aidan MacDonald wrote:

> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
> > On 12/11/2022 16:18, Aidan MacDonald wrote:
> >> Remove use of the deprecated mask_invert flag. Inverted mask
> >> registers (where a '1' bit enables an IRQ) can be described more
> >> directly as an unmask register.
> >>
> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> >> ---
> >>  drivers/mfd/max14577.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > Mention this is a resend or provide a changelog for v2.
> 
> Most of these patches are resends, but they're so trivial it seems
> pointless to mention that fact. There are no changes from v1.

How are people supposed to know the difference between "no change"
and "there have been lots of changes, but I forgot to add a
change-log"? :)

Nothing wrong with:

v1 -> v2:
  No code changes

> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Best regards,
> > Krzysztof

-- 
Lee Jones [李琼斯]
