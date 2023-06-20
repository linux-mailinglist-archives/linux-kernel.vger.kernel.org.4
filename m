Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775657366C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjFTI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFTI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A65C2;
        Tue, 20 Jun 2023 01:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84E2A60F78;
        Tue, 20 Jun 2023 08:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DB1C433C9;
        Tue, 20 Jun 2023 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687251546;
        bh=Q76e9KS89JkCi6z+8bBTIgdM00Yu5UYDLIbWK9nqQPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6aKi3mthlK9NFT+ZqMLhFez1ZEp6G+H7Jp8AV9W/lFmmhergRz7pcpTe8jQFT2yR
         Y0PBzxyV8JCNKRkwXh7Sgsrkh941eFOS9njY9/pt6erg3VE0XdmNI6uEd4FaOo80Ge
         9L69BjrWaQ6ECE2nVSeS2WrShZh8YzFbVHuTTcf0CVXwaNeXDrMxYMP6qnW/jH6m4z
         xpiBG+CWPVRuEvHZTis8HNBliy6y4XKJeXkCG4kBQS5qG0+ugBlFfUdkYOsvZVoErQ
         t1GfkPM0rCQ4YOJD+QjyCnY7ASe/NMhVyR0C/T5qbh0Eo88sinBic0FyTOjyBXr8hF
         wY3DYmctOZe6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBXCc-0007YJ-Rr; Tue, 20 Jun 2023 10:59:06 +0200
Date:   Tue, 20 Jun 2023 10:59:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gnss: ubx: Use devm_regulator_get_enable_optional()
Message-ID: <ZJFqWuKgoQfH7PMP@hovoldconsulting.com>
References: <c398861197e9d5e28fa2420089abd9c3adb61a87.1686996063.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c398861197e9d5e28fa2420089abd9c3adb61a87.1686996063.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 12:01:22PM +0200, Christophe JAILLET wrote:
> Use devm_regulator_get_enable_optional() instead of hand writing it. It
> saves some line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
 
> -	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
> -	if (IS_ERR(data->v_bckp)) {
> -		ret = PTR_ERR(data->v_bckp);
> -		if (ret == -ENODEV)
> -			data->v_bckp = NULL;
> -		else
> -			goto err_free_gserial;
> -	}
> -
> -	if (data->v_bckp) {
> -		ret = regulator_enable(data->v_bckp);
> -		if (ret)
> -			goto err_free_gserial;
> -	}
> +	ret = devm_regulator_get_enable_optional(&serdev->dev, "v-bckp");
> +	if (ret)
> +		goto err_free_gserial;

Same here, this breaks the driver as -ENODEV is returned when the
optional resource is not present.

Johan
