Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8476D121D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjC3W2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjC3W2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA0CA30
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680215231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yrg7gd+3buI58FtTknCRM1CGb3Q5tRIhU3QrztqGTxw=;
        b=NsuuR3VET14lycej3l6vBMjEXFtN7mI/tUCi22BgpXZQGzglFwAF3l6qMaaR8O2ktng2J3
        5sXI1Itbs0QP/+U8GUo+DNJ3DK0QHqOq5Op8WMSAc3sckvrZYBnFUtINWCyt5XTgk9iHqA
        Pu5w4t1FSZHSxh2iW7wCFhEPqg8B4yQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-uRFbNsv1MC2DVtLu_RWfiQ-1; Thu, 30 Mar 2023 18:27:10 -0400
X-MC-Unique: uRFbNsv1MC2DVtLu_RWfiQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-746bae78af3so65343785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrg7gd+3buI58FtTknCRM1CGb3Q5tRIhU3QrztqGTxw=;
        b=Tlax2061I3Eb91Jrdkush7IaVO/2pfLBLBPOKP0LDN2UD+re5rezkcT48V2gMdyTjA
         TLwb5IW7loXomniE+GAorXgI2wHKcuxwyFJYzYpiXZdPLZSsR9wj5fvyg2DXOgX4XqsD
         RFGCwljC9MmrNwYXl1z1kUcbxeYwSYoe7Lb8OtfQXMIg0BLrHgwBFieEM6WSxOjAoT9E
         rPjcJ+WZ5hNQfs58PYlqkK39szEjyCJpI1TkBASRBSCMvmrmNDeYFdXas4af/UKqleTS
         Cz5cV/Cw5m+IPxnFkZPDizMzOeOpTMET+nLq07hpPDkNuKIUNDL5Cc5qM+8/OcddxJZK
         uOwQ==
X-Gm-Message-State: AAQBX9fsOuQ/37etkf/qxGAT8/FHKo8IsO237PEF9fEJy5XXhz7N96Pd
        4RvPkkLIJBqF0/eGqEh8y+qhZZJGeoNfNyMjmN2TNszscnOV3xPs2tjoqf0WO8MDz7++NC7bXXn
        Cr0nCPIEk0we+THLxCcnci+fT
X-Received: by 2002:a05:622a:1a0a:b0:3e3:7ed0:d6df with SMTP id f10-20020a05622a1a0a00b003e37ed0d6dfmr6427796qtb.6.1680215229921;
        Thu, 30 Mar 2023 15:27:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bGOjNmUVk9T+eZ7zs/ZYSmIplExG8QnhHyqHyNy/4pL14K7OcrvahsGGY40TBYdu4lZVEzjQ==
X-Received: by 2002:a05:622a:1a0a:b0:3e3:7ed0:d6df with SMTP id f10-20020a05622a1a0a00b003e37ed0d6dfmr6427778qtb.6.1680215229676;
        Thu, 30 Mar 2023 15:27:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84753000000b003dffd3d3df5sm191625qtp.2.2023.03.30.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:27:09 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:27:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 01/29] Revert "userfaultfd: don't fail on unrecognized
 features"
Message-ID: <ZCYMu5P2BJy/2z5t@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330155707.3106228-2-peterx@redhat.com>
 <CAJHvVcgDZBi6pH0BD12sQ3T+7Kr9exX1QU3-YLTd1voYhVBN0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcgDZBi6pH0BD12sQ3T+7Kr9exX1QU3-YLTd1voYhVBN0w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:04:09PM -0700, Axel Rasmussen wrote:
> On Thu, Mar 30, 2023 at 8:57 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > This is a proposal to revert commit 914eedcb9ba0ff53c33808.
> >
> > I found this when writting a simple UFFDIO_API test to be the first unit
> > test in this set.  Two things breaks with the commit:
> >
> >   - UFFDIO_API check was lost and missing.  According to man page, the
> >   kernel should reject ioctl(UFFDIO_API) if uffdio_api.api != 0xaa.  This
> >   check is needed if the api version will be extended in the future, or
> >   user app won't be able to identify which is a new kernel.
> 
> 100% agreed, this was a mistake.
> 
> >
> >   - Feature flags checks were removed, which means UFFDIO_API with a
> >   feature that does not exist will also succeed.  According to the man
> >   page, we should (and it makes sense) to reject ioctl(UFFDIO_API) if
> >   unknown features passed in.
> 
> I still strongly disagree with reverting this part, my feeling is
> still that doing so makes things more complicated for no reason.
> 
> Re: David's point, it's clearly wrong to change semantics so a thing
> that used to work now fails. But this instead makes it more permissive
> - existing userspace programs continue to work as-is, but *also* one
> can achieve the same thing more simply (combine probing +
> configuration into one step). I don't see any problem with that,
> generally.
> 
> But, if David and others don't find my argument convincing, it isn't
> the end of the world. It just means I have to go update my userspace
> code to be a bit more complicated. :)

I'd say it's fine if it's your own program that you can in full control
easily. :) Sorry again for not noticing that earlier.

There's one reason that we may consider keeping the behavior.  IMHO it is
when there're major softwares that uses the "wrong" ABI (let's say so;
because it's not following the man pages).  If you're aware any such major
softwares (especially open sourced) will break due to this revert patch,
please shoot.

> 
> I also still think the man page is incorrect or at least incomplete no
> matter what we do here; we should be sure to update it as a follow-up.

So far it looks still fine if with this revert.  Maybe I overlooked
somewhere?

I'll add this into my todo, but with low priority.  If you have suggestion
already on how to improve the man page please do so before me!

-- 
Peter Xu

