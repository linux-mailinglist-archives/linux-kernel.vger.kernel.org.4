Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1072B412
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjFKU7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjFKU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:59:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E512DA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xgrV+DpWEP3Ve/Iojzz4GtYaWVfM89pjp0bSBvIBopA=; b=whVFZs5c3PL3p5Sw+UR08gFwuc
        K2AV08sbh24NHEDBH9DEczZ4JM1rjKFaBAAEy58bw8oG6lAkJlBpEbE7Zv1QQQY9ZcBNBIyTdhXe7
        FRxWA0+OXIY15WRvNjfThULSMhCH9Qd10cFRP5/qu2rU2zC+kYTZ5alQuU30pmvWCFj/TsX6UCknL
        DMXA5ysqWNQlP4I2LEL0pT62UrkCuNndMi47ndGzrObOTaq0hsBfjSAYidkRRAPELDLK5iN/8xqV2
        CibnZ8Grzb9zE3fWw5Lz120FKsK/QaeZuxQZQY0i5RViy3lEO7M9oTcAJAh0z7QLljkSfyaJqNbeX
        XGo7krCg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8S9s-001l1d-0R;
        Sun, 11 Jun 2023 20:59:32 +0000
Message-ID: <fc94fa7f-2e73-7b9f-ea4c-2c5dffcbf844@infradead.org>
Date:   Sun, 11 Jun 2023 13:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mux: mmio: depend on REGMAP as the code has that
 dependency
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
 <20230210115625.GA30942@pengutronix.de>
 <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
 <946cea0c-6d7f-c2e3-4412-4967ece40b94@axentia.se>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <946cea0c-6d7f-c2e3-4412-4967ece40b94@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/24/23 05:52, Peter Rosin wrote:
> If CONFIG_REGMAP is not active, the build errors out like this:
> 
> ../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
> ../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
>    76 |                 struct reg_field field;
>       |                                  ^~~~~
> In file included from ../include/linux/bits.h:21,
>                  from ../include/linux/bitops.h:6,
>                  from ../drivers/mux/mmio.c:8:
> ../include/linux/bits.h:23:28: error: first argument to ‘__builtin_choose_expr’ not a constant
>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>       |                            ^~~~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:16:62: note: in definition of macro ‘BUILD_BUG_ON_ZERO’
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                              ^
> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |          ^~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>       |                             ^~~~~~~
> ../include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                   ^
> ../include/linux/bits.h:23:10: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>       |          ^~~~~~~~~~~~~~~~~
> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |          ^~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>       |                             ^~~~~~~
> ../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
>   102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
>    76 |                 struct reg_field field;
>       |                                  ^~~~~
> 
> REGMAP is normally "selected", but that causes a recursive dependency.
> But since REGMAP is "depended on" in other places, do so here as well.
> The (implicit) REGMAP dependency was lost when the strict dependency
> on MFD_SYSCON was removed.
> 
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based multiplexer")
> Link: https://lore.kernel.org/lkml/64cf625b-2495-2382-0331-519d1cab0adf@infradead.org/
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> Note, there is a patch in linux-next that removes "|| COMPILE_TEST" from the
> pre-existing depends.
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 80f015cf6e54..7f07ca06eb2b 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -48,6 +48,7 @@ config MUX_GPIO
>  config MUX_MMIO
>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>  	depends on OF
> +	depends on REGMAP

REGMAP is mostly selected, not depended on, so preferably

	select REGMAP

here whenever this patch is ready to be merged.

>  	help
>  	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
>  

thanks.
-- 
~Randy
