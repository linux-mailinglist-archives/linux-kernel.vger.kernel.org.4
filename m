Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508556D0F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjC3Tuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjC3Tuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E060FF27
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92B21B829B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102B0C433EF;
        Thu, 30 Mar 2023 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680205842;
        bh=RrELxMFNuf4dLlJIG3ONCd0cfpSBkkVInFuMvO4j2qY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N6IUXBx+FkLpsPUyMXZ3D2e24NPET3PSVdDCzUNuuIFJZswqdKi/uTFoGxfToOv6c
         WElGpC7bqWp2vMxns3mGcmVMY78p3oj+t7hWTQrJN/Gq9Xnsi0zm79afB5MzoWsTuM
         YK1OK3B5LLlsiERNAfyIlqVRWSzOk/Oikf46GP5g=
Date:   Thu, 30 Mar 2023 12:50:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH 0/4] log2: make is_power_of_2() more generic
Message-Id: <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
In-Reply-To: <20230330104243.2120761-1-jani.nikula@intel.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 13:42:39 +0300 Jani Nikula <jani.nikula@intel.com> wrote:

> is_power_of_2() only works for types <= sizeof(unsigned long) and it's
> also not a constant expression. There are a number of places in kernel
> where is_power_of_2() is called on u64, which fails on 32-bit
> builds. Try to remedy that. While at it, make it a constant expression
> when possible.

Yes, the current `is_power_of_2(unsigned long n)' isn't very general.

But wouldn't all these issues be addressed by simply doing

#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))

?

(With suitable tweaks to avoid evaluating `n' more than once)


