Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB66C7968
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCXILm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:11:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BBB74A;
        Fri, 24 Mar 2023 01:11:39 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a] (unknown [IPv6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BCE66603103;
        Fri, 24 Mar 2023 08:11:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679645498;
        bh=3Mr86UDy3UpNufjt21Ufqdk3iHtyAj7hnO+u3KjB708=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mnKwthLEv+tlfb7ktpXfQvkMYedJR8yf4IqgZX78OzHBsb3TXu0cXugvy4Tly1zQo
         T559lOJFKtJKlc5TrAvI/G7z02NG3Zw5H9zTdNntrzJ6WRCUa5ZOfMF+6ak+B5hYRQ
         0EU351Y7+sj8DXpHNRkpvvVU2JmsmcZCv7YN/hb+EfppmoltHjTd82Xz3hGp5fSQuh
         JXjn5XZhtu358kjzylV8DCcNzShYzFfxEiwlJ9sy1xu1Qgfmb8C8oSYABUGDCo6bNi
         TmnC5WYWGJMw2VFJ4ri7+hmLy6b0+HnNNczgw9Ff6SVwpnRXjus4LbzhUT6M+Ru8XG
         sZWzWQx6uyvWA==
Message-ID: <a88b93cc-a81f-6186-09fc-02223867e677@collabora.com>
Date:   Fri, 24 Mar 2023 09:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic
 allocated
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <4e2cb832-de83-4ba6-bd8a-119a19038cfe@kili.mountain>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <4e2cb832-de83-4ba6-bd8a-119a19038cfe@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/03/2023 à 06:01, Dan Carpenter a écrit :
> Hi Benjamin,
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
> base:   git://linuxtv.org/media_tree.git master
> patch link:    https://lore.kernel.org/r/20230321102855.346732-3-benjamin.gaignard%40collabora.com
> patch subject: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic allocated
> config: arm64-randconfig-m041-20230319 (https://download.01.org/0day-ci/archive/20230324/202303240148.lKRnUqW9-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202303240148.lKRnUqW9-lkp@intel.com/
>
> smatch warnings:
> include/media/videobuf2-core.h:1272 vb2_queue_add_buffer() warn: sleeping in atomic context
> drivers/media/common/videobuf2/videobuf2-core.c:2456 vb2_core_queue_init() warn: Please consider using kcalloc instead of kmalloc_array
>
> vim +1272 include/media/videobuf2-core.h
>
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1263  static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1264  {
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1265  	bool ret = false;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1266
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1267  	spin_lock(&q->bufs_lock);
>                                                          ^^^^^^^^^^^^^^^^^^^^^^^
> Holding a spin lock.
>
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1268
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1269  	if (vb->index >= q->max_num_bufs) {
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1270  		struct vb2_buffer **tmp;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1271
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21 @1272  		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
>                                                                                                                                       ^^^^^^^^^^
> Sleeping allocation.  GFP_ATOMIC?  Or is there a way to move the
> allocation outside the lock?

I will add GFP_ATOMIC flag in next version.

Thanks for your help,
Benjamin

>
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1273  		if (!tmp)
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1274  			goto realloc_failed;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1275
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1276  		q->max_num_bufs *= 2;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1277  		q->bufs = tmp;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1278  	}
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1279
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1280  	if (vb->index < q->max_num_bufs) {
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1281  		q->bufs[vb->index] = vb;
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1282  		ret = true;
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1283  	}
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1284
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1285  realloc_failed:
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1286  	spin_unlock(&q->bufs_lock);
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1287
> 487d3f14d12ecf Benjamin Gaignard 2023-03-21  1288  	return ret;
> 625d46c1c1fe8e Benjamin Gaignard 2023-03-21  1289  }
>
