Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5E60D115
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiJYP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiJYP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:56:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8217EF2A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rCB4w7a7izDHuCRG0GKLpQ0oTnbpcNv0boNPZHCst/M=; b=dHR1J6tKlacNZjErtr5USYxBhW
        oNsx2Xex4IuDJHHttfj92eiAv2tOFoSiFBS8wKiJmq3QN0PltWuYH/MCAQQuOYdM4TR9k+PMrG+DT
        K+kUVsz7L/Zhaofl7LM3jfSHVSWJsIJMxNRDX5qZdRgV+oscznTJJFgIOORSSL7kN9h795xH2UNdV
        NL5gUKg+K8EudHUQB9Utfoy2SW35103RKs7NJ15wzafFoUu0eJCkpC6SceXVkTi5xZ0fyriciJ5iR
        s4vidGiejNKBhgXMzwhHf2uv16D0Ykk2lddn56vGUYMXhkpuSoyjplozCdt4KMrgXZqDmIpjyVqRZ
        DX/4LwHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onMHz-006CKM-Hc; Tue, 25 Oct 2022 15:56:27 +0000
Date:   Tue, 25 Oct 2022 08:56:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/params.c: defer most of param_sysfs_init() to
 late_initcall time
Message-ID: <Y1gHKwPnw+vQ/irX@bombadil.infradead.org>
References: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:00:02PM +0200, Rasmus Villemoes wrote:
> param_sysfs_init(), and in particular param_sysfs_builtin() is rather
> time-consuming; for my board, it currently takes about 30ms.
> 
> That amounts to about 3% of the time budget I have from U-Boot hands
> over control to linux and linux must assume responsibility for keeping
> the external watchdog happy.
> 
> We must still continue to initialize module_kset at subsys_initcall
> time, since otherwise any request_module() would fail in
> mod_sysfs_init().

It would be good to document this through a comment.

> However, the bulk of the work in
> param_sysfs_builtin(), namely populating /sys/module/*/version and/or
> /sys/module/*/parameters/ for builtin modules, can be deferred to
> late_initcall time - there's no userspace yet anyway to observe
> contents of /sys or the lack thereof.
> 

Other than that, this looks good and looks cautious enough.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Happy to take this in through moduels and give this a spin on linux-next
to see what blows up early. Can you send a v2 with a small code comment for
the above?

  Luis
