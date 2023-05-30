Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD0715B08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjE3KGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjE3KF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:05:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586CCD;
        Tue, 30 May 2023 03:05:58 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B1D166059A8;
        Tue, 30 May 2023 11:05:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685441157;
        bh=IFEh9xUtBJ9o/3DO6FK5coeeTQJVx9mIKVRRSoGucss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cqg3wxNMrjsgnS+BQadiK5VX9GeihQjwVdZMM+9EdWoIPXISRKwr0BXvBQ1k3pZb7
         tzw+uxKrUaVcZ78WraUnkF4trcZBKxnMEWcvSIjhn+MIjEcB8B7qpdS48Bwi6jof70
         +xyCgnECJ/ya6s7oeyh7TPvqAMjfbsYBDmrbs7HKpDCGGzEmYkrj1X+NiGZdyaKc1Z
         S5aKiDPK8MOwPezQqabUg5lZiPZdtgv/vLAvO4llm3e87AB+2nmxLRNBmhHk4NpujK
         i5vV1nX7Mw+BRZYf4V3ikGv21CmoPoHQuLYkvcKstS5XAUJ/jLCEF7FtkKtidFpWl/
         9vz6sF0YJV11A==
Message-ID: <cf49601e-2ba8-4629-dab8-9253bd95e275@collabora.com>
Date:   Tue, 30 May 2023 12:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5,4/8] media: mediatek: vcodec: Get each context
 resolution information
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
 <20230525021219.23638-5-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525021219.23638-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 04:12, Yunfei Dong ha scritto:
> Will store the string to temp buffer like "echo '-picinfo' > vdec" when
> user want to get needed information.
> 
> Then getting debug information using command 'cat vdec' calling mtk_vdec_dbgfs_read
> to analysis the temp buffer.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


