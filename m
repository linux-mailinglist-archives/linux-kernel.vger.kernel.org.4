Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF95FFBD6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 22:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOUGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 16:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJOUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 16:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057843625
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 13:06:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93C071F8B2;
        Sat, 15 Oct 2022 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665864368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d195GuIU1w2GH4mO1pb865I7+J+Sq8iEhi1gyiUJdtY=;
        b=Am9p6LzQDFspTjj+DpqXDdTwG9Zn5jMrTm7LIh1NNXwj1pcybri5RhdeuA+s9m63QQiRx5
        7S67yU1GHZYjgiGkEjspVysKMsktcbI0YxZkkvfrkmEIju7p7yBJR90Ns8zS+/YjCtTZDJ
        KUwQ+8slUL2Bpi+MRF8qg7oi3SnWHVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665864368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d195GuIU1w2GH4mO1pb865I7+J+Sq8iEhi1gyiUJdtY=;
        b=17IwrYcP0W8nM0caKmkeOzNRircviKwgCPIZgZdHVP15aCRqyU7Op6IvocIB05I6Osa1mH
        DLMeYb+d+xr5CBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62877132C4;
        Sat, 15 Oct 2022 20:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kh5dF7ASS2ONIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 15 Oct 2022 20:06:08 +0000
Message-ID: <83deef1e-48ab-6e29-4611-2e7c37d023c8@suse.cz>
Date:   Sat, 15 Oct 2022 22:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab hotfix for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Feng Tang <feng.tang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab changes from:

    git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.1-rc1-hotfix

It's a single fix for the common-kmalloc series, for warnings on mips
and sparc64 reported by Guenter Roeck. It's rather last-minute, but I
thought it would be better to avoid the warnings in rc1.

Thanks,
Vlastimil

======================================

* A SLAB fix for warnings during creation of caches with off-slab
  freelist, by Hyeonggon Yoo.

----------------------------------------------------------------
Hyeonggon Yoo (1):
      mm/slab: use kmalloc_node() for off slab freelist_idx_t array allocation

 include/linux/slab_def.h |  1 -
 mm/slab.c                | 37 +++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)
