Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19556DA640
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjDFXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDFXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:44:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF0120
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:44:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso40298109pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680824675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM5yP2pQ2NYPi6a+BhVoXAxnw5yjpnbyF9Bo/kTEiDk=;
        b=NowLn9YBZM92Cp2OL5BmFlN9nwYVbhKaDMqG/Opl98f5kJFZ5sXo2v/Edo1DAC4o9a
         i6R7W5yuOoxF2wzBMVTYpJWlKO0stRMEG6NkXheFwz7TjS/ewsm1KKduXKi7kioAdkg4
         msEuo/UZ220uvMQc5Wkm9Mp5gP5BWtApfT39LWfuNhvA+wRRCcnKQoVzWseHvDT2Ip+w
         szzIQKeGI9flnnH2LHAQowsq2vJHpZY28hkU3+Ei8EmgiHspiKxB9wAKZbO5O/uqdNUX
         0yiFWTyny/KcdRwj+kd0UZxivX/6ddaMGnBYiIvrSEWtAOSodpV4M/qjRzcHxBCjN6Gu
         mW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680824675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM5yP2pQ2NYPi6a+BhVoXAxnw5yjpnbyF9Bo/kTEiDk=;
        b=fJv4xh5iXei4yp0KmOy72u8fRr7Xjhe6E9W3esdEXWA+m6DAHZE+slOYfSE5ZlEDzV
         CMNgg+NbscAXUoUqi7VffYOf4ROqCioD1qV4x0ifu5hmE924qtzcsniUyCF2FnU6mNZk
         996cMBPmbDMAoJEuIu84fAfkcZyIkvZlJYW63m8WaD6o+FQ/AMlxVvg7LIaqinhByHdq
         wlRgFgi8LfiVYBjAMvcIs/h3qVkN+NexIAlUXLuc4KUcAXu918LBOn8knpRMnZenDuCz
         MiqjqvGeO18mQ3nSQ37uXpQJBhuu4uv+dR/8X4S9bwn6IWXmV0Wb6lcVVvQvMa8W2JMi
         tY1w==
X-Gm-Message-State: AAQBX9cfAm3AIHrG10Wv4NrkuMBKH6huMZNR2s07zQGCM/rDJCJ+94Ni
        +iqZEP7LTHDc3uRMXGJ7XmY=
X-Google-Smtp-Source: AKy350YRhZDeCWKl13JSZFKjtkuk1LnkcWSoeniRa4MoFv/lhHeS/ZsEbV1z3/R80ckYKT8TscvQZQ==
X-Received: by 2002:a05:6a20:4918:b0:de:807e:620e with SMTP id ft24-20020a056a20491800b000de807e620emr916525pzb.58.1680824675582;
        Thu, 06 Apr 2023 16:44:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b0062d9ced3db3sm1863836pfi.23.2023.04.06.16.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:44:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 16:44:32 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Message-ID: <ZC9ZYAp8a46dILdO@google.com>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:21:50PM +0530, Charan Teja Kalla wrote:
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
> 
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the clients who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt](). One usecase is implemented on the
> Snapdragon SoC's running Android where the graphics client is allocating
> lot of shmem pages per process and pinning them. When this process is
> put to background, the instantaneous reclaim is performed on those shmem
> pages using the logic implemented downstream[3][4]. With this patch, the
> client can now issue the fadvise calls on the shmem files that does the
> instantaneous reclaim which can aid the use cases like mentioned above.
> 
> This usecase lead to ~2% reduction in average launch latencies of the
> apps and 10% in total number of kills by the low memory killer running
> on Android.
> 
> Some questions asked while reviewing this patch:
> Q) Can the same thing be achieved with FD mapped to user and use
> madvise?
> A) All drivers are not mapping all the shmem fd's to user space and want
> to manage them with in the kernel. Ex: shmem memory can be mapped to the
> other subsystems and they fill in the data and then give it to other
> subsystem for further processing, where, the user mapping is not at all
> required.  A simple example, memory that is given for gpu subsystem
> which can be filled directly and give to display subsystem. And the
> respective drivers know well about when to keep that memory in ram or
> swap based on may be a user activity.
> 
> Q) Should we add the documentation section in Manual pages?
> A) The man[1] pages for the fadvise() whatever says is also applicable
> for shmem files. so couldn't feel it correct to add specific to shmem
> files separately.
> 
> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
> and this difference will cause confusion?
> A) man pages [2] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This means on issuing this
> FADV, it is expected to free the file cache pages. And it is
> implementation defined If the dirty pages may be attempted to writeback.
> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
> covers the semantics of MADV_PAGEOUT for file pages and there is no
> purpose of PAGEOUT for file pages.
> 
> [1] https://linux.die.net/man/2/fadvise
> [2] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
> [3] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
> [4] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

I am not familar with why the shmem has noop_backing_dev_info
but the below code to reclaim shmem pages and POXIS_FADV_DONTNEED
semantic looks correct for me.

Only nit is the description covers mostly DONTNEED case but not
WILLNEED case.
