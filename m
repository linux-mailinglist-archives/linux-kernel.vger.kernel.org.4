Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E27059CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEPVuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A495FDC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E768D63FBB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0371C433EF;
        Tue, 16 May 2023 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684273811;
        bh=yKkl+O+uwemVUkRqo3YT8W36ra+vpuQRbPNcizoUogE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fVWIMxwdFdnveGr0Eu1f+wb2bNaPbs0KhmFzgzLq704feoxQL0vucOiJjQUONdpmh
         dr5/MV75n/TuMO2OihaPfcn6cHE3Zg14Ap7UpvvBRVeMGp4CmsDRBcukl8yGM5TaKA
         azfMmCrsroyXZ+oM6Tjw2puCtKmyBqgvdXnDdz9ssNWjBi5C8CFXHoHUXspB2u/30V
         FCwN5x41wuOa42vanctEHH1taIIVqRcBkSC5wLJuTzAFCwc16RaNESgkKG+c+NxMTT
         /9R4ylh9qWb8PHSXVoM2CfA/hGw41Eo2q1k4zeCbBJUKGsr7YaZUr9WjEamy3Vkujb
         UrEvX4+wuO1qQ==
Date:   Tue, 16 May 2023 14:50:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jamal Hadi Salim" <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Peilin Ye" <peilin.ye@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230516145010.67a7fa67@kernel.org>
In-Reply-To: <87y1lojbus.fsf@nvidia.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
        <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
        <20230508183324.020f3ec7@kernel.org>
        <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
        <20230510161559.2767b27a@kernel.org>
        <ZF1SqomxfPNfccrt@C02FL77VMD6R.googleapis.com>
        <20230511162023.3651970b@kernel.org>
        <ZF1+WTqIXfcPAD9Q@C02FL77VMD6R.googleapis.com>
        <ZF2EK3I2GDB5rZsM@C02FL77VMD6R.googleapis.com>
        <ZGK1+3CJOQucl+Jw@C02FL77VMD6R.googleapis.com>
        <20230516122205.6f198c3e@kernel.org>
        <87y1lojbus.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 22:35:51 +0300 Vlad Buslov wrote:
> > Vlad, could you please clarify how you expect the unlocked filter
> > operations to work when the qdisc has global state?  
> 
> Jakub, I didn't account for per-net_device pointer usage by miniqp code
> hence this bug. I didn't comment on the fix because I was away from my
> PC last week but Peilin's approach seems reasonable to me. When Peilin
> brought up the issue initially I also tried to come up with some trick
> to contain the changes to miniqp code instead of changing core but
> couldn't think of anything workable due to the limitations already
> discussed in this thread. I'm open to explore alternative approaches to
> solving this issue, if that is what you suggest.

Given Peilin's investigation I think fix without changing core may
indeed be hard. I'm not sure if returning -EBUSY when qdisc refcnt
is elevated will be appreciated by the users, do we already have
similar behavior in other parts of TC?
