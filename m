Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B050762F7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiKROnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiKROnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:43:14 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883213E3D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:43:06 -0800 (PST)
X-KPN-MessageId: 52309e82-674f-11ed-bd66-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 52309e82-674f-11ed-bd66-005056994fde;
        Fri, 18 Nov 2022 15:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=pdKgFBSjrP7J6mKQWKcIHbUGqiu8JHE7FpanMMKui3g=;
        b=BgVJUG6vwXZgwsVHy52Z9oCXmaMqSN+28IZDHEUPzlrFkGElqCPZMgN6VUdjQ62RZYOHfu4fIBXfu
         bOhoGzmtirLjc6X3v+HdKmf8O5vv/OLYFKSmfVZI8o8XkoVfI71X6OPlVfXZ1Jvblt9sh7/fyYfBZ6
         r7XCD6jSWatpceQb4l8N+aPqd4CU1b5GsRxz5j/XAMmIxG6NB0MtJKrJaZsvjpbbxDhormaVm2TU3f
         o0oZkzzV1TTUG8RpQtuEnSxxMjDaHAtncb5dOoe4FbfBd4W4jce1sIaIWa6QaLRCrZxiBscjjadV8+
         8ro9aFmub64GuhkyjBz4jMQ4YTZKTIw==
X-KPN-MID: 33|fFbkAkP83JGUv1qU/pkLvLXfT30fA7fHDImREHGq0OWKitaWJxgZHuYLjNX20sd
 8Y4TSjdxnqiTBqkocf6bxo2mf264VvBfGDuMtNnGFIMU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aHFuH5bFQHDW5BFR+HnL4ys8tdkYBqpjYSJCY+kUj64PdKCi5JWSVX+hIOzqbkh
 R4Gvzo2Hok/cWEKeNGFSRVA==
X-Originating-IP: 173.38.220.59
Received: from [10.47.77.219] (unknown [173.38.220.59])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 4e226081-674f-11ed-9b31-00505699b758;
        Fri, 18 Nov 2022 15:43:03 +0100 (CET)
Message-ID: <9c46615d-2dfb-837e-48a8-9d952c04a824@xs4all.nl>
Date:   Fri, 18 Nov 2022 15:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] media: platform: mtk-mdp3: add missing call to
 of_node_put()
Content-Language: en-US
To:     wangkailong@jari.cn, mchehab@kernel.org, matthias.bgg@gmail.com,
        moudy.ho@mediatek.com, sunke32@huawei.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <be6c204.133.18470aa3e15.Coremail.wangkailong@jari.cn>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <be6c204.133.18470aa3e15.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 12:05, wangkailong@jari.cn wrote:
> Fix the following coccicheck warning:
> 
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:892:1-23: WARNING:
> Function "for_each_child_of_node" should have of_node_put() before
> return around line 914.
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:892:1-23: WARNING:
> Function "for_each_child_of_node" should have of_node_put() before
> return around line 920.
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:951:1-23: WARNING:
> Function "for_each_child_of_node" should have of_node_put() before
> return around line 993.
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index d3eaf8884412..4162fc732f38 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -908,6 +908,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
>  		alias_id = mdp_comp_alias_id[type];
>  		id = mdp_comp_get_id(type, alias_id);
>  		if (id < 0) {
> +			of_node_put(node);
>  			dev_err(dev,
>  				"Fail to get sub comp. id: type %d alias %d\n",
>  				type, alias_id);
> @@ -916,8 +917,10 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
>  		mdp_comp_alias_id[type]++;
>  
>  		comp = mdp_comp_create(mdp, node, id);
> -		if (IS_ERR(comp))
> +		if (IS_ERR(comp)) {
> +			of_node_put(node);
>  			return PTR_ERR(comp);
> +		}
>  	}
>  
>  	return 0;
> @@ -988,6 +991,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  
>  		pdev = of_find_device_by_node(node);
>  		if (!pdev) {
> +			of_node_put(node);
>  			dev_warn(dev, "can't find platform device of node:%s\n",
>  				 node->name);
>  			return -ENODEV;

There is a 'goto err_init_comps;' in this function as well that needs
an of_node_put(node); line.

Can you make a v2?

Regards,

	Hans
