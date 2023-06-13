Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2A72ED37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjFMUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFMUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACCFB8;
        Tue, 13 Jun 2023 13:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D344617CE;
        Tue, 13 Jun 2023 20:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CAC433C8;
        Tue, 13 Jun 2023 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688827;
        bh=Z8QA9l2t6x+zzVdOzXUbwg8TddQFuNQ3qjSjveRGaP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2n2S3PgON714b2FFpHJWKBiNaKAYAU+06BfFOkqXb1McnAM4rfdaGgbARtf7lP9G
         pAyyhC1oPxg4aPN1BHxI8Kvg4tYwW1u1yOmV0nn7XKZfgrQX5n84qBJ73tP7Ohw/cn
         RMkQafwrgkwYUNANIJD/3Rq1ZrDR4rlpzPcc7RI0MBlf2vMI0xG7iG4irseuLQwMoZ
         vgxC9X2HCJ3e1/7AqZGulZLMS33tBOeH6zFiZRz3Hkgb00tXznq391+FeuX1LfqKso
         iSYBknpvalI78sNM08nA5quUMz5fo5gtlfZAAvMbeWU3qZpH4V+Pez9nyrjEUWQp6d
         otWnU+TxFjIcg==
Date:   Tue, 13 Jun 2023 22:40:24 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Johannes Roith <johannes@gnu-linux.rocks>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] hid-mcp2200 added driver for MCP2200 GPIOs
Message-ID: <20230613204024.zdp45ofohdur462p@intel.intel>
References: <20230611144831.41238-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611144831.41238-1-johannes@gnu-linux.rocks>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joannes,

[...]

> +/* this executes the READ_ALL cmd */
> +static int mcp_cmd_read_all(struct mcp2200 *mcp)
> +{
> +	struct mcp_read_all *read_all;
> +	int len, t;
> +
> +	reinit_completion(&mcp->wait_in_report);
> +	mutex_lock(&mcp->lock);
> +
> +	read_all = kzalloc(sizeof(struct mcp_read_all), GFP_KERNEL);
> +	if (!read_all)
> +		return -ENOMEM;

where are you unlocking?

> +	read_all->cmd = READ_ALL;
> +	len = hid_hw_output_report(mcp->hdev, (u8 *) read_all,
> +			sizeof(struct mcp_read_all));
> +
> +	if (len != sizeof(struct mcp_read_all))
> +		return -EINVAL;

what about read_all? what about the lock?
> +
> +	kfree(read_all);
> +	mutex_unlock(&mcp->lock);
> +	t = wait_for_completion_timeout(&mcp->wait_in_report, msecs_to_jiffies(4000));
> +	if (!t)
> +		return -ETIMEDOUT;
> +
> +	/* return status, negative value if wrong response was received */
> +	return mcp->status;
> +}

[...]

Andi
