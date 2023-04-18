Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C066E6F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjDRWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDRWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1F269F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA1A615CD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED60C433D2;
        Tue, 18 Apr 2023 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681855707;
        bh=A8qCPR0691ECOrXmuz6X4xvdj4xXQbRWYqn0vXEFJrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9qKdnuaAkHDdGDGC7hXjBWiX9KmdmBTUh1GRDLQHPGN553w+QtJFPUC5VbEX5Zmc
         81wR2O0zW6CUSFEnMdGnQ4RGveVxBJvFoOHv0SXFwkaOv/ULg+gtc4bxjFtu4vdSVj
         rmqV+cndvX5R43kZJQyqA005bl/FJtu/0m6zpoRI=
Date:   Tue, 18 Apr 2023 15:08:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     elver@google.com, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: Fix lockdep report invalid wait context
Message-Id: <20230418150826.ae36090243b21f21f3265792@linux-foundation.org>
In-Reply-To: <20230327120019.1027640-1-qiang1.zhang@intel.com>
References: <20230327120019.1027640-1-qiang1.zhang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 20:00:19 +0800 Zqiang <qiang1.zhang@intel.com> wrote:

> For kernels built with the following options and booting
> 
> CONFIG_SLUB=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> 
> [    0.523115] [ BUG: Invalid wait context ]

Could we please get some reviewer input on this change?

Thanks.
