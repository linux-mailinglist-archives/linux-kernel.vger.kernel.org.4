Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299C5FBE34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJKXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJKXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:13:36 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F59E0EC;
        Tue, 11 Oct 2022 16:13:28 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 706FF84DB7;
        Wed, 12 Oct 2022 01:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665530005;
        bh=l+dlg0AQEU9Qd30nOIVb+gtSSQPQJSUwCrZ7VHzam6Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nWBnCuXLlXu1DwS9AKbkWVVkSy39PRAiDXtGzcpF+x0Eh86mx3PtUAv6byce79P3f
         w7bq5RVntAuB4Ibz/XaX0qH9Akm6ik0oNcM7uqrS+fn2YraUhxppHZVcfYYLxx/5jR
         321TvSd7YMwGZgYGrLM2uC8KdqmUZbapiXdxYdeGDg1PrNSaAPoex0jANd4Njdrc03
         Ihr6cxz84jF1AAFtheiautbmTFgpSKB2cSV6yWb1DgPJDl6UP0G8BR5VF4SDPcBU6I
         8Dh+K4ddBuHabP4XpxPReqYIxoX3YT8fdyuTXzMxCVgad0IBX6rMkhET7BbUpXmhW7
         JvkK9ToBKfdjA==
Message-ID: <ec599991-44da-7b83-9374-d0043b32f053@denx.de>
Date:   Wed, 12 Oct 2022 01:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
To:     Tim Harvey <tharvey@gateworks.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        Markus.Niebel@ew.tq-group.com, aford173@gmail.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
 <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 22:10, Tim Harvey wrote:
> On Fri, Jul 8, 2022 at 1:57 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V4:
>>   Because the header is not included when adding NoC node, the fsl,imx8mp.h
>>   needs be included in this patchset. So include it in patch 6
>>
>> V3:
>>   Move adding NoC node patch to i.MX8MP ICC driver patchset
>>   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
>>
>> V2:
>>   Use a low bandwidth value instead INT_MAX
>>   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
>>   Add A-b tag from DT maintainer
>>
>> i.MX8MP NoC settings is invalid after related power domain up. So
>> need to set valid values after power domain up.
>>
>> This patchset is to bind interconnect for each entry in blk ctrl.
>>
>> This patchset is not include DVFS DDRC feature.
>>
>> Peng Fan (7):
>>    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
>>      ctrl
>>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
>>      ctrl
>>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
>>      ctrl
>>    soc: imx: add icc paths for i.MX8MP media blk ctrl
>>    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
>>    arm64: dts: imx8mp: add interconnects for media blk ctrl
>>    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
>>
>>   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
>>   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
>>   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
>>   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
>>   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
>>   6 files changed, 125 insertions(+)
>>
>> --
>> 2.25.1
>>
> 
> Hi Peng,
> 
> I built origin/master from commit 041bc24d867a today for an imx8mp
> board and am running into errors that appear to be introduced by this
> series:
> [   15.177372] platform 381f0040.usb-phy: deferred probe pending
> [   15.183155] platform 382f0040.usb-phy: deferred probe pending
> [   15.188928] platform 33800000.pcie: deferred probe pending
> [   15.194439] platform 32ec0000.blk-ctrl: deferred probe pending
> [   15.200287] platform 38330000.blk-ctrl: deferred probe pending
> [   15.206129] platform 32f10000.blk-ctrl: deferred probe pending
> [   15.211974] platform 32f10100.usb: deferred probe pending
> [   15.217382] platform 32f10108.usb: deferred probe pending
> [   15.222791] platform cpufreq-dt: deferred probe pending
> # cat /sys/kernel/debug/devices_deferred
> 381f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> 382f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> 33800000.pcie   platform: supplier 32f10000.blk-ctrl not ready
> 32ec0000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> 38330000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> 32f10000.blk-ctrl       imx8mp-blk-ctrl: failed to get noc entries
> 32f10100.usb    platform: supplier 32f10000.blk-ctrl not ready
> 32f10108.usb    platform: supplier 32f10000.blk-ctrl not ready
> cpufreq-dt
> 
> Is there a driver I'm perhaps missing that is needed now or are there
> some patches that come from a different unmerged tree needed?

Do you have these enabled ?

CONFIG_INTERCONNECT_IMX8MM=y
CONFIG_INTERCONNECT_IMX8MN=y
CONFIG_INTERCONNECT_IMX8MQ=y
CONFIG_INTERCONNECT_IMX8MP=y
