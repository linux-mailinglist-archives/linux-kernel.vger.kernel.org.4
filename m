Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A76D3F48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjDCIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjDCIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:43:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D79729A;
        Mon,  3 Apr 2023 01:43:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF6866600357;
        Mon,  3 Apr 2023 09:43:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680511421;
        bh=rbDlcT8qTYcqq8cEMegnVryZ0bTQ1eDdWF0iSr9Dkw4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zia9iO5HAIZ9wnzF2QEAAEnv9ZofTGPxQVph7sr5q5o+66Tke5K5C24xQRFodznf/
         LCTIYaW8mFw5ccNLk/SRJZLLtQafF2ty0mHXFvWn8l5Vq5GWyHXGjtLmtosOaB6trj
         UU/T6nov2MwpfzMioLWMD0F4UbX1L1lAqUpSKlXnxhyIm2uIPad1f6W7ziv/ZKK3Ua
         Ltcg3yyBvDoKGnWVixfqWob9qkcoegB/5zpDq+Uey3ZD/3FOzDYp1grZdRV3QXP9T+
         Eo5GZbJ4CcP7quw+jaAhezkUE6yKk16bKeYHqELV0sYsV3RcLG6O1gcsUUVo4vFDMM
         VuHsg8qMHFW5w==
Message-ID: <98a774d3-ade4-72a8-1c6a-3712d596682a@collabora.com>
Date:   Mon, 3 Apr 2023 10:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: linux-next: build failure after merge of the mediatek tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230403175220.5b946b60@canb.auug.org.au>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403175220.5b946b60@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 09:52, Stephen Rothwell ha scritto:
> Hi all,
> 
> After merging the mediatek tree, today's linux-next build (arm64
> defconfig) failed like this:
> 
> Error: arch/arm64/boot/dts/mediatek/mt6795.dtsi:647.21-22 syntax error
> FATAL ERROR: Unable to parse input tree
> 
> Maybe caused by commit
> 
>    a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks")
> 
> but I don't know how.
> 
> I have reverted that commit (and the following 2) for today.
> 

Matthias, this issue happens because you didn't apply 07/17 [1] from the
6795/xperia-m5 series...

[1]: 
https://lore.kernel.org/all/20230327083647.22017-8-angelogioacchino.delregno@collabora.com/

That contains the mediatek,mt6795-gce.h header that has the definitions used in
a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks")
....and this is the reason of the syntax error.

Does this commit have to go through devicetree trees?
I'm adding Krzysztof and Rob to the loop for this.

Regards,
Angelo
