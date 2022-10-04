Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6475F44BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJDNtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJDNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F6B4AA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664891383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSbZxDSZa0MB8ZF/Gz/fWRW6UQaKjwrDHpdispjH1M8=;
        b=dqg5otDmSSSr8MBEHqA3xIu2tjWI01DjOA8n9BwWB1dWhqJrmg69Ubrp2mGWyVHu1DvSB3
        7NNZAhkSN/UaSQWtH70V/uaD9aSp49owxTO132MLldRk2QAzJp8eFiPoW0kC2zQ3H0Y9vv
        62Br3KET79WgfM1virDiQ/ZW3VC9qow=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-vxKA-MFDOluIz5GwSB4v6g-1; Tue, 04 Oct 2022 09:49:40 -0400
X-MC-Unique: vxKA-MFDOluIz5GwSB4v6g-1
Received: by mail-qv1-f69.google.com with SMTP id ks15-20020a056214310f00b004b18ea4bc05so3286063qvb.22
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eSbZxDSZa0MB8ZF/Gz/fWRW6UQaKjwrDHpdispjH1M8=;
        b=Nnrs0+/49HYIozdisftvCAzfE0XbLnfnVsPqZrEnoaYk8eN+UXtjfhfbwoguTaRyTm
         xGFE0F9FxSM9USYTjAnickTCRG+ok643njkfn8ULhKYoiZHTCB+J8ycqWIybgY3QM6td
         BYDBUkv3Iw6YqEECl7wSPwKBPLoPz2GZrBBIYGja4/Jqxf7W5hAEfgfOVAg1kmFz9X8W
         dHnFxfo3DAiBjk/1tO1sEphL6IGaxI/+Pwp9dR3Sp8XxABDAKP9vhzVyTgYfjiWhwCDn
         4UkZanP1AfNdX+n3oz3w/Dv1UpAp4yHSStvsNuGsO4vr1/4fnUgxaI+Q89RN0W/sv4YX
         IAqA==
X-Gm-Message-State: ACrzQf0wVXJ/0F3lyXg6GQ9gzyVioIGPpD1t3Re2edor1AJXKi0tY9Zu
        ISIMPSTsPcR/L7qQKFsfDICr0Hgb966iPo5dQsQVTeSYki9NIfBbFJczp831lbkaGB/znMsGqr0
        T1Is/UyRExelnRAtcvpaBArbo
X-Received: by 2002:a05:620a:f0e:b0:6cf:beb5:a28 with SMTP id v14-20020a05620a0f0e00b006cfbeb50a28mr17115899qkl.738.1664891379856;
        Tue, 04 Oct 2022 06:49:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4LxMm7nV9MgnbYAFEedzhXQ/r4UiO7lrTm2ZvfXZdx6zJM21f1TQE5VMTOTWUginb5wHunpw==
X-Received: by 2002:a05:620a:f0e:b0:6cf:beb5:a28 with SMTP id v14-20020a05620a0f0e00b006cfbeb50a28mr17115886qkl.738.1664891379646;
        Tue, 04 Oct 2022 06:49:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h16-20020ac85690000000b0035bb8168daesm12238061qta.57.2022.10.04.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:49:39 -0700 (PDT)
Date:   Tue, 4 Oct 2022 09:49:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Fix race condition of uffd
 missing/minor handling
Message-ID: <Yzw58fSsSmxSqfYo@x1n>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-2-peterx@redhat.com>
 <41fb1d6c-0d36-e88c-39fe-ea1e9d80a1fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41fb1d6c-0d36-e88c-39fe-ea1e9d80a1fc@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:19:36PM +0200, David Hildenbrand wrote:
> That looks kind-of ugly now. I wonder if it would be worth factoring that
> handling out into a separate function and reusing it at two places. Would
> get rid of one level of code indent at least.
> 
> Apart from that, LGTM. Although the lockless reading of the PTE screams for
> more trouble in the future :)

Right there's potential to further rework it, I am just not sure whether
that could be common enough so that we can start to take pg lock for the
whole region (then we'll need to release for either page lock or alloc).
Not really sure whether that'll be worth the effort.

However, at least uffd minor doesn't really need the page lock so we can
optimize it with a find_get_page() earlier then the missing mode can be
moved over too (following a lock_page?).  Maybe I should give it a shot.

For this one I'll keep it simple since I think we should have it for stable
too.  Thanks for the review!

-- 
Peter Xu

