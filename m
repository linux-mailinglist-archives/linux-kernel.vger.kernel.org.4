Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB95F7293
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiJGBlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJGBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:40:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E84A4B95
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:40:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u24so3243857plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psA+UjfPNNFZ4z+eBeZEC7iWY14Pqcje4PonnYU9M7M=;
        b=tbuceVX/H+PzhuayDzo0ykHHjxLNbJsg4T19hxiQSsdfkU48qf8ZZuz3sLTXWQfdEL
         pcIHj5O2ie5l4RAXMHP0YrRbHFrCm5I24YXoi/vX0aZEpHPPiQ7sCQzhTe0gFsYDpDb4
         F8LwHS1381/FWww8nQ+Q/fFcHFdgpHKbpFKOftwPMmDsntEFh6VyKkhDS1+yMh1yPZJU
         /UJzsMGPOEaFevtotpvmhcA2umPoHMAjyfeYeJ0HhaN62ca25GBn7pLZLLWS/ZOHhClY
         Wk6B/yi3nLhM/R6Fy8CT+sQ7VM4xOf4bcQot4+mpwfLyecUdlqKV/KoGkg33BpjLuZrm
         OdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psA+UjfPNNFZ4z+eBeZEC7iWY14Pqcje4PonnYU9M7M=;
        b=7rhBEsjK/eV/zQOsgudFlgPDFZucdR1PCoRFOCwGl/AyN3JGlotSG+TlFuC9WLgGFQ
         ZbDfoCvswUHTTfm+yQ71RYcUKEjXfGnw+CBCMTl5YlrkYKyYxtMnhHn10kxIyWehc2Hr
         22ruEM2ItxzWYrVojo9jtBxWnThztpYCl+RCs7soyEI5OByEKSyDIg4N5mEoxghK9vpP
         wIhQxsct3Xrr1uVce+O3sept7jX8AXPi8+S7Twl4BKyck75Hy9xc75Zqfjb5qQTwiTMx
         P1Slz4aTC202U+RU+uz/y0VKnxz+Y1zHnJ8NjAndp2CVnmgLM47hlzxCrBAID+mIvXOm
         u9fg==
X-Gm-Message-State: ACrzQf1/UlLCpYk19xg/ZnqtENtSIP28XeehXnc/3NA77wWhS6CqIx+e
        0sX3Dm802jEj5Ew4tisvkJLoPg==
X-Google-Smtp-Source: AMsMyM5jX+Gww3bP73OzQcH0vIQiFVHxId96yushgKidEcYGmx9RGQXlWH1eBEQeVkoI06GpeM0sIQ==
X-Received: by 2002:a17:902:b692:b0:176:d346:b56f with SMTP id c18-20020a170902b69200b00176d346b56fmr2222567pls.140.1665106854044;
        Thu, 06 Oct 2022 18:40:54 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0056188850950sm270985pfk.180.2022.10.06.18.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:40:53 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:40:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 0/3] kvm/mm: Allow GUP to respond to non fatal signals
Message-ID: <Yz+DoQKUvfvG/q2B@google.com>
References: <20220817003614.58900-1-peterx@redhat.com>
 <Yz8+7/1uCzcGumBS@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz8+7/1uCzcGumBS@x1n>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022, Peter Xu wrote:
> On Tue, Aug 16, 2022 at 08:36:11PM -0400, Peter Xu wrote:
> > v3:
> > - Patch 1
> >   - Added r-b for DavidH
> >   - Added support for hugetlbfs
> > - Patch 2 & 3
> >   - Comment fixes [Sean]
> >   - Move introduction of "interruptible" parameter into patch 2 [Sean]
> >   - Move sigpending handling into kvm_handle_bad_page [Sean]
> >   - Renamed kvm_handle_bad_page() to kvm_handle_error_pfn() [Sean, DavidM]
> >   - Use kvm_handle_signal_exit() [Sean]
> 
> Any further comments from kvm side?  Thanks,

Code looks good, patch 2 just needs to be split up to better isolate the three
changes in there.
