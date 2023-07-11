Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1A74F9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGKVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGKVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:45:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856C10C7;
        Tue, 11 Jul 2023 14:45:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356fe4so34065335ad.2;
        Tue, 11 Jul 2023 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111904; x=1691703904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgtYI22NCwe9dx+Of1T/iE4i1/7dLMof/+iCsFkq1rs=;
        b=O7nGdWt5CZLCDIWmoNlNzyBNO2oiXqA+AoYOgty59JgmhaLp+WI7FZmqDrqOYrsPno
         wUkDh7CZ2gsrxvq+wDP8Tl9j3RPftB6TBpkpLiWUECFlJeV+qnKFDtrepyOk8ms28Jv2
         puqa8CMEbbdsL7sgzT2PYIX+m0KTnDiQ4Jk+Q7XaYnP6ST2p79x25yLIxyy43moyP/zr
         7rAgOAdwrSp1qs6zUj7vthz3IV42KdN8S/UNGyTt/QvQIhi2brWchIPL3cOc4aavKkcZ
         h005FkNhxVMx8XSZTlzhbXk0GZtM/LGFNUdeCOENv+G/J7V7nG1J3CLqqK47R0/UAoaj
         WSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111904; x=1691703904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgtYI22NCwe9dx+Of1T/iE4i1/7dLMof/+iCsFkq1rs=;
        b=dMwxAYWvtwVvS4VTJgVo0A2hex8Em+EC6RYEuhbUZ3fH33jRRIN9bS00mr6ctU7CEW
         4fzSqccYUhw+3VIeQIRYH2J9U/pGYfKX05lAJQsGFoW+JIci5uxVV5XujuwsMwRjkDdk
         pw0XDPFHPxIsPm7VwXPgAdTSAAUW777tMkpTxCRUsX8dvmpXmIhKe3cY5yl87BkDIyFP
         B71zaf/DD82N2bEmJ2RZtVYEpdOP0dLMMGlOitaJntBxb4Pnxp4tN2UQRsAuQ0e+UB2v
         I0/jyZ3Hqov61dz+vNpUdtmuwSI+kWfO0M3o6BHkFJcioS4lATshKbumUl9w7SSUfNCC
         cOKw==
X-Gm-Message-State: ABy/qLYDYbjiHPXt6ozXIaXlp+7L4eJ1+u52txIcbwak/rv5N6buWfn6
        XJpY9XuDKt3bZpxUzkgnnfs=
X-Google-Smtp-Source: APBJJlEDpmEKUfT11rMvOXkdzqveqwgVWu1FyToCJCqX4+ayDvDmicIYt53U0JjbmgG4PbVbvN3tZg==
X-Received: by 2002:a17:902:a60f:b0:1b9:cca6:551b with SMTP id u15-20020a170902a60f00b001b9cca6551bmr8700837plq.7.1689111904384;
        Tue, 11 Jul 2023 14:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001b9de2b905asm2397378plb.231.2023.07.11.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:45:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:45:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 12/34] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZK3NXp02NbnWe61q@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-13-tj@kernel.org>
 <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:21:48AM +0200, Andrea Righi wrote:
> On Mon, Jul 10, 2023 at 03:13:30PM -1000, Tejun Heo wrote:
> ...
> > +static void free_dsq_irq_workfn(struct irq_work *irq_work)
> > +{
> > +	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
> > +	struct scx_dispatch_q *dsq, *tmp_dsq;
> > +
> > +	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
> > +		kfree_rcu(dsq);
> 
> Maybe kfree_rcu(dsq, rcu)?
> 
> With 7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> we don't allow single argument kfree_rcu() anymore and I don't think we
> want to use kfree_rcu_mightsleep() here...

Oh, thanks for pointing that out. I'll update.

Thanks.

-- 
tejun
