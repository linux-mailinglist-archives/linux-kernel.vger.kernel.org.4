Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90D7407C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjF1BtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1BtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:49:21 -0400
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F421BD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:49:20 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687916956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOyzcJ8VePO1Q+C6BRDa2asTrgF7Hq/6F0KbFPox+Ks=;
        b=qPmhKnINywNfOvxpUNbxYp+kqBqH7hwkNQ4PS5AIPiIJaX0M49bhKlHhjx5OtyxVwP1Ld8
        FotqAp9S+ioG+EmE3dPT3UWQ7Th8gejYgE6sKLCqLr+BFczkqKArPEpr4WMO1hZ5I2Bv1E
        GMuJWgzgd1K8mMmQa3dwmny1jAZL/Ok=
Date:   Wed, 28 Jun 2023 01:49:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <45683de8eea1912297542aad909ece6d@linux.dev>
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230627143318.GN52412@kernel.org>
References: <20230627143318.GN52412@kernel.org>
 <ZJkudvnGz+Tt5Qml@kernel.org> <20230625050850.GJ52412@kernel.org>
 <20230624024622.2959376-1-yajun.deng@linux.dev>
 <4c361d62e0b77242fe4b8592c82c4d90@linux.dev>
 <a13e81ae159d388d3d3e18978a1b1091@linux.dev>
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

June 27, 2023 10:33 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> O=
n Tue, Jun 27, 2023 at 12:13:16AM +0000, Yajun Deng wrote:=0A> =0A>> June=
 26, 2023 2:21 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A>> =0A>> On=
 Sun, Jun 25, 2023 at 07:39:10AM +0000, Yajun Deng wrote:=0A>> =0A>> June=
 25, 2023 1:08 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A>> =0A>> On=
 Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:=0A>> =0A>> It o=
nly returns address now in memblock_find_in_range_node(), we can add a=0A=
>> parameter pointing to integer for node id of the range, which can be u=
sed=0A>> to pass the node id to the new reserve region.=0A>> =0A>> Introd=
uce memblock_reserve_node() so that the node id can be passed to=0A>> the=
 reserve region in memblock_alloc_range_nid().=0A>> =0A>> Signed-off-by: =
Yajun Deng <yajun.deng@linux.dev>=0A>> =0A>> What problem does this patch=
 solve?=0A>> =0A>> If we set nid and flags in memblock_alloc_range_nid(),=
 we may not need=0A>> memblock_set_node() in memmap_init_reserved_pages()=
.=0A>> =0A>> When memblock_reserve() is called before NUMA setup, the nod=
e ids are still=0A>> unset in memblock.memory, so very early reservations=
 will be missed and we=0A>> still have to update node ids in memblock.res=
erved later.=0A>> =0A>> Even so, we still need to pass the 'flags' to the=
 new reserve region.=0A>> choose_memblock_flags() may return MEMBLOCK_MIR=
ROR in memblock_alloc_range_nid(),=0A>> memblock_reserve() couldn't pass =
this flag in this case.=0A> =0A> flags are only relevant to memblock.memo=
ry, we don't care about the flags=0A> in memblock.reserved.=0A> =0A=0Aget=
 it.=0A=0A>> I tested this patch and delete memblock_set_node() in memmap=
_init_reserved_pages().=0A>> It works fine. I did not delete memblock_set=
_node() in this patch just in case.=0A>> =0A>> --=0A>> Sincerely yours,=
=0A>> Mike.=0A> =0A> --=0A> Sincerely yours,=0A> Mike.
