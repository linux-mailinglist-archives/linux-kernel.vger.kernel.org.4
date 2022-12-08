Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281064710F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLHNxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLHNxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:53:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6313837214
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:53:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3FDD61F23
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E9C433C1;
        Thu,  8 Dec 2022 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670507629;
        bh=UFQfRk1vno7SOJWjl9cbkzX7RqM//nccHk5UmmdBsRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2RYVV7mpy7vFXjesp3hKa50RyAYHP6xR6F/NCvGl/FGqULl0p6i2rTwvIcjAwsOP
         5mOYkZ5TjnrzZVQw3qvL+nXNfEgc/g1lXsBBGX5FjGUIbWSF2r3fmGBUbkP7Nooa5z
         y3tHxBmTLtF4F1KVpS6NcqtBL5yC3qSziMChs6NSw7up0v5hMTbxxNdK3/7PCkVu+4
         VT4/VvtU4e6CtMogRye0IpRanYbfmfGXy5tu8bnTJigNJYFOUuNLuabP0ckoLqhX98
         A3ONv+/bKRMdIsH69z9JfvaTt7BPhKLf384A6yhHX17SrQF1JTNZ2pIpI50jGNg5aU
         Ju7098aDnZ1iQ==
Date:   Thu, 8 Dec 2022 13:53:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rohm-bd*: Use dev_err_probe()
Message-ID: <Y5HsV41KCSEmWSNV@google.com>
References: <Y33lte0PKd2u6dyR@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y33lte0PKd2u6dyR@fedora>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022, Matti Vaittinen wrote:

> The dev_err_probe() has (at least) following benefits over dev_err()
> when printing an error print for a failed function call at a device
> driver probe:
> 	- Omit error level print if error is 'EPRBE_DEFER'
> 	- Standardized print format for returned error
> 	- return the error value allowing shortening calls like:
> 
> 	if (ret) {
> 		dev_err(...);
> 		return ret;
> 	}
> 
> 	to
> 
> 	if (ret)
> 		return dev_err_probe(...);
> 
> Convert the ROHM BD71828, ROHM BD718x7 and ROHM BD9576 core drivers to
> use the dev_err_probe() when returned error is not hard-coded constant.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/mfd/rohm-bd71828.c | 23 ++++++++++-------------
>  drivers/mfd/rohm-bd718x7.c | 21 ++++++++-------------
>  drivers/mfd/rohm-bd9576.c  | 17 ++++++++---------
>  3 files changed, 26 insertions(+), 35 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
