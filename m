Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC36C7547
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCXB74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:59:55 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4F18B1C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:59:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679623192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rhPKrr+KvKxfSIp3VNo6gU3WN6f4iovovmQovzneIQ=;
        b=lJ4W1xY0WVMXMyLSLZ0Duv+S4EjkUyRed2cUA7YSxniKOHJCHNcTW/jC9eUKqWOzT8/v35
        ayqaAXzOeQbbbd7lpzj6n/ygXkkmOImR4WGMCed4431GSnQTIhlwomdRD141rkZAlvUT+B
        Yli++sAofEYZE5HbEyOj27qN4E+S7Qc=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kfence: fix handling discontiguous page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230323151850.e2785b1cff37fba078f26f2b@linux-foundation.org>
Date:   Fri, 24 Mar 2023 09:59:16 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, jannh@google.com,
        sjpark@amazon.de, kasan-dev@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEB74A1F-9DA2-4B37-8AD5-5E41A399046C@linux.dev>
References: <20230323025003.94447-1-songmuchun@bytedance.com>
 <20230323151850.e2785b1cff37fba078f26f2b@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 24, 2023, at 06:18, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 23 Mar 2023 10:50:03 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> The struct pages could be discontiguous when the kfence pool is =
allocated
>> via alloc_contig_pages() with CONFIG_SPARSEMEM and =
!CONFIG_SPARSEMEM_VMEMMAP.
>> So, the iteration should use nth_page().
>=20
> What are the user-visible runtime effects of this flaw?

Set the PG_slab and memcg_data to a arbitrary address (may be not used =
as a struct
page), so the worst case may corrupt the kernel.

Thanks.

>=20
> Thanks.

