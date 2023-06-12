Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302072BBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjFLJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFLJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:11:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93249C9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:31 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52CBC1EC0398;
        Mon, 12 Jun 2023 11:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686560789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WIqAXYhmPnEU9dj5lf/logPLqqEiC6f75w0Ym0WO1bI=;
        b=bITKK+kztJsqPgwe/Nd1OSNsogiYbafQC0GKy+rewnEUN5WMEfc9D/z1dO4K4UasEmzjrq
        VIVt/fwL+zRzFUlT5RcDye2XPtMGVbyvY9PKTd4LPp6WB0Gfplz2b++K3ssqKY7PMI5J3n
        39F55r4qAxnje2nrK1jd0Vj3wuKwbV4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686560788; bh=WIqAXYhmPnEU9dj5lf/logPLqqEiC6f75w0Ym0WO1bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHZZx5anovK27viZaym0AoBUR8A3yiq65fwfLEm79HOesF3fj1/ouRveKr7Hht7R+
         FwrNATwqsqFER/b0+wg7G05kL0v2TG7Vj5peuuVArSOR+fXNJiM+iek+8Utn4Dlj5f
         l4p5lZoaxAExPxFbq89giA5REWbo0mqxto9IXgpt/USNKR8w7/VnBoj4su7VNvGWTc
         /P6uEaCiHt3j9FLpyj7CxiXgikH8v8XO5rFyj6Kb0955CpXxIW5A58ik/En4TKiXUF
         35lutSVaRxe5EBn2Uh6K7vUCSfM6umuNv7zCqAxvTUwSxaJXlBZy5qikqNVEBPtEeS
         ug2bI0aHN7VBfsKc4BnM/1/FzZYm3TiXHgRsvF13YPSOssoeg42DUPSd/kNksfSll0
         3p5K5qeczuiTIHN/ZbrHvzst8abzh6RGjp+ICcuyKv2Ijz0bvApEXqMASG6d+jd9J6
         oqxQ8yr5+VU0L950hGkkBRRPF4EN68zgVVKaZjZvmdMQ5XNU1Fi5F9wk1ugM8FhTWw
         PpxgiMnsqHSEroFD04gyDeDKzNGF4mH6VS+0Ino9GrM6cKEAPrM5UgovJ7o/Xx47N3
         gCmHeD3fKP8cxD6di9OutXddr5vL61eP96GZqy9rFXDJ+lDwXjTn9/9HvBdUHcEHKR
         9I+uSjHoj712LDajiPrwwwHE=
Received: from zn.tnic (p200300ea971Dc508329C23FffeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c508:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F82840E01E8;
        Mon, 12 Jun 2023 09:06:23 +0000 (UTC)
Date:   Mon, 12 Jun 2023 11:06:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <20230612090617.GAZIbgCcI9PssBgHxF@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <ZIE1G9UBAT36kPhJ@a4bf019067fa.jf.intel.com>
 <20230609122828.GBZIMa7OtCIpSkYGxV@fat_crate.local>
 <ZINHMRR28jre+Bw/@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZINHMRR28jre+Bw/@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:37:21AM -0700, Ashok Raj wrote:
> Since the code doesn't use this in the early loading, it appears we can
> drop the cmdline entirely?

The driver needs a control mechanism and this is it. It needs to be
always there so no, no debugfs.

> If the user switches the expected flow, should the code "taint" if its
> opted out?

When it turns out that this needs to happen, it'll get added then.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
