Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A45F63A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiJFJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiJFJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:30:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B1B85A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:30:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE2086601595;
        Thu,  6 Oct 2022 10:30:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665048650;
        bh=DZafEcdio5imhGIlFetdrZR2SPXKufatKggl05kVwN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T3TXFlla5OAqLTidG45otxzLLgFgUL7vK2o1YNvBgcn6GZ6qZ7qZSUWvxHk/5ec58
         CzznJ9DXUzmbFafqfvVOeriSGvfaI8u3cHbj2EIxL4SSzXh6WU4GavD/2jWTVQ5g8c
         V1srnsG9PCBlbU4c8RsPtqxeq6Fli38wH6gvbEUtzq3eQSnSMudB1RZBS/hLnKHYhF
         BZRs84tP5p29RH/FsD+3/BSzPCU94nc8r7LzkkyR2jt8LxUl/kcFmWo1dg5R6QBFiz
         UWNb9Kpr0BeHfcA0PrqPyuT9SA1m6DepfrlqMb5GXvAKKgM3pk4W5iEC7Ja6Yda5zN
         IJWSYjjYlvN6w==
Message-ID: <294fa048-1dc0-ea52-d65b-2c6c0c48bafc@collabora.com>
Date:   Thu, 6 Oct 2022 11:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
 <20221006043456.8754-4-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006043456.8754-4-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 06:34, Yongqiang Niu ha scritto:
> add gce ddr enable control flow when gce suspend/resume
> 
> when all cmdq instruction task has been processed done,
> we need set this gce ddr enable to disable status to tell
> cmdq hardware gce there is none task need process, and the hardware
> can go into idle mode and no access ddr anymore, then the spm can go
> into suspend.
> 
> the original issue is gce still access ddr when cmdq suspend function
> call, but there is no task run.
> so, we need control gce access ddr with this flow.
> when cmdq suspend function, there is no task need process, we can
> disable gce access ddr, to make sure system go into suspend success.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>


I already gave you my Reviewed-by tag for this patch and here nothing has
changed from v8 to v9. Please retain tags that were given to you in these cases.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
