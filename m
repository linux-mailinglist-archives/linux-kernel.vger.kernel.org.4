Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA64E5F5B70
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJEVIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJEVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:08:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643E69F56;
        Wed,  5 Oct 2022 14:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2239EB81F2C;
        Wed,  5 Oct 2022 21:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E44C433D6;
        Wed,  5 Oct 2022 21:08:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O7Mic4ki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665004109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0iSLSVi/n52XMFHM127/WLFmzaUyWKAiR6pK/M7lho=;
        b=O7Mic4kiBroXUePGTdFwmFAqvciFjlQdk25g0vGRCnfsk6sobXH1MHYwPiJhHhfY9dWkee
        66Nd+U5emxWZ/gL81/h2O+z0+AkFaGoUg2Gdl7wjYw9uzRJuXM1TVWueIL+qUtsC9Hyw3x
        mWTfwSpXX0p//M9hGVguEnqRWN6ebNw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1ad1aca6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Oct 2022 21:08:28 +0000 (UTC)
Date:   Wed, 5 Oct 2022 23:08:19 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz3yQzaNUcdIuUMX@zx2c4.com>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz2+UsgVGRSm+o7W@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Wed, Oct 05, 2022 at 07:26:42PM +0200, Sebastian Andrzej Siewior wrote:
> That del_timer_sync() at the end is what you want. If the timer is
> pending (as in enqueued in the timer wheel) then it will be removed
> before it is invoked. If the timer's callback is invoked then it will
> spin until the callback is done.

del_timer_sync() is not guaranteed to succeed with add_timer_on() being
used in conjunction with timer_pending() though. That's why I've
abandoned this.

Jason
