Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6E6C1439
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCTOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCTN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:59:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A96A42
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:59:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679320775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdd7BrJeCYboXvMa1xKZJ73sd6/A3cBZ5PM4ufK0ePM=;
        b=T0OTW/PtYQB04vu1DQIaI9rQ5z+qGcEw9heuq7pFN9hDzy67+92vPhl9sedEkMUCpkmdr+
        kc4arZDJxn+46EEbAGmUHXg0ilp9vx/ft2cVkhrmaIOZ+FJBYzm2GPrIX1dqYPjV9tu2lx
        l1CXkDKycbCOELEX3UapEW0H9EZXELM+MVy4xLhd7b30gw/R+v+ZZKzbPVB1i1bVbn6Eyc
        hgD0R98SQhYJkxf6I9tsNnXreS2604LhACwq/K39zTVSsQ8J00w5pBMWdeUvltBDyPbH/u
        vESZufNfYCMo8cxqY2Ke5U+gPAs1SAEBGSI3rsaLnANueJCqbd5/hAQDHOTPag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679320775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdd7BrJeCYboXvMa1xKZJ73sd6/A3cBZ5PM4ufK0ePM=;
        b=ijgGxuWl5qLMXJiSVjh3QHwYgfrKg++OtSZug4DaUr/XHOy3H60O/dimLDPKqtM4uadpw2
        +1gDfKhiXBduifCQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 07/36] cpu/hotplug: move to use bus_get_dev_root()
In-Reply-To: <20230313182918.1312597-7-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-7-gregkh@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 14:59:34 +0100
Message-ID: <87ttyfa5h5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13 2023 at 19:28, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Vincent Donnefort <vdonnefort@google.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

No problem.
