Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F95F37E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJCVgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJCVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:35:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6263C8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:32:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so10796671plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=ZuRCUl6HMVxBq0xSk9jSUx9iN/xsLc64vNYxQtVKrJE=;
        b=JjwHslh0LG2aAfS0Fb4RaGPpmGCNi58yusVxfb7nSqOwnv8rRdfK0rlN/PCcJfb27I
         /1ahyFCKK8F4kmI7XvKqu5gpjzaJEt2pzykZl4FxKOp8J2aMvu6qXtKIZg/MYg8jzWpR
         YFpRZB17dBQl7krFq6+QJhSvu074CoNDgFkAQaQ9s5moBZenGl9UPxoZBns5rq3M8S9T
         JRnWF1hSm9wewHqJF4uS1GoWg9BsHoSWO26EuVj5hTmyqlsaI/Wh87Rj1xQ1XqGJzIYU
         sbYYfTAuk15fQXlI+F51KMyMPVCwuavNy1zsBU8r6mMjernlh+U0xqstpmfXC3nfE8xd
         ljVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZuRCUl6HMVxBq0xSk9jSUx9iN/xsLc64vNYxQtVKrJE=;
        b=je9B8XnbmloroIbuwPafBsnmVC3TqUo5ZlvIPCO/0puaymjK+nBCw/LpkrQxndqypG
         Qkr0NULxL8RMwZytwd4hbLtfMguVPfjjQkcqsmjmvriMMvC9ihnsuJocacEbQ7ildPm0
         EdkbLvzs1keCBtEqeYB2PksbF3tC1xcjtzk1IiVTNnGXRFWMr5NjsejIfXt4El4hLNpq
         mBdzVnbCD7VJfSlBVl5jHNalTPhwl+zirmLmFKJq2oh/dGHTpQ9R/31OJ8adNsZPgm2X
         vDtcIDfQ7mPDI/VK3g6TCO8zYw+/WG0Xv5x/NURvc5omrYixgVUAjLFWNFMxP0QXD+cK
         sg+Q==
X-Gm-Message-State: ACrzQf1DW6YPAfQCN+v5mOhh3AiAPhTkEr5NA4zPNdg8kTShvF4zf9hK
        H1dLBmnZSD2mi2+mzrdkHq171hO11FJdMN0I
X-Google-Smtp-Source: AMsMyM5tgwjt2ZzRUzY5eF7WQIxz+cdMiLlXU+UEX28a9b6I9SHSqdW55ZCGbNrsIq8zUEg3I2kwjg==
X-Received: by 2002:a17:902:8ec5:b0:179:ffdc:ee4d with SMTP id x5-20020a1709028ec500b00179ffdcee4dmr24606007plo.124.1664832753300;
        Mon, 03 Oct 2022 14:32:33 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b0017b5e1f486asm7613440pld.211.2022.10.03.14.32.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 14:32:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YztRR35U6gI/CA4r@x1n>
Date:   Mon, 3 Oct 2022 14:32:31 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <568C0BF2-28B9-438C-93D2-19130FAA3364@gmail.com>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
 <BBCFE41B-9ABB-49C1-BDC7-EAF07964A6FF@gmail.com> <YztRR35U6gI/CA4r@x1n>
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

On Oct 3, 2022, at 2:16 PM, Peter Xu <peterx@redhat.com> wrote:

> On Mon, Oct 03, 2022 at 02:00:36PM -0700, Nadav Amit wrote:
>> On Oct 3, 2022, at 8:56 AM, Peter Xu <peterx@redhat.com> wrote:
>>=20
>>> +			 */
>>> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
>>> +				ret =3D hugetlb_handle_userfault(
>>> +				    vma, mapping, idx, flags, haddr,
>>> +				    address, VM_UFFD_MISSING);
>>> +			else
>>> +				/* Retry the fault */
>>> +				ret =3D 0;
>>=20
>> Might be unrelated, but at least for the sake of consistency if not
>> potential GUP issues, don=E2=80=99t you want to return VM_FAULT_RETRY =
?
>=20
> VM_FAULT_RETRY implies releasing of mmap sem, while we didn't?

Of course. My bad.

