Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0597106F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjEYIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjEYIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:12:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C7195;
        Thu, 25 May 2023 01:12:06 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EABD6605835;
        Thu, 25 May 2023 09:12:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685002325;
        bh=MN9eqSpRVglS1WDgssyRKlrNQodr0dvGosGQ0rVhxN4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MnFq75WRF5WGpp6NYskGgRv9yi+/pV5UI95oKZlq3HUN3LVugVxNwFKSxjqu0ygSs
         +NELlkT1vukd/OKbkzXaMs0lJFJMpcdXQR1vkd3P+SgYlLfbA6oqvZYj8RveHtuPkv
         VH7t+mCZeVoK2tle7uZLGtBo/XUpe5ZBQfsHlcPhQHk40WMefJG/YeFmVCF6qnIsAZ
         tKd9w2mTUekoqQmC/1Tb74AcKbywsTCsXCYCNrJFq3UpKs3ouD0NwhBtrF+byDRkv3
         Dqhr5IaM3o+1bclqdyyQzI5379HMsCNb+kAjGt0qfdqiOB9LKRPQZDkV8oIdg2tZgY
         eSAksMQ52PfSw==
Message-ID: <816a4aa4-cf6d-8f2b-8c86-5ea33e14a48c@collabora.com>
Date:   Thu, 25 May 2023 10:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4,2/4] media: mediatek: vcodec: using decoder status
 instead of core work count
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
 <20230525014009.23345-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525014009.23345-3-yunfei.dong@mediatek.com>
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
> Adding the definition of decoder status to separate different decoder
> period for core hardware.
> 
> core_work_cnt is the number of core work queued to work queue, the control
> is very complex, leading to some unreasonable test result.
> 
> Using parameter status to indicate whether queue core work to work queue.
> 
> Fixes: 2e0ef56d81cb ("media: mediatek: vcodec: making sure queue_work successfully")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

