Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815A5E90AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIYBnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIYBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:43:46 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28A43E53
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:43:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664070220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WXzLSYTukyduxymcxvBjNdNw/QHJy+xi6+TnpxtGIM=;
        b=m8kKGGgphu59i/ommAnhzqGoS4nnOgVqCBVLFxqa3W4mhI3XPVa6npODzCKdCnrKX99M5E
        PetI1lwRWDcjo8x0wA9mx8KSOGwcMccNjXtXYM5mqHyIY1dTq1Wjb5jW3BciUUCzVUDSFM
        if0SrB7G1yWVsC6pFBU4rp70vzCsArI=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: fix misuse of update_mmu_cache() in
 do_anonymous_page()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
Date:   Sun, 25 Sep 2022 09:43:34 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
References: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 24, 2022, at 13:32, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
> if PTE entry exists") said, we should update local TLB only on the
> second thread. So fix the misuse of update_mmu_cache() by using
> update_mmu_tlb() in the do_anonymous_page().
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

The change looks good to me. However, I am not sure what is the =
user-visible
effect to xtensa users. So Cc xtensa=E2=80=99s maintainer and the author =
of 7df676974359
to double check this.


But anyway:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


