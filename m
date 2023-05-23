Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7153D70D278
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjEWDoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWDoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:44:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBCA90
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MnRcPFIPcgsXKY32Wes3cbPQqcL7hwCbiuzXvG9RsCg=; b=PAUsKu+GHlfjskoli9bkEtf9K0
        eZaZB4xS3IinYWwq5N1PlN0+xBjBuDNmx0Nu4T3X9Mdax5ZHg5yokNcQb0Ywvw5ZnJ4TVoPKC7Dyj
        GUPCUahr3btuTUM4s2SC8uEGiDKY5m/VBkvMlVqd0diYWUUeSx4JwxoJuiTySnPAkxdDniYkhsNAD
        8ZtXYKc13OfXIU1vFYp2oqYN0N4LqGXFLysJjsLD9+ouo27VvID02U7KeuPKusJoFEzHfzp9CiXfG
        crUaezazuztMVL1iRigCbmAVKPCAAUYgdulOo36VhI6oy/oc0wJv0kxp9r04uJ8zIsbYS9g/oSB/X
        PMTnDHEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1IwC-009kVr-LA; Tue, 23 May 2023 03:43:52 +0000
Date:   Tue, 23 May 2023 04:43:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
Message-ID: <ZGw2eJxxQl4DrfWi@casper.infradead.org>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
 <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:39:27AM -0700, David Rientjes wrote:
> I think VM_BUG_ON*() and friends are used to crash the kernel for 
> debugging so that we get a crash dump and because some variants don't 
> exist for VM_WARN_ON().  There's no VM_WARN_ON_PAGE(), for example, unless 
> implicitly converted with this patch.

It could be added, but there's already a VM_WARN_ON_FOLIO() and
VM_WARN_ON_ONCE_PAGE(), so hopefully we just keep converting code
to folios until nobody notices that we might need such a thing.
