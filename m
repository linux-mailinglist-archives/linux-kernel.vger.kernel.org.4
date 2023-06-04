Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B8721B21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjFDX7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737E0C4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685923103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koo3yH5MPFViQPVYh2VWDsSwxsVmauul0f0H0scecGw=;
        b=Yf6ycMWfM2J8FOvea5OuRJeaTNXuFStLtL5IWPc7OtlzhtTMYvZpdsFnMlhRbnRrClHcmq
        6jcxURsH3yFPu5PbltCrNC2bC0RUKDORxpNUg00fwxMSVkVhpe+CItgHR/++5OwZY4fhT+
        ioXkqOkq94AVym88H6vCzhsCUygI/3M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-WPmxjeZBNguV2L6VK6rM-A-1; Sun, 04 Jun 2023 19:58:21 -0400
X-MC-Unique: WPmxjeZBNguV2L6VK6rM-A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62607e62fa8so5070316d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 16:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685923101; x=1688515101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koo3yH5MPFViQPVYh2VWDsSwxsVmauul0f0H0scecGw=;
        b=VJO8BakGxDO6INTgMoMZ4mG7/KSXda9xtyiUfr3LUSbH5JDI7cfqBeb1vdz0YNNxmi
         p8A7ZdFMGkDdUZyCQrcg2n2d4MeOcLCnTP93PQScXWGwj2xkYYdQreUiJE+YnoD8m672
         96jlUsfUeKvVAKwStdGV0xiYvJi49Kf+T+ccailIJpqNbNSXNlu4fggqVin1sAhSs10g
         myAdg1w1QLlGqV5aXBK6nRpL+5N5geCrJtnQRA/c+B3ejsDxxkB0XJCZu18ixcs+mJyJ
         8/Kk8w5GfHPL7xBm5ps3Fi/5blmC3jo8rPoEwpP5QLA619FgxbLaOatTStIy7XvlvYLY
         CJzA==
X-Gm-Message-State: AC+VfDwRFA8tML8Oj6uZkGgPYs83QzyMZV/2ci6XYqLyfxTxSCclOQxf
        gdOoj0PuArlg4SjDDnvB0n/ge6wXnOTfkikf4thUbE0qsjbH2sWskFU2Edp9kW6PU8SaLLKlejk
        16nqItBuU5iQoxDXdm1mO8E8a
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id 2-20020a0562140d6200b0062588f57c62mr19160384qvs.2.1685923100975;
        Sun, 04 Jun 2023 16:58:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LSRhaeGa+jP8jS2Pla4RAxoXEfKFtm5voEN4LshrtFdiTiJUOIVIpDUIrkE+Kh+yLufRM5A==
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id 2-20020a0562140d6200b0062588f57c62mr19160374qvs.2.1685923100693;
        Sun, 04 Jun 2023 16:58:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ph14-20020a0562144a4e00b00605f796d30esm3813391qvb.51.2023.06.04.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:58:19 -0700 (PDT)
Date:   Sun, 4 Jun 2023 19:58:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 1/4] mm/mprotect: Retry on pmd_trans_unstable()
Message-ID: <ZH0lGt747WoemufM@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
 <20230602230552.350731-2-peterx@redhat.com>
 <CAHbLzkq+Mf3N1FvjMRD8+SiEsry_39ycgCN92GHp5VsshyKE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkq+Mf3N1FvjMRD8+SiEsry_39ycgCN92GHp5VsshyKE8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:04:48PM -0700, Yang Shi wrote:
> On Fri, Jun 2, 2023 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > When hit unstable pmd, we should retry the pmd once more because it means
> > we probably raced with a thp insertion.
> >
> > Skipping it might be a problem as no error will be reported to the caller.
> > I assume it means the user will expect prot changed (e.g. mprotect or
> > userfaultfd wr-protections) applied but it's actually not.
> 
> IIRC, mprotect() holds write mmap_lock, so it should not matter. PROT
> NUMA holds read mmap_lock, but returning 0 also doesn't matter (of
> course retry is fine too). just skip that 2M area.

True.

> The userfaultfd-wp is your call :-)

Yeah I think uffd should still be a problem.  I'll reword the commit
message (by dropping mprotect example) in the new version.

If you have time feel free to have a look at patch 4, where I think it's a
bug for pagemap too (I didn't check as close as all the rest; the memcg one
might be suspecious, that's also in patch 4).

Thanks!

-- 
Peter Xu

