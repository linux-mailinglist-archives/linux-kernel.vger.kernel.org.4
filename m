Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A078631272
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 05:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKTEEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 23:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTEEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 23:04:14 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33369E97B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:04:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668917049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDxWdGiElBsqX8waqP46DZtvp4qVUO5EP4TRxvBLmaY=;
        b=g3EvtgwwK1CFc0Jgv3Ju3S+OtVQ2JsxjeC09PWbMWC9UN5lIDfZzL2MG6SJc/Z63dVoSP7
        WvVu1I3F35qBcmrjIEsf78lSkMiAYLSbY+40l73sTTiHNI97ORFuueqE34ZnasaIKuaks7
        UXmObkORL9qcHf/QG0P2VmTJbeYbOX4=
MIME-Version: 1.0
Subject: Re: [PATCH] hugetlb: Fix __prep_compound_gigantic_page page flag
 setting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221118195249.178319-1-mike.kravetz@oracle.com>
Date:   Sun, 20 Nov 2022 12:03:52 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D335332-2BFB-4F69-ACA2-3CE5EC5BD494@linux.dev>
References: <20221118195249.178319-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 19, 2022, at 03:52, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> Commit 2b21624fc232 ("hugetlb: freeze allocated pages before creating
> hugetlb pages") changed the order page flags were cleared and set in =
the
> head page.  It moved the __ClearPageReserved after __SetPageHead.
> However, there is a check to make sure __ClearPageReserved is never
> done on a head page.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, the
> following BUG will be hit when creating a hugetlb gigantic page:
>=20
>    page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
>    ------------[ cut here ]------------
>    kernel BUG at include/linux/page-flags.h:500!
>    Call Trace will differ depending on whether hugetlb page is created
>    at boot time or run time.
>=20
> Make sure to __ClearPageReserved BEFORE __SetPageHead.
>=20
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Fixes: 2b21624fc232 ("hugetlb: freeze allocated pages before creating =
hugetlb pages")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

