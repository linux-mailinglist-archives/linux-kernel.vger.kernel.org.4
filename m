Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222BC73CEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFYHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFYHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:30:54 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0AD180
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:30:52 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687678250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9nyBrLHmgd9V5+rOcrUy7opZUww68dtnkYzDPpoC2U=;
        b=bwNUNuUQAa6GS+fhjZjPkwotxrJrDk0CKqqnl8Bj6BjbeB//I352af89HRd5+y8MVjuiXp
        Xo+8g6DIY0zt7jqQpCxyULteKJ2dAHfoiadazCZsAlOJxyJF0o7R/pjC3JVzgs9A//embD
        e2cNU8bL8eR1n0YaUTiEdpmZNA/dUSA=
Date:   Sun, 25 Jun 2023 07:30:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <a18b0cf466191b0d692e431fe33c7c80@linux.dev>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all 
 architectures
To:     v-songbaohua@oppo.com
Cc:     "Christoph Hellwig" <hch@lst.de>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        peterz@infradead.org, rdunlap@infradead.org, kim.phillips@amd.com,
        rostedt@goodmis.org, thunder.leizhen@huawei.com, ardb@kernel.org,
        bhe@redhat.com, anshuman.khandual@arm.com,
        song.bao.hua@hisilicon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev,
        "=?utf-8?B?UGV0ciBUZXNhxZnDrWs=?=" <petr@tesarici.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Barry Song" <baohua@kernel.org>, 21cnbao@gmail.com
In-Reply-To: <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org>
References: <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org>
 <20230515094955.GB23880@lst.de>
 <20230512094210.141540-1-yajun.deng@linux.dev>
 <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
 <20230515133821.769158bb@meshulam.tesarici.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 24, 2023 8:40 AM, "Andrew Morton" <akpm@linux-foundation.org> wrote:=
=0A=0A> On Mon, 15 May 2023 13:38:21 +0200 Petr Tesa=C5=99=C3=ADk <petr@t=
esarici.cz> wrote:=0A> =0A>> On Mon, 15 May 2023 11:23:27 +0000=0A>> "Yaj=
un Deng" <yajun.deng@linux.dev> wrote:=0A>> =0A>> May 15, 2023 5:49 PM, "=
Christoph Hellwig" <hch@lst.de> wrote:=0A> =0A> This looks fine to me. Ca=
n you please work with Barry to make sure=0A> the slight different place =
of the initcall doesn't break anything=0A> for his setup? I doubt it woul=
d, but I'd rather have a Tested-by:=0A> tag.=0A>> Barry's email is no lon=
ger in use. I can't reach him.=0A>> =0A>> Which one? I would hope that hi=
s Gmail account is still valid:=0A>> =0A>> Barry Song <21cnbao@gmail.com>=
=0A> =0A> Maybe his kernel.org address works...=0A> =0A> I have this patc=
h stuck in limbo for 6.4. I guess I'll carry it over=0A> into the next -r=
c cycle, see what happens.=0A> =0A> fwiw, it has been in -next for six we=
eks, no known issues.=0A=0AHi, Barry, The slight different place of the i=
nitcall, does break anything?
