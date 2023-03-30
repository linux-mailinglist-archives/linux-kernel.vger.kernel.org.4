Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74C6D03A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjC3LoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjC3Lnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:43:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45345A5C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 519BFB81F8C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C80C433D2;
        Thu, 30 Mar 2023 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680176567;
        bh=/uRMfdpJp8Qn/GifrLkvProNn293X9vPqI+8k8b/SKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIS58kdDFZfAzWI6kIikV+S1j8wCtdHkgdYgIWjo5E1yf9bHNXx6YpjdiyCRLIfI0
         4nQb+TO9gEERafI3IzbtZD4/wbqBzfBI5/ZzUKcsLC3phPAO1I5pK/ZASLfoShUaTq
         Rd9x1qyTpoAiJagkO7vn8ozW7tNRHNU7T4aduhixXnHt+hHxoQHnyyeqXx8qGjZ7xN
         f95IBXGY0hiqdc0qjRfAB4Lq8SCJakt9SWGq7720mnlPoT8cqpMRModh/F0nowIPHX
         lKNvwkJ8IOe+zM5LcgFqHq0pKGWAjaFzKW3V5+5p9mgh+k+Fird6zw92YQt57w8456
         Zb98jxBTfaF/Q==
Date:   Thu, 30 Mar 2023 12:42:42 +0100
From:   Lee Jones <lee@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
Message-ID: <20230330114242.GC434339@google.com>
References: <20230320152319.665592-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320152319.665592-1-loic.poulain@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Loic Poulain wrote:

> Use of_io_request_and_map() instead of of_iomap() so that the
> region is reserved and protected, i.e reported in /proc/iomem
> and not accessible from user side (CONFIG_IO_STRICT_DEVMEM).
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index bdb2ce7ff03b..7e6d4edda118 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -60,7 +60,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		goto err_map;
>  	}
>
> -	base = of_iomap(np, 0);
> +	base = of_io_request_and_map(np, 0, NULL);
>  	if (!base) {
>  		ret = -ENOMEM;
>  		goto err_map;

Looks sane though.

Arnd, do you have an opinion?

--
Lee Jones [李琼斯]
