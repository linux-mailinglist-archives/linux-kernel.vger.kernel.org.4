Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371B6E813D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDSS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDSS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254940D7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681928845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2onLLBooGq3bEAgd4FBs+LTfCCveM4cC504bz5pRP5U=;
        b=Y0in4j2idOKKhORL6Ewqc7QV20pr6tu2Q6qUjlkNX/6w65tOZFu357HvZTqFLnoQa2INMF
        SahziPHZLR6afffrmLVm9+vtssrXVlBFGXo/gw8WFUv44XLUgFowDi2n4+ly7tcI/hlscH
        QzVxkrOZGWybs7PwdmvVc08BPeF3ADE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-eOtgbIh1PeGTxSYBqYDnnQ-1; Wed, 19 Apr 2023 14:27:24 -0400
X-MC-Unique: eOtgbIh1PeGTxSYBqYDnnQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ecd50d9db9so164271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681928844; x=1684520844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2onLLBooGq3bEAgd4FBs+LTfCCveM4cC504bz5pRP5U=;
        b=DvgxUQHKlCMT6VWwohAah+HDWbmPrJSBJSYMPL0v3TYkJ82ocNO86YFxhwfgat3jmi
         Ut20cqLIusCBFuM/teUjbZM96A3M7es56UQjxU0HoHPOdFiJwYFPrCSUCtdTRHqCsESs
         pmcrr9GpEPoW6n5BcR8Bwvt7bhNGz0XSewiy0pkVQ0/cz+NLGqkv+6L08O2yTypYHDsE
         5V1b539/qXuYVYVfhWgRlVhyjShvgJNSigb6nmspvYxIJdcC3jQRZo2v+xvfOWBCoC7L
         HDYGOpsSI6wH/6C/cYHaKPSiX/CSkc4+WlN95POTeWRh/3Gf0jNafgqR4g/981Ai/RqP
         iHLA==
X-Gm-Message-State: AAQBX9cZexMJfzlM0r4Sh7hzrVj2zmKCblBHeSgnSIzfvY3iAWjq6quF
        M/ME/drlkg8PE1YPdXekH3FVzKz0MWFrrls5CQs6PCblObBr7fY08eKYw5PKbzC0UCjfbAdv6j8
        92EkASqaKfkW6SK2PMMoT0GQD
X-Received: by 2002:ac8:7f09:0:b0:3ef:168:7833 with SMTP id f9-20020ac87f09000000b003ef01687833mr22897595qtk.5.1681928843882;
        Wed, 19 Apr 2023 11:27:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZLVi1GcCgkvvecYXJFqlz7c5nkR/mfKbtlcZOkNdh0ec8eUGiD4s1zunfpuZfstBSsT+OYGw==
X-Received: by 2002:ac8:7f09:0:b0:3ef:168:7833 with SMTP id f9-20020ac87f09000000b003ef01687833mr22897570qtk.5.1681928843652;
        Wed, 19 Apr 2023 11:27:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a405000b007468733cd1fsm4814337qko.58.2023.04.19.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 11:27:23 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:27:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZEAyiRk1oglQNDjq@x1n>
References: <20230419175836.3857458-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419175836.3857458-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:58:36AM -0700, Suren Baghdasaryan wrote:
> If the page fault handler requests a retry, we will count the fault
> multiple times. This is a relatively harmless problem as the retry paths
> are not often requested, and the only user-visible problem is that the
> fault counter will be slightly higher than it should be.  Nevertheless,
> userspace only took one fault, and should not see the fact that the
> kernel had to retry the fault multiple times.
> Move page fault accounting into mm_account_fault() and skip incomplete
> faults which will be accounted upon completion.
> 
> Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

