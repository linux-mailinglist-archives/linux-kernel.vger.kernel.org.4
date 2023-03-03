Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C666A9C9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjCCRDL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 12:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCCRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:03:08 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47AD533
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:03:06 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C8E791603C1;
        Fri,  3 Mar 2023 16:53:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id B1D5E6000C;
        Fri,  3 Mar 2023 16:53:02 +0000 (UTC)
Message-ID: <e1be073e8e53da8dcdd9e37ffc6e60d1375c59bb.camel@perches.com>
Subject: Re: Infinite loop in checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Alexander Potapenko <glider@google.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAG_fn=WZnBtRujLyhouz1AmerSKB71oPej442JDOw2OaORbWQg@mail.gmail.com>
References: <CAG_fn=WZnBtRujLyhouz1AmerSKB71oPej442JDOw2OaORbWQg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 03 Mar 2023 08:52:57 -0800
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B1D5E6000C
X-Stat-Signature: fyjdf78ycetdnxmkymxabogu9kj5fwxt
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182hfoMHKx1a/qiRR/lIrsTQWRJ4lUHW7c=
X-HE-Tag: 1677862382-426096
X-HE-Meta: U2FsdGVkX1/YP/POAhmPSmV40csoHua+ZwOVcqC/uKLkutucj8FYAJ8i4OAmFziLycIsQIZvk6pJPSMxzhowLg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-03 at 15:28 +0100, Alexander Potapenko wrote:
> Hi folks,
> 
> I've noticed that checkpatch.pl chokes on the following file (also attached):
> 
> ==================================
> $ cat test-checkpatch.txt
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> @@ -504,6 +504,25 @@ static void
> test_memcpy_aligned_to_unaligned2(struct kunit *test)
> + EXPECTATION_NO_REPORT(expect);                              \
> + volatile uint##size##_t uninit;                             \

checkpatch isn't a syntax complete c parser.  Don't expect to be.

