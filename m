Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A85F75BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJGJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJGJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:08:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D26BCBB5;
        Fri,  7 Oct 2022 02:08:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3183066022C7;
        Fri,  7 Oct 2022 10:07:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665133679;
        bh=DxOpyHFK5ayCTwPgk9axtIkRiweZ/9Ci4i7s880jvCM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XOLAk2i57v2mPxnsS02TQB6BXwUzSbBlroT8DUUmu9YZmCZ4o2MABuDJUPns0otlG
         LeMaRfYOPyiwFzI0LfMSRX0Jsx0UU3ggDyXySGlMhMZ+kf9acV3Acif1BtTBuJcXsG
         o9G3dSBysqjbvGXBtFd2zo3AwHEsvEqjhTgwZ8kHRv8Ekvij4rgj9C+8WU/kesyY8O
         ZoTVRttbwv0qsjHLf/eDrtTrji/1I9IejlBCRyCRufTWIFo6augl1ix5x+2+Hr5d17
         +zjZ2xARy8Gxydy2SeXspIMfwb6vpGECe4LjWtgV5zOlHjclzNg7gAlzSXJtlhdlKL
         ovfU5D05a71mQ==
Message-ID: <9e14ae09-6100-a55f-7aa7-6ed9edb49e09@collabora.com>
Date:   Fri, 7 Oct 2022 11:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 1/6] media: platform: mtk-mdp3: add chip configuration
 header file
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221007031737.5125-1-moudy.ho@mediatek.com>
 <20221007031737.5125-2-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221007031737.5125-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/10/22 05:17, Moudy Ho ha scritto:
> In order to be compatible with more MDP3 chip settings in the future,
> move the chip-related configuration to a separate header file.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   .../media/platform/mediatek/mdp3/mt8183_mdp.h | 35 +++++++++++++++++++

What if we choose a better name format for the chip header?
Would mdp3-plat-mt8183.h work for you?

Aside from that, the changes look good... but anyway, what this driver
really needs is an abstraction of `mtk-img-ipi.h` since, as you know, new
SoCs are using a different firmware and even a different architecture for
the MCU.

Is that planned?

I think that such change would perfectly fit inside of this series.

Regards,
Angelo

>   .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 27 ++------------
>   2 files changed, 37 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183_mdp.h
> 

