Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B317040C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbjEOWLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbjEOWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:11:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBA8A7B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:10:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2758607f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188621; x=1686780621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcasEqjqVqeZD6iRt2acWNL10GV04xiY11Aorq1Q2nM=;
        b=RCLXWcRIkUtTeSnsDneWy3ua5n1ZSO+btm22KJcVMSLPorWDPAGjqjqM70gptvZlXV
         7NlfYafwS44YFcqoYLkJuHah4Z3z/Z7YNDC6mfLuYJgNu1g7PJCEUiUKqK6g2WF1LhJB
         a+pkzyNmLDQJUNM5UGpQtkFlDBTd82RL6JEro8JOQajcBHgQSZTW/DOz77HYuLRhVBPl
         /fKAohlTgCL9oVUDoGI8HsrYrP9o0y6z58X6XTb1kz0p66KfqlL7Pnf6mhDxJBkWmUQ3
         xvYWUHmOMKsp/rhfKLwuu+/Vp2YdGiVlrD4AMiZqP2mexMEjRwlzHttsI99fmLWFbaC+
         qJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188621; x=1686780621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcasEqjqVqeZD6iRt2acWNL10GV04xiY11Aorq1Q2nM=;
        b=IJwhKMC7YbJSAtGY/K+YN2dPWeLpa0Pvm+e0pbToeoV275vEIO49yMjo0unF0cTPs0
         QFkb3siaSQptjolhMNsrCCpBackl26gx+FfdZKCtKZjsH6GcSdz0KIe2dL7l/QF6itWh
         8T9yBBGJvKyQ0UNJwIBpPyDHT1w4tfVtpw/h7DiWwRvyRU59Gi/XSanKPuYVkB0xVYPK
         scO0aXbSfRqAYut4MfPt/rUvb1ZwkryXS4ZroVfMcIIBvbnPPf7lYyM/MxYaphE7Tog/
         c8iaIsUyYzlRS/ibjDJv5ohx5XjN79b/v5XecOT/HIaXkC4ytRiN6zf4PxZ7Aj8hWPkH
         v79w==
X-Gm-Message-State: AC+VfDxBzGtrROG3CqPVqMPmeaKrjZxbihOasXwyjxPsfZ3SAm3TlVVA
        FEoMei6Rfr3N/iepmWFa45Sy9Kf1LTN1Ag==
X-Google-Smtp-Source: ACHHUZ7K/t3stitaVskNFjUzr78g28lE3oEjtjJswqzrJG4v2pFCXfbk72g7XJNHy/562eUNOSabnQ==
X-Received: by 2002:adf:ee46:0:b0:2d2:f3e3:115d with SMTP id w6-20020adfee46000000b002d2f3e3115dmr27524669wro.59.1684188620429;
        Mon, 15 May 2023 15:10:20 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b002c70ce264bfsm393491wrt.76.2023.05.15.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:10:19 -0700 (PDT)
Date:   Mon, 15 May 2023 23:10:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <a0ad836a-c837-47bb-9c04-cd89a11d6ffa@lucifer.local>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKmjUL5etmvIouh@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKmjUL5etmvIouh@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:39:25PM -0400, Peter Xu wrote:
> On Mon, May 15, 2023 at 08:32:32PM +0100, Lorenzo Stoakes wrote:
> > As well as fixing the repro described in [1] this also continues to pass
> > uffd unit tests.
>
> Side note on testing, not directly relevant to the patch itself..
>
> I'm wondering whether do we have tests somewhere to just test vma
> operations on split and merge, then verify it using smap or whatever.
>
> The uffd unit test in this case is probably not gonna trigger anything
> because we always mostly register with a whole vma over the testing ranges,
> so not immediately helpful.
>
> The trick here is we have quite a few ops that will call vma merge/split in
> different ways, but logically we can still category them into: (1) add/del
> vmas, or (2) modify vma flags, so at least for case (2) we can have a
> framework to cover all the cases (mbind, mprotect, uffd reg/unreg, mlock,
> etc.), the difference will be the flags we'll be looking at for different
> cases, however how vmas merge/split should be somehow in the same pattern.
>

I totally agree we need more testing on this. We do have some basic
self-tests for various things but I don't think we test this specifically
or certainly not in the way I'd prefer (somehow pull vma_merge() + friends
into userland and instrument with heavy unit tests).

I do intend to try to do something with this soon.

Something with /proc/$pid/[s]maps could be a good straightforward thing, I
will try to write some small test (we already have a little repro for the
reported issue) for this anyway.

> --
> Peter Xu
>
