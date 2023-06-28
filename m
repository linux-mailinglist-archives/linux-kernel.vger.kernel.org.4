Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5B7412CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjF1NnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231382AbjF1NnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687959739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rndt2IvyzL1bpq00OdsHzX63mJ29mnBqUBKzgaUOisQ=;
        b=E1vo6W//54F4gMefK9N52tVpQVQJWpxfu90KQqTqqK95Jf6E2kWa+vRVvH/OAQXrtKU+ho
        Yjsv4eO3ONJxxpnalFvbCmYYn2dA1tILI/JRPYP/H6X8pbQg4Ifm2NF40KzhddpToP41Wa
        D0pMZ5PqoCCfkfo+3nZhexzNaupBhYo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-VFsD99TPO9aDnYYHSWFmsQ-1; Wed, 28 Jun 2023 09:42:15 -0400
X-MC-Unique: VFsD99TPO9aDnYYHSWFmsQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4032a3ad8c0so167691cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959734; x=1690551734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rndt2IvyzL1bpq00OdsHzX63mJ29mnBqUBKzgaUOisQ=;
        b=GrWMThkNtIo3BIgY7cvSuBSLEG338gR1m0Du68WrpL0pWUPjRNg8R2St1fQQmLSrSu
         fH5RFqNSCKWGKXIjxj2l4FeZfbTd9VeFYXU6PXcn/4fTgdz73IpVp8HYDCuiYei2S+Xg
         IxXmngA2qDKjVEL/amaDglBW5UGrQ/4MLSSy7r6BCK6sbxXkf1SuA1va8srBARCgzz87
         vQZSzmpVtHzhWoayllMu3AuzjeBrLdPm0XswHFX9DT/I2dMfwbKRUv3KAsvtzyvLCSKN
         6kstyUUr1mVEcHd0RwvBQjfHBjvXn8V7sYqMCoJWU23K7DfLkk/gFCDu+L6+UyjWG61/
         uXaA==
X-Gm-Message-State: AC+VfDwwwVBpxfh7fDjgLfYqrRwkOSbqWC/KR6AOWehlAUq2ASmCo6f7
        C+XHTXWUh1u6EpKjzLdFlQQ3sWmLUqDAebGefhbgSA6zuT4PaoJcHQCYeKkCJHgddYKQx3B4V58
        16HalF/EtjvJmQUYqR7IMaKzx
X-Received: by 2002:a05:622a:cd:b0:400:7965:cfe with SMTP id p13-20020a05622a00cd00b0040079650cfemr25071924qtw.4.1687959734533;
        Wed, 28 Jun 2023 06:42:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LJyKRZ1t9xeZ7f1URuPPES1doCxywGeau5zExcrD1uMnZePa5MPysl7HJ8/dtiT97DYpdRw==
X-Received: by 2002:a05:622a:cd:b0:400:7965:cfe with SMTP id p13-20020a05622a00cd00b0040079650cfemr25071899qtw.4.1687959734190;
        Wed, 28 Jun 2023 06:42:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ge6-20020a05622a5c8600b004009320adb0sm5867387qtb.80.2023.06.28.06.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:42:13 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:42:11 -0400
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
Subject: Re: [PATCH v4 4/6] mm: change folio_lock_or_retry to use vm_fault
 directly
Message-ID: <ZJw4s0k8E1exM5XH@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628071800.544800-5-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:17:58AM -0700, Suren Baghdasaryan wrote:
> Change folio_lock_or_retry to accept vm_fault struct and return the
> vm_fault_t directly.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

