Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3758070E76A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbjEWVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEWVgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:36:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CEFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:36:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-306dbad5182so6395f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684877810; x=1687469810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ5K7dlutGkMyOa+L7swtJKw1T6VrOfxQw91P9GKg/c=;
        b=u9Bbr4+Qiz7b1Pu4j+NnA4t0BD2NhAyGr55vUSUZkkNJcyyPDqt7KGrotGkkXjNFI5
         QZHOD1WJpXO55O/mIAFU1yougV5MJOr5L3rhXl2LsIJ+X6rou+5MLc8w/puzT7QqiIWK
         REC2DxbjbOVndco/bUNqZ76fD0/lj8P7dtG/ucSL4e+yrvwkJuu3FhBjop2DKi9k/ELX
         La1cHz3no1l4IhNsv2eP8BVGVnZf8KEfDao5Ct8sgaLWqo+fjoEZzEiw+TsT+KMV/thp
         1gejzFk8qCCY1zJmdfsBZfBs9eyQLJDQPs5wb6bgu1IiDhfUQuTXloINPPeB0KrULofO
         33SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877810; x=1687469810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJ5K7dlutGkMyOa+L7swtJKw1T6VrOfxQw91P9GKg/c=;
        b=gDy/Va+tccfGwZZLBbONNvdSzBVSdRkl6ZduD6qmAhhLzIhqOKdaIvSTzdtJTe8vvA
         cxVPUeS6NKhQtOdj2YB5UDkdh3sDd7IiYVqzZGTqFAk5jekxjnP7sqZkQFwUIEy7kUCl
         p0m+BmAaDk1oOhWv/eBreTCJLhQ7PePoqW1NaXNqmFo2oui2UgfAu7unWJig5gw5n3C2
         o4D9L42U4EVIx9JOVAijAnOKllCkqBKRkUcAETjiCFfsP011hnIOYI2dXI4w4w3l8Yzl
         3l6Q53p6LjpPMyyqCqhOLYdAG0YYkPg8z+5TWqQL3ShYa6ktYAcxxvwLgfsnJrKST0fn
         KiUw==
X-Gm-Message-State: AC+VfDzP0yIAk01LzRdkoJ6DuZIe6Fr/Xj01QOp3FLOGeVDEldCzc83J
        GmgwHLxp0eFUdgQKejWpMJizYhbdRMW2vAccKVv+dA==
X-Google-Smtp-Source: ACHHUZ7Vvmg/4c3r7SsL9lksoS1NrVLe33/emBnb8TTtsX5HBT/PttY5MM3zrcVA2t8F8oU67MY9TalYYNedfSbAgZY=
X-Received: by 2002:a5d:4bc4:0:b0:309:4227:829c with SMTP id
 l4-20020a5d4bc4000000b003094227829cmr11007981wrt.36.1684877810453; Tue, 23
 May 2023 14:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
 <ZGf5rfESYhKYzPSY@slm.duckdns.org> <ZGgAKK-c_DZpvNJB@slm.duckdns.org>
 <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com> <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
In-Reply-To: <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Tue, 23 May 2023 14:36:39 -0700
Message-ID: <CAB=BE-QgcoHEQo+2moWsDfpq3mR7gbDN5+tvWRrMt2Qhucfj_Q@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Sandeep, any chance that you could try out Tejun's series with plain
> workers, and compare it to the percpu threads?
>
> See
>
>      https://lore.kernel.org/lkml/20230519001709.2563-1-tj@kernel.org/
>
Hi Linus,
I will try out the series and report back with the results.

Thanks,
Sandeep.
