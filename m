Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6333D7416BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjF1Qse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbjF1QsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687970838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rP7oTLZXnrKdM7Uf6r5o7yLX5pLrMAahCaLybcdGA/I=;
        b=f/1jFSv4LLBfLYgEvAuuHpIbrQYHtljisTgKE5ffm88VuupeffqcxrTKPIyhrrhh38IHb1
        cn5hquMo/MJVjC6eYmq5FgIBlk1w402UJ1CIoAacF6eT75nOJmTmP/bSGCCJLRiji8IiqV
        DmdhwHVuBoNEQ19w77c/G2uYiMu+0kY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-N59JoN2ZOkCHjKHfpVoEQA-1; Wed, 28 Jun 2023 12:47:16 -0400
X-MC-Unique: N59JoN2ZOkCHjKHfpVoEQA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4009ad15222so86751cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970836; x=1690562836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP7oTLZXnrKdM7Uf6r5o7yLX5pLrMAahCaLybcdGA/I=;
        b=B/06VXmoBsk1uqmVIjpt+40ECqrZ5uHoBsVLtip/6obiLVv1Pf/cOB8pKAMncDTYxF
         Ni4leeQyxGRcdakdV0Fj2B/cvcEumrrFhSjlMpxxKtnZ1aFRAp5+EZ6PLJDw20okh5PG
         qY8qkzk+TfwcQet4g2KtXWkhno1tiJCmRa5ChZmp6UF1PnDVFii3/eTBLpYu2E9DaXn5
         HT9V6u8V2y8prdgpR7KN+zcDg+PACzzpk5UCzEvDrE7P/H9wtm5S7j0BEPy2gmph5uWC
         z5LNhAkfBaB4JSOyk8Cev0EhFaGXgNLflhqm9MPpcLuYrz948Tln5pgoaF9J9Sl66ruo
         PY4A==
X-Gm-Message-State: AC+VfDy048jPXwbvtbc7WcCwpuTs+yFMuPJddWNBSVWSje0XWiuM1g1c
        ZPN9GG/+ajGA8UoOnqQwj6RGKvm4kwRrq9fQbf1s3ly7Mu9QzikYpB4KKKXnXxN61/xz5HwpmH5
        gerYzTiKIccOPolOumxD1D3OW
X-Received: by 2002:a05:622a:1827:b0:400:a9a4:8517 with SMTP id t39-20020a05622a182700b00400a9a48517mr11519359qtc.4.1687970835960;
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LY9IyT/sYyokB/ZS4mBtNEaOWQAWl0KHBcBGkRFXhA9IA4rTLIiYa9kmVOKNwHngvfuwDCg==
X-Received: by 2002:a05:622a:1827:b0:400:a9a4:8517 with SMTP id t39-20020a05622a182700b00400a9a48517mr11519338qtc.4.1687970835728;
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403214e8862sm1027423qtx.33.2023.06.28.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:47:13 -0400
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
Subject: Re: [PATCH v4 6/6] mm: handle userfaults under VMA lock
Message-ID: <ZJxkEVWMAXnz8Y9D@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-7-surenb@google.com>
 <ZJw8Z3E3d4dHPDuZ@x1n>
 <CAJuCfpGRresZRacCSDU=E+CNDkGfMwO2u-oTB_H30cASzFgNtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpGRresZRacCSDU=E+CNDkGfMwO2u-oTB_H30cASzFgNtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:22:24AM -0700, Suren Baghdasaryan wrote:
> Ack. I was not sure if the ctx->mm would always be the same as vmf->mm.

Feel free to look at the entrance of handle_userfault(), where there's:

	struct vm_area_struct *vma = vmf->vma;
	struct mm_struct *mm = vma->vm_mm;
	struct userfaultfd_ctx *ctx;
        ...
	ctx = vma->vm_userfaultfd_ctx.ctx;
        ...
	BUG_ON(ctx->mm != mm);
        ...

So I think we should be safe.  Thanks,

-- 
Peter Xu

