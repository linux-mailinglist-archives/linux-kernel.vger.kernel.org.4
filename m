Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4340A71967B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjFAJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjFAJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E192E1B0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685610637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g14oLQSgEmt6zzVDTbcm+P3Q+U0P9qW/qGUNJAVuUPE=;
        b=VylsQlPRsP/8exxbLkaGXHNjXJjdQ8z86QYJYkdZHpMKqaY06lo+Fonv7hx+EUR5nXu4rK
        65DQi19jNzDUEoKgFiVV5yKQs1VC4truTate37/FsMVV+5jtC+5aga0DkM4f2hmk3vpzwb
        jSZvqCul1cb+/KnlAwVlAvraceUVGmA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-EquZ1fcWN7GPY8WLBLqrDQ-1; Thu, 01 Jun 2023 05:10:35 -0400
X-MC-Unique: EquZ1fcWN7GPY8WLBLqrDQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f605aec1dcso992735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685610634; x=1688202634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g14oLQSgEmt6zzVDTbcm+P3Q+U0P9qW/qGUNJAVuUPE=;
        b=hZwELfkBG6BAKfjHTLzVInwoy3Hb/AQ3pTyVcNzhQXnU7OzooTgGdWGR7IAqVfgoGa
         Nh3uuSe5PdrhkvxG/BzDxE/SY6G0dIFOMmA49qVjMYOO19Tm1KvI7AEYjEUiTnUao30f
         sMISti7L/PbXrmKMN5Uhsnvi+a2n0IjirLjCcisbBcUW0NC/X9RNe7+qwOEYaBdUbZ0d
         6MUDE0bLJolw7J4XW917XAmzFszgF1bz4cTtLQjD52JGHVWvFI3E5Xt4ctc2jRp2Y39F
         uGHq+DfQvbvyaUFdLjffusztCMemNQcM0qMdHhl38sEtF1JEcx/FyQqFpAkFm86pSFU9
         hdfQ==
X-Gm-Message-State: AC+VfDzTh0IThEKEq7rGBD6TzlacFT5cbnM/sredrVyARa8NLVj35jHH
        Dk9u0DkG5m2mKZj2hZiPU1ZbmeaLcnuoHJ7tk2PbtUuNq88+RE18I6MmQKzgkk40Y6HH0/4VAz0
        1RSkem72V0dUEPsAGWeS/pDx7
X-Received: by 2002:a5d:65cd:0:b0:30a:de3e:9662 with SMTP id e13-20020a5d65cd000000b0030ade3e9662mr4035105wrw.5.1685610634682;
        Thu, 01 Jun 2023 02:10:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mms0A1WlCkP0K3yaI/0fZc23SLgg5alz4C88Skxnyews44HVbaLI8fulqGUNquQeEpquSQA==
X-Received: by 2002:a5d:65cd:0:b0:30a:de3e:9662 with SMTP id e13-20020a5d65cd000000b0030ade3e9662mr4035097wrw.5.1685610634405;
        Thu, 01 Jun 2023 02:10:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-89.dyn.eolo.it. [146.241.242.89])
        by smtp.gmail.com with ESMTPSA id r13-20020adfce8d000000b0030630de6fbdsm9441149wrn.13.2023.06.01.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:10:33 -0700 (PDT)
Message-ID: <db32243e6cb70798edcf33a9d5c82a8c7ba556e2.camel@redhat.com>
Subject: Re: [PATCH v4 4/4] sock: Remove redundant cond of memcg pressure
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Jun 2023 11:10:32 +0200
In-Reply-To: <20230530114011.13368-5-wuyun.abel@bytedance.com>
References: <20230530114011.13368-1-wuyun.abel@bytedance.com>
         <20230530114011.13368-5-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 19:40 +0800, Abel Wu wrote:
> Now with the previous patch, __sk_mem_raise_allocated() considers
> the memory pressure of both global and the socket's memcg on a func-
> wide level,=C2=A0

Since the "previous patch" (aka "sock: Consider memcg pressure when
raising sockmem") has been dropped in this series revision, I guess
this patch should be dropped, too?

Is this targeting the 'net-next' tree or the 'net' one? please specify
the target tree into the subj line. I think we could consider net-next
for this series, given the IMHO not trivial implications.

Cheers,

Paolo

