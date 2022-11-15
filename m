Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3462A19A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKOS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKOS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:58:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564128715
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668538647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhhMRXuffKWmJnSyDCn2McoLOIVtIOCGZv8DUDNnMo8=;
        b=Y0yx+pkmsaq1C0uWFlPARo8Nlpbpp0icIXDLRV4RU4msd9F8fmAsduU238CsnQOVKBHq3x
        lCzB8Io/GiCkAXjVU5DCZZk9XP8+ioNGFfayk246m+JKRfB9UuNjU5UStSuhpiwbGG4+/r
        1xS2Apku0PCQLZ3ZcoM3d3ufUInasug=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-ZE0vms-ZPdCagNEYIwqCjg-1; Tue, 15 Nov 2022 13:57:26 -0500
X-MC-Unique: ZE0vms-ZPdCagNEYIwqCjg-1
Received: by mail-qk1-f199.google.com with SMTP id bm2-20020a05620a198200b006fa6eeee4a9so14667675qkb.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhhMRXuffKWmJnSyDCn2McoLOIVtIOCGZv8DUDNnMo8=;
        b=eyuXS3qXo53JkyFhSGkYzznMzIpbSLAz/HOU7vLFsOMaoblAz53Z12TGX7FeVXm7sl
         mnxa2btJ0Gbbc5vXogQG3nZvh91c8Dck4GstY0WCIkget1S6AnScp108jrNHAtCPvA47
         JRXCHUOtbFO8JeKMMBktB5EZLpMgp99kri3EwiM4p2MJ5FfUpvvECPU9jzTidtnt+e1k
         I4ob2YK3KUo1xV2J1pjel+77WShrZ3xSoo58TM8kt4z5PqpUeK6wduOB9lxHKG3W5ofu
         8YrXwCwwPGJviwvSUIv5lA5BrA/C7/knwX3ufDkjAz5ek3IRwZJnuckR69jGuL50DCGe
         JQMA==
X-Gm-Message-State: ANoB5pn5oBr8qWz2PC5o3NySpv0/rcqvdVCDPeg3NYN12Mk+oX6FqJYW
        D3vP+54+4DM/kH031jMcA3+6n9EUs04Oblq5zmyyeCTXifwhtyQEHj2f3kxgZMNcbUKABSytiah
        yK9luBZIAToUDydXoKrGyHgoF
X-Received: by 2002:ae9:df02:0:b0:6fa:349b:7ba9 with SMTP id t2-20020ae9df02000000b006fa349b7ba9mr16439670qkf.339.1668538638077;
        Tue, 15 Nov 2022 10:57:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7GD+tyKObY1rdcIBVv/8GoCtuT4sd5/XvTzrz7bCmBtCQN9hqUquK8/onwIkjV5MLTbXaA0g==
X-Received: by 2002:ae9:df02:0:b0:6fa:349b:7ba9 with SMTP id t2-20020ae9df02000000b006fa349b7ba9mr16439513qkf.339.1668538634735;
        Tue, 15 Nov 2022 10:57:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id l6-20020a05620a210600b006ce1bfbd603sm8460405qkl.124.2022.11.15.10.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:57:14 -0800 (PST)
Message-ID: <bc4616002932b25973533c39c07f48ea57afa3dc.camel@redhat.com>
Subject: Re: [PATCH v2] net: sched: fix memory leak in tcindex_set_parms
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hawkins Jiawei <yin31149@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, 18801353760@163.com,
        syzbot+232ebdbd36706c965ebf@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 19:57:10 +0100
In-Reply-To: <20221115090237.5d5988bb@kernel.org>
References: <20221113170507.8205-1-yin31149@gmail.com>
         <20221115090237.5d5988bb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-15 at 09:02 -0800, Jakub Kicinski wrote:
> On Mon, 14 Nov 2022 01:05:08 +0800 Hawkins Jiawei wrote:
> 
> > @@ -479,6 +480,7 @@ tcindex_set_parms(struct net *net, struct tcf_proto *tp, unsigned long base,
> >  	}
> >  
> >  	if (old_r && old_r != r) {
> > +		old_e = old_r->exts;
> >  		err = tcindex_filter_result_init(old_r, cp, net);
> >  		if (err < 0) {
> >  			kfree(f);
> > @@ -510,6 +512,12 @@ tcindex_set_parms(struct net *net, struct tcf_proto *tp, unsigned long base,
> >  		tcf_exts_destroy(&new_filter_result.exts);
> >  	}
> >  
> > +	/* Note: old_e should be destroyed after the RCU grace period,
> > +	 * to avoid possible use-after-free by concurrent readers.
> > +	 */
> > +	synchronize_rcu();
> > +	tcf_exts_destroy(&old_e);
> 
> I don't think this dance is required, @cp is a copy of the original
> data, and the original (@p) is destroyed in a safe manner below.

This code confuses me more than a bit, and I don't follow ?!? it looks
like that at this point:

* the data path could access 'old_r->exts' contents via 'p' just before
the previous 'tcindex_filter_result_init(old_r, cp, net);' but still
potentially within the same RCU grace period

* 'tcindex_filter_result_init(old_r, cp, net);' has 'unlinked' the old
exts from 'p'  so that will not be freed by later
tcindex_partial_destroy_work() 

Overall it looks to me that we need some somewhat wait for the RCU
grace period, 

Somewhat side question: it looks like that the 'perfect hashing' usage
is the root cause of the issue addressed here, and very likely is
afflicted by other problems, e.g. the data curruption in 'err =
tcindex_filter_result_init(old_r, cp, net);'.

AFAICS 'perfect hashing' usage is a sort of optimization that the user-
space may trigger with some combination of the tcindex arguments. I'm
wondering if we could drop all perfect hashing related code?

Paolo

