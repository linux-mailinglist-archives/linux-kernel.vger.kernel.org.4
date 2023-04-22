Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0B6EBA97
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDVRNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5331A2114;
        Sat, 22 Apr 2023 10:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD4560E9B;
        Sat, 22 Apr 2023 17:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6153C433EF;
        Sat, 22 Apr 2023 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682183577;
        bh=dq2mWH2zsRT78Bh1KU9LpxGEzixDbvMmHZ0wzOfn++w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DA4/hLPyUXDRXZ3vSrh40L+CoA3JsasBezpy1VUg5TjyBPR5ViCWGQK3dPW8QaP99
         r284UrX7cHhv3nwy9eB5Hf1Cb/zu0YvIKTo52O1KHh7TRLqg9DouCTbEgmTHC6LhWP
         fMb8XMwwAhn1wBnRIK86ixAHR83/xmEA3NtETN7Ptj/IwyD6HRiIn9qLqk6IVJAyGm
         +2VjXYAguZc4p7yitfckEVyqrGM6e4Scyf5n5T3s9Lmya3OlxofUesuJohW0InnQ7f
         MCLMHnvgj7G1eT2QolYSfChljQm4qLlX/lttK2gUPddRHSPg5glZke30sIr4+Zwf/A
         wzaG2oJg/Vt3w==
Date:   Sat, 22 Apr 2023 18:28:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: accel: kionix-kx022a: Warn on failed
 matches and assume compatibility
Message-ID: <20230422182833.7fbf6aae@jic23-huawei>
In-Reply-To: <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
        <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 22:22:02 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Avoid error returns on a failure to match and instead just warn with
> assumption that we have a correct dt-binding telling us that
> some new device with a different ID is backwards compatible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - no changes, this patch is introduced in the v2
> 
>  drivers/iio/accel/kionix-kx022a.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f98393d74666..70530005cad3 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -1038,9 +1038,7 @@ int kx022a_probe_internal(struct device *dev)
>  		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>  
>  	if (chip_id != KX022A_ID) {
> -		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> -		return -EINVAL;
> -	}
> +		dev_warn(dev, "unsupported device 0x%x\n", chip_id);

Try building this ;)  You have remove the closing bracket but kept the opening
one.

Jonathan

>  
>  	irq = fwnode_irq_get_byname(fwnode, "INT1");
>  	if (irq > 0) {

