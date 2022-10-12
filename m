Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227B85FBF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJLC2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLC2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200EA6C22;
        Tue, 11 Oct 2022 19:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABAD2B818D3;
        Wed, 12 Oct 2022 02:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6C6C433C1;
        Wed, 12 Oct 2022 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665541696;
        bh=vw6gsGbne+1unyAJpVc3ZFwZjNHdqONWQBeoeJEwRRU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mPwolRD+51ZSJoDRF3c1ERe0UbqjCI0K+FcYQKPKJ2ohIHPSXIF43c91DnJ5SxZrp
         LsfXuIOWqvp/mSgtYJ0pcMW3dvgvvrW5HPVqwkoEep9SUvwMjFrBhBTsD8xZQuVj0w
         Jzca21Wjk/8F+bjXRLFt+p8Myv1/rCQl0Klmbf2uBFUTqWVguCPsRYDFFVZ5uKn0kM
         JGfNhH4a8uXVq4KdDcnY7FiAWoNa8r2XmgYvNoL5sW6AtFDPzskstDk8nOpxhogQta
         2yWr7UwAoYDkrflDapyNk202V94wI1jFLXL5Jz9bC32RqvYSlfRIiQfmQf2kZaDFOz
         7OEl0jkMVBPHg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221008051534.151392-1-wangkefeng.wang@huawei.com>
References: <20221008051534.151392-1-wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] clk: at91: fix the build with binutils 2.27
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-clk@vger.kernel.org
Date:   Tue, 11 Oct 2022 19:28:14 -0700
User-Agent: alot/0.10
Message-Id: <20221012022816.5E6C6C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kefeng Wang (2022-10-07 22:15:34)
> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> index 3484309b59bf..4fc387d0335d 100644
> --- a/include/linux/clk/at91_pmc.h
> +++ b/include/linux/clk/at91_pmc.h
> @@ -12,6 +12,8 @@
>  #ifndef AT91_PMC_H
>  #define AT91_PMC_H
> =20
> +#include <vdso/bits.h>

Can we just include linux/bits.h instead? It looks weird to include
vdso/ outside of the kernel's vdso.

> +
>  #define AT91_PMC_V1            (1)                     /* PMC version 1 =
*/
>  #define AT91_PMC_V2            (2)                     /* PMC version 2 =
[SAM9X60] */
>
