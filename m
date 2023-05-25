Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D3710E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbjEYOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbjEYOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:35:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB7B101
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:35:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3319ea112c7so15778205ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1685025311; x=1687617311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JahCaEAcBw9V6auX2WbLCtlVTk1hNDt7t03CHUqfyvo=;
        b=SILAZmmgq40xZgWfpxY3p9hsAyde96AlkJ5qyeD39YtWBjB5PFhdA77+izm6ZtU36Z
         2p3oRgcC5agZmP2e1FhX/XDexpm6x0N7qxAhYSLz3aMVpvqITip0GgGm50berArVoVSG
         PJThuD0bxmiNPDl6RLIREMJ4ptm4V1BQgu80Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685025311; x=1687617311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JahCaEAcBw9V6auX2WbLCtlVTk1hNDt7t03CHUqfyvo=;
        b=MJomlbD0W6jkf+kGHqqv14cugjR5E4j0onQdL2G+sVdB/tZBvuYENztRynr213qxYS
         sqRbqDkp78bOalnTz+mgu9bCIPjUUxtPqtYbNN109I6tXwOBO+DayTcqzKw8VRpb85H6
         rPPGuLrl3ZYXAQFGLQvbUg3RNVGY+hCum315BFhyjwo7+67jzjYvdbnfaglCePX3UXNI
         gDuFd8wot9ZxSLtsKOQxlzhrIPJ07/ik6oe1sMnrK7r6Aso86zIVMnm/Bn4pdS7B+4Na
         35kxXosfwxe6GaNSfts1y2ot6MJ7RTzhXLGTk0b7+caOloqf5hTb06rvtRuBa2Lym1Vk
         iWlg==
X-Gm-Message-State: AC+VfDx2CmRICL8/sgsfxE3iGRVxlHHbf1NudLJdOR0Bn0UwEsF6L2XG
        2Fjlfr0/vJXNFp+gedywpknikw==
X-Google-Smtp-Source: ACHHUZ57NPBBTPwP4lbLmEm986qk4qyv9srWKqLvNVrBhAlVekEW1NwCP5+Y04iPFmqJa7342e+Cpg==
X-Received: by 2002:a92:bf06:0:b0:33a:2863:2c57 with SMTP id z6-20020a92bf06000000b0033a28632c57mr7791038ilh.9.1685025310896;
        Thu, 25 May 2023 07:35:10 -0700 (PDT)
Received: from fastly.com ([216.80.70.252])
        by smtp.gmail.com with ESMTPSA id o14-20020a92c04e000000b0032648a86067sm374789ilf.4.2023.05.25.07.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 07:35:10 -0700 (PDT)
Date:   Thu, 25 May 2023 07:35:08 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, edumazet@google.com,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        haoluo@google.com
Subject: Re: [PATCH bpf-next] bpf: Export rx queue info for reuseport ebpf
 prog
Message-ID: <20230525143508.GA21064@fastly.com>
References: <20230525033757.47483-1-jdamato@fastly.com>
 <26c90595-f45e-a813-d538-0892c3ef2424@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c90595-f45e-a813-d538-0892c3ef2424@meta.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:26:32PM -0700, Yonghong Song wrote:
> 
> 
> On 5/24/23 8:37 PM, Joe Damato wrote:
> >BPF_PROG_TYPE_SK_REUSEPORT / sk_reuseport ebpf programs do not have
> >access to the queue_mapping or napi_id of the incoming skb. Having
> >this information can help ebpf progs determine which listen socket to
> >select.
> >
> >This patch exposes both queue_mapping and napi_id so that
> >sk_reuseport ebpf programs can use this information to direct incoming
> >connections to the correct listen socket in the SOCKMAP.
> >
> >For example:
> >
> >A multi-threaded userland program with several threads accepting client
> >connections via a reuseport listen socket group might want to direct
> >incoming connections from specific receive queues (or NAPI IDs) to specific
> >listen sockets to maximize locality or for use with epoll busy-poll.
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> >---
> >  include/uapi/linux/bpf.h |  2 ++
> >  net/core/filter.c        | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> >
> >diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >index 9273c654743c..31560b506535 100644
> >--- a/include/uapi/linux/bpf.h
> >+++ b/include/uapi/linux/bpf.h
> >@@ -6286,6 +6286,8 @@ struct sk_reuseport_md {
> >  	 */
> >  	__u32 eth_protocol;
> >  	__u32 ip_protocol;	/* IP protocol. e.g. IPPROTO_TCP, IPPROTO_UDP */
> >+	__u32 rx_queue_mapping; /* Rx queue associated with the skb */
> >+	__u32 napi_id;          /* napi id associated with the skb */
> >  	__u32 bind_inany;	/* Is sock bound to an INANY address? */
> >  	__u32 hash;		/* A hash of the packet 4 tuples */
> 
> This won't work. You will need to append to the end of data structure
> to keep it backward compatibility.
> 
> Also, recent kernel has a kfunc bpf_cast_to_kern_ctx() which converts
> a ctx to a kernel ctx and you can then use tracing-coding-style to
> access those fields. In this particular case, you can do
> 
>    struct sk_reuseport_kern *kctx = bpf_cast_to_kern_ctx(ctx);
> 
> We have
> 
> struct sk_reuseport_kern {
>         struct sk_buff *skb;
>         struct sock *sk;
>         struct sock *selected_sk;
>         struct sock *migrating_sk;
>         void *data_end;
>         u32 hash;
>         u32 reuseport_id;
>         bool bind_inany;
> };
> 
> through sk and skb pointer, you should be access the fields presented in
> this patch. You can access more fields too.
> 
> So using bpf_cast_to_kern_ctx(), there is no need for more uapi changes.
> Please give a try.

Thanks! I was looking at an LTS kernel tree that didn't have
bpf_cast_to_kern_ctx; this is very helpful and definitely a better way to
go.

Sorry for the noise.
