Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757F36D1CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjCaJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjCaJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B29DBE3;
        Fri, 31 Mar 2023 02:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972B9B82DB2;
        Fri, 31 Mar 2023 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A814C4339C;
        Fri, 31 Mar 2023 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680255501;
        bh=wCW2noNuh0ReKGztv3/AKEg47Svuyjqs8pGPxwn+w2Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pecHnj1Qc5+sC3C5/aKm6jooywGKncaEHDGoQb+HDVWflF/N2q4NWnp8gAaCQvIZ2
         AoJye49a/XYVqoX+O0F5dFUaSyhK5rfk9VRkuFZVUskwpdu/Kdye5sq2GRbcMY12gW
         9lyA/DnFmP0976OL3FvqwhovOROTco7hmorcqPewRItJYwudmHyMjqxOrjpQtNVovy
         R3Er+FzAL2raHAjHe6wb//Me95rfMMKrXfy4AO+TTTxyNJvrHj5dHwGtoXnvvUQzFc
         zBX2ogFHXBpCYRvE/jvjqQElXnPVJuE0oEUyJBh6Mq7Wtg2NF5J30a6jgc7yskTc66
         dyfb6087YvRYQ==
Message-ID: <2e2390ca-7c36-7290-fd62-392c83e1a7fc@kernel.org>
Date:   Fri, 31 Mar 2023 11:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] clk: imx: imx93: Add nic and A55 clk
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
 <20230331064629.2475338-6-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230331064629.2475338-6-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 08:46, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The A55 clock logic as below:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

>      A55_PLL ----------------->\
>                                 A55_SEL-->A55_CORE
>      A55_CCM_ROOT--->A55_GATE->/
> 
> Add A55 CPU clk to support freq change.
> Add NIC CLK to reflect the clk status
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c             | 17 +++++++++++++++--
>  include/dt-bindings/clock/imx93-clock.h |  6 +++++-

NAK.

Bindings are always separate patches.

Best regards,
Krzysztof

