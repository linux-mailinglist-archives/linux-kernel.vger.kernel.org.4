Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8D617A84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKCKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:02:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC325F7;
        Thu,  3 Nov 2022 03:02:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10CF56602910;
        Thu,  3 Nov 2022 10:02:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667469733;
        bh=cJ7/RbB6T0ABdRfkEHmG42usHctHRiTqhYQyfhjHJMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VvdeKyjARZCCL/SdvIIIfp++2uEa4iuO5NcBoZaStwwkIIX21PZoX5wF8gpW+u8Ax
         xJEDis3rirygwyq53jDEAWaj2lTGxq+wgTkynVabwtR6PudpEjUJLp6cadg8A+1oY6
         9WgwLhMf/FSOh5lop5mkzMdzTooiVTpBMoaxtGMM4ttxyjcbbACWmx4Fw7bwb/jvDq
         q+v7pZDCMSGKvxNfFil79es3XPExbPKWqVz7KkZgTV+Q6XjJS5EbstUWU/q1I8NTI9
         BFIDtkVHr9QUfIBZlHvw1tftEmnrD/PqQRIMtPA+uDZ+3KulOAm4nGTKs+ZkaP838O
         WIVTgQD4If87w==
Message-ID: <bb439583-9963-b705-9239-b8cedc71b5db@collabora.com>
Date:   Thu, 3 Nov 2022 11:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 10/10] media: platform: mtk-mdp3: decompose
 hardware-related information in shared memory
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
 <20221103064842.12042-11-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221103064842.12042-11-moudy.ho@mediatek.com>
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

Il 03/11/22 07:48, Moudy Ho ha scritto:
> The communication between the MDP3 kernel driver and SCP is to
> pass a shared memory through the cooperation of "mtk-mdp3-vpu.c" and
> remoteproc driver.
> The data structure of this shared memory is defined in "mtk-img-ipi.h",
> as shown below:
> 
> vpu->work_addr -> +-----------------------------------------+
>                    |                                         |
>                    | To SCP : Input frame parameters         |
>                    |          (struct img_ipi_frameparam)    |
>                    |                                         |
>       vpu->pool -> +-----------------------------------------+
>                    |                                         |
>                    | From SCP : Output component config pool |
>                    |            (struct img_config)          |
>                    |                                         |
>                    |           *struct img_confg 1           |
>                    |                    |                    |
>                    |                    |                    |
>                    |                    v                    |
>                    |           *struct img_config N          |
>                    |            (N = MDP_CONFIG_POOL_SIZE)   |
>                    +-----------------------------------------+
> 
> One output component configuration contains the components
> currently used by the pipeline, and has the register settings
> that each component needs to set.
> 
> Since the quantity, type and function of components on each chip
> will vary, the effect is that the size of the "struct img_config"
> and its substructures will be different on each chip.
> In addition, all chips will have to update their SCP firmware for
> every change if the output component config structure is defined
> and shared by a common header.
> 
> Therefore, all functions that operate on "struct img_config" and
> its substructures must be separated by chips and so are the
> relevant definations.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Hi Moudy,
thanks for this much needed rework of the IMG-IPI parameter passing architecture!

I can for sure go for a review of the code that you've currently pushed, but I
would prefer that you also push support for MT8192 and/or MT8195 (requiring the
different IPI structures and alignment), as previously discussed.

That will make us able to actually perform validation and will make us able to
give you a better code review.

Since this series is definitely big (hence, a bit difficult to review, but that's
fine, as there are no alternatives!), you can push support for the new chip(s) in
a separate series, dependent on this one, so that we also won't block this rework
for SoC-specific implementation code reviews.

Many thanks again!

P.S.: There's a typo in this commit message `*struct img_confg` :-)

Cheers,
Angelo
