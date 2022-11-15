Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93262A108
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiKOSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKOSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485163E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668535428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZPGmCDP4PdFjMklWOBrmsqQLminbKqT3dINkdp9yW4=;
        b=fZ+rWeSsnKXg293z9HL6yOmD7UDK9J5zQrYxWyZnh99EV/ASOnJhTN5gEz/n1rpNRm9vdd
        Fotc7xVsMKHM2DR05YWA+e+pdgRGpyd8nNv1CH2Hkq0Vq62DW9VwagKGf/iDH5Eqw44DkJ
        3L2ZaLM9cP1fzSvFsAyJGkDMVrpPt5o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-zZLJ8pXEMX-9MHPx-YQchQ-1; Tue, 15 Nov 2022 13:03:47 -0500
X-MC-Unique: zZLJ8pXEMX-9MHPx-YQchQ-1
Received: by mail-qk1-f199.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so13618864qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZPGmCDP4PdFjMklWOBrmsqQLminbKqT3dINkdp9yW4=;
        b=X/MkghO97jctEWXUmFcwqiY5GIzbo8DA98emiLWzNKhGRBY8yOtbZdK8G+VylMi3f8
         tNVFJulhvGl6UcF6BiT3A5ZxKRm6bco2jgLIS16pl5p7RqOXSEUJkCVZV0WBy//7X+SW
         RhPViIaGi0VBUXfCf1aoff8/5ZLsf0Z5GQP7wA4e7DlSzaGmCyZjjz23+2SznEdlkfe2
         84q4dpoZkEcrWW8j0tjg6bASGIjWYTugd+Erer2lZKRNy36QluKzAnK2DiEXxyY+8rCO
         IdnHChrEzXSwvWm1yPL/fBrA7K1Wn3MpYlqY34tRK2LIgViiaoMzYQEyCbHUmGKFpGFo
         ItDA==
X-Gm-Message-State: ANoB5pmLy5E4dKTEJBK7LAqYS97BtiXn0J6xxV9c+jt6bESQL5IN+4hD
        qf79zaWhMv3jDYj70gjywa0BH1grEuKhED3wzDYrtb6SQzLt11BWDAUBh18SFQw3ywyfX3UfGDB
        b6us3gZoleuizJyGhRqgCJd/Y
X-Received: by 2002:a0c:fb4f:0:b0:4bb:746b:b643 with SMTP id b15-20020a0cfb4f000000b004bb746bb643mr17508977qvq.19.1668535426682;
        Tue, 15 Nov 2022 10:03:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6mtOCzP7fiXUrDhLbvxXOqillzwqzhWEmXWxlkkc1Rq2ucanEsEPbR5tAtX2D+jVp+DisnVg==
X-Received: by 2002:a0c:fb4f:0:b0:4bb:746b:b643 with SMTP id b15-20020a0cfb4f000000b004bb746bb643mr17508949qvq.19.1668535426426;
        Tue, 15 Nov 2022 10:03:46 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id e8-20020ac86708000000b003431446588fsm7455092qtp.5.2022.11.15.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:03:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 13:03:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y3PUgOUYx6ECN405@x1n>
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com>
 <Y3KgYeMTdTM0FN5W@x1n>
 <ec8b3c86-d3b2-f898-7297-c20a58ae2ac1@redhat.com>
 <Y3O5bCXSbvKJrjRL@x1n>
 <82d7a142-8c78-4168-37e9-7b677b18987a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82d7a142-8c78-4168-37e9-7b677b18987a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:22:03PM +0100, David Hildenbrand wrote:
> That's precisely what I had in mind recently, and I am happy to hear that
> you have similar idea:
> 
> https://lkml.kernel.org/r/20221108174652.198904-6-david@redhat.com
> 
> "
> Note that we don't optimize for the actual migration case:
> (1) When migration succeeds the new PTE will not be writable because the
>     source PTE was not writable (protnone); in the future we
>     might just optimize that case similarly by reusing
>     can_change_pte_writable()/can_change_pmd_writable() when removing
>     migration PTEs.
> "

I see, sorry I haven't yet read it, but sounds doable indeed.

> 
> Currently, "readable_migration_entry" is even wrong: it might be PROT_NONE
> and not even readable.

Do you mean mprotect(PROT_NONE)?

If we read the "read migration entry" as "migration entry with no write
bit", it seems still fine, and code-wise after pte recovered it should
still be PROT_NONE iiuc because mk_pte() will just make a pte without
e.g. _PRESENT bit set on x86 while it'll have the _PROT_NONE bit.

May not keep true for numa balancing though: when migration happens after a
numa hint applied to a pte, it seems to me it's prone to lose the hint
after migration completes (assuming this migration is not the numa
balancing operation itself caused by a page access).  Doesn't sound like a
severe issue though even if I didn't miss something, since if the page got
moved around the original hint may need to reconsider anyway.

-- 
Peter Xu

