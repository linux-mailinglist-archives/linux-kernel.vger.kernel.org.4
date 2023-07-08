Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C474BB22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGHBlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:41:14 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9F19B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:41:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688780468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRhfBAQl1hCC0Cjr0rsZo9q87R9bFpiUUmeqFf16aAI=;
        b=Dci2ghm98pi89aXcedutDYqUEZXyeEMztVc+komY2Jimt6OHtnWxnVgYpKyjfGsW2nSS/A
        OB31R2Jm6LIzmLLgRD/dCefNzt/Ru0fDsACzh+XSrmwQMEHQi8ttG1toWKmJhYxAR/fBrl
        h5uJEzwpOtNKr2vnVeZT5XZp+4JYtsA=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd split
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230707124116.d7be4ba6504a452d11e2629d@linux-foundation.org>
Date:   Sat, 8 Jul 2023 09:40:30 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07A5567A-8BED-40DB-88F4-96C37DCD78BF@linux.dev>
References: <20230707033859.16148-1-songmuchun@bytedance.com>
 <20230707124116.d7be4ba6504a452d11e2629d@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 8, 2023, at 03:41, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri,  7 Jul 2023 11:38:59 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> And inline __split_vmemmap_huge_pmd()
>> since it only has one user.
>=20
> "open code" would be a better term than "inline" in this situation.
>=20
> If we are to offer this change to -stable then it would be better to =
do
> the open-coding of __split_vmemmap_huge_pmd() in a separate, later
> patch.
>=20

I see. Bug fix is better to "open code" instead of "inline". However, it
is a simpler and cleaner way to fix this bug by using "inline". Because
we must hold init_mm.page_table_lock to get the page table page in =
__split_vmemmap_huge_pmd(), then it is just a couple of duplicated
code from split_vmemmap_huge_pmd(). Consequently, =
split_vmemmap_huge_pmd()
is redundant, just remove it. And rename __split_vmemmap_huge_pmd()
to split_vmemmap_huge_pmd(). The result is the same as the "inline" way.
So I keep "inline" to fix this.

Thanks.

