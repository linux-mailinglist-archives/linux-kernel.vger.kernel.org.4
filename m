Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19D66E6E78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjDRVl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjDRVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:41:22 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93DD1996
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:41:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id m14so13018533ybk.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681854080; x=1684446080;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l5NmV5LTOy+MuZF5xVusIDHhnwmLcYQzsGvy/o6FI4=;
        b=Pv9SA57WCaI0h5O+syMJxPCGe7ngSa+KNB/ytcvTS2xA0ArUjcFUFcGZ16ZtypomcT
         JMoa1uPFNnUQAuyhcGMpaYZMDqfSNfSfPLc7TI4Np1hhUYBZigm96fLmxniMpEMpp76Y
         hn8IYYMozPjcmJwXO+ddLqdEA/5U7hZ9BJajITz9rrVswELd9Na6053tL9Irhs/OwYAT
         Ity6LtA0N24HWrG8dBKNKMPboyxGPFV30ynashqnpYqjrv8jTl1VmvAN6C1xA2otuP62
         frtHWLg1vo7n7rSRpqrtmkuPufvrZwPa+bOlRMF3uAPrCw0mZOLVIe1ybIEWmTXzMkuG
         6J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854080; x=1684446080;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l5NmV5LTOy+MuZF5xVusIDHhnwmLcYQzsGvy/o6FI4=;
        b=EYsLzAnFLxnzgzmS71EzvdWjnVOKuTeWWZQoNxhnENVKrwCxqAY5khzjKXYX4WruAS
         jRD/DdITjbNk1n0mU4NntZmKPFFbtKGBUUtUxhKHWCoIuizP1vWSGqsQeACGFO9e57WM
         3ygnmfDLRGJf3dgYREuXE4Gl5ly84HOneEAcCs8ej+yBLzDISY08/xANAu1ob3UXSJPO
         CtwBKhhDXGnuoMP4YPBnd/j5x6rfekGAdwYQTtoKglLlj9C/nJ3Xh/F/DJ9EPMPiTeCu
         SgAuQGWb0IZ4gMC+C4q0ngPmEBMsGgkPbdNJvhGJls0zmJycDLiez/l/wD4wGDrZrKG3
         2Crg==
X-Gm-Message-State: AAQBX9dr+wVB6XSZc23g1Mc4QlxwGdXkJ0+B5DpvWxkFejFOciSXcEFl
        nYvxmq3YRb27Bm/2W62lP6H8rw==
X-Google-Smtp-Source: AKy350bBpV4DRJsoJMtUOdmmSo5lT/qQl5OOsDX8dIyNKzyq26sIVASCEbgl7SRgoGKjXd8OYcGPzg==
X-Received: by 2002:a25:2fd0:0:b0:b8f:4182:2cc9 with SMTP id v199-20020a252fd0000000b00b8f41822cc9mr17849382ybv.6.1681854079745;
        Tue, 18 Apr 2023 14:41:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k134-20020a25248c000000b00b958a4c8847sm573011ybk.11.2023.04.18.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:41:19 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:41:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, linux-mm@kvack.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 5/6] shmem: update documentation
In-Reply-To: <ZD8JgfphE+HWCGve@bombadil.infradead.org>
Message-ID: <6064b468-33fb-3693-54e-6f1f8d316f64@google.com>
References: <20230309230545.2930737-1-mcgrof@kernel.org> <20230309230545.2930737-6-mcgrof@kernel.org> <a4afef5c-27e4-5e67-9771-374132db61f8@google.com> <ZD8JgfphE+HWCGve@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Luis Chamberlain wrote:
> On Mon, Apr 17, 2023 at 10:29:59PM -0700, Hugh Dickins wrote:
> > On Thu, 9 Mar 2023, Luis Chamberlain wrote:
> > 
> > > Update the docs to reflect a bit better why some folks prefer tmpfs
> > > over ramfs and clarify a bit more about the difference between brd
> > > ramdisks.
> > > 
> > > While at it, add THP docs for tmpfs, both the mount options and the
> > > sysfs file.
> > 
> > Okay: the original canonical reference for THP options on tmpfs has
> > been Documentation/admin-guide/mm/transhuge.rst.  You're right that
> > they would be helpful here too: IIRC (but I might well be confusing
> > with our Google tree) we used to have them documented in both places,
> > but grew tired of keeping the two in synch.  You're volunteering to
> > do so! so please check now that they tell the same story.
> 
> Hehe. Sure, we should just make one point to the other. Which one should
> be the authoritive source?

Documentation/admin-guide/mm/transhuge.rst has been the authoritative
source up until this patch, so I suggest it remain so; but good if you
point to it from this Doc - unless in reading it you find that actually
its account is wrong.  (Haha, it refers to fadvise too, never mind that.)

But the man page is more important than either, so it would be good to
point to that too.  Mention the "huge=" option in this document, but
point to elsewhere for the detail of its values.

> 
> > But nowadays, "man 5 tmpfs" is much more important (and that might
> > give you a hint for what needs to be done after this series goes into
> > 6.4-rc - and I wonder if there are tmpfs manpage updates needed from
> > Christian for idmapped too? or already taken care of?).
> 
> Sure, what's the man page git tree to use? I can do that once these
> documents are settled as well. I'll send fixes.

Thanks. I'll look up a mail to lkml from Alejandro and forward that
to you, it has the details.

Hugh
