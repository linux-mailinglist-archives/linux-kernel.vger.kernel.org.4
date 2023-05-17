Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE929705FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjEQGVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjEQGVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:21:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F432690
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:21:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30644c18072so169582f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304463; x=1686896463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3ZoBkyA20S5DTdyyP5tByv+QSgEyMwfqwV8c9kD140=;
        b=P8RRYSTStyO/5/f4NJKVG/ZHYLkeB6wgqmu7btxrr1iDGqSIuosSv/k72eOWuTOeIl
         F7xdz4xLlW1UC4r5Z/syHHyLjEnR9x1A0xJqqpsFqX1LurpTok0el2TCr/d32/l8WnH9
         1OcIFDCPzgTpYA04t/WYA95u6kp51qoIzg/6RbxFxS4gwQOfbXLaLaUNVI5fYTmic8D4
         DzqiGeK26Wt3/7WZkOnLO5yKB6QYmF5ELWQO2HObuZ2JCG1FqGJ0/MKSJjsOGKf1GcgJ
         O160RMjH5y0ZybGk7Z7y8ydtdq1G5nwZSsvHljNA9Dkd+7bDP+u5/iXAu75FCLOWfDqb
         r3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304463; x=1686896463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ZoBkyA20S5DTdyyP5tByv+QSgEyMwfqwV8c9kD140=;
        b=L+hlElO42i81zv1ynGp0OOMXhIKPv9KFsJFnQi5mO/cQKRRJJCQPH2H8qxVAC3JhCE
         z5bgjsq9DtsWRId4D5YjG4U1/dnQHyof9XIRJ41kDM1IotYCFmvCESUG6zE01TY0iF8X
         NGz9Ba81F6ouHuB945DWAbbqRTUBH2j5F1nqfj6fcE86RKeu9Ex6vckGlGgzlb31sFz3
         4lrnLb7hSAPOCytaBZcwnxhBR9oxpuzKYSbTXdDh6YrbIjhOzfGfdywUMA8EXg1Fjh8M
         qNgMtcpp6NMLN6An83L30Q4fygi/tSKztSbdFIHgnH7QHkFL9Txb7Hhkp7Ox702ZVELr
         1VwA==
X-Gm-Message-State: AC+VfDzWzk0bd14KBLu1bS72tcgeD++5eoVcN+Mt2by0vM4qyqxhQYE0
        b+xyjb9eCq7MtyJZKCrFuqo2pVH0VPXv9Q==
X-Google-Smtp-Source: ACHHUZ618y+YEYNwPVMIefe4aIrlbudzEMK7Q3k92kQNoGobewTK+u0fSxZmD1lu5xRSbrgBq/vuIA==
X-Received: by 2002:a5d:550c:0:b0:2f6:987f:a0f5 with SMTP id b12-20020a5d550c000000b002f6987fa0f5mr26388667wrv.5.1684304462838;
        Tue, 16 May 2023 23:21:02 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f12-20020adff8cc000000b002fe13ec49fasm1508567wrq.98.2023.05.16.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:21:01 -0700 (PDT)
Date:   Wed, 17 May 2023 07:21:00 +0100
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
Message-ID: <1f94f0be-a3fa-4539-9278-0e876f693c09@lucifer.local>
References: <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
 <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
 <ZGP4KSw/yD5ItTYu@x1n>
 <9174fd63-5d32-4b83-bf6b-27f9cb00bd9e@lucifer.local>
 <ZGQEhuXTBdzC2CGC@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGQEhuXTBdzC2CGC@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:32:38PM -0400, Peter Xu wrote:
> On Tue, May 16, 2023 at 11:15:54PM +0100, Lorenzo Stoakes wrote:
> > I'll try to address this in a later series, I don't think there's much use
> > in going round in circles on this. If you dislike that series, you're
> > welcome to provide negative feedback there, I don't think there's much use
> > in discussing further here.
>
> I'm happy to read it, sorry if any of my wording was intruding, I didn't
> mean so.

No it's fine, I've perhaps not been clear, but this has all inspired an
upcoming change so it's all good :)

>
> I think there's chance at least on generalizing vma flag change cases, even
> though I'm not sure whether vma_merge() needs change.  Maybe it can be
> another layer on top of it while keeping vma_merge() as is, but I can't tell.
>

Indeed, will dig in!

> > We've seen a regression on invalid input to vma_merge() (explicitly I mean
> > triggering a VM_WARN_ON()) and VMA fragmentation you were not aware of
> > here, that does not strike me as a great + clear interface.
>
> Yes, the code needs time to read through, even the interface.  I don't
> think I fully digested that myself.
>
> [...]
>
> > Ah the thanks you get for contributing a regression fix _and_ a repro - a
> > nack :) will you at least give me some kind of a tag... or buy me a beer?
> > ;)
>
> I can. :)
>
> We actually met on the conference, if I'll be able to meet you somewhere
> that's what I can do.

Yeah was nice to meet! And only being tongue in cheek, I actually at this
point do think your suggestion should replace my patch.

>
> I was probably hashing in the words, sorry about that if so, and thanks for
> looking at this issue!  I appreciate both your assertion patch and the png
> documentation file.
>
> It's just that I feel irresponsible when we were talking about having vma
> not merged correctly but then the discussion tried to end at there saying
> it kept so so it's fine.  IMHO we should look into that problem or
> something could be missing here.  Then when I was looking into that
> not-merged issue I found that it's not uffd that's special.

Sure, we should try to keep all invocations as close as possible if we
can. It does seem as you say that uffd got left behind on this.

>
> > > Before that I'd like to know whether you agree that the new patch 1 (I'll
> > > fixup the vma_prev() side effect) could be a better solution than the
> > > current one, no matter whether we need a full revert or not.
> >
> > In principle it looks fine actually (pending Liam's assessment), case 4/5
> > should handle it, but I feel like we need a comment (perhaps only in commit
> > msg) to make clear that we are ensuring that the inputs to vma_merge() are
> > either clamped to VMAs or case 4/5.
> >
> > Let's see what Liam thinks, then let me check it locally to give a final
> > OK, if I may.
>
> Sounds perfect here.  Thanks a lot.

Great!

>
> --
> Peter Xu
>
