Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF663DC18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiK3Rgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK3Rg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:36:28 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EB2935A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:36:28 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t62so19488901oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAKs3FMJBtAtSZmpMRqAhPhuYj2WYHmeTXUWNI3mQVg=;
        b=fJBBa1j79Fa7M86oY1GqNIx2ObJfcN5mkJX50cLznX2i/Mlzs/UYvl4OW57QqMmhG0
         ONTAX680s68WxcDKVX0S8CMyE+l1doSN7smFea8TsuQD/LRKFwk3L8vFBsC/Xjnnru/V
         S+yUFYkIHXbOz90AAwQZbe7iuYN+6WIMprTOi0la2d5y64Ju30bZzim+TrVfUCuBWmnP
         yLN1wwz0ydAvWiKE9WeVvXhQzh6YlFCnQfkvEyQSeX24fUjBSs/h9qkY3kWLB0j9Myj9
         cjkqAvWDw/EyCgvdIhk8fgwjkPQe1F8swmEwAaTOGPyeul5eGkiHnoNereC82GlOkSqE
         rbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAKs3FMJBtAtSZmpMRqAhPhuYj2WYHmeTXUWNI3mQVg=;
        b=FpFmB2HI647U1TsrGbhuupkzqh2RIW7Wkd4PO2/WR6ycYgbtDKAuXClGNDBpp3Uv0j
         3r7s7KVRp+kdHmaGvJ6vvPXPmhcVxEkYVmHDdgP9HcTZ71dza5d+QTZSwwscJB3/qw3e
         jguTN0pABzEVZJXG/hPQo3/Yf60WaM6qYXzzz6EqBQeKUyhS1KtLla5yahSFXeODHrZJ
         NjVvC/4SEIuiizxMGaBAZcG3HkqmPSUL8Ow/z0QbSIjI8jAMCpOtGKCc3Z65X2MslecK
         +xrm2rvHYyf499hRZO84yqxFaimTGWcbWj3YcJd3crtQSI2cCzcSQb43RUHQaS94uIlD
         S2UQ==
X-Gm-Message-State: ANoB5pnQLsRk+ylE3Ri+uxyyCZiHvSUgoYaIwJm5aox2Fmx9yzlJDaKH
        Qm42ZlZ5ep9QmkB2WQZoRgAS6Q==
X-Google-Smtp-Source: AA0mqf4EHlC8pv70KzQMLzwL/6dlo9KVductf3RY5PwTszGiOsMncGGVm23R7x/WfITlKlQsD97G0Q==
X-Received: by 2002:a05:6808:493:b0:354:6112:4160 with SMTP id z19-20020a056808049300b0035461124160mr30939687oid.11.1669829787189;
        Wed, 30 Nov 2022 09:36:27 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056830374100b0066871c3adb3sm1174153otb.28.2022.11.30.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:36:25 -0800 (PST)
Date:   Wed, 30 Nov 2022 09:36:15 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Shakeel Butt <shakeelb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
In-Reply-To: <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
Message-ID: <e0918c92-90cd-e3ed-f4e6-92d02062c252@google.com>
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com> <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org> <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com>
 <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 30 Nov 2022, Shakeel Butt wrote:
> 
> 2. For 6.2 (or 6.3), remove the non-present pte migration with some
> additional text in the warning and do the rmap cleanup.

I just had an idea for softening the impact of that change: a moment's
more thought may prove it's a terrible idea, but right now I like it.

What if we keep the non-present pte migration throughout the deprecation
period, but with a change to the where the folio_trylock() is done, and
a refusal to move the charge on the page of a non-present pte, if that
page/folio is currently mapped anywhere else - the folio lock preventing
it from then becoming mapped while in mem_cgroup_move_account().

There's an argument that that's a better implementation anyway: that
we should not interfere with others' pages; but perhaps it would turn
out to be unimplementable, or would make for less predictable behaviour.

Hugh
