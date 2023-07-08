Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02B74BB23
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGHBnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:43:36 -0400
X-Greylist: delayed 86108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 18:43:34 PDT
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777812D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:43:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688780613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dyaU2obnqlYOinMQdt1uRiNJmX1iW5TxGQjnfBScPQ=;
        b=KJ0QAeymXgL1YZEXWipaHrr63jNSlk49L7zSYZ+5wkPXIceawxxFyFs4IzdjVwFcyMk3ho
        rNd3xCRefYQooqi0j06dkTDu3JhuSkQJXsTkHKV2KRSGVYuDWCjkAt2RR36vzIK0Fd/YMh
        eTrKLf/FXLv8/K1rHHUc2csJWcUaGlE=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd split
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230707123844.adf56ba3e0d000f6da431494@linux-foundation.org>
Date:   Sat, 8 Jul 2023 09:42:57 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <63EDE3B6-B0AD-4D67-8EC6-FC8AE627E352@linux.dev>
References: <20230707033859.16148-1-songmuchun@bytedance.com>
 <20230707123844.adf56ba3e0d000f6da431494@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 8, 2023, at 03:38, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri,  7 Jul 2023 11:38:59 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> The local variable @page in __split_vmemmap_huge_pmd() to obtain a =
pmd
>> page without holding page_table_lock may possiblely get the page =
table
>> page instead of a huge pmd page.  The effect may be in set_pte_at()
>> since we may pass an invalid page struct, if set_pte_at() wants to
>> access the page struct (e.g. CONFIG_PAGE_TABLE_CHECK is enabled), it
>> may crash the kernel.  So fix it. And inline =
__split_vmemmap_huge_pmd()
>> since it only has one user.
>=20
> Is this likely enough to justify a backport?
>=20
> I'm thinking "add cc:stable and merge into 6.6-rc1", so it hits =
-stable
> after a couple of months of testing.
>=20

Hi Andrew,

It is better to backport it to stable. Could you help me add it?

Thanks.

