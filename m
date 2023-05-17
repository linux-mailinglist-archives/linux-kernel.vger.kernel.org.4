Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1D707114
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEQSsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB3FE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FFF648BA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C447C433EF;
        Wed, 17 May 2023 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684349287;
        bh=AmPDufIVjIb0VxPo/YFNGszWHrR8ib13WMhB1Zb+HWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GPJu0owjDbbuXoUWW/tJE2qTjljII0Jbu7BtcAVBMkZhSDqh7YqWMgB+AyDLiiseY
         N60k8eWZ8VpClfVmUL4s8WhO5mpn8Qghe1Yfg0I2uvmAOl56v6tKSe1OVT9Mu9K4e+
         5QINQ723OY82vPmDHkGZPthk2o6+i5MT3Xb1oCtB5TvoEPjAytSXm4Icov3JliheyY
         /s58PLEcgzucjFbWRWzO/5d26G344J316XUnQehVc69BkpeoyVwxeLwInKIk/4OtfJ
         WLTu4YXCE4DgYPUFNxXNaP/RwTvwea7PA/rXSrHYG6Yaf10Q55TH74Rjw7X6BbPfIS
         PG5zD3BNASwoQ==
Date:   Wed, 17 May 2023 11:48:05 -0700
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
Message-ID: <20230517114805.29e9bdca@kernel.org>
In-Reply-To: <87ttwbjq6y.fsf@nvidia.com>
References: <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
        <20230510161559.2767b27a@kernel.org>
        <ZF1SqomxfPNfccrt@C02FL77VMD6R.googleapis.com>
        <20230511162023.3651970b@kernel.org>
        <ZF1+WTqIXfcPAD9Q@C02FL77VMD6R.googleapis.com>
        <ZF2EK3I2GDB5rZsM@C02FL77VMD6R.googleapis.com>
        <ZGK1+3CJOQucl+Jw@C02FL77VMD6R.googleapis.com>
        <20230516122205.6f198c3e@kernel.org>
        <87y1lojbus.fsf@nvidia.com>
        <20230516145010.67a7fa67@kernel.org>
        <ZGQKpuRujwFTyzgJ@C02FL77VMD6R.googleapis.com>
        <20230516173902.17745bd2@kernel.org>
        <87ttwbjq6y.fsf@nvidia.com>
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

On Wed, 17 May 2023 11:49:10 +0300 Vlad Buslov wrote:
> On Tue 16 May 2023 at 17:39, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Tue, 16 May 2023 15:58:46 -0700 Peilin Ye wrote:  
> >> 
> >> Seems like trying to delete an "in-use" cls_u32 filter returns -EBUSY  
> >
> > I meant -EBUSY due to a race (another operation being in flight).
> > I think that's different.  
> 
> I wonder if somehow leveraging existing tc_modify_qdisc() 'replay'
> functionality instead of returning error to the user would be a better
> approach? Currently the function is replayed when qdisc_create() returns
> EAGAIN. It should be trivial to do the same for qdisc_graft() result.

Sounds better than returning -EBUSY to the user and expecting them 
to retry, yes.
