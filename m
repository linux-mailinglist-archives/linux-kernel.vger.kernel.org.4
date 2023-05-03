Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002A6F5EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjECTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:02:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2D7D8B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0YYQc/fnT1nOd7uUw0b6TC/AbODgNNfUdncisBUND+I=; b=fUfcica9Ew9kItgGFKcp587Hq/
        RiMrXeA3W9LDTufGeUHqKWAJfL0hBD+Pz7cfjDqUnHLcVn2YM9LFiP3nXsoKE/X6MqieqEacFjhVD
        lDyU/yJvJdLzLfZUmMKkUreffDu/a8YtqB29dEtN8zVVrAydNTTxq5xzx+q8nmfzCjSsUqJsoeOfZ
        uRKaa37sWp9s3u7EuRIECiUneG27Uy1DMCIcaKUXsZGNwM/2rjOJAlbleJGxANqdhl+RF5ajBLKFm
        vmomxrDj3IDDRx7S5cf7kLcZ51tClwkUdMq7XarLw4iq8t7C4DfyNrkDRUuRlGYcL7WIfMjMPUSD8
        VyfVK6Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puHjZ-000BoW-2T;
        Wed, 03 May 2023 19:01:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC4EA3003CF;
        Wed,  3 May 2023 21:01:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A705024AE4AB5; Wed,  3 May 2023 21:01:47 +0200 (CEST)
Date:   Wed, 3 May 2023 21:01:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 10:54:38AM -0700, Linus Torvalds wrote:
> On Wed, May 3, 2023 at 9:38 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'm going to just remove the 'sign' games entirely. They are
> > completely broken in 'untagged_addr_remote()', they _used_ to be
> > completely broken in 'untagged_addr()', and it looks like it's all
> > unnecessary.
> 
> Ok, I've pushed out my changes to the 'x86-uaccess-cleanup' branch.
> 
> I think it's all good, but it would be really nice to hear it's been
> tested on a setup that actually has LAM (simulator? or maybe there is
> actual hw inside Intel)
> 
> And any other commentary is appreciated,

Looks sane from a first reading. But I'll try and have another look
tomorrow.

Also per how 2s complement is constructed 0 has to be in the positive
space for it to be 'half'. Also, typically 0 is included in N and the
traditional 'positive integers' set is then written as N \ {0}, but
that's somewhat modern and a lot of variation exists -- although
typically books tend to specify where they stand on that issue.

I suppose that's a very long winded way of saying, that yes, ofcourse 0
is a positive number :-)


