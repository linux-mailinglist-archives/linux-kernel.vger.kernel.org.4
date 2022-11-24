Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1DC637836
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiKXL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKXL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:57:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AD1A80D;
        Thu, 24 Nov 2022 03:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35A62B827A3;
        Thu, 24 Nov 2022 11:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F1C433C1;
        Thu, 24 Nov 2022 11:57:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lvSAgpCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669291054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwytzee17QiLY0NrswP8mxqbM9pNfA5/V31a1RxlM2I=;
        b=lvSAgpCAjW9L9lQNNZQXxvYjOwxEXeVhhZEKiCRzW/VW8NnnOpcuCu0NZVOPAP21PWKHgD
        UluRjTsGUKUGFFMMqF/A1Y7Da/1hPc7MBLsUVR5+PbA+BOPTfMEmi3nJv5/McEjZF85bZ2
        vhpdXaYH5DZX5QRF0Iw3G8IW8dIzEdg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f7c4f87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 11:57:34 +0000 (UTC)
Date:   Thu, 24 Nov 2022 12:57:30 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v6 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y39cKn2FbSxe+SWj@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-3-Jason@zx2c4.com>
 <87r0xulzfd.fsf@oldenburg.str.redhat.com>
 <Y37EHHq41KBvgr8z@zx2c4.com>
 <875yf47wfn.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875yf47wfn.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu, Nov 24, 2022 at 06:28:44AM +0100, Florian Weimer wrote:
> > Right? And if you look at the expansion of that glibc macro, it's just:
> >
> >   #define INTERNAL_SYSCALL_ERROR_P(val) \
> >     ((unsigned long int) (val) > -4096UL)
> >
> > So it looks like the same exact thing?
> 
> syscall already does internally (with a translation to -1, not NULL), so
> the caller shouldn't do it again.  The userspace syscall function does
> *not* return an error code.

Ahh, okay. Thanks. I'll fix up the example to assume those semantics.

Jason
