Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70316A4DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB0WQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0WQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:16:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677928207
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2176160B71
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0EEC433EF;
        Mon, 27 Feb 2023 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677536207;
        bh=lhIQQrDfUiCYIFpNMIqlj8bCtQYAOQ3RHcT3/exgPA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=npNn47k9PO7Icc23/f3zW0pP7TnEVN/FznCtQCzLIjTlgBvPtNhLL7E/AdVX3QrzO
         /I1ardBp944AU4xMRN1ERTPIV+SdcFo+R9St9KgQXnoHyBCJaTRT6KV96m1JCBehPa
         STRI+C66fMpwKJAKGQTHvB59wTP+rmh6UGml5Nww=
Date:   Mon, 27 Feb 2023 14:16:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mm] kasan, powerpc: Don't rename memintrinsics if
 compiler adds prefixes
Message-Id: <20230227141646.084c9a49fcae018852ca60f5@linux-foundation.org>
In-Reply-To: <20230227094726.3833247-1-elver@google.com>
References: <20230227094726.3833247-1-elver@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 10:47:27 +0100 Marco Elver <elver@google.com> wrote:

> With appropriate compiler support [1], KASAN builds use __asan prefixed
> meminstrinsics, and KASAN no longer overrides memcpy/memset/memmove.
> 
> If compiler support is detected (CC_HAS_KASAN_MEMINTRINSIC_PREFIX),
> define memintrinsics normally (do not prefix '__').
> 
> On powerpc, KASAN is the only user of __mem functions, which are used to
> define instrumented memintrinsics. Alias the normal versions for KASAN
> to use in its implementation.
> 
> Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/ [1]
> Link: https://lore.kernel.org/oe-kbuild-all/202302271348.U5lvmo0S-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>

Seems this is a fix against "kasan: treat meminstrinsic as builtins in
uninstrumented files", so I'll plan to fold this patch into that patch.

