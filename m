Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CEE674DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjATHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjATHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:11:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF38530D7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7037D61E2A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104FEC433D2;
        Fri, 20 Jan 2023 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674198675;
        bh=ruN1axoeesLkwpizVlQSezOYj0g97Z2CA0toTiAowkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4Nc3EDdT9+NsuR0dqwZmho96bwdIryMHGcPgkzRX8rIixs38DtpJk4qpO6NjNKQO
         AlCLw/1l8gFrahmjqQuMn8LM4NptHXP73DYwSfmWEiV5QhCKclRsShybPQ8qOE4JiM
         fT5x/wntGrk7AF3XD7hPLjKBqvi889HsIe1OwLu77/yrdpnD7T4FaD1R77gKiSoAIU
         iWS4fmY9DVjnqoi5oWzqW+MUPlGf4jPAw948oLkU0EzI0mAOQWXmmAW1Vn1u9im/BR
         nAFgFhKf3EkNE+vBF+vHXkzl1lgnMgVauTKYt1cbCca5GRoKZZiyGtKNpmO8BCUuox
         TQ9WCCRWN1VJQ==
Date:   Fri, 20 Jan 2023 12:41:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: Return NULL if the PHY is optional (part two)
Message-ID: <Y8o+j8lyyANpFSvz@matsya>
References: <663dfcec9f703c41759dcd4cd824d00caa2dd5fb.1674036031.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663dfcec9f703c41759dcd4cd824d00caa2dd5fb.1674036031.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-23, 11:02, Geert Uytterhoeven wrote:
> If we're trying to get a handle to an optional PHY, then the PHY
> framework being disabled shouldn't return a hard error.
> 
> Instead, return NULL just like phy_optional_get() does when there's no
> PHY provided in the DT.
> 
> Based on commit 11a6e41c0ee503ff ("phy: Return NULL if the phy is
> optional"), which did the same thing for devm_phy_optional_get().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> It seems there were never any in-tree users of this function since its
> introduction in 788a4d56ff378bff ("drivers: phy: Add support for
> optional phys") in v3.14.
> Perhaps it should be removed?

Ack, devm_phy_optional_get() is used by bunch of folks, but not this
one, so lets retire this

> ---
>  include/linux/phy/phy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b1413757fcc3b89b..559c3da515073697 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -429,7 +429,7 @@ static inline struct phy *phy_get(struct device *dev, const char *string)
>  static inline struct phy *phy_optional_get(struct device *dev,
>  					   const char *string)
>  {
> -	return ERR_PTR(-ENOSYS);
> +	return NULL;
>  }
>  
>  static inline struct phy *devm_phy_get(struct device *dev, const char *string)
> -- 
> 2.34.1

-- 
~Vinod
