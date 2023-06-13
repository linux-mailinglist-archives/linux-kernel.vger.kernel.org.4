Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E188B72ED4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFMUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFMUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D90810CB;
        Tue, 13 Jun 2023 13:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B84F61766;
        Tue, 13 Jun 2023 20:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9549C433C0;
        Tue, 13 Jun 2023 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689339;
        bh=LZ97z1+GXSKxEYwgCKzZ2M26Iq4Z4fYmY+AtBbPX4jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egSlXNlxxAKAQanOSQh+hPBzHCaBVRvixNxVcK2PJLzPdac6XjuvJiFqmo1PbHKZJ
         Ep97EhFKsafUAwSTb8qqUCtG9te6TFq9SWAHJowvncUZsHKulS4eASY3NMq0/PWXZB
         7UMWhPcj+ugQbMihh7minnDiwKgznugCS5mPCwN8PqtwXFOXC4NvaM+6rmlvpurxL9
         jVgPZJwHl/CiQgsMqft2H2PA0ZCia8a6C8Ebi+na/1ui3DfqJlclh32at2veSCA+o0
         nK7ZJczVXDZ6SuAUsMNq9rHKMbNYb4llkARuZQKa0mjnaunkw1W4ecGEtKKMBkWpQK
         Qf+m3EQ9dn6Bg==
Date:   Tue, 13 Jun 2023 22:48:55 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Marge Yang <marge.yang@tw.synaptics.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.chiu@tw.synaptics.com,
        derek.cheng@tw.synaptics.com, sam.tsai@synaptics.com,
        vincent.huang@tw.synaptics.com
Subject: Re: [PATCH V2] Input: synaptics-rmi4- Add a new feature for Forepad.
Message-ID: <20230613204855.bm4wxneamkd76heq@intel.intel>
References: <20230612022607.315149-1-marge.yang@tw.synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612022607.315149-1-marge.yang@tw.synaptics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marge,

[...]

> +static irqreturn_t rmi_f21_attention(int irq, void *ctx)
> +{
> +	struct rmi_function *fn = ctx;
> +	struct f21_data *f21 = dev_get_drvdata(&fn->dev);
> +	int error;
> +
> +	error = rmi_read_block(fn->rmi_dev,
> +				fn->fd.data_base_addr+RMI_F21_FORCE_CLICK_OFFSET,
> +				f21->data_regs, 1);
> +	if (error) {
> +		dev_err(&fn->dev,
> +			"%s: Failed to read f21 data registers: %d\n",
> +			__func__, error);
> +		return IRQ_RETVAL(error);
> +	}
> +
> +	if (!!(f21->data_regs[0] & RMI_f21_FORCE_CLICK))

no need for double negation here.

Andi

> +		input_report_key(f21->input, f21->key_code, true);
> +	else
> +		input_report_key(f21->input, f21->key_code, false);
> +	return IRQ_HANDLED;
> +}
