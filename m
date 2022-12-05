Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A36430A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLESlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiLESkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FC209B0;
        Mon,  5 Dec 2022 10:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9EE60025;
        Mon,  5 Dec 2022 18:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F52C433C1;
        Mon,  5 Dec 2022 18:38:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i/q4yG4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670265498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uBKJVNJYw3pTg89I4Wru5rBtHkt0SHV5a0kfWhJUMs=;
        b=i/q4yG4TRgcAfsp7bhNnqZhFDbgcrF2khLVdsny531uYWtiAIhVlrF0tPkXFrjyvCvWcFp
        RHvI2Qg7ASdNESHkEkaGsMx8gD9/hevhpNpAtWT2ChagkR35gDzAMEPdaeGR36DoJLiKeU
        RVcP4QY26axwZe0XMMLJEUYhhAzf1Ho=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bb930d2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 18:38:18 +0000 (UTC)
Date:   Mon, 5 Dec 2022 19:38:16 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y446mGVCvJX+5mGd@zx2c4.com>
References: <20221205020046.1876356-1-Jason@zx2c4.com>
 <20221205020046.1876356-2-Jason@zx2c4.com>
 <87cz8xr96o.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cz8xr96o.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 07:34:39PM +0100, Florian Weimer wrote:
> > + *   - Passing the first state to munmap(2), as described above.
> > + * All other uses are undefined behavior, which is subject to change or removal
> 
> Suggest: “Passing the first state *and total length* to munmap(2)”

Will do.

> Rest of the documentation looks good to me.  It addresses my concerns
> about future evolution of this interface.

Great! So hopefully the api is more or less settled now, and we can turn
attention to the glibc part.

Jason
