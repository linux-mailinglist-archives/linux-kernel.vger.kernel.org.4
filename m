Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE3674C75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjATFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjATFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:34:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9B6F30F;
        Thu, 19 Jan 2023 21:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39BEEB825EB;
        Thu, 19 Jan 2023 16:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801E7C433D2;
        Thu, 19 Jan 2023 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145821;
        bh=CTW9GEliJS5Gv0X4UM6xxF09SAs0ttdWxKfuhxwqGjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFs7DjxZIfNGTQhNrwMLwqpgwgZK+L0JC53xsxCa1UlYbn3pojyEzbkE/u7Outv9X
         RlRgKQXy9dvW2irapvqVTG3cPybYQKGoeIEWyJqHDUnOmg+Mkhkcb0opBkf46y9/i6
         UD419D5YvKHh71W7UNQa7zTWbqVsvzypEvJsJWq2qITYz2N2lxvCk2xx53Uzv5JZa3
         PfCmILc7upqfuDKzKjxVT50k9JOtXL3KJsSkuM1cDVVsFlX8qPWxuUkNPPy/FBc4i+
         +91KMGDjHbF/kkTun5MatyQMmcUn4ga1YRP4UyPYZ22TLT/N6hV6E9X6ft6rGoRCAA
         gcx3sr76g4QxQ==
Date:   Thu, 19 Jan 2023 16:30:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] mfd: syscon: allow reset control for syscon
 devices
Message-ID: <Y8lwGKzWqxfQfG0j@google.com>
References: <20230105005010.124948-1-jk@codeconstruct.com.au>
 <20230105005010.124948-3-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105005010.124948-3-jk@codeconstruct.com.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Jeremy Kerr wrote:

> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. Rather than requiring a custom driver to
> implement this, we can use the generic "resets" specifiers to link a
> reset line to the syscon.
> 
> This change adds an optional reset line to the syscon device
> description, and deasserts the reset if detected.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> v2:
>  * do reset control in the early of_syscon_register() path, rather than
>    the platform device init, which isn't used.
> v3:
>  * use a direct reset_control_deassert rather than handling in the
>    regmap
> v4:
>  * collapse unnecessary `else` block
> ---
>  drivers/mfd/syscon.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
