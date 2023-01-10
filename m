Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F14664579
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjAJP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjAJP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3F4FCED
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43D2AB817F6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAC9C433D2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:59:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fx6dh58j";
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GrYnIo+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673366368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDH00etmdS8/BILcXpN5zPvqj8ZbmM2o4PpcSzT1ImI=;
        b=Fx6dh58jgthbYv6kL2dbCgVnKJafml6rhbNqXHGto/5JJrahGZqx0a7vmtFVFodPp/hm20
        OPQz7NRfIm/WBVcfCnNM+pQmDJH8kb94tcS0DMsS0Qe9T81l2dFOmPeamgh0C6ccwLb9YV
        dnbs+ri95qZYmFM5q3OTHiXM5lWdkfE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 95741fc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 10 Jan 2023 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673364894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDH00etmdS8/BILcXpN5zPvqj8ZbmM2o4PpcSzT1ImI=;
        b=GrYnIo+9SqLJ3MTOK77uQTBueKyCj8KmmXIflSTKMvXwXgvfrG5VHkI3FIePYv2NU0AMB3
        YGcugcvBs6iE+agfYwviK9pKj4bbNLp8xhVO+CaR676F9ddNXcJdwdWr37mgSiMi8vJbqb
        mTQQOdaGw6F3bg13P5Sxtg/4TMaFlO0=
Date:   Tue, 10 Jan 2023 16:34:49 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
        pbonzini@redhat.com, ebiggers@kernel.org,
        Mathias Krause <minipli@grsecurity.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y72FmQlNwBsp8Ntc@zx2c4.com>
References: <Y69fUstLKNv/RLd7@zx2c4.com>
 <20221230220725.618763-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221230220725.618763-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Could you queue up this patch and mark it as a fix for 7.2.1? It is a
straight-up bug fix for a 7.2 regression that's now affected several
users.

- It has two Tested-by tags on the thread.
- hpa, the maintainer of the kernel side of this, confirmed on one of
  the various tributary threads that this approach is a correct one.
- It doesn't introduce any new functionality.

For your convenience, you can grab this out of lore here:

  https://lore.kernel.org/lkml/20221230220725.618763-1-Jason@zx2c4.com/

Or if you want to yolo it:

  curl https://lore.kernel.org/lkml/20221230220725.618763-1-Jason@zx2c4.com/raw | git am -s

It's now sat silent on the mailing list for a while. So let's please get
this committed and backported so that the bug reports stop coming in.

Thanks,
Jason
