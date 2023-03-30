Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099936D05A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjC3NBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3NBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:01:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55AA260;
        Thu, 30 Mar 2023 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iZumIeXl4HeZrBWMKcDLhreN5huMTw07n6pSDNiiTBg=; b=ANc5+coFvAoz53qhvpUAreVboa
        PsfomhUa8aNd4agC0fRueuOdESvYrkBYzMtJRLaNKI2DSNdhyqjbyXzz2n+o+KmzNtyQUud/JPRcF
        1nDjybv1exWiIepldSL6sEHax3/Pox6daZlQdCFkmM23nG2dLjxwl+kBMNcVm1QRSU/IOkz0W1P0u
        vlbDS3BpmtzIL8GmOLChTIHTQ5S125tD1kzQCU4tAtHskD3ujvuQvAjbQK9L+Vd2c7kzhWI7hna81
        W1CSXG+ijYNiwx4qoQw0V31iqfNJ+cuZc3+crBBs/8EJpNFt7Xuh0coh19ij0xw+BQ6YCSCC0JvBF
        gHQTb4RA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phrts-00AQL8-Rd; Thu, 30 Mar 2023 13:01:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63684300134;
        Thu, 30 Mar 2023 15:01:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AA8F20134244; Thu, 30 Mar 2023 15:01:08 +0200 (CEST)
Date:   Thu, 30 Mar 2023 15:01:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <20230330130108.GE124812@hirez.programming.kicks-ass.net>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330043954.562237-3-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is the `struct mutex` lock backend and allows Rust code to use the
> kernel mutex idiomatically.

What, if anything, are the plans to support the various lockdep
annotations? Idem for the spinlock thing in the other patch I suppose.
