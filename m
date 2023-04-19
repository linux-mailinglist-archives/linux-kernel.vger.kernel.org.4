Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947B6E80D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjDSSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDSSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:05:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D515FFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Br4ngN1fQglzJjB6bKNoUPG9ISH75ESuia2dlD25OAM=; b=DmTdrO5al01o/2aGLet2LzP1Kh
        HKSuvcWgJGPXIExSaKftpDzbfWZsOIjKB+zmCC6cw53ikFQtQoQPwXieSSidnPDrCNTWeb6CAbsJ0
        ywZ3kdssiq7PfpzHbYw9knmZHrC5xMYO77TLty+ML2tgUZAuD7TWIoJV5LY9fBNkFQHLGsjAD5Or4
        vzagvAx+NI41DswVynQ80v3/LdfXbwPVYsNScPbvNj12vqDOTtp4W0satvvyPjLOmogkkeGVYljTb
        MgvdZA9XampIYwoYyO8kjpFoxPFd9IcSZCxEty8/54dP/zuZhf9xMRjaOwU81ToPMI5+RHkuvqv4t
        7dXJF/mA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppCAy-00DT6w-9I; Wed, 19 Apr 2023 18:05:04 +0000
Date:   Wed, 19 Apr 2023 19:05:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZEAtUE+1lzDEPZ7E@casper.infradead.org>
References: <20230419175836.3857458-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419175836.3857458-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:58:36AM -0700, Suren Baghdasaryan wrote:
> If the page fault handler requests a retry, we will count the fault
> multiple times. This is a relatively harmless problem as the retry paths
> are not often requested, and the only user-visible problem is that the
> fault counter will be slightly higher than it should be.  Nevertheless,
> userspace only took one fault, and should not see the fact that the
> kernel had to retry the fault multiple times.
> Move page fault accounting into mm_account_fault() and skip incomplete
> faults which will be accounted upon completion.
> 
> Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

