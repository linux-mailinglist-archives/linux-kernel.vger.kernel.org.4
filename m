Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFE740F85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjF1LAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:00:44 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:56908 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjF1LAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D634A61299
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A3C433C0;
        Wed, 28 Jun 2023 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687950039;
        bh=HtahVF+pJpNe2YHKhxkdzNcPAEdwQISTrjw7ZhmhZsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZ4sfofjdSYzEscfFYeHh5noLEUFKTfJVWy1xC2/0HtPRsI4I0mnNc7AH4Pu9nyrZ
         axmaFL36Tm/oni4O4dDFwese5ePzYGJSPMphAHwEdHKqJcbvraoo/rUhhvQPrcmZCS
         qTs3UpZQuM2WJZzFV0FwQgCKnYwWU0bEeTY4N+dk=
Date:   Wed, 28 Jun 2023 13:00:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Message-ID: <2023062851-gutter-rudder-5c2d@gregkh>
References: <20230628105250.40874-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628105250.40874-1-dg573847474@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:52:50AM +0000, Chengfeng Ye wrote:
> As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> context, other process context code should disable irq or bottom-half
> before acquire the same lock, otherwise deadlock could happen if the
> timer preempt the execution while the lock is held in process context
> on the same CPU.
> 
> Possible deadlock scenario
> bcm_vk_open()
>     -> bcm_vk_get_ctx()
>     -> spin_lock(&vk->ctx_lock)
>         <timer iterrupt>
>         -> bcm_vk_hb_poll()
>         -> bcm_vk_blk_drv_access()
>         -> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave().

how was this tested?  As per the file,
Documentation/process/researcher-guidelines.rst, you have to show this.

thanks,

greg k-h
