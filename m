Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DA710704
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjEYIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjEYIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:12:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325C18C;
        Thu, 25 May 2023 01:12:27 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14C126605835;
        Thu, 25 May 2023 09:12:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685002346;
        bh=U1OuA9KiKKzfHNwI0WOpa1d4Zr7n714CcEvD1zhZC6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DmGcEqdBZfRjNcCcg7vdJC4KvaOEXYsriTTxXv9PiB5qaeWLi3/Np6g8XCm/JnHnz
         B7Om60vQzFU4ymuNaKOgC7ABYX3qUbI+jHxMiFGDkBdAPuK0sQEuWvtdh+9t1Wxbyg
         VQV9iPQmzM8Tw57Imzm4oTdyRWBgOHymsnt3cB0RMOf6b7wDAVfiU8O+5xFi9dng/A
         PgxGMIPjl+CWWl9RaJMptRFtv8+vD0EX+EHYqKrKBAOLEQcqmzb47tfDH4ckp/59oo
         p/bgWhnWtjf/LSvKX7bGUa9DotB04pteK80SRG/gEAp3iZiLyhDCx7xgEAAlwOiMqG
         DUbt2EcCgRAcA==
Message-ID: <9c160f44-c9ab-99a6-6ae6-ee4e0790b7f0@collabora.com>
Date:   Thu, 25 May 2023 10:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4,3/4] media: mediatek: vcodec: move core context from
 device to each instance
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
References: <20230525014009.23345-1-yunfei.dong@mediatek.com>
 <20230525014009.23345-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525014009.23345-4-yunfei.dong@mediatek.com>
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

Il 25/05/23 03:40, Yunfei Dong ha scritto:
> There are so many lat buffer in core context list, some instances
> maybe be scheduled for a very long time. Moving the core context to
> each instance, it only be used to control lat buffer of each instance.
> And the core work queue of each instance is scheduled by system.
> 
> Fixes: 2cfca6c1bf80 ("media: mediatek: vcodec: move lat_buf to the top of core list")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


