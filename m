Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823FD72FF83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjFNNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbjFNNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:09:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ABF184
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c1LRriEtPigBy2WL6mreARXL7LjKGOPu5GjXdsLymgk=; b=oLg/P4L9LWFW9iNUTFfCsRYGYi
        k6vpGIhdA26TJ100kLlm9pt/Q94+mcw1Bfu0XI055jOvJe7Hz/3xjSR86tAAkisJZ1tEVsUh437Tb
        aXpfdVPDGwRkTlH2DtqYpTTlHc5sNLbwDHxVLaOgn3zSsTC+Q094glxYIbGVc/CKVZDEpYyOEwFDD
        J20vdsgbOsN/v93aweKj7RX+bWQUfNz3Z/P8288g3wjFe/iQhbVg08n+jUpsBNvelHTbUDjfmO4Ix
        QpZWPY0pSCfhN7f9tFiJblzqGoLnIiJHz7PyGJnuL1CkQK89TJJ7SjpLJL90C+mLldYZECQoXF83q
        Mqu6qwPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9QFu-006LHY-Am; Wed, 14 Jun 2023 13:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFDDA3002A9;
        Wed, 14 Jun 2023 15:09:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D74CD245CC9AA; Wed, 14 Jun 2023 15:09:45 +0200 (CEST)
Date:   Wed, 14 Jun 2023 15:09:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614130348.GF7636@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 02:03:48PM +0100, Richard W.M. Jones wrote:
> On Wed, Jun 14, 2023 at 02:53:20PM +0200, Peter Zijlstra wrote:
> > Ooooh, what qemu version do you have? There were some really dodgy
> > reports all around self modifying code, all reported on 7.2, that seems
> > to have gone away with 8.
> 
> > Now, all of them were using TCG, and I think you're using KVM.
> 
> I'm using qemu-system-x86-8.0.0-4.fc39.x86_64 with KVM.  The host
> kernel is 6.4.0-0.rc5.41.fc39.x86_64.
> 
> > I've at least 36000 cycles and still nothing :-(, let me go try your
> > .config.
> 
> I can definitely reproduce this with your config (but AMD host), so
> that's odd.  Let me try with Intel hardware and your config.  You
> really should see this with only a few thousands iterations.

Yeah, I'm running on some ancient ivb-ep, let me try on the alderlake. I
don't really have AMD machines at hand :-/
