Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907AD730371
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjFNPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbjFNPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:19:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E816C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dHebVBBXxeCEnUn6koWWLEwMxL08aFziCNICAn86fcI=; b=d/xBgTi9yThHY2HsE9TpwATP9G
        WJgT2F/ONFoDw0hhz0d/oGDrem+IKjaq7uEp2PK0w5OvYnaZzppHWo3eVm6TviQQ2Ex491OPb5GeZ
        JlyZSYwwTjAufx9FOC+ZSAfdzVDyMsQKGti4uPJPQjj4R3CetO2J1t8rXVrYd4DqWHOwVj9znaRhu
        54z+2Iy0gWctmbWs31XCJjawv37s01RbfqEi4FX/CD2RTXlbHyPVv7mOu28b+f0GIQWmBl6uM576E
        Eb/RwT4VU3P8Yj44a5TE7k78uQ/g+AdBi+RKJB5BEpGu9aX/1/OxxhXbmp/Mo/y5cFkeYJ91KIvFo
        vLW0NjMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9SHI-006Sz3-Si; Wed, 14 Jun 2023 15:19:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68F28300195;
        Wed, 14 Jun 2023 17:19:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 523F3240FDF97; Wed, 14 Jun 2023 17:19:20 +0200 (CEST)
Date:   Wed, 14 Jun 2023 17:19:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
References: <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614150717.GG7636@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:07:17PM +0100, Richard W.M. Jones wrote:
> On Wed, Jun 14, 2023 at 04:53:48PM +0200, Peter Zijlstra wrote:

> > Clearly I'm doing something wrong.
> 
> I'm suspecting version of qemu may have something to do with it, but
> honestly I don't know.  Which qemu are you using?

ivb-ep: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-3)
adl: QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-1+b2)

I'll try and upgrade the adl to 8.
