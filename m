Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179F5E8922
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiIXH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:29:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA31D338
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:29:12 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so1332113otq.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=ZsVr0q7yabDdKFmE4b0RvYJDpC4ReAh7J6+IaRkZIac=;
        b=MgP3Bi14j1EF47j8QRIFn8p0mfiL4/3LY6SQNRqnp1QBkgKiPN0SgFnSU1m6htUBMH
         q9DRtpuc86QAspRW4NWxak+QLSzUG+L+hmdnFEjJZ9Ueaq/JfM2nSD/K9CWPOZzyEU9i
         fpyjZIXHufF3pdQI4jcY2Z8OEomcx4fN99nFQejM3QptJwSd3KGiAxwTnT/4C6dPD1dp
         luG4+GaWZbWvbPC2QgUw/zZu/wYeR/F/Br/TbjMxn98k9YY0KTSSrhkpO/HImWNVduMs
         6xnZKp0W9GtlRhzsUiBtzO5kj9ZO7/9IfHbzVu4nQFX8QUvHJCWUPScUyKnfE9STBnzq
         QrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZsVr0q7yabDdKFmE4b0RvYJDpC4ReAh7J6+IaRkZIac=;
        b=Lxp6SqBqoRawIi9z+gjn4LzhbBjep7G3q1FbO8mCVlgyz4agFpMn9VVlZyQcmvW/Z7
         3AFwX65h14tssoYAWi3GJMaQAoegtJMDMRTMZ3hn8FKCBk/+S9cRpz6QIENRHng2sqP/
         96iOcsx5B3QgqQFTSDxrWkVQKJrFjndd2ek7nxvjSmehOIqh5Y/k+/f/A4kja9WEcW0w
         kDISVP9ZaxXzio1zyv/AhDAkMRCUNUENvq4eTZFC7wV99uqwhq+1R19fOEV2cTgLXWH+
         YkAfu9M1iO9RsMjTWGerv8r10sjrrpRbXtjUPmB8KuSWLDQFKZHqKtuYidopGi8SquZk
         6jnA==
X-Gm-Message-State: ACrzQf1bjT4MaV9TTVVsTs48pTYM9syo2yzTVoqvhu6sJCPGVRZOQhP9
        qajoBK7Dy214q1InMc3ju7r4Kg==
X-Google-Smtp-Source: AMsMyM7rHX9avXVvGti6b14/UhSMtpCFTnD4H/T7tGZQ0DnOKU/conEyd8/+GV2Sa0mhjuKYTnQ/KQ==
X-Received: by 2002:a9d:150:0:b0:659:f778:3b90 with SMTP id 74-20020a9d0150000000b00659f7783b90mr5552597otu.183.1664004551986;
        Sat, 24 Sep 2022 00:29:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m9-20020a056870a40900b0011f390fdb0asm5883375oal.12.2022.09.24.00.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 00:29:11 -0700 (PDT)
Date:   Sat, 24 Sep 2022 00:28:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Nathan Chancellor <nathan@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
In-Reply-To: <Yy5M0Ht6X3hFuq/S@dev-arch.thelio-3990X>
Message-ID: <ff6b391-9ec3-56a3-694c-c1954bde146@google.com>
References: <0000000000006c300705e95a59db@google.com> <Yy4g/BKpnJga1toG@monkey> <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com> <Yy5M0Ht6X3hFuq/S@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Nathan Chancellor wrote:
> On Fri, Sep 23, 2022 at 05:14:38PM -0700, Hugh Dickins wrote:
> > 
> > But me, I cannot even get the latest linux-next to boot: next job.
> 
> Maybe I can save you a bisect:
> 
> https://lore.kernel.org/all/Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X/

Many thanks Nathan, yes, you did save me a bisect with that link.
And I managed to get a patch to revert the badness,
I'll reply there on that thread now.

Hugh
