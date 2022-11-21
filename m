Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F759632D37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKUTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiKUTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:47:27 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744DD53BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:47:22 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3876f88d320so123690427b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=miGLX/uer5DgQxU7dvQq3Q5LleCS+CJp67dSlDVaExE=;
        b=W2eOWoW8GzSBhampXzP/DkPaV0qxqLK7MXncDfdEBhfBV0RYg1+uYg9j9oBTndzM3T
         96Ik633xtnuZok5Z8y8RfrMiVr+a75bpLEwv/Rl49WaGFUifA/lPteT7VUVt2P1uaNhQ
         p6q1xNDRV1aNGPRDHmUu9DNNwkjc6hHvJIPJOp2GqIagFJX82jlHrGYZvUM01JjJD3YY
         Xs/LFjGEpBLKr7g+8yqOzY+gYblQXhLmDy2WnCKnCLP1bT6JOr1nxQsyB5lsnEqVPY3q
         kgAF8ahZxe+UEz+dCBQN3snrVjZ4vOkXoAlPIL0CyKCWtXsWjSGEHAsdyGjs/gC+GDmJ
         DHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miGLX/uer5DgQxU7dvQq3Q5LleCS+CJp67dSlDVaExE=;
        b=Fb/FZLd/+kQ0/XK2xjtAGWqdeNQ9zUNGXBkSAQ0K4TNz/FsKuqM3IfEFdG/ZrtQFFz
         zpREET3FwP3lpCVn7SwZCLkcPUr1cVD+xfEf2DHRZ4KcEhNQXTGxeuECKPT7uKnodp9C
         LJIWAKPZvPOhbCYCJCg2YHLeC6M98r8BP06Za8OLodLF2EVmzGHy+x+zPa5HWygx9h0U
         9A1tN+bsqRlNedMAahgwoT93cdqxJIKYDW+DAh1W6G86cqkkVmfbaSwsaG3TOW72OdnT
         PipbcVn2YPnWHNYSb1EzrOpzJQnfiHJtzFjoNcP15ipQBOwZCQUXJ2XQ35Qzo6M//C+5
         kjtg==
X-Gm-Message-State: ANoB5pmngK7UiKVoHr7wSj05sD+Nlfn4IQOR8FIq4SesxqIW164Tcw9+
        SdBeYbu+tvMQcpdBmjLDmChrTuZGsZpnT8Es7qzD0g==
X-Google-Smtp-Source: AA0mqf7B/dgQPr7bn/BklMbZlqJRMsNTBtq6JKRQPaSuWwvWGzkQMMVJYbTG6638TJXaq3twZOa68lSzR7DB2QQgO3c=
X-Received: by 2002:a0d:c103:0:b0:370:7a9a:564 with SMTP id
 c3-20020a0dc103000000b003707a9a0564mr18324139ywd.278.1669060041149; Mon, 21
 Nov 2022 11:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20221121182615.90843-1-nbd@nbd.name> <3a9c2e94-3c45-5f83-c703-75e1cde13be1@nbd.name>
In-Reply-To: <3a9c2e94-3c45-5f83-c703-75e1cde13be1@nbd.name>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 21 Nov 2022 11:47:10 -0800
Message-ID: <CANn89iKps9pM=DPn1aWF1SDMqrr=HHkHL8VofVHThUmtqzn=tQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_flow_table: add missing locking
To:     Felix Fietkau <nbd@nbd.name>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:45 AM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 21.11.22 19:26, Felix Fietkau wrote:
> > nf_flow_table_block_setup and the driver TC_SETUP_FT call can modify the flow
> > block cb list while they are being traversed elsewhere, causing a crash.
> > Add a write lock around the calls to protect readers
> >
> > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Sorry, I forgot to add this:
>
> Reported-by: Chad Monroe <chad.monroe@smartrg.com>
>
> - Felix

Hi Felix

Could you also add a Fixes: tag ?

Thanks.
