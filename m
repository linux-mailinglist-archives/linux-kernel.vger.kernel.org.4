Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F33627C66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiKNLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiKNLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:32:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BB266D;
        Mon, 14 Nov 2022 03:32:35 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFE45660231C;
        Mon, 14 Nov 2022 11:32:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668425554;
        bh=Seg+J/REXMKHgoEGjmRDEeF/wX05uAJ/2q6GwLx9/5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gq1gpDLBjMXZfYvpTd0gyUQfbajVu/iFeHkeX6M/FyrXIvYKdOs086toHnmY1QDUC
         IoEjHd+Lc8GbngCu7gNgs+m3N9qbBSi3yu9jZJQHq4IjccSSNAld09GtyWjRnxPjce
         SqD/2IJt6n7Fq9960THjFNITuJK5mvs7BhWGEDweEpABZBgNpw8gEp7B79G+rRpjn6
         axHVSkWJOfxo+O1eEOghgrUotReG/aBdVhPte3KcdsPog2nOiP5WdimGv68VsojVQn
         jq74Z8C3UnEm2L74Q/qI1aJ9LA8gZSCHe1dqh9OVNNVbz+Kj8+DyEM7THmXZrhVWv4
         x56A0pUw/aqmQ==
Message-ID: <081238de-77cd-5d95-abba-8f2f3117506e@collabora.com>
Date:   Mon, 14 Nov 2022 12:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] spi: spi-mtk-nor: Optimize timeout for dma read
Content-Language: en-US
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221114081327.25750-1-bayi.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221114081327.25750-1-bayi.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/11/22 09:13, Bayi Cheng ha scritto:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The timeout value of the current dma read is unreasonable. For example,
> If the spi flash clock is 26Mhz, It will takes about 1.3ms to read a
> 4KB data in spi mode. But the actual measurement exceeds 50s when a
> dma read timeout is encountered.
> 
> In order to be more accurately, It is necessary to use usecs_to_jiffies,
> After modification, the measured timeout value is about 130ms.
> 
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


