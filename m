Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5B27056FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjEPTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjEPTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606A1999
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7FCF63E42
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2764C433D2;
        Tue, 16 May 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684264927;
        bh=FN416ecFDfAW41Eioma/+kx2ZpZ+tyHBV47uheUxRXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APe2b3ZFrWdZM7UdAwQ0MwILSkyB25UXxJRNF8mjWhQvWun59gwUzKdUtacMyqOvC
         51PW874Crl0O2LX7qSCi1yvXAg20UQJkNEiRTlHyZlrvQs2w+scYwP5w+nWAacOo7F
         QALfmINYvhDOuhYfQvqDYV3QYEdiwsgaP3oixzDqmzupWhnIWWTDowKddrjp8fnKlk
         RHs1Pmx4/5fymS87iu+6DC6yKD29gQ8NNEs4h/X3wrup0gDwVhU/a25relmFMSJthF
         Yd8kfHlUnWO4SzUzCmlvonqUgohJkOvmWjL6zD8o4di3iqMXbkEG8K2TSeOPvkS+I0
         8QRDfaO4jnDrw==
Date:   Tue, 16 May 2023 12:22:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230516122205.6f198c3e@kernel.org>
In-Reply-To: <ZGK1+3CJOQucl+Jw@C02FL77VMD6R.googleapis.com>
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

On Mon, 15 May 2023 15:45:15 -0700 Peilin Ye wrote:
> On Thu, May 11, 2023 at 05:11:23PM -0700, Peilin Ye wrote:
> > > You're right, it's in qdisc_create(), argh...  
> >  
> > ->destroy() is called for all error points between ->init() and  
> > dev_graft_qdisc().  I'll try handling it in ->destroy().  
> 
> Sorry for any confusion: there is no point at all undoing "setting dev
> pointer to b1" in ->destroy() because datapath has already been affected.
> 
> To summarize, grafting B mustn't fail after setting dev pointer to b1, so
> ->init() is too early, because e.g. if user requested [1] to create a rate  
> estimator, gen_new_estimator() could fail after ->init() in
> qdisc_create().
> 
> On the other hand, ->attach() is too late because it's later than
> dev_graft_qdisc(), so concurrent filter requests might see uninitialized
> dev pointer in theory.
> 
> Please suggest; is adding another callback (or calling ->attach()) right
> before dev_graft_qdisc() for ingress (clsact) Qdiscs too much for this
> fix?
> 
> [1] e.g. $ tc qdisc add dev eth0 estimator 1s 8s clsact

Vlad, could you please clarify how you expect the unlocked filter
operations to work when the qdisc has global state?
