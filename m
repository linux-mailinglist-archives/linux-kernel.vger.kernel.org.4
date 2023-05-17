Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA1705C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEQAjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEQAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872F9E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 353B2636E3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527BC433EF;
        Wed, 17 May 2023 00:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684283944;
        bh=Zslh2K+EiuqVbcrhfXH9F3Qcm2xfSzOpQ7kfI0xJDsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HZ3jKn/4isWeBlgY0+8j3SRSjUdYBNm4ec8PBhTmmnZzG/PqvIiJJ3KCbKdAcSvyi
         MmhxMHXLd+DpHywy7DkanNFAH+79ZFyYspjN94j25ZzoZlCy2DSEmbu0YCHx5r2bTE
         abJWlytcrRsVdh9+iTDxq5asQwM6oipzWMyK6NBUbVoJTlTHGitf73iOdiX7MRWtgV
         xmJ5JMJlReyH+Yq433eJEY3DG5sDFKCeNSL5m2su+sXI+NCRuJBPAIVDyIpio1/bNa
         FTujAuXnKtOg9QYwyMmOEw9GLYVD1Kv+r34GcqRQLHa0ws7CGLOWZpJDZrLBE6jkGc
         c5JaDjG5dtS3g==
Date:   Tue, 16 May 2023 17:39:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Vlad Buslov <vladbu@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
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
Message-ID: <20230516173902.17745bd2@kernel.org>
In-Reply-To: <ZGQKpuRujwFTyzgJ@C02FL77VMD6R.googleapis.com>
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

On Tue, 16 May 2023 15:58:46 -0700 Peilin Ye wrote:
> > Given Peilin's investigation I think fix without changing core may
> > indeed be hard. I'm not sure if returning -EBUSY when qdisc refcnt
> > is elevated will be appreciated by the users, do we already have
> > similar behavior in other parts of TC?  
> 
> Seems like trying to delete an "in-use" cls_u32 filter returns -EBUSY

I meant -EBUSY due to a race (another operation being in flight).
I think that's different.
