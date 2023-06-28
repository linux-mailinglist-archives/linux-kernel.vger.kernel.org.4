Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E567412C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF1Nmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232072AbjF1Nmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687959710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILSaV7SEbZMYRZS2QLMojuBNjtkSUW+dMP8xI7bFpVE=;
        b=DOe05T5UCy3MEwlm39MaFRxA10AhX1Qq16wEaI+SXfGfJUzc7h17Om1m9P7bXvvS9Ni1Yx
        vnQOHLU5nOxInkgWfRgim4lIi3zW/eWUswSa5UlQ76PLeeV4Q19KI7K3/7XY2zgTDYBuQN
        gvpV0hx/KqkaaBZ+IFnfGs+opbO5NRY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-4kkYsD1nODShuelVeQc5TQ-1; Wed, 28 Jun 2023 09:41:42 -0400
X-MC-Unique: 4kkYsD1nODShuelVeQc5TQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7655fffd637so123687685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959694; x=1690551694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILSaV7SEbZMYRZS2QLMojuBNjtkSUW+dMP8xI7bFpVE=;
        b=FvxanTQaI8PVHAKfu5WMTGMPACpi3HUJVLVFTG6FzpPNHqP7kgajqkLx/kbWY8ksRr
         wUVTLXZIlRBXmWxW2HZdxPiz2JijZ6x0dbGOX++Jhnpt8ylOfzxHnj29Xd+epa5nZCVr
         FRuBsNdfCz5T00niFULkWu6BaCoG8GxEp0Q72D3nNiTKtfklvODnQxYZQpyTUiH4IPy1
         FgDElo+iaf7JMZeH5NmZDz4f3vLu5hK8M3NuceLUopXbIT1hpaoSpeluozHoimi84X89
         IFH/ZIemPNSgUuCpA3WZNRPc2696bPvXt5X6OGKvvvPCqi9tyA6KkD3bwvjgX2ecvxZi
         biSg==
X-Gm-Message-State: AC+VfDxOFyZr9L7KLUfeEnSB91r7Ulngy2aP884cpAkHDnHTYQfaz59b
        6RwqSiDi+v8FwgWa2qw5bg9j7ZSWNfh/6QER1XMiImMvQBynorb84QMrQAINXScOxuitc97gx12
        u72PosCUnQxipo0Xas+DpMNRI
X-Received: by 2002:a05:620a:31a8:b0:767:1573:d36e with SMTP id bi40-20020a05620a31a800b007671573d36emr4488742qkb.3.1687959694165;
        Wed, 28 Jun 2023 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EYwd3DwX2vFwTswXmip/cui/gItGng+GTU5PNz+TRsCiUUcV7PXYj6w3sA6knSn3LjwckQg==
X-Received: by 2002:a05:620a:31a8:b0:767:1573:d36e with SMTP id bi40-20020a05620a31a800b007671573d36emr4488725qkb.3.1687959693901;
        Wed, 28 Jun 2023 06:41:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a128f00b007594a7aedb2sm5045644qki.105.2023.06.28.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:41:33 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:41:31 -0400
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
Subject: Re: [PATCH v4 3/6] mm: drop per-VMA lock when returning
 VM_FAULT_RETRY or VM_FAULT_COMPLETED
Message-ID: <ZJw4i67FKlsvIiV3@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628071800.544800-4-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:17:57AM -0700, Suren Baghdasaryan wrote:
> handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
> mmap_lock has been released. However with per-VMA locks behavior is
> different and the caller should still release it. To make the
> rules consistent for the caller, drop the per-VMA lock when returning
> VM_FAULT_RETRY or VM_FAULT_COMPLETED. Currently the only path returning
> VM_FAULT_RETRY under per-VMA locks is do_swap_page and no path returns
> VM_FAULT_COMPLETED for now.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

