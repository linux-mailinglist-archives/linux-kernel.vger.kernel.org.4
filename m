Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEDB74DBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGJQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGJQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:57:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0EF4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5hY1mK8fZM8mievQWkaMMm4+MneK9G0ZnnK8toOvx5I=; b=SC+66HP1BlDPbpQxGahSSWJ35M
        fT6K1bP7MUlouKf8yvfhfswwGpb/mbAW3m53gPRX7XBqo330JJQl9BvEOkYZh9wH9u9cQ8geX4hTj
        68Cz11xkwt24Pk9OFzlaAxAN/qJIWRzpgNkNBBtS46ucnHNBHeVMIt12ctwIhseska14knK2K9hCp
        thirdKfVxI4CUfFStNeBw0PlX+Z64djfBnS195SpYcbnvGeKb3aQFH3x4MU2CrZ1zp408NZPDncrH
        wJ17RZlMyUJt9gRwxUDESpCoAjeT3wznlCKDgG2OM/iiDflUJ9LP8iZVDvHM0Is37WHh991T39jps
        usjWds5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIuCS-00EljV-7C; Mon, 10 Jul 2023 16:57:24 +0000
Date:   Mon, 10 Jul 2023 17:57:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Message-ID: <ZKw4dJpNIPtSVKGA@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
 <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
 <8304d1e2-2848-858d-e25b-5eeef8606754@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8304d1e2-2848-858d-e25b-5eeef8606754@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:07:47AM +0100, Ryan Roberts wrote:
> I think this compaction issue also affects large folios in the page cache? So
> really it is a pre-existing bug in the code base that needs to be fixed
> independently of large anon folios? Should I assume you are tackling this, Matthew?

It does need to be fixed independently of large anon folios.  Said fix
should probably be backported to 6.1 once it's suitably stable.  However,
I'm not working on it.  I have a lot of projects and this one's a
missed-opportunity, not a show-stopper.  Sounds like Zi Yan might be
interested in tackling it though!

