Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D161629D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKBMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKBMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:21:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C129CB3;
        Wed,  2 Nov 2022 05:21:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CD616602946;
        Wed,  2 Nov 2022 12:21:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667391714;
        bh=GWrRwN7bo6fjXnGPMvnQdgStYumrjcHBQAPPOaH9oHo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TFEcV7yYRYT7iW5wv1LhRrmo+Xj1fG3UlLNU1htU2Ve/t57kVotd9+jk1QcLJGJYv
         21LoV00Gq5lKqyIfGkihnXbvJeetV2KzpagoJZy+0j2xVYVswmw4ZP11SVNSezlslk
         LO0tMXIilWpkTiDtfVRLaKghaC2ISJubVKOrE1v2CyEOd1ZrfsdNyZ8qgOvGRy2o6Y
         kOlRvh4rQk2CBpaudqPMhevdpq3GS5JOmr5+hF+mJlQqDQzSycp3sDqjOBhO8ta4ZU
         zNJOU0bRGMS1SpTirb6ZqP24Zvj7HNkvUhLwGtC9Tq5qTYoQ8E38m3lGhX/ONOlL8U
         kyZNE0W558Dnw==
Message-ID: <4841b48c-c35c-a375-8e78-154bc5217930@collabora.com>
Date:   Wed, 2 Nov 2022 13:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mtd: spi-nor: Fix the number of bytes for the dummy
 cycles
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bayi Cheng <bayi.cheng@mediatek.com>
References: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
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

Il 31/10/22 13:46, Allen-KH Cheng ha scritto:
> The number of bytes used by spi_nor_spimem_check_readop() may be
> incorrect for the dummy cycles. Since nor->read_dummy is not initialized
> before spi_nor_spimem_adjust_hwcaps().
> 
> We use both mode and wait state clock cycles instead of nor->read_dummy.
> 
> Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")
> Co-developed-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Tested-by: Dhruva Gole <d-gole@ti.com>

On MT8195 Tomato Chromebook:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


