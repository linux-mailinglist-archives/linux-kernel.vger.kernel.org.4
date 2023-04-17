Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0972C6E418C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDQHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:45:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37C358E;
        Mon, 17 Apr 2023 00:44:44 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD2346602F91;
        Mon, 17 Apr 2023 08:44:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681717482;
        bh=4ju2sjdECGeN8KyDD+a8vUNcwUjOKUkgswflyYi99Wg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=md97EAfMLICLqvYW/f+XUwyoMyVlvKHug1PQ/NPDtwv+z02yXSSAB24+d5spuEXxG
         OMYX1Gt2+6g6KY/ZvjT5sQ/TQaGoQtjZFPLuQdAOW5RC/IO0eelyn/5eeOgZ5+SRDh
         zKl1F5FCEZSyBAWVq3Td3sl0pH3wbh6IqdsCL/oRw2mM9ln1izz8BA+rdnamGIJFTL
         +QckzYq0H5ePOVfjZ24MhoV95jSxUwF0rXH7VtLxh0Z48j1DTZGN13FkYqVwXxvmk4
         aeQ57ikMa3pS1XWYHJIKEKSZ9F7bJxT9BJ0HVBtjksrzvwIT4sEnAyZ8bVhR/M/1yb
         +jH9qa2cndHKQ==
Message-ID: <ad088fd1-d96e-76df-4c9d-07e0929813f7@collabora.com>
Date:   Mon, 17 Apr 2023 09:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] media: mediatek: vcodec: Move a variable assignment
 behind condition checks in vdec_vp9_slice_single_decode()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Haowen Bai <baihaowen@meizu.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/23 20:30, Markus Elfring ha scritto:
> Date: Fri, 14 Apr 2023 20:07:01 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “vdec_vp9_slice_single_decode”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable “pfc” behind some condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: b0f407c19648ae9110c932c91d6e1b9381ec0aeb ("media: mediatek: vcodec: add vp9 decoder driver for mt8186")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


