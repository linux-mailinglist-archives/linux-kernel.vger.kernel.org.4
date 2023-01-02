Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF09665B806
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjABXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:04:59 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E225FE;
        Mon,  2 Jan 2023 15:04:53 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 353B485248;
        Tue,  3 Jan 2023 00:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672700691;
        bh=Dt6Bn0ykiFiQ6yaIgtrTmcFZQMlrk4/kuZ5biJWYY24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sPT1S+LOuwcrE5khvePPYkCHbXHyD/Dd/c9XFWVSqxYqwvV0sTp2Xov6uU3bUNkev
         SxVqxMs/wTpOQrbWP0EPMz5zGFT4harnLB2PKUbZFyr0jXZmL86x7VykMHHk9tQzhu
         DgXyenpdp7iyfOcEGN3JxRRy5HxtPncIGJmhLl3PU6ktHCdtkloFRFEuN9uaUUCZXB
         wgEbTc3lO+NVbF343PZTpJUZ78rPq7DyrQLGWf6JqUufsdHqxVrXY3EVaXpW6hgTCi
         nib/3u7QQF6grxr1hg64+kt3qcdCMYkjL/yOVCRV5RtveK9xAA3VPGi07lzBYbysdS
         dRTfdBWnkVUkg==
Message-ID: <73979439-2e41-c4ea-02e0-d382f7ae1459@denx.de>
Date:   Tue, 3 Jan 2023 00:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v2 00/11] clk: imx8mn: setup clocks from the device
 tree
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/23 18:57, Dario Binacchi wrote:
> The idea for this series was born back from Dublin (ELCE 2022) after
> having attended the talk entitled "Updating and Modernizing Clock
> Drivers" held by Chen-Yu Tsai and the availability of a board with
> imx8mn SOC.
> 
> This series aims to setup all imx8mn's clocks from the device tree and
> remove the legacy setup code with hardwired parameters.
> 
> I am well aware that the series lacks patches for the DT bindings. The
> effort up to this point has been important and so I thought I'd ask for
> feedback from the community before proceeding to implement them. If it
> is positive I will add the DT binding patches starting from version 2.
> 
> The series has been tested on the BSH SystemMaster (SMM) S2 board:
> https://www.apertis.org/reference_hardware/imx8mn_bsh_smm_s2pro_setup

I might be wrong, but I vaguely recall AT91 (?) had this kind of massive 
clock tree description in DT and they then switched to much simpler 
clock description where the clock topology is encoded in the driver 
instead (like what iMX does right now). It might be worth having a look 
at that and the reasoning around that conversion.
