Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99C5F10E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiI3Ra7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiI3Ram (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:30:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740BF476EC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:30:41 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 960D11EC04DA;
        Fri, 30 Sep 2022 19:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664559035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U1ZDaKZwSReBXbolJqaq6t6lWQBzmqaj7Iy2MMSnFtc=;
        b=gJs9qu1qds+pMa4cKCGHBhY4Ljwz/8hJKLm8IxaJTKwCEtbjyXILY8U83gL81tcAX+u9Dr
        DXrEOY7EjychrgNHGUo1R8JceBnEXM01C3pIK/jO97ssh3Tpuv+hERuafSdJhqGmoRFvrD
        lfYE+HwNtI1Mm4f33RpRDFpIzd90Nj0=
Date:   Fri, 30 Sep 2022 19:30:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v6 2/5] x86: Add cmdline_prepare() helper
Message-ID: <Yzcnt2oDiGHo10kP@zn.tnic>
References: <cover.1661565218.git.baskov@ispras.ru>
 <fc6713d1cb670313cdb61cc6f929dddc110f25d9.1661565218.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc6713d1cb670313cdb61cc6f929dddc110f25d9.1661565218.git.baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 05:08:07AM +0300, Evgeniy Baskov wrote:
> +/*
> + * command_line and boot_command_line are expected to be at most
> + * COMMAND_LINE_SIZE length. command_line needs to be initialized
> + * with COMMAND_LINE_INIT.
> + */
> +static inline void cmdline_prepare(char *command_line,
> +				   const char *boot_command_line)
> +{
> +#ifdef CONFIG_CMDLINE_BOOL

Right, this is an ifdef...

> +	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {

... but this is a IS_ENABLED().

Why?

I think we should stick to one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
