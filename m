Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7872668A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjFGQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFGQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267E13D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97ADD641AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B56FC433D2;
        Wed,  7 Jun 2023 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686156943;
        bh=lHpEd50gTEijmEkCWFoSmf/58Vv4Gh9yH0NWwWRI72s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIGFLMdMuRmdqyJ2qczERmqoGOrsBTFZf0BiKTQ6pXacpR/QWGXGR8/+TfyXRKinm
         /750GR+7G0ymWTqZOOJjd5COL8MhF7UOqQP3xcSmq3v6828yxllyjaNR8fOzlF+zS2
         PtrxBwx7qOZwG4YFRf4WW8SiLBC72+05royNh0kS33pNY+ekXbfapAzMl1xU0zyu+n
         F4UurRtC/XLSBkKAtH05rW5vMvfg+9qckLbJXwYSw1qgDoJsnWgaFAMHi3UixJYeDc
         kSBwE6Ph2mNlIXIuQIaM8dg0qpi1Zus2is2ZZZd6tHhQJJjmsMEyMNECtM8Sunwyzl
         y4xlZhQ6tnNMg==
Date:   Wed, 7 Jun 2023 09:55:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/14] splice, net: Use
 sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
Message-ID: <20230607095541.586a3300@kernel.org>
In-Reply-To: <20230607140559.2263470-4-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Jun 2023 15:05:48 +0100 David Howells wrote:
> Replace generic_splice_sendpage() + splice_from_pipe + pipe_to_sendpage()
> with a net-specific handler, splice_to_socket(), that calls sendmsg() with
> MSG_SPLICE_PAGES set instead of calling ->sendpage().
> 
> MSG_MORE is used to indicate if the sendmsg() is expected to be followed
> with more data.
> 
> This allows multiple pipe-buffer pages to be passed in a single call in a
> BVEC iterator, allowing the processing to be pushed down to a loop in the
> protocol driver.  This helps pave the way for passing multipage folios down
> too.
> 
> Protocols that haven't been converted to handle MSG_SPLICE_PAGES yet should
> just ignore it and do a normal sendmsg() for now - although that may be a
> bit slower as it may copy everything.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
