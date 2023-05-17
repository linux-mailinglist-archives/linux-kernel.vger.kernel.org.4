Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E970715B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjEQSzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A28A79
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684349683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkG2ZLXHuugF8E/05ptWNFpBJazv1H3EjWyKDlq3jVU=;
        b=FvVHQ2E7OCDYppfvzL7/yNxiUBJakWX+RUnrX70bUf3XBiKEnBj5s3cmMOaa9ct3GnjcpZ
        3RTDwy1eYGhqkqvpuRURMv5XlPCP2/wiwxTMohU9ookjzhnG/YbujfP5e44qf91LKNhxVp
        RIk2Qkja0QLftYBqkclaBI7R9/5140Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Z9wH1b39NNyTm2M1zdinSQ-1; Wed, 17 May 2023 14:54:41 -0400
X-MC-Unique: Z9wH1b39NNyTm2M1zdinSQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61a3c7657aeso2117406d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349681; x=1686941681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkG2ZLXHuugF8E/05ptWNFpBJazv1H3EjWyKDlq3jVU=;
        b=VFYj9ub3FohxmqU3kX55DFV6QF6CaRw97j+vpQc1wgS+jesbEl/DEKNCNM83r3A8tB
         JjxVhu457LuLYN96M/L8WCUOMASN1+G2MsgKDm9N0eNDwbg92Epkt5AX6dvs4g+XrVDH
         pq3GWFdY7AaiMFAg4dmpmfvw6yx8wua/KhvGHtKBKRW4YoLaW8ksermuma3pTzRAAN95
         vhLiZqnC0HPg/qlPd/E1rzEQAykPKp3Vyj7eraSkZUemLIwjFthMJGOVVGOfk332jEAF
         46X4hhBxOw9MP2dqTaam5GWOsp6cwCCTrbxmprb+IYVK/NDkpDMQxwyH5Hfdep857UC5
         QnpA==
X-Gm-Message-State: AC+VfDxnoEF+WaByeUs+mpDLaLI17OFlW0GBrTmWs2kSUMHRlLM9xPVr
        PJgab51VNioXryYt9SIDkbJaf4M8FeT8wvCH5nTB3oVueEJAaBjFeXjvQSGtOTz+svQAxyKVD/W
        NJJI+k9nMziBCkXkfCi/Rsn/9
X-Received: by 2002:a05:6214:e6d:b0:5ac:325c:a28f with SMTP id jz13-20020a0562140e6d00b005ac325ca28fmr6964957qvb.0.1684349681327;
        Wed, 17 May 2023 11:54:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EypXB7UqbFiDuTkKMybkoiPJcibWVXF0N5XugzSsxuyTZrUjrBZtLZWsVQH9jV9pw+C/W2A==
X-Received: by 2002:a05:6214:e6d:b0:5ac:325c:a28f with SMTP id jz13-20020a0562140e6d00b005ac325ca28fmr6964932qvb.0.1684349681041;
        Wed, 17 May 2023 11:54:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id j7-20020a0cf507000000b006211c23abbasm6531041qvm.26.2023.05.17.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:54:40 -0700 (PDT)
Date:   Wed, 17 May 2023 14:54:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <ZGUi79uCvmDLuh0i@x1n>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
 <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
 <ZGUe9f/niO03t7lC@x1n>
 <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:40:59PM +0100, Lorenzo Stoakes wrote:
> On Wed, May 17, 2023 at 02:37:41PM -0400, Peter Xu wrote:
> > On Wed, May 17, 2023 at 06:20:55PM +0100, Lorenzo Stoakes wrote:
> > > On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> > > > It seems vma merging with uffd paths is broken with either
> > > > register/unregister, where right now we can feed wrong parameters to
> > > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > > vma_merge() by Lorenzo Stoakes:
> > > >
> > > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > > >
> > > > The problem is in the current code base we didn't fixup "prev" for the case
> > > > where "start" address can be within the "prev" vma section.  In that case
> > > > we should have "prev" points to the current vma rather than the previous
> > > > one when feeding to vma_merge().
> > >
> > > This doesn't seem quite correct, perhaps - "where start is contained within vma
> > > but not clamped to its start. We need to convert this into case 4 which permits
> > > subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
> > > will be clamped to the start."
> >
> > I think it covers more than case 4 - it can also be case 0 where no merge
> > will happen?
> 
> Ugh please let's not call a case that doesn't merge by a number :P but sure of
> course it might also not merge.

To me the original paragraph was still fine. But if you prefer your version
(which I'm perfectly fine either way if you'd like to spell out what cases
it'll trigger), it'll be:

  It's possible that "start" is contained within vma but not clamped to its
  start.  We need to convert this into either "cannot merge" case or "can
  merge" case 4 which permits subdivision of prev by assigning vma to
  prev. As we loop, each subsequent VMA will be clamped to the start.

Does that look good to you?

Thanks,

-- 
Peter Xu

