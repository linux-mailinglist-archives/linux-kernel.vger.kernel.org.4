Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A735A6878BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjBBJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjBBJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:25:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD670991;
        Thu,  2 Feb 2023 01:24:48 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A2206602EEE;
        Thu,  2 Feb 2023 09:24:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675329887;
        bh=GGlzxb9dTf55nUdjrZGMa6zqJ7/7TKIvIYIgKU9Rb5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZvUxkYeBF/qxbq81L6/3HDd//AT9Uxt1am7QMf3e6V6d6Zcehjp97kxk6TdFefmvs
         B/c7D5eSdLngjBXHt8ZTlcQ4Qo51U298924xUKKrfkr6YVOvFNRW20cDK7EKzurQ7h
         577xNPkTq9IDMrcUbs1UW3HV0mM7Z7R0RWVXPgJvxMPPaipdbKWZLA2ONEK6X+0D1/
         0HOW5dXK7THS/ynnnJhv3QV93UCJMc0w5fVCUJmhdNJdJDCpndr23ZEb8TtM891Nr3
         /3AeMYnjYskyIIlXcpP1yr2LqD2hMBAZVC18KVbnGsQWA21hAWw55R12nxpseI2otn
         tVTp/5FdigjGw==
Message-ID: <6fd35f0b-60ed-36ed-45bf-62346c0e220e@collabora.com>
Date:   Thu, 2 Feb 2023 10:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] nvmem: add generic driver for devices with MMIO
 access
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230201064717.18410-1-zajec5@gmail.com>
 <20230201064717.18410-3-zajec5@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230201064717.18410-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/23 07:47, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With nvmem layouts in place we should now work on plain content access
> NVMEM drivers (e.g. MMIO one). Actual NVMEM content handling should go
> to layout drivers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

I agree but if you want to really bring on this change, you should add
some kind of write support... and clocks... and regulators with different
voltage levels (write/fuse-blow voltage, read voltage if any)...

Describing this entire thing in device-tree should be possible, but then
some SoCs may need a specific register sequence in order to enter writing
mode, which is something that you can't just put in devicetree, so this
driver should be a framework on its own - hence not as simple as proposed.

Regards,
Angelo
