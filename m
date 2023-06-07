Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0B726786
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFGRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjFGRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298C26A1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E520A64212
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B558C4339B;
        Wed,  7 Jun 2023 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159271;
        bh=ZvKkcdQ1lOUxF1b2GWrc8NYGJ2lVBPJVjPW9hRJYDeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f1DYw+dARGN05S/WBtv2Cv3qeGsq03nD/hjgdBmRuZn7tHofzqrcVc3qmxpX6RZ9N
         xIiXWKferDCKJj3wBA163Od+ev9SAuMo2CRtKL4Oc+BFr+y/gHHwcPjLN7wRBGbZdr
         DH0YrspVUj4s3jnJ8AvaiuflIIoreADBS+niNH8Akf62Svt4IQVHY5ziZhoHXXiqzg
         cx7QTYjjdNi91iWHPWR1sg9fy0YZVA8mE5XT7KcioQ211J5NadouXr89vDn0H1UYtz
         lCS8bvvAORmfeuLFBO9Yhk28Fum6KK3XHkF1CjzZNmuVffM8ro2wHac2l/3t5fJ5WO
         U6m8y87qq73rA==
Date:   Wed, 7 Jun 2023 10:34:29 -0700
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
Subject: Re: [PATCH net-next v5 11/14] tls/sw: Support MSG_SPLICE_PAGES
Message-ID: <20230607103429.2f4162af@kernel.org>
In-Reply-To: <2293095.1686159070@warthog.procyon.org.uk>
References: <2291292.1686158954@warthog.procyon.org.uk>
        <20230607101945.65c5df51@kernel.org>
        <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-12-dhowells@redhat.com>
        <2293095.1686159070@warthog.procyon.org.uk>
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

On Wed, 07 Jun 2023 18:31:10 +0100 David Howells wrote:
> > > Why move pending-open-record-frags setting if it's also set before
> > > jumping?  
> > 
> > I should probably remove it from before the goto - unless you'd prefer to do
> > it in both places.  
> 
> Actually, I need to keep the one before the goto.

Yeah, feels like goes together with updating copied, really,
not no point passing it all the way to tls_sw_sendmsg_splice().
I'd drop the reshuffle next to the label.
