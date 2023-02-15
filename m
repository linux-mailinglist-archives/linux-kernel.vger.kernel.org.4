Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7336973AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBOBdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:33:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879C2B601
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:33:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so25855220lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+w3LbzPvMWbBgPnILe+wwnZS5ZiKny6OZv0ppYywUgw=;
        b=Xd/LxmxL18xkn4GKKw+kk7nmN9AhtdRkFtuyCLu5gaPLEeY4wMTyXXr6/OJTD5jDUW
         j4yLBrPdNX1ZSPZxQfJ3d9d5ue5mXWNb5pzwRS+1tzEu+Ue9qu7VqJW4s8Yheq4vMVnG
         K8Qu6JmM1GXlNcprcCCPy0t2SGKaLfdDfp/Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w3LbzPvMWbBgPnILe+wwnZS5ZiKny6OZv0ppYywUgw=;
        b=GmypOiNIJHZa5wUNCuUHM7RfsSbZfmD53aor05eyPRGapQCaysELiix3T+reZ5zUCJ
         Bk7fBqnRpWk4taNg8a+bofOkig8ZtvVNhRBUvuLnFhD5/1TTke5vkE94ht36Hgd2aDsa
         ibvrSza3/IVDW72F9E/FC2dJNIGEEy8+KDg776V9iy9WJMqMpEi4UtgW6UKbssdCQDDV
         KUAEQuvnz8B/E419EEYYcHo4lcUrC5LTe+Fr3Azs6t8IbNTuzC1sFcPVmO2zG8F++A4a
         4MrjbQR7shRSFlLvwYqIRbcF4BmrMnKKRqy0kEDuyvYg0tT7v5wtIzPncIrILxKF3fE6
         PraQ==
X-Gm-Message-State: AO0yUKXMbyi/1LDhtFE+T+cPN955l7PutvlbxExNJchk3/2f6VFmnLyI
        RwQK4YwbRJ9AF2vTRZgx2YbgQUNivNylcMaB1Q1HeA==
X-Google-Smtp-Source: AK7set8TzUas9M+ScnKwXa648gIhE0hdrmRXlNPvZPSxcsb71Aal/1Q2wrlPhyHfQxfYupVzc3m1smfnLm4FF/3jdyk=
X-Received: by 2002:ac2:5296:0:b0:4db:266c:433b with SMTP id
 q22-20020ac25296000000b004db266c433bmr32291lfm.1.1676424806799; Tue, 14 Feb
 2023 17:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20230214075710.2401855-1-stevensd@google.com> <Y+usdhfguWr/aD5x@casper.infradead.org>
In-Reply-To: <Y+usdhfguWr/aD5x@casper.infradead.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 15 Feb 2023 10:33:15 +0900
Message-ID: <CAD=HUj76eeScAKkX=uf03KnGcVvyzz_kJ4sYVx8XeFqwTVhDow@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/khugepaged: set THP as uptodate earlier for shmem
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:44 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Feb 14, 2023 at 04:57:09PM +0900, David Stevens wrote:
> >       /*
> > -      * At this point the hpage is locked and not up-to-date.
> > -      * It's safe to insert it into the page cache, because nobody would
> > -      * be able to map it or use it in another way until we unlock it.
> > +      * Mark hpage as up-to-date before inserting it into the page cache to
> > +      * prevent it from being mistaken for an fallocated but unwritten page.
> > +      * Inserting the unfinished hpage into the page cache is safe because
> > +      * it is locked, so nobody can map it or use it in another way until we
> > +      * unlock it.
>
> No, that's not true.  The data has to be there before we mark it
> uptodate.  See filemap_get_pages() for example, used as part of
> read().  We don't lock the page unless we need to bring it uptodate
> ourselves.

I've been focusing on the shmem case for collapse_file and forgot to
think about the !is_shmem case. As far as I could tell, shmem doesn't
use filemap_get_pages() and everything else in filemap.c/shmem.c that
checks folio_test_uptodate also locks the folio. But yeah, this would
break the !is_shmem case and is kind of sketchy anyway. I'll put
together a better patch.

-David
