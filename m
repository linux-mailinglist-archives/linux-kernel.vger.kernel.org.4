Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C472A4D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFIUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D822D7C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686343325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+p+efMF1py6pEpvkihdBi8OztSv7Pz8tdWi2Iw9yIU=;
        b=Ql1Q2gTLMWewSfgVXHb+IRl5Q5qpGrj9j/T3OX18cV8NnOwgXYD1LABz/ObqDPxqyIiJhp
        gvQa1DOZGEgeB1klQE4Q/A/o9qVFqsigyHoyPb16La5XoDl8mMXX0r67Wxmvb5QfF2EF7E
        EsLVRLLjwR8/PGUzLoTCQPezTCuo+j4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-sNVN0syjOW2IN_2R-wjfsA-1; Fri, 09 Jun 2023 16:42:04 -0400
X-MC-Unique: sNVN0syjOW2IN_2R-wjfsA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75b147a2548so47048285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686343323; x=1688935323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+p+efMF1py6pEpvkihdBi8OztSv7Pz8tdWi2Iw9yIU=;
        b=eru35MHFK4CnndZPNLDxc7kP5c+S0OrUpUrYgPwM72GY6vk7YkCfWf/P8FmzD0cnjJ
         UnOxa1NeyXPk9bXyMO7GI48NJnGcCkCyUVXOVnNNMoa84HiDAD8g2GUxno+g94diLblR
         bLQhpnMK/hdJkysQv8XtyLkmFcsClZfsdQuP2/PWWd4660KeWgAUWCMS3MEJFL94K6Bp
         KmX7qWdtMvebIKBFxn2ctGI4hTwWdmGvYHyF3MeRwvGB2TTVI04TzPVhzdoe6bBGi+vT
         ldZpFFwwHUc4q7V+siHTahaF8hFeI8yd0oiMXDTHSrWaGBTHuFy2pjAgDJ5ILAbLetPL
         iUyQ==
X-Gm-Message-State: AC+VfDziL/MArygdmy8EqmelPmPbB5To1Rq+X3nh4AhPqnleLsD0nPsW
        Jo2DG4J35vGYFaYuKxgWfvgQiOn+NyYYNz2dSq6OAJOGE6gwb1eVQZ7EqSvbpIJI9uCQy0T+fLn
        CtjxJhx4Tk9c3igY1gwc25rxH
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr2844976qkb.7.1686343323580;
        Fri, 09 Jun 2023 13:42:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MhYTYYAIL9lllr8F5q12r8SC+qD0eDeSyZp3uUsLxhZSNfrjXGqhTrE3LVMEEYGVFirie1g==
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr2844938qkb.7.1686343323262;
        Fri, 09 Jun 2023 13:42:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a14ae00b007595614c17bsm1259288qkj.57.2023.06.09.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:42:02 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:42:00 -0400
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
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIOOmC26qh4EXUEX@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-5-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> migration_entry_wait does not need VMA lock, therefore it can be dropped
> before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> lock was dropped while in handle_mm_fault().
> Note that once VMA lock is dropped, the VMA reference can't be used as
> there are no guarantees it was not freed.

Then vma lock behaves differently from mmap read lock, am I right?  Can we
still make them match on behaviors, or there's reason not to do so?

One reason is if they match they can reuse existing flags and there'll be
less confusing, e.g. this:

  (fault->flags & FAULT_FLAG_VMA_LOCK) &&
    (vm_fault_ret && (VM_FAULT_RETRY || VM_FAULT_COMPLETE))

can replace the new flag, iiuc.

Thanks,

-- 
Peter Xu

