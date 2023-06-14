Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0777303E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjFNPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbjFNPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:31:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30203C3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zesKwNNSCYhuMX7FGbKo4AdD1/64QjsAiQXuaan3nJk=; b=FEw8Tg93j3B3Q9piggY7QVi7co
        znyCePtb1+BzjGffUOsfXX3wgBxjPcqkDep0ZV9QUMEG6klYNOyWSl/GOT6+akN904hCxswvlpaPC
        0ZA5hd/jF6/xY9QZ9TF4rNrLHhqiNo/chVABydxIqdOsssdpF35Be75gQDdXZI+zYwinC0WF45EZG
        gSNl4EGGGnzrnR8SlltnrUUK6Xderi1Tbrw2beb6L6o/JrFbhlLgSsBNGgUvZ6aUxFPX8pxMv3x6l
        tqkTi/qsl1Q+kiwRocmukIBSIMKBlUG57ueJUaQkpvtgaAYe1y7f75nMogwj5tqYeMAVEHzi4kdxy
        9ipVAxVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9SSk-00AoSd-15;
        Wed, 14 Jun 2023 15:31:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B1C43002F0;
        Wed, 14 Jun 2023 17:31:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB993240FEB2C; Wed, 14 Jun 2023 17:31:08 +0200 (CEST)
Date:   Wed, 14 Jun 2023 17:31:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614153108.GC1640563@hirez.programming.kicks-ass.net>
References: <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
 <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:19:20PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 04:07:17PM +0100, Richard W.M. Jones wrote:
> > On Wed, Jun 14, 2023 at 04:53:48PM +0200, Peter Zijlstra wrote:
> 
> > > Clearly I'm doing something wrong.
> > 
> > I'm suspecting version of qemu may have something to do with it, but
> > honestly I don't know.  Which qemu are you using?
> 
> ivb-ep: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-3)
> adl: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-1+b2)
> 
> I'll try and upgrade the adl to 8.

adl: QEMU emulator version 8.0.2 (Debian 1:8.0.2+dfsg-1)

started it again.. 
