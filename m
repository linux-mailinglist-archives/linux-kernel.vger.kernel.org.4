Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6576E4378
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDQJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjDQJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:18:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916DB7;
        Mon, 17 Apr 2023 02:18:20 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 115E3660309E;
        Mon, 17 Apr 2023 10:18:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681723099;
        bh=B6LbGft4HxAIqoilnk5IC83grPCkk/Hif1oJBGNxpWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jebdwN5kgEG64iYOCZj683+YGj3wMzGsaamuIPbrw7rTfny4mghm2QLnsviE9sNuV
         TLUfGHqyQZvtoMVtvnjYLI210dt4ZZupgQ0WHJNrgBpnha92v/5dx251GIkO1OX38t
         CLR3CAd1YLab+xYyY5unuL3GgDAMKU2eJvGZJhyJy1CeUMoGD33aMXhW8OXH2n77je
         vjNudg7KXB/jWsj5P96Yz9zvgxRzfad6MvpYtv3+vY4KEdvT3P2tNs1gi4K7tMgMv0
         ocBThx1DCx2vT6aSVt4XK05xHxlZA6zO2heIV19bFQBN0FUNAUmzd/eFH9Xc+fb1KX
         fEEdYW5UOdqrQ==
Message-ID: <37b56f69-99c2-adf0-cc9f-572fbdaa2eee@collabora.com>
Date:   Mon, 17 Apr 2023 11:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/6] media: mediatek: vcodec: can`t regard getting lat
 buffer fail as error
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
 <20230417054816.17097-2-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417054816.17097-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 07:48, Yunfei Dong ha scritto:
> The speed of lat decoder is much faster than core, need to get trans
> buffer again when lat fail to get trans buffer.
> 

The commit description is misleading, looks like you're doing functional
changes, but you're just changing loglevels... and the title is also a
little confusing, so.. I would propose:

media: mediatek: vcodec: Avoid unneeded error logging

Since the LAT decoder works faster than its CORE, getting the trans buffer may
be done only after CORE finishes processing: avoid printing an error if the
decode function returns -EAGAIN, as this means that the buffer from CORE is not
yet available, but will be at a later time.

Also change the log level for calls to vdec_msg_queue_dqbuf() in H264 and VP9
LAT decoder drivers to avoid excessive logging.

Cheers,
Angelo


