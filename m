Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0C707116
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEQSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33528FE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB0E63D49
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE443C433D2;
        Wed, 17 May 2023 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684349307;
        bh=0wwL2+NXSkmPfNrLmHdlLeDAx4VxNIV7troyimyoYxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSMgvqNIyW74smSyIMZr6dOQQXAsSrCfLV9GC2GllU7IqZY2LERlvM0h4DrOy80lS
         CQNhX5DMLOC+w5ZXhy0CHWPDvu9UvFfxDg9IvbPHCwH/2Qw18QUqvPX9iN3MvcNKsJ
         no4UeUK8405fuXOCY8ZSGZmds0zQTTvw/LH8+pW3Jka5uiU4uOrydGRA3OBwOwo6AW
         kMFZFSafBCqBeav+Fb1KAjHCHfvDP8im+/E81T9Rj5XCxkIl11RdHZ7FMSdG5LtsgM
         PJgRg9QD9it1cz6vvNEXuGRuqzqSGT3I2+lYlUVN5RQe611M6pozW51WGkxZ/KRCgI
         LJJLasJpHuNrQ==
Date:   Wed, 17 May 2023 11:48:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230517114825.5d7c85a4@kernel.org>
In-Reply-To: <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
        <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 May 2023 17:16:10 -0700 Peilin Ye wrote:
>  		} else {
> -			dev_queue = dev_ingress_queue(dev);
> -			old = dev_graft_qdisc(dev_queue, new);
> +			old = dev_graft_qdisc(dev_queue, NULL);
> +
> +			/* {ingress,clsact}_destroy() "old" before grafting "new" to avoid
> +			 * unprotected concurrent accesses to net_device::miniq_{in,e}gress
> +			 * pointer(s) in mini_qdisc_pair_swap().
> +			 */
> +			qdisc_notify(net, skb, n, classid, old, new, extack);
> +			qdisc_destroy(old);
> +
> +			dev_graft_qdisc(dev_queue, new);

BTW can't @old be NULL here?
