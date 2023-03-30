Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5346D1211
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjC3WXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjC3WW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAAB74B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680214932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UCtYmcIVveJt1GygL0WFSLaZcObhg2mwhCm1ywrGMFo=;
        b=KwtMWL9szy3jYzJp/9lLPOehI6U6TPEL9YsT9iaVFxcRFxkWmA9JRtBFydLIntpxq8wRe2
        s/aJ62pl+tF+EhuJsO7mS+TOTdSdjD73oxm8Rcl/kMXbU1wIvPQ2RcGDJihFgRCLLN9t3l
        tCfszjscm0FL9tlhtoC7l74GwVjsRow=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-9h84g_VCM1ySDNdGkvNipg-1; Thu, 30 Mar 2023 18:22:11 -0400
X-MC-Unique: 9h84g_VCM1ySDNdGkvNipg-1
Received: by mail-qt1-f197.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so13422285qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680214930; x=1682806930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCtYmcIVveJt1GygL0WFSLaZcObhg2mwhCm1ywrGMFo=;
        b=wX9mMLSJb34m2amU9VLwknexO+VQqCo6OlwqfvJjOuGl68Sak5WwxvRE/3MpUVAgX5
         uVZb00vouv5XayV1ACxz0DBW4ed3LIdRgMgoUWtbSrO9S4kNHZ0Y3hHo+6+IB2696DO1
         KOZwLII6SikqvQU/Y2+wMIY6sqTLEW14GXSDwB9x1WJfnQLoDFKkc0CGkjxmJAd2bMhV
         DobygTDlHWABCojJS1O1b3oUmrZfiAefaRSeVlWSFbur/Djrm6vNL6NIervAxnfUeTNx
         lRrBaBB6vKpp7iDI/OsaQKd6tH9y5YC5j609IOnR6EEmh8rgM3Iql7GoOEmP2VaeGzrL
         PWbg==
X-Gm-Message-State: AO0yUKVycB1sOXaxBYHWEh8SG4EdADcIXpl7rhKMnFZucJw2q+esd++G
        qcbdvKxjqWcNNieoSustTtpRtlNlMvudh4jGjUyoS0rnL43SiIjRg/EVPsjETgGwfTmIqzh/uRd
        lWhQ5EvU/lsvhfD+Fs9hLlguX
X-Received: by 2002:a05:622a:14f:b0:3bf:a3d0:9023 with SMTP id v15-20020a05622a014f00b003bfa3d09023mr41854327qtw.5.1680214930618;
        Thu, 30 Mar 2023 15:22:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set+1rDPUb5agPSUAJx2zyqakmqGt6Gwrb53dQzVWPlFXTq0vAm9ooO7dNYFeBYNa7GdVMbgwwQ==
X-Received: by 2002:a05:622a:14f:b0:3bf:a3d0:9023 with SMTP id v15-20020a05622a014f00b003bfa3d09023mr41854302qtw.5.1680214930387;
        Thu, 30 Mar 2023 15:22:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id x16-20020ae9e910000000b00746aa080eefsm205950qkf.6.2023.03.30.15.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:22:09 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:22:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 01/29] Revert "userfaultfd: don't fail on unrecognized
 features"
Message-ID: <ZCYLkA9MM7yhpYBr@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330155707.3106228-2-peterx@redhat.com>
 <6eb02bdd-e69e-d277-c44c-0aefb23430bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6eb02bdd-e69e-d277-c44c-0aefb23430bb@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 08:31:30PM +0200, David Hildenbrand wrote:
> On 30.03.23 17:56, Peter Xu wrote:
> > This is a proposal to revert commit 914eedcb9ba0ff53c33808.
> > 
> > I found this when writting a simple UFFDIO_API test to be the first unit
> > test in this set.  Two things breaks with the commit:
> > 
> >    - UFFDIO_API check was lost and missing.  According to man page, the
> >    kernel should reject ioctl(UFFDIO_API) if uffdio_api.api != 0xaa.  This
> >    check is needed if the api version will be extended in the future, or
> >    user app won't be able to identify which is a new kernel.
> 
> Agreed.
> 
> > 
> >    - Feature flags checks were removed, which means UFFDIO_API with a
> >    feature that does not exist will also succeed.  According to the man
> >    page, we should (and it makes sense) to reject ioctl(UFFDIO_API) if
> >    unknown features passed in.
> > 
> 
> Agreed.
> 
> I understand the motivation of the original commit, but it should not have
> changed existing checks/functionality. Introducing a different way to enable
> such functionality on explicit request would be better. But maybe simple
> feature probing (is X support? is Y supported? is Z supported) might be
> easier without requiring ABI changes.

Yes, I mentioned a similar "proposal" of UFFDIO_FEATURES here too, simply
returning the feature bitmask before UFFDIO_API:

https://lore.kernel.org/all/ZCSUTSbAcwBINiNk@x1n/

But I think current way is still fine; so maybe we'd just not bother.

> 
> I assume we better add
> 
> Fixes: 914eedcb9ba0 ("userfaultfd: don't fail on unrecognized features")

Yes I'll add it.

> Acked-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

