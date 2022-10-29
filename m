Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87B8612123
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJ2Hx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ2HxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E057287D;
        Sat, 29 Oct 2022 00:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE77B82E8A;
        Sat, 29 Oct 2022 07:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37E5C433C1;
        Sat, 29 Oct 2022 07:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667030000;
        bh=+6WVpF4K49pNId8+IaknC6gKbX8Hg9zp34C7h3dBSYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyuvhzqlHfYigkNjWL6BWEequGcW6HXDcoGJxxN9tnOrx2KRZ5fiCRLPxgpPvZRUL
         XJMIe0bw9YwEsh9Trj27yMigb9hW0onY1dq/WWa7lGoMEOryLFl4XHBmiqdkWFein6
         nM2CHcRCIQ+Muku2oCun/jhd7AP394fiCxM8nJlg=
Date:   Sat, 29 Oct 2022 09:54:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Add __alloc_size hint to devm allocators
Message-ID: <Y1zcJxBBzivWh66K@kroah.com>
References: <20221029074734.gonna.276-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029074734.gonna.276-kees@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 12:47:34AM -0700, Kees Cook wrote:
> Mark the devm_*alloc()-family of allocations with appropriate
> __alloc_size()/__realloc_size() hints so the compiler can attempt to
> reason about buffer lengths from allocations.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Won Chung <wonchung@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm hoping to carry this via the hardening tree so I can add a
> KUnit test that depends on it...
> v2: use __realloc_size instead of __alloc_size
> v1: https://lore.kernel.org/linux-hardening/20221018073430.never.551-kees@kernel.org/
> ---
>  include/linux/device.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
