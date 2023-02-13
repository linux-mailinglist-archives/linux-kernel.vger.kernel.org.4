Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEE86949A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjBMPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjBMPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:00:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE291CAF2;
        Mon, 13 Feb 2023 07:00:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1349F66020A2;
        Mon, 13 Feb 2023 14:59:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676300369;
        bh=MVAAR+POGKgxUb9d/9L16cYTpx1kxwtwfwvhi78kve4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WfDy+2PvvZncwh76LKqnlhWbyBXLB8Aj0DGQn8/I2T7JJbv4hydXkytVzZIRjS0s0
         5wMGlHlF7scmNvxTGni8GoKxk8u8NXxZz4UEKaHKt3bqOfHXJrT9zJrrodkTMBf+YN
         U2t4bQpwEuyzSvP4GbrFQ21vtJaKzTRcUX6Z5K4X0vJOltNLO6k5wO8oZZ6o0PgGCi
         z29jfvXwDpgHtVBHIQqc3TJ9HBEXfz6HC73LP9Tpw3l/jWhKD+xi4ZKQ+J7hHP3lrE
         NIcohd1cRtBVuWmzz1+40KhpsA5i/eauFOCE3nEIpUf/cg64D4GJb+yiZD6pXczTz4
         wN+bs3fJbGoTA==
Message-ID: <32a41b0f-48e2-a87b-9736-1e10fe8859d9@collabora.com>
Date:   Mon, 13 Feb 2023 15:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 09/12] remoteproc: mediatek: Setup MT8195 SCP core 1
 SRAM offset
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
 <20230213033758.16681-10-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230213033758.16681-10-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/23 04:37, Tinghan Shen ha scritto:
> Because MT8195 SCP core 0 and core 1 both boot from head of SRAM and
> have the same viewpoint of SRAM, SCP has a "core 1 SRAM offset"
> configuration to control the access destination of SCP core 1 to boot
> core 1 from different SRAM location.
> 
> The "core 1 SRAM offset" configuration is composed by a range
> and an offset. It works like a simple memory mapped mechanism.
> When SCP core 1 accesses a SRAM address located in the range,
> the SCP bus adds the configured offset to the address to
> shift the physical destination address on SCP SRAM. This shifting is
> transparent to the software running on SCP core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


