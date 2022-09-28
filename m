Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517A5ED42B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiI1FQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiI1FQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:16:46 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBA127C9C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:16:45 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-131a17bf7fdso1323637fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=RRxMxuisd8lNkNGWBlf9ZKEk1omHCIF/OzgSnFJx1kM=;
        b=rp3aMO0gAAhK0s2GVDrsTX/gwBmv9vZ3TFYoRHevkUoy9MkVX+I1yOVHL2U+wScbD3
         a4Iu0r7SxbTXEQwzbBoZotEQ4SXYXNn9iUmyFlUxqyCmRZN4Kbm2xqd6f6dFNjiPuyB3
         jdUvgYFtYBIDqfDNZgg4N/aFo2WUQzp96+1+1PTKz7p9Qa9H86j2OxuffAhEqyzPvh3J
         I+BvstOwG6UAnBYqKE2CW9ZXw42ycTphdbRCqVp8/lewnvDIwfOHR1LyGlrrnA8Noqr7
         KDmEIYBn6ZmUCKQBmbNp8Pczg76HqN9FdijVfr11GfCtPvQthYMEEnTlZ2ohWkIOiJ3C
         OXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RRxMxuisd8lNkNGWBlf9ZKEk1omHCIF/OzgSnFJx1kM=;
        b=Z6mvlyzbEBwIeK/M18fFYDAKS+sbluaey2sDCM7a1WAxM9/p5xVRSfnvVuNx22kRIR
         HlJ3a4pB0NTXgNHxnLZRtwhxMWVw3gZOV6EkWDFxwUkPQoPgEafh5TCUTCOCfumbQ9gN
         jfPLNTtB/EnykUXKi/SxAyLPqFXhg7bigVooTy3JVm5Cs4TZ/T9OMVrvN0YnK2zS+yHz
         9atYcYu8dQumzbEUaGubGSZFqyn2a3uyRmv4IGJoglLZdf1ioGFOSe3wkeEXktdbuN06
         JFGmwtxpiy9dJyBBVGsBQ4XZ4cBfeEedEumKZuNdXQhgjCD1GB4qhkfxRy/F8k9HbFVX
         t1qw==
X-Gm-Message-State: ACrzQf3Mvl/RNGqdNTD49Ja1LIvb5+x8D+sqY7HOSh8vYn2aOLQ4peYq
        DpA4WofFHLHhNErRNk4wqmZsj3sJcoC1Sw==
X-Google-Smtp-Source: AMsMyM4PZ3D1UYkxS5n08OIECJI0ht8TLoWou8MHGKLjkqkXvqmfbdICMQDwIMHH775ucD9gOnhgSg==
X-Received: by 2002:a05:6870:80d3:b0:126:1e6c:f01c with SMTP id r19-20020a05687080d300b001261e6cf01cmr4613620oab.17.1664342204582;
        Tue, 27 Sep 2022 22:16:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q5-20020acac005000000b0034fddfc5922sm1466958oif.36.2022.09.27.22.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:16:44 -0700 (PDT)
Date:   Tue, 27 Sep 2022 22:16:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
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

It's a bug in linux-next, but taking me too long to identify which
commit is "to blame", so let me throw it over to you without more
delay: I think __PageMovable() now needs to check !PageSlab().

I had made a small experimental change somewhere, rebuilt and rebooted,
was not surprised to crash once swapping and compaction came in,
but was surprised to find the crash in isolate_movable_page(),
called by compaction's isolate_migratepages_block().

page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
which expects struct movable_operations at page->mapping minus low bits.
But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.

Over to you! Thanks,
Hugh
