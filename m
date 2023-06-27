Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1D73FF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjF0P1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjF0P1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464362962
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687879571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpxx00XoyC132Mr6RO3yKQstSVhf2gcfuBHHVEFTNh0=;
        b=KQF/VGQk34R4yoYPP//ZAESluqCW+Bw3TNvYaTOKuSmu+R+V59Oo1EBcVRllLtHRlgopEV
        0kX4cOl7+c3/p4sWyuJd/aeYS8eKYXd1muEn6dO+NU4/O0NN/2VT2r7E6/PTb5TWFOjXOA
        bA7LpsbWxQxSNAMajc+OV6j3IlnRxr4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-qXyGxcF_MHSN8C-6M4AJjw-1; Tue, 27 Jun 2023 11:23:02 -0400
X-MC-Unique: qXyGxcF_MHSN8C-6M4AJjw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62dd79f63e0so7955686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879361; x=1690471361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpxx00XoyC132Mr6RO3yKQstSVhf2gcfuBHHVEFTNh0=;
        b=AY6gvaZAwA3c1DycrDgaulrCPaAPOGIJBw1j+4/IlSMNt0QCN4ZH65kANtwbMs3FWv
         QVcvD7oLFmkyZ9drQ3btDqcXBCbyURSYVrObirAbppSxYvcoAs04RD7n4wBxVcsme5tB
         D4MQSmhM3K1qO50CJsBobDzCANktQgZyvFDbAGko2xzfGkFQl8HsdUFi5Ud+9FGyhpiS
         AIx0nK2lzjNzUTrBiuFEeqANz9HyRfyV6Y3T55RClPy4jk6bOgAvEtcvMiHqJF4pSzQA
         DlLxWVZmVotp0YWG1eZpJG9ixm0OGOTm2vrIKaL9w4AD5ZELQ++tvrqp8ESwYrnCFhwp
         DrCQ==
X-Gm-Message-State: AC+VfDyy1vaAFe4eXmxUiiBE31iCHjZd57cWHuakkerrXWMZDznpp9kZ
        N8dymBn7/uSAyV4tNKN/hv5/IJPS5b6ydfhyZC8amMLNcFB55MaxDE9PxfVFlTJPijdqvoNxwID
        d/R+QrkgXBd+j2/pwADcQFMbl
X-Received: by 2002:a05:6214:c22:b0:625:77a1:2a5f with SMTP id a2-20020a0562140c2200b0062577a12a5fmr40561812qvd.5.1687879361508;
        Tue, 27 Jun 2023 08:22:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7k+Rvj2HAGIGv/kROiZog/CMhixAGLi2szEMwd9ZGPIqaz7MS5XLwAM8b1ix+sT9QAUyZ4HA==
X-Received: by 2002:a05:6214:c22:b0:625:77a1:2a5f with SMTP id a2-20020a0562140c2200b0062577a12a5fmr40561789qvd.5.1687879361249;
        Tue, 27 Jun 2023 08:22:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0063003786840sm4661038qvb.99.2023.06.27.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:22:40 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:22:38 -0400
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
Subject: Re: [PATCH v3 4/8] mm: replace folio_lock_or_retry with
 folio_lock_fault
Message-ID: <ZJr+vlkIpaHWj1xg@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-5-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:17PM -0700, Suren Baghdasaryan wrote:
> Change folio_lock_or_retry to accept vm_fault struct and return the
> vm_fault_t directly. This will be used later to return additional
> information about the state of the mmap_lock upon return from this
> function.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

The patch looks all fine to me except on the renaming..

*_fault() makes me think of a fault handler, while *_lock_or_retry() was
there for years and it still sounds better than the new one to me.

Can we still come up with a better renaming, or just keep the name?

Thanks,

-- 
Peter Xu

