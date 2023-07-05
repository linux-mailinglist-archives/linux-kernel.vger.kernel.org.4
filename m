Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A85747EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjGEIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGEIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900012A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3A561456
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B03C433C7;
        Wed,  5 Jul 2023 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688544351;
        bh=8KCphNAk0TlE+DiBeEL+TuuxFz0PYy0g5YKTvdC+ijI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuaXkKPi1GzQd5We+Vzc6C0n2FlJjXu+6jw6iKinzD53OAn9L8boQiXhLtvjJCpDY
         ZWYqzmLA0CuLGf0UDTaHT1KDAMYbOHy5YAyC0ikL1PuqWauZcavKlWMOJ8J/vVn+yK
         18cQAzyQbDtKsm2qtKsVlSMPaDUZYuLEcEPrXCuskw+TRFU5kKzUzK75OuUfSpLE+t
         uPqfamCBDs17v5ff6PtnLxgVctp99SfmEIoSEodGUVIYBo3+vV3lPK3jc91ewf6zbA
         sZTv1aNVdoU6tTlV9OQVYW6RL/gDAGhwERcxAp2ZVCY/iOKfwKlcd/+f2BMQC/2WNa
         TfJiFMt4IkeXw==
Date:   Wed, 5 Jul 2023 09:05:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, linyunsheng@huawei.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230705080545.GA589018@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311180630.4011201-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Was a follow-up to this ever sent?

-- 
Lee Jones [李琼斯]
