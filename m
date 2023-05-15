Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C2703165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbjEOPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbjEOPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F422139;
        Mon, 15 May 2023 08:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 984C86232F;
        Mon, 15 May 2023 15:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC257C4339B;
        Mon, 15 May 2023 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163989;
        bh=+9CdGMrVSR4XNVZr7m66okVDKTErq2sdbihqtqeXtqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bkk70pAupN616UTiABdQmSL8eEnURH2Zpy/aQe6912TLAn+hJvs+DKPRMlio3TBQL
         ewNxx4nBF2/BpfIciJVkojY6qxCmcmRUkQtlYNBnDShs5ZGRqItsOQl0kkUJ5BrhcA
         wXRcpFi448WCHlpdBL7HnqHaTAG3Y1ZkfIZBW45BlR1IlN6Bz4vAFgioX9Y48APNPp
         SiMCXyfzoSLaq1escDa7ZCvs3Xqu2NzLkJHAFngaJUw3GE27A4MoTc27E9UWHaFjL0
         hIljqf+eW8caVSqcNlAp/kqcNxiYcRKirDdfK1UgkgXO3ZMjRBA008FijGsXyDjwRI
         2qiUfcSQhEwGw==
Date:   Mon, 15 May 2023 16:19:42 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 06/14] mfd: rk8xx-i2c: use device_get_match_data
Message-ID: <20230515151942.GR10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Sebastian Reichel wrote:

> Simplify the device identification logic by supplying the relevant
> information via of_match_data. This also removes the dev_info()
> printing the chip version, since that's supplied by the match data
> now.
> 
> Due to lack of hardware this change is compile-tested only.
> 
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk8xx-core.c |  2 -
>  drivers/mfd/rk8xx-i2c.c  | 89 +++++++++++++++++-----------------------
>  2 files changed, 37 insertions(+), 54 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
