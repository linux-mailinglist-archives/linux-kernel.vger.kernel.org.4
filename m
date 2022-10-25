Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9845560CFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiJYPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiJYPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12B17E233
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666710512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0d57/FG1yOMIs5lFLRr57Noshc6kW2xI64qo/QoA5us=;
        b=KvfzO3xzta48vDvs0HvvaC7Dvkc7TahrLKpzA0JdQvCgDvqnEz5O3huK26hd9dJEYjBiuX
        YUHJAf2b/BOzMB04GuYDb0yOOa9rpJBn/LkcA0G4XECEKzrTdZz0hVaep4hnHUTmJN6075
        3Cv26afOWbTy6lw+3W+cKuxrCqZODQY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-D_2yNBIMPrugCdZmqZbTEg-1; Tue, 25 Oct 2022 11:08:25 -0400
X-MC-Unique: D_2yNBIMPrugCdZmqZbTEg-1
Received: by mail-qv1-f72.google.com with SMTP id mz8-20020a0562142d0800b004b18a95b180so7125828qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d57/FG1yOMIs5lFLRr57Noshc6kW2xI64qo/QoA5us=;
        b=wQ2j4EhBRHE3ZvAXDTAWWKPuYiFvbYVJFhZdTKRZGgEPIinzjMIMXUJOFTOZI13F7z
         uXBdzsM8jzBfjEfQ/WHzI31UIhkeDboAz+EB3mk9vqsTNUZa8LSIrE1JYFNYj4i8N+4f
         NbR/NvCQ8CnYUft0NYTCLwthoF1/33zAf5VR/RfvxYqkV1jI6k100s049wtetoHS/1le
         aLhUyZW0kECdDKqlHzYSMtjt5B0B5jneD8ksRpDS5bzYFgiZkE2UNVjBHo1HxY/2iiDk
         S/VUDuY32oItqfGVuPuCLssVRMAK4kqSfNjjqKsX1G2G8TY9+Mr783gR/xLyVfu0NaFK
         jykQ==
X-Gm-Message-State: ACrzQf1emixn50hSVygAR9+R0bPTk650ybHlJIwg8AkyHeYYMhbalT3j
        NQ8i7dP8JfJ+5umgswwwU9hfJNeGyOmol5hpbsRCjCMNcQk+l0FxgGbRkANyrnCYFs0ufssLCEw
        0LaCyM1e2FY6b9TQj5UAW+JiZ
X-Received: by 2002:a37:8083:0:b0:6e3:e0e5:7c08 with SMTP id b125-20020a378083000000b006e3e0e57c08mr26581753qkd.257.1666710500831;
        Tue, 25 Oct 2022 08:08:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6a8ZvILx4KvqqwuKwl7jmQmdd4g7PTM7g5m1ZdbDggKnrV6aTWHPznnOasUUTeiGrWJvQ2Tw==
X-Received: by 2002:a37:8083:0:b0:6e3:e0e5:7c08 with SMTP id b125-20020a378083000000b006e3e0e57c08mr26581734qkd.257.1666710500584;
        Tue, 25 Oct 2022 08:08:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a400a00b006f8665f483fsm433951qko.85.2022.10.25.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:08:19 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:08:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC 0/2] mm: Use pte marker for swapin errors
Message-ID: <Y1f74hN8kzjE3Ud+@x1n>
References: <20221024204830.1342169-1-peterx@redhat.com>
 <87r0ywli7n.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0ywli7n.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:01:32AM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Hi,
> >
> > This series uses the pte marker to replace the swapin error swap entry,
> > then we safe one more swap entry.  A new pte marker bit is defined.
>           ~~~~               ~~~~~
>           save?              file?
> 
> It's good to save one swap file.  Thanks for your patch!  Please feel
> free to add my
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> for the whole series.

Thanks for the quick feedback, Ying.  I'll wait for a few more days before
a repost.

-- 
Peter Xu

