Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688EA62C9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKPUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:12:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F766CB6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174EC61F85
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46950C433D6;
        Wed, 16 Nov 2022 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629553;
        bh=nKmdqQ14QC5fdMxLgY/zru8azigJGTo+MgnD5VdFrA4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZmqoITTL1pnLuDiQpbHotHXGxfuEMl/2nicwHx+AXXL91qYLDcyA4XIw72Y9I8qBg
         SkpESnDQZuXWZ+HemlXojK/cYWpX5zAWtFlGt1axYbcSdUOtxbRYeK2LMQmaQ96KoG
         EEzgQII8e0FqtRWZGlPrbSbkc1gwFe4p5aY2jE0t4E0gRlIN2dPI30rSpkgAVAsT56
         ykAZ+Vbe9ercgg8tAYQ4NpXiljxwUkudij3IkuSk9hUYziHa9/NEVi0CmumiiQ7i2g
         JHF9DA0LS3rvjItCKjkOaOzLAfZBG+v/P8TFzfgKSuRWk9Uwt4tPvBoAYcRsxuVR6g
         rbvf6wlBq9/IQ==
Date:   Wed, 16 Nov 2022 12:12:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: KMSAN broken with lockdep again?
Message-ID: <Y3VEL0P0M3uSCxdk@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying v6.1-rc5 with CONFIG_KMSAN, but the kernel continuously spams
"BUG: KMSAN: uninit-value in __init_waitqueue_head".

I tracked it down to lockdep (CONFIG_PROVE_LOCKING=y).  The problem goes away if
I disable that.

I don't see any obvious use of uninitialized memory in __init_waitqueue_head().

The compiler I'm using is tip-of-tree clang (LLVM commit 4155be339ba80fef).

Is this a known issue?

- Eric
