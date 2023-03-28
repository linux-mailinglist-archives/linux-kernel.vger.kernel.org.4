Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEB6CBFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC1M7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC1M67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A2B773;
        Tue, 28 Mar 2023 05:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8CE361776;
        Tue, 28 Mar 2023 12:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC61C4339B;
        Tue, 28 Mar 2023 12:58:22 +0000 (UTC)
Message-ID: <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
Date:   Tue, 28 Mar 2023 22:58:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        Markus.Niebel@ew.tq-group.com, paul.elder@ideasonboard.com,
        gerg@kernel.org, linux-imx@nxp.com, devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        djakov@kernel.org, l.stach@pengutronix.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org> <2678294.mvXUDI8C0e@steina-w>
 <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
 <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
 <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 28/3/23 17:33, Marco Felsch wrote:
> Hi Greg,
> 
> On 23-03-27, Greg Ungerer wrote:
>> Hi Ahmad,
>>
>> On 27/3/23 17:16, Ahmad Fatoum wrote:
>>> On 27.03.23 08:27, Alexander Stein wrote:
>>>> Am Montag, 27. März 2023, 06:50:37 CEST schrieb Greg Ungerer:
>>>>> Any thoughts on why this breaks USB?
>>>>
>>>> Maybe you are missing CONFIG_INTERCONNECT_IMX8MP?
>>>
>>> And if that's the case, did you check /sys/kernel/debug/devices_deferred
>>> to see if there was any indication that this is the reason?
>>
>> Yeah, it does:
>>
>>      # cat /sys/kernel/debug/devices_deferred
>>      32f10100.usb	platform: supplier 32f10000.blk-ctrl not ready
>>      32f10108.usb	platform: supplier 32f10000.blk-ctrl not ready
>>      32ec0000.blk-ctrl	imx8m-blk-ctrl: failed to get noc entries
>>      381f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
>>      382f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
>>      imx-pgc-domain.11	
>>      imx-pgc-domain.12	
>>      imx-pgc-domain.13	
>>      38330000.blk-ctrl	platform: supplier imx-pgc-domain.11 not ready
>>      32f10000.blk-ctrl	imx8mp-blk-ctrl: failed to get noc entries
>>
>> As far as I can tell blk-ctrl should be good:
>>
>>      #
>>      # i.MX SoC drivers
>>      #
>>      CONFIG_IMX_GPCV2_PM_DOMAINS=y
>>      CONFIG_SOC_IMX8M=y
>>      # CONFIG_SOC_IMX9 is not set
>>      CONFIG_IMX8M_BLK_CTRL=y
>>      # end of i.MX SoC drivers
>>
>>
>>> If you didn't find any hint there, you might want to place a
>>> dev_err_probe with a suitable message at the place where -EPROBE_DEFER
>>> was returned.
>>
>> I will try that.
> 
> Can you check that CONFIG_ARM_IMX_BUS_DEVFREQ is enabled? This is the
> noc/interconnect driver. This could also the problem for you vpu issue.

I do not have that enabled. Enabling that fixes the USB probing.
So that is good, thanks.

It doesn't fix the other problem I mentioned with the vpu pgc nodes though.
I do get some extra messages now with this enabled and the 6.1 kernel:

     imx-pgc imx-pgc-domain.8: failed to command PGC
     imx-pgc imx-pgc-domain.8: failed to command PGC
     imx8m-blk-ctrl 38330000.blk-ctrl: deferred probe timeout, ignoring dependency
     imx8m-blk-ctrl 38330000.blk-ctrl: error -110: failed to attach power domain "g1"
     imx8m-blk-ctrl: probe of 38330000.blk-ctrl failed with error -110

Regards
Greg


