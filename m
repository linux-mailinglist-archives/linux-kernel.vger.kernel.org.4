Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3460D7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiJYXGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiJYXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:06:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51678E8AA8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o/2rqPUzMMz/iftug8ES08ZnowPqk70xK/g4Ab48Ce4=; b=rB9WzZT5XjDfRufiNuQSjakJl7
        TByRGMmaVkpBZP+O5wh18QSMPNdY3HSAaNbgr94fEEbbj6uw96NBO+MLtuvtSeg2lFtVyPHsOFC7A
        4Q1Cq66fZUKi62xat7N89CL/NnXnMCXIx6ojbfoQKAfApuA4+soDDoGGJ/7NNKDZjO4W8NZlB8zQY
        xqpXimmvvazw/qOxuzJnbKyi+QRHMoo/8/tqOHUzLu6fa9IizpqKb39HD4QN+qw78Y8SJRisHlwZa
        Wi8g9PSSIpWfisrLZuc8a94FAZwKhEJgxRpWykkNkxoY+BluBLdeh+jXr6kUPN+iF4PR5abeETjQ3
        hM4UfnDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onT0N-007VN2-Gz; Tue, 25 Oct 2022 23:06:43 +0000
Date:   Tue, 25 Oct 2022 16:06:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/params.c: defer most of param_sysfs_init() to
 late_initcall time
Message-ID: <Y1hsA1b3GwJuxxE/@bombadil.infradead.org>
References: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
 <20221025221356.1126728-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025221356.1126728-1-linux@rasmusvillemoes.dk>
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

On Wed, Oct 26, 2022 at 12:13:56AM +0200, Rasmus Villemoes wrote:
> param_sysfs_init(), and in particular param_sysfs_builtin() is rather
> time-consuming; for my board, it currently takes about 30ms.
> 
> That amounts to about 3% of the time budget I have from U-Boot hands
> over control to linux and linux must assume responsibility for keeping
> the external watchdog happy.
> 
> We must still continue to initialize module_kset at subsys_initcall
> time, since otherwise any request_module() would fail in
> mod_sysfs_init(). However, the bulk of the work in
> param_sysfs_builtin(), namely populating /sys/module/*/version and/or
> /sys/module/*/parameters/ for builtin modules, can be deferred to
> late_initcall time - there's no userspace yet anyway to observe
> contents of /sys or the lack thereof.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks, queued onto modules-next.

  Luis
