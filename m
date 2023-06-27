Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5589B73EF99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjF0ANV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF0ANT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:13:19 -0400
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99852106
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:13:18 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687824796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFgU9qn91+n5dnmwJFQd5phUqXXyZnU0m9ZLzY0G0lQ=;
        b=iijq2dGRrhXtGry+SS/vYvXL2SGxp0knv6IxSR/oDlmCIHBV3tD+DGWTQ9tHwykJbxLR40
        K8gXTRR0zfx3vcwMGJzh1BAR0QA2F5hsQxw3+U61vl1Kgt+sV/yPliVjH2HoEK/kJBuiQb
        XmMjL7Zmqq2L1/+s/wmpudpPgXk1H14=
Date:   Tue, 27 Jun 2023 00:13:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <a13e81ae159d388d3d3e18978a1b1091@linux.dev>
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZJkudvnGz+Tt5Qml@kernel.org>
References: <ZJkudvnGz+Tt5Qml@kernel.org>
 <20230625050850.GJ52412@kernel.org>
 <20230624024622.2959376-1-yajun.deng@linux.dev>
 <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
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

June 26, 2023 2:21 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> On=
 Sun, Jun 25, 2023 at 07:39:10AM +0000, Yajun Deng wrote:=0A> =0A>> June =
25, 2023 1:08 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A>> =0A>> On =
Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:=0A>> =0A>> It on=
ly returns address now in memblock_find_in_range_node(), we can add a=0A>=
> parameter pointing to integer for node id of the range, which can be us=
ed=0A>> to pass the node id to the new reserve region.=0A>> =0A>> Introdu=
ce memblock_reserve_node() so that the node id can be passed to=0A>> the =
reserve region in memblock_alloc_range_nid().=0A>> =0A>> Signed-off-by: Y=
ajun Deng <yajun.deng@linux.dev>=0A>> =0A>> What problem does this patch =
solve?=0A>> =0A>> If we set nid and flags in memblock_alloc_range_nid(), =
we may not need=0A>> memblock_set_node() in memmap_init_reserved_pages().=
=0A> =0A> When memblock_reserve() is called before NUMA setup, the node i=
ds are still=0A> unset in memblock.memory, so very early reservations wil=
l be missed and we=0A> still have to update node ids in memblock.reserved=
 later.=0A=0AEven so, we still need to pass the 'flags' to the new reserv=
e region.=0Achoose_memblock_flags() may return MEMBLOCK_MIRROR in membloc=
k_alloc_range_nid(),=0Amemblock_reserve() couldn't pass this flag in this=
 case.=0A=0A=0A>> I tested this patch and delete memblock_set_node() in m=
emmap_init_reserved_pages().=0A>> It works fine. I did not delete membloc=
k_set_node() in this patch just in case.=0A> =0A> --=0A> Sincerely yours,=
=0A> Mike.
