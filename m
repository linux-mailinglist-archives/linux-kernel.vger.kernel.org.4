Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9874173D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjF1RdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230425AbjF1Rc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687973529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0S2qMu17h8mlXEB7YzGyxzD+O5lnlad32j3R4zdlCU=;
        b=dR1Tn1bv3hkJfFTjmlgHYyRIsQE2sJbTVqk36WYoxqF+HjofjIe+lfkntJAKXkCyGW/gZe
        efoUIpD4HnxJvR/dfceeQ2JC0b3XpAqNbahJC2O0mAFvCP7CK7MxD+fpYwf2zuMZr/mTSu
        1Q579Vw/raHwlZtC/pL/VOvflp48m5E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-NjNbOOpCPTaosrWwCRcszw-1; Wed, 28 Jun 2023 13:32:07 -0400
X-MC-Unique: NjNbOOpCPTaosrWwCRcszw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40234d83032so251261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973527; x=1690565527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0S2qMu17h8mlXEB7YzGyxzD+O5lnlad32j3R4zdlCU=;
        b=fgcKoTBljJ6jaILWZnX0xoQ183NAE2hUs3YrNcUIKaOFiyAJtrX4ix86QHkYGWiGTZ
         lM/7oquofXfLxgLLaSD7zqDCTvczPBtPMd4U8HcNPJx93A0VXZUOsKAX6b0rMqW1LGVE
         OTYGC0o19IQCW5cdqmvY23nY8Dyy1DLzKHNp8fx/ykP8vlfMiuRZC+GvkuYHZgJGL4ek
         juswwqNaupVni0H2eXNMM7k7oZOiWZdMoBNPOZoT9oDiuCQ5vNiG5Hd4zA4s/tCLvMQq
         KAXlYCGDaVhjEpof7dKq+KqUgKpSCEcM5aotQCOZEUWPzZ7Q8fryy2LZ7ZXXjkWgKPrH
         PdVA==
X-Gm-Message-State: AC+VfDxP/nc8oHxbZ89+8cUKHKry7EtBEKk629pL/n06iHDyn5FzLfK4
        q0V7H8yID7xP9gAHfUIIxzaBbUUr0jJstNdE38GcMPEalX55uN/ijo/eIqgCxaOTKRH+OgIGs4x
        eKGhFnoyaidV4+V73AbAEGXk8
X-Received: by 2002:a05:622a:1811:b0:3fd:eb2f:8627 with SMTP id t17-20020a05622a181100b003fdeb2f8627mr39939253qtc.6.1687973526685;
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zIbrpeVS1P//ROrLWn98rbJUqVC2cFPhvP6qO+5ZYOuBmYLSEJ8G5hmetYO7hG2lGw3zRQw==
X-Received: by 2002:a05:622a:1811:b0:3fd:eb2f:8627 with SMTP id t17-20020a05622a181100b003fdeb2f8627mr39939221qtc.6.1687973526431;
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l25-20020ac848d9000000b003f7369c7302sm6095196qtr.89.2023.06.28.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:32:04 -0400
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
Subject: Re: [PATCH v5 6/6] mm: handle userfaults under VMA lock
Message-ID: <ZJxulItq9iHi2Uew@x1n>
References: <20230628172529.744839-1-surenb@google.com>
 <20230628172529.744839-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628172529.744839-7-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> Enable handle_userfault to operate under VMA lock by releasing VMA lock
> instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> should never be used when handling faults under per-VMA lock protection
> because that would break the assumption that lock is dropped on retry.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Maybe the sanitize_fault_flags() changes suite more in patch 3, but not a
big deal I guess.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu

