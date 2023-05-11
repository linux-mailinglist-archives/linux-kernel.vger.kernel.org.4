Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E354C6FFB62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjEKUkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbjEKUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:40:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF600AD;
        Thu, 11 May 2023 13:40:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75764d20db3so536446585a.2;
        Thu, 11 May 2023 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683837617; x=1686429617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnld3zEnNrYJTC+Po5oprlcoZKv9fFDKe9k4DZBIlFI=;
        b=K5eZFpcQMIncRsOeztQjS+Er6+WbVtg0SoBKQpSBMRTLBXyT/UASXIgdHU5uHd7/kF
         icuBns2EO3hiT1O26gu6l/yw7daxFyAZd+Ab90alEpPtQ5t81bp77HtRBEfIOPAI0csz
         80FCOj2CbKZYm85KGvQf/ndc2cTbaoqHs3vfcQ1Zb9Nwj9H6xqL+XXLZJlu44BI48iYp
         ab9Wu+U2PA1SzhvQXTE1bz1kBBA0T3/cGB5RlAGBI55rowfc1v9vAcmtjIjbgKYHV9n2
         tv8ulHS/rspek2tGLWlrpO+YgWJo94kY2lZfR+VTdwtJ5hLKeiU74dHpZ+rQcQNoqwcm
         EXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837617; x=1686429617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnld3zEnNrYJTC+Po5oprlcoZKv9fFDKe9k4DZBIlFI=;
        b=G8R7mLGM909PXArb1U8AHvPxYHA+uU8ZSA/fz2YmwfgrpQr3pWRE1jFSE/F+x83jkK
         V7CJI3t0+UkAvbqiZk1X77XTC4GfnB9PyqwRUQZG1kZuHzDvARNC+4c8PthENhH7OelR
         smR9IhdySRJ3txivrPP38byXTZpuF/YvGUg5EaxiqcQtweKHmzqdi8Gh0SZVtVHb0G06
         KKaUI3x/kK32IBgYoHmAJlqhokiLvjboFAiwZf1qHfY+L+iiHiTHgObzcCjmQu/lOACf
         VPlHWz0Pc3OxTegs0WP+HErwmmDJleBFxL3RUfGGfNd1EVsJr4V6JHIAMbgdp2mMaHcn
         uU/w==
X-Gm-Message-State: AC+VfDz+BvbmiSE5CjubWQ9Jo9FGyi+XP7Z8yi1tQwT7vqCu8KMjaAxe
        4HayBdMUBvNeop5fRPA1PdlsHB2p7A==
X-Google-Smtp-Source: ACHHUZ72cysp9w6EvSts3m3lHTzZZTu9anT0uvFcKwZAjN/2YHQYi2ue+od9ZhzOcpw965RYA5DkbQ==
X-Received: by 2002:a05:6214:1cc4:b0:61b:6e43:b20 with SMTP id g4-20020a0562141cc400b0061b6e430b20mr32286427qvd.42.1683837617037;
        Thu, 11 May 2023 13:40:17 -0700 (PDT)
Received: from C02FL77VMD6R.googleapis.com ([2600:1700:d860:12b0:b187:de6c:7549:89e])
        by smtp.gmail.com with ESMTPSA id r12-20020a0c8d0c000000b0062136626e09sm2328311qvb.57.2023.05.11.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:40:16 -0700 (PDT)
Date:   Thu, 11 May 2023 13:40:10 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <ZF1SqomxfPNfccrt@C02FL77VMD6R.googleapis.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
 <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
 <20230508183324.020f3ec7@kernel.org>
 <ZFv6Z7hssZ9snNAw@C02FL77VMD6R.googleapis.com>
 <20230510161559.2767b27a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510161559.2767b27a@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:15:59PM -0700, Jakub Kicinski wrote:
> My thinking was to make sure that dev->miniq_* pointers always point
> to one of the miniqs of the currently attached qdisc. Right now, on
> a quick look, those pointers are not initialized during initial graft,
> only when first filter is added, and may be cleared when filters are
> removed. But I don't think that's strictly required, miniq with no
> filters should be fine.

Ah, I see, thanks for explaining, I didn't think of that.  Looking at
sch_handle_ingress() BTW, currently mini Qdisc stats aren't being updated
(mini_qdisc_bstats_cpu_update()) if there's no filters, is this intended?
Should I keep this behavior by:

diff --git a/net/core/dev.c b/net/core/dev.c
index 735096d42c1d..9016481377e0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5116,7 +5116,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
         * that are not configured with an ingress qdisc will bail
         * out here.
         */
-       if (!miniq)
+       if (!miniq || !miniq->filter_list)
                return skb;

        if (*pt_prev) {

On Wed, May 10, 2023 at 04:15:59PM -0700, Jakub Kicinski wrote:
> On Wed, 10 May 2023 13:11:19 -0700 Peilin Ye wrote:
> > On Fri,  5 May 2023 17:16:10 -0700 Peilin Ye wrote:
> > >  Thread 1               A's refcnt   Thread 2
> > >   RTM_NEWQDISC (A, RTNL-locked)
> > >    qdisc_create(A)               1
> > >    qdisc_graft(A)                9
> > >
> > >   RTM_NEWTFILTER (X, RTNL-lockless)
> > >    __tcf_qdisc_find(A)          10
> > >    tcf_chain0_head_change(A)
> > >    mini_qdisc_pair_swap(A) (1st)
> > >             |
> > >             |                         RTM_NEWQDISC (B, RTNL-locked)
> > >            RCU                   2     qdisc_graft(B)
> > >             |                    1     notify_and_destroy(A)
> > >             |
> > >    tcf_block_release(A)          0    RTM_NEWTFILTER (Y, RTNL-lockless)
> > >    qdisc_destroy(A)                    tcf_chain0_head_change(B)
> > >    tcf_chain0_head_change_cb_del(A)    mini_qdisc_pair_swap(B) (2nd)
> > >    mini_qdisc_pair_swap(A) (3rd)                |
> > >            ...                                 ...
> >
> > Looking at the code, I think there is no guarantee that (1st) cannot
> > happen after (2nd), although unlikely?  Can RTNL-lockless RTM_NEWTFILTER
> > handlers get preempted?
>
> Right, we need qdisc_graft(B) to update the appropriate dev pointer
> to point to b1. With that the ordering should not matter. Probably
> using the ->attach() callback?

->attach() is later than dev_graft_qdisc().  We should get ready for
concurrent filter requests (i.e. have dev pointer pointing to b1) before
grafting (publishing) B.  Also currently qdisc_graft() doesn't call
->attach() for ingress and clsact Qdiscs.

But I see your point, thanks for the suggestion!  I'll try ->init() and
create v2.

Thanks,
Peilin Ye

