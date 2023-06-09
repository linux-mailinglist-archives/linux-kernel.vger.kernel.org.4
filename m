Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA36872A4C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFIUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC783
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686342895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPbQmwUDw1rrCoBIsKEBQ6SaspaPtKCgJlbYD45n1n4=;
        b=S8RRdnZabsnwk45LqM5X4E0Lo22XoXzRSW+/1z5jAb33nL8f1h4c/Eu2O53k6tC29z4qPb
        R6tsLXMziXPVewQTeJqeV7Q1yO9Atro0/D1MrNqVWQC7SKgBId1aXrS4LiPkGhUjreEqZz
        dDCsz+XQvcc+ZCf9y64QUuO57Dx0d9E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-0VEAwdPmMOGaqH-uGtqjdA-1; Fri, 09 Jun 2023 16:34:49 -0400
X-MC-Unique: 0VEAwdPmMOGaqH-uGtqjdA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75d54053a76so34063185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686342889; x=1688934889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPbQmwUDw1rrCoBIsKEBQ6SaspaPtKCgJlbYD45n1n4=;
        b=dCZj55skNI0xQyf+7ILn+eAcVyoAqqalyhm7Jt1BV3sQeHQejIhZSaMPlCPNd8LbRl
         qWVmsYMoVsL2JWPA3OLoZN9MC2Mta6/WtXH7lPL6Ifeho4HITZDr2yeqJuQHZtROq6EL
         xU8xpnxHWcLGyhQ5boAN+vl08yqZhFE7+3H7pk6b1+gS0n4nRadkWgtrXrs/ha4IdZHd
         w+4/VADJ7RL0pQ6K9z4cSkNzrMZUzSKfDbmqeClCqQGO+Ttz4fn7ASYFQjJjSqhX1rB9
         ZBQZiaj3hXLn1uejIpKBSDbsHrWDK+baH0fpDUjTknovr5dWHwIGZFWC7VnMRvCsJxL7
         O22A==
X-Gm-Message-State: AC+VfDxtsXV77sML428lXSFJ2IXrtZjCPZZELeriDn8EU5JXFNmlQkfj
        BmKsztzt+I/t+w/w2sh8awm7icF9+Klf3JNmXsQXwsURnsghRcvaiXvQUM7b4vbaKoDfLuhllk8
        QxZcinUgPPeudSr/gtOtn37Xb
X-Received: by 2002:a05:620a:3711:b0:75e:b9ee:79ff with SMTP id de17-20020a05620a371100b0075eb9ee79ffmr2740567qkb.6.1686342888795;
        Fri, 09 Jun 2023 13:34:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dU66sFL5e0sKBdTSuUBDYP+uMeSF/Slrlj3huXsRNDM2MpZKmMDCZm0x+DMxh9aiYqjIwXw==
X-Received: by 2002:a05:620a:3711:b0:75e:b9ee:79ff with SMTP id de17-20020a05620a371100b0075eb9ee79ffmr2740526qkb.6.1686342888499;
        Fri, 09 Jun 2023 13:34:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b007590aa4b115sm1269161qkg.87.2023.06.09.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:34:47 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:34:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 3/6] mm: add missing VM_FAULT_RESULT_TRACE name for
 VM_FAULT_COMPLETED
Message-ID: <ZIOM5RJhshoqqZFF@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-4-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:55PM -0700, Suren Baghdasaryan wrote:
> VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
> to be used as flag_array inside trace_print_flags_seq(). The element
> for VM_FAULT_COMPLETED is missing, add it.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

