Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EDA60DB10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiJZGSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJZGSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:18:07 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA00BA278
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:18:06 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666765084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1h2nRHncW11E9hbd/qHDUawOsfI9aSjq5L1zDtP0vo=;
        b=XaHlgRjh0xMKIeZT1Iyrc7R4v2F3klDrIor2q8nv0TUmZP0JVdW58yMsP8/WTwMGH46IQE
        gLpjVLn7E93oTmKQVn3F3fS5Q/Fa7hSqTsiv3YQC+XMTbOkKNnWtQcrrV+unkExj/eb4cy
        RRZiPUYw5B/DYUNqXaNzTlniJt90LXg=
Date:   Wed, 26 Oct 2022 06:18:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <b4af84bdc4b9c757c9fea2e63dd98a61@linux.dev>
Subject: Re: [PATCH] memblock: remove repeat round
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1jN/KeU6dgJWQIL@kernel.org>
References: <Y1jN/KeU6dgJWQIL@kernel.org> <Y1a6BoawCoDDCo/K@kernel.org>
 <20221019120337.2098298-1-yajun.deng@linux.dev>
 <6cccd4cba4f8407d52815c68f60446fb@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

October 26, 2022 2:04 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A>=
 On Tue, Oct 25, 2022 at 03:24:58AM +0000, Yajun Deng wrote:=0A> =0A>> Oc=
tober 25, 2022 12:15 AM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A>> =
=0A>> @@ -598,22 +597,6 @@ static int __init_memblock memblock_add_range(=
struct memblock_type *type,=0A>> return 0;=0A>> }=0A>> =0A>> - /*=0A>> - =
* The worst case is when new range overlaps all existing regions,=0A>> - =
* then we'll need type->cnt + 1 empty regions in @type. So if=0A>> - * ty=
pe->cnt * 2 + 1 is less than type->max, we know=0A>> - * that there is en=
ough empty regions in @type, and we can insert=0A>> - * regions directly.=
=0A>> - */=0A>> - if (type->cnt * 2 + 1 < type->max)=0A>> - insert =3D tr=
ue;=0A>> -=0A>> -repeat:=0A>> - /*=0A>> - * The following is executed twi=
ce. Once with %false @insert and=0A>> - * then with %true. The first coun=
ts the number of regions needed=0A>> - * to accommodate the new area. The=
 second actually inserts them.=0A>> - */=0A>> base =3D obase;=0A>> nr_new=
 =3D 0;=0A>> =0A>> I believe nr_new variable is no longer needed, is it?=
=0A>> =0A>> No, nr_new is needed before memblock_merge_regions() for retu=
rn.=0A> =0A> Why?=0A> =0ASorry, nr_new was removed, and added ocnt variab=
le for the original of type->cnt.=0A=0AI already sent another patch with =
'[PATCH v2] memblock: don't run loop in =0Amemblock_add_range() twice' su=
bject, you can see that.=0A=0A> --=0A> Sincerely yours,=0A> Mike.
