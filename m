Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741DF707538
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEQWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEQWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:20:07 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA240D4;
        Wed, 17 May 2023 15:20:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38bed577755so513195b6e.0;
        Wed, 17 May 2023 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684362005; x=1686954005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl82PCjaobzfyCKJH7gtzfUj7oNT+ck4bpgRl4YkUEo=;
        b=BdHBv35odlVW1N+ZrB/GBkSKhSQ+DKRwN0hJ1qtOce2fCsj/xoh04THq9wQ+SK0XHA
         IGAEPXceJkfbZAYFISewGISfl39bOQyR/svy7B6Wgqnk75i/r+3WVthbQZMMWNt0ixny
         IUMwwxHT74yuJAyour/hSxrm4ICocp+t124akNbTGAphaJsh+YfTGSHDylvhBd8Rcd2n
         zh9TukZBHTGP62ZRZt23A72JkB0ZTCKknWQyabH9oQF9PfCSrdjBwMqnHo7FVPRuh5Aw
         yeDbmbQkNGQuz/xRMJlHEBQWSHkk1WC8qWaqskP71QX8ftFoa3OHavgFun2vgQ7Kgiwc
         NwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362005; x=1686954005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl82PCjaobzfyCKJH7gtzfUj7oNT+ck4bpgRl4YkUEo=;
        b=ARUUERhf4CjNHzjVebnv+wzur2y0pc8E0jXrOHVIToGHsEt9dn3kIeust5DZ6QL/zG
         HAAV5xoEg3Y0Kh/XtVwGUYfmlSpAubeVdC+g+dPQ7YG5iYvRM++4Aq3QWxkl/eI9DfVt
         609a1l5MUAcnydoMFpXYs7B6d2+pJodJiwxsBEZ0CkhjBu1b6OqDCJdME3ZZ/WAAyFI6
         oIJb1WdIolQwM9rbhSzjfnqJgI+zcDJA5bYRq0yZ7IBb4LccxL2uEpgkZAZcmYyd9vrB
         oNZcPiuLM0x/TJ1pKCN6X5ZebCe9sARz0suFI0YhanXI1+fnmQtXtnqQxOXd8bJOlVjr
         vKWA==
X-Gm-Message-State: AC+VfDzW3xVf3fIwqO5WNXwFJOFhDFyquRrWDQM2fo5owZXiiGXycNDl
        hZjxf8P7d/h2hY52F4piuQ==
X-Google-Smtp-Source: ACHHUZ62DLogLUNsC8TqXrkQqOHBtNk4cq3H0sVPcqClw8bHfoWVgTJVaVSiw74+HfwPocRxMMjcBw==
X-Received: by 2002:a54:4e01:0:b0:396:26bf:d66c with SMTP id a1-20020a544e01000000b0039626bfd66cmr128316oiy.45.1684362004949;
        Wed, 17 May 2023 15:20:04 -0700 (PDT)
Received: from C02FL77VMD6R ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id m125-20020acabc83000000b0038c06ae307asm4021oif.52.2023.05.17.15.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:20:04 -0700 (PDT)
Date:   Wed, 17 May 2023 15:20:00 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
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
Message-ID: <ZGVTEEiosnRHTzlZ@C02FL77VMD6R>
References: <ZF1+WTqIXfcPAD9Q@C02FL77VMD6R.googleapis.com>
 <ZF2EK3I2GDB5rZsM@C02FL77VMD6R.googleapis.com>
 <ZGK1+3CJOQucl+Jw@C02FL77VMD6R.googleapis.com>
 <20230516122205.6f198c3e@kernel.org>
 <87y1lojbus.fsf@nvidia.com>
 <20230516145010.67a7fa67@kernel.org>
 <ZGQKpuRujwFTyzgJ@C02FL77VMD6R.googleapis.com>
 <20230516173902.17745bd2@kernel.org>
 <87ttwbjq6y.fsf@nvidia.com>
 <20230517114805.29e9bdca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517114805.29e9bdca@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:48:05AM -0700, Jakub Kicinski wrote:
> On Wed, 17 May 2023 11:49:10 +0300 Vlad Buslov wrote:
> > I wonder if somehow leveraging existing tc_modify_qdisc() 'replay'
> > functionality instead of returning error to the user would be a better
> > approach? Currently the function is replayed when qdisc_create() returns
> > EAGAIN. It should be trivial to do the same for qdisc_graft() result.
>
> Sounds better than returning -EBUSY to the user and expecting them
> to retry, yes.

Thanks for the suggestion, Vlad!  I'll try this in tc_modify_qdisc() and
tc_get_qdisc() (for Qdisc deletion) in v2.

Thanks,
Peilin Ye

