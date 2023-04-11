Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36C6DE473
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDKTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDKTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB03C31
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681239822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxO1n2PWxys5TFVibtUzDwp6ndZRuDOsr/RkUx0+dQ0=;
        b=EM5Si4q9R9MT9CWrN4WcDwXJO76dhE0VoS4Tt5/UaXKROA3R+bXQ7pjhy+3/ReXq/nqryA
        fmoVV+QDMzDQyWYcuImasM+RKXQjZZjr0koXnZKpeSNnDIz2omWKNW6HhsQb3yr9g/AyV+
        YCAH0goFFMKEVtYwKJHVqn6auzWNxCY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-48DQgEx5PAGzmOGZmvqz2w-1; Tue, 11 Apr 2023 15:03:41 -0400
X-MC-Unique: 48DQgEx5PAGzmOGZmvqz2w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5eee59cadefso1013446d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681239820; x=1683831820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxO1n2PWxys5TFVibtUzDwp6ndZRuDOsr/RkUx0+dQ0=;
        b=jnYZnbPPMFFCHRGN41nPgwLbvj+Z0eDH+hiLu+1kBOFJuBJXcOydJHN1e68mrFH2lu
         nd73GmD87x1xqGwXbVWbO76QsIPYjCCtljumBtcSRV1VMjPYaS0VCClyD54UB/ljB+zH
         G3VMFfkbfxHaASa6yor0te8Eho6bseXQavxYdYCwCykMjxhsJ8FfG19PHezMQ4rEajBt
         Y5pNmKZiTxnwmCEtIUGrixJy6w7ynmLfA5jzt51URrt/CjWhxwrqrslS1PbszOUE9VFA
         au6Y8kRFZT3Z5khMo67xKN5S7FFki7yfd9PyjQCGoobzYFzZTzECWTnDaVEPbIkST1Lp
         Edfg==
X-Gm-Message-State: AAQBX9eA8EpwuHaT5Toimdyc7tcCiUggD+Avw0xjN5SKTS9/QMb4Bim/
        t7sh52gz2fk/hoLMy+6h3889U9hkNt641UZTKeeyHDJeHrXHBskFU+/Nq6DPMA+GCQfSbBwuIZg
        ODNBEaWd/FLOa/7lSJs9qR+Yx
X-Received: by 2002:a05:6214:3016:b0:5df:55b5:b1a with SMTP id ke22-20020a056214301600b005df55b50b1amr294205qvb.4.1681239820615;
        Tue, 11 Apr 2023 12:03:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y6QOiRlYeQAmlr91U5Ze9LR4gX32PPzEF3QLXPxjseSyjVWH5jZY/RSGgRKUCXmiA3/yHu9g==
X-Received: by 2002:a05:6214:3016:b0:5df:55b5:b1a with SMTP id ke22-20020a056214301600b005df55b50b1amr294129qvb.4.1681239819739;
        Tue, 11 Apr 2023 12:03:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id m14-20020a05621402ae00b005ea34e69373sm2334001qvv.37.2023.04.11.12.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:03:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:03:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when
 !hugetlb
Message-ID: <ZDWvCXArb/88rdpL@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160714.3106999-1-peterx@redhat.com>
 <20230331183726.GD12460@monkey>
 <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
 <cfc0d7c8-edb5-ae5d-8edf-d4f7ee18b877@redhat.com>
 <ZCr6g3RDwt1pWTkx@x1n>
 <ZC/lhZlcDaDCErsz@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC/lhZlcDaDCErsz@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:42:29PM +0300, Mike Rapoport wrote:
> > +/*
> > + * Registers a range with MISSING mode only for zeropage test.  Return true
> > + * if UFFDIO_ZEROPAGE supported, false otherwise. Can't use uffd_register()
> > + * because we want to detect .ioctls along the way.
> > + */
> > +static bool
> > +uffd_register_detect_zp(int uffd, void *addr, uint64_t len)
> 
> Let's spell out 'zp' as zeropage, what do you say?

Definitely can do. :)

Thanks,

-- 
Peter Xu

