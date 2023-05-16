Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1A704798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjEPITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEPITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:19:37 -0400
X-Greylist: delayed 629 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 01:19:34 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D9CD1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1684224542; bh=MGnFW31psCJp5sPWKx6WOpe7YpGa7jmZLWFLPIu43/8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ImdhTrlz2TqRRcSvdWzpxHRRWXoijUmOuAdWQqj2quRa/ovXFZYWeEIaReDrwjfrO
         TnljqfKs5ulPVfG+RoWq2AE72R/O4HEu7YtMjmbNB62p2M6BtYxDSGQBP1KpaFveoJ
         dy0gVMm/nL9KJRVQJbnDOi7WxFYOpDAo+OeDY1UBio2M+QwV/fyzZtDlQFqvyxgX0e
         Sv5kCwQBfFaiT0TrrX1btJTwuHwvmLD77NnSw7oniRPxd+OjPYgPkrH94EXoxmuFey
         QFwAl6W1yApZpSevVNfVNzPsXLVLu4aSRJZba0bRiySAbUdXW49Fb+uI94wdFSk32k
         K7IYDUeOjhlxg==
Received: by gentwo.de (Postfix, from userid 1001)
        id 3E76AB00191; Tue, 16 May 2023 10:09:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 3CFF1B0009A;
        Tue, 16 May 2023 10:09:02 +0200 (CEST)
Date:   Tue, 16 May 2023 10:09:02 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v8 00/13] fold per-CPU vmstats remotely
In-Reply-To: <20230515180015.016409657@redhat.com>
Message-ID: <b1f75dca-5d86-125f-bbba-7b575b62d21@gentwo.de>
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset still modifies the semantics of this_cpu operations semantics
replacing the lockless RMV operations with locked ones. One of the
rationales for the use  this_cpu operations is their efficiency since
locked RMV atomics are avoided. This patchset destroys that functionality.

If you want locked RMV semantics then use them through cmpxchg() and
friends. Do not modify this_cpu operations by changing the implementation
in the arch code.





