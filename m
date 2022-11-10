Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00065624D66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiKJWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKJWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:02:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D051C09
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:02:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3098646pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hUxSNiyiP1FDxtyo/mybNyzLXRprRaysx2LPFaFTIg=;
        b=iFKKKqEsH752Yu9uMRK7Rbwse7YpvoeLmOwrxmv4hOT0T4Qjibq/cSYYi89cBhCMJZ
         GY2x49iXFuIz7pi02LbkQYc5NO8fA46+IjPy/oV/vYakFl3ap8hHgUHHLHi3KULiqg4M
         6VLdVaPLHwJO4ppMmQ9dxvamh9PwVPz0X2o0c4Qx8RA+I4zF7Aqau9z9KlJGgzB/BnsU
         TOZx/yAFYJBujkCLha1e3nseIptn2GnOMYWzDV6kiKja3rfnPJ3/ba7n0KhIoaXOkrpk
         Y/8y2qhqr1Vo5RQIT+S6Q+bEAmOo5C/BP0PrA+h2tdNyaCQ5DXoD4MFG2VHUyUtX/CDQ
         6FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hUxSNiyiP1FDxtyo/mybNyzLXRprRaysx2LPFaFTIg=;
        b=Lf9QRWTNsibXiFFei94vZhNJ8JF2ZnPIu5dvbcUJY6PDvhQTPWZs0hfSWZAw9S3UT4
         hZ8++kfzy6LJD320cfv85yDESOU+2SrACR6+DRMRXCHxb6rCcIbnopYh+qM9RSL4pGzh
         m3BupV2wTqBfZHilwRWjjhW0tDsIoltNB3c1qIIUwzgCO+KjlCCxC9c2jPpzBbF0L/jN
         M4t3BE5HU/yhi7XWPAFMj5rC7R4++HxMrzpdlLyEk3060WPn0p1H2FI7yU/6mjvSUFfR
         697ZbfBDsjPjHvzOlagmXSQMTV4n+XoEXkCUYAFlEPZgRpmm5czWqhEkp0+4b9S7gFDk
         z7bA==
X-Gm-Message-State: ACrzQf35pOTtMJ7ggpX6vA3skrIJt5jOZCpkSdsWaln5tRQ+ZCxR+rez
        mtPEcU2f1XI9ULqTEuX5t8c=
X-Google-Smtp-Source: AMsMyM7/Wb2clQiZC8X/DJgAfJ62LgZY7EjD+MfsEcrYj3vVkIYrcx05UVRdFV6YX8hh7tpx61/hgQ==
X-Received: by 2002:a17:90b:1d4c:b0:210:a844:217c with SMTP id ok12-20020a17090b1d4c00b00210a844217cmr2298643pjb.150.1668117778506;
        Thu, 10 Nov 2022 14:02:58 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id r17-20020a170903411100b00186c3727294sm141647pld.270.2022.11.10.14.02.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2022 14:02:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v8 2/2] mm: remove zap_page_range and change callers to
 use zap_vma_range
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y21s1uzkey6u4nyK@x1n>
Date:   Thu, 10 Nov 2022 14:02:56 -0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C16276B9-F40A-4767-AB3A-8566FA61A8DF@gmail.com>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
 <20221108011910.350887-3-mike.kravetz@oracle.com>
 <7140E1D7-B1B9-4462-ADDA-E313A7A90A68@gmail.com> <Y21s1uzkey6u4nyK@x1n>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2022, at 1:27 PM, Peter Xu <peterx@redhat.com> wrote:

> Hi, Nadav,
>=20
> On Thu, Nov 10, 2022 at 01:09:43PM -0800, Nadav Amit wrote:
>> But, are the callers really able to guarantee that the ranges are all =
in a
>> single VMA? I am not familiar with the users, but how for instance
>> tcp_zerocopy_receive() can guarantee that no one did some mprotect() =
of some
>> sorts that caused the original VMA to be split?
>=20
> Let me try to answer this one for Mike..  We have two callers in tcp
> zerocopy code for this function:
>=20
> tcp_zerocopy_vm_insert_batch_error[2095] zap_page_range(vma, *address, =
maybe_zap_len);
> tcp_zerocopy_receive[2237]     zap_page_range(vma, address, =
total_bytes_to_map);
>=20
> Both of them take the mmap lock for read, so firstly mprotect is not
> possible.
>=20
> The 1st call has:
>=20
> 	mmap_read_lock(current->mm);
>=20
> 	vma =3D vma_lookup(current->mm, address);
> 	if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> 		mmap_read_unlock(current->mm);
> 		return -EINVAL;
> 	}
> 	vma_len =3D min_t(unsigned long, zc->length, vma->vm_end - =
address);
> 	avail_len =3D min_t(u32, vma_len, inq);
> 	total_bytes_to_map =3D avail_len & ~(PAGE_SIZE - 1);
> 	if (total_bytes_to_map) {
> 		if (!(zc->flags & =
TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
> 			zap_page_range(vma, address, =
total_bytes_to_map);
>=20
> Here total_bytes_to_map comes from avail_len <--- vma_len, which is a =
min()
> of the rest vma range.  So total_bytes_to_map will never go beyond the =
vma.
>=20
> The 2nd call uses maybe_zap_len as len, we need to look two layers of =
the
> callers, but ultimately it's something smaller than total_bytes_to_map =
we
> discussed.  Hopefully it proves 100% safety on tcp zerocopy.

Thanks Peter for the detailed explanation.

I had another look at the code and indeed it should not break. I am not =
sure
whether users who zero-copy receive and mprotect() part of the memory =
would
not be surprised, but I guess that=E2=80=99s a different story, which I =
should
further study at some point.=
