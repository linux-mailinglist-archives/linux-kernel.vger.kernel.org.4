Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5B714649
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjE2IbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2IbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:31:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5DA7;
        Mon, 29 May 2023 01:31:14 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01ABC6605961;
        Mon, 29 May 2023 09:31:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685349072;
        bh=SgaXQ43zqDd+lRFXqCMttSv2BWRnEkrhM1NPjt8EZ+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K1XiEgSw6AMo6WNIulUT0UFwL37XiC77QE1vQeZaukNLzYgcvyD5h8gGi9xSNlaZo
         1bdajVGwTs45qLcL11net7MloIXbs82Q759SyfRGigi2u28MzanEfKoc2EQuCThng7
         kQsvH1ZxCd2DCGBqFwJ8DXXeYRUc9q2y7MMOAAFdxAWxObIicJseZRINCXTFtCM+Z/
         YJ9FLdc5+w09UA7kh4v7Fd1W4qjIdfM56oAkNOA+DuGwO51f6HRlvA4uoq3w+fu84g
         XB9Jk62h8iCtVL+Xjt3bxlPS5a7m9G4sokuNYzYTCvOF2k8Q7UWi/80XnQ9dYTo+/r
         f9HzdiYrv1o2w==
Message-ID: <2bae7dea-afc5-96b5-c6d1-f4724bae155c@collabora.com>
Date:   Mon, 29 May 2023 10:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
References: <20230526063149.1801196-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526063149.1801196-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 08:31, Pin-yen Lin ha scritto:
> From: Alexandre Courbot <acourbot@chromium.org>
> 
> When running memcpy_toio:
> memcpy_toio(send_obj->share_buf, buf, len);
> it was found that errors appear if len is not a multiple of 8:
> 
> [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
> 
> This is because in ARM64, memcpy_toio does byte-size access
> when the length is not a multiple of 8 while access to the
> vpu iomem must be 4 aligned.
> 
> This patch ensures the copy of a multiple of 8 size by calling
> round_up(len, 8) when copying.
> 
> Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned access to DTCM buffer.")
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> This is a re-send of v5 because it was marked obsolete, but this patch
> is required for MT8173 platforms.
> 

Hello,
I have solved this issue in a different way and the commit was already picked.

Please check:
ab14c99c035d ("media: platform: mtk-mdp: Fix mdp_ipi_comm structure alignment")

Regards,
Angelo

