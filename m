Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40C60307E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJRQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJRQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:05:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2051A21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:05:14 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c1:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36ED11EC04DA;
        Tue, 18 Oct 2022 18:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666109109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BZpUJTJl+WAmPhcKXxfbAwcaW4yauzcoyPsuiUOSTKo=;
        b=Pv7amGoa/8DpJnjglyhcH7W6aLK2seD8G8NNSwENwbDpXOFYDnDKAryytlD4yUG2VJ6lHh
        xAOPcl4FR4JOxQZ3PZXCP0Sykb5teNqaZ98UmqcQeg8Bmw0UmTPpBps+ioFxpew83GjINV
        3K1pFLYBnY/Qtpu8OCtypk9/pIbfioA=
Date:   Tue, 18 Oct 2022 18:05:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Message-ID: <Y07OsE+B9HwZPD0z@zn.tnic>
References: <Yz3KI5qY70rvJV63@zn.tnic>
 <20221005194644.311204-1-tony.luck@intel.com>
 <Y00wIFEN9h9YPGe1@zn.tnic>
 <SJ1PR11MB60835DDCB1F3EBC8B6DFA2F7FC299@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y02vmRn1Uz6/NMFF@zn.tnic>
 <Y066BV4jiRMxgjYV@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y066BV4jiRMxgjYV@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:36:53AM -0700, Tony Luck wrote:
> Sadly, we need to have a trace_show() function. If trace_open() just
> does:
> 
> 	return single_open(file, NULL, NULL);
> 
> then we get a deref NULL OOPs if somebody does "cat daemon_active" :-(

I guess but as you see yourself, cat-ting that file is done only by
us when debugging stuff. So we shouldn't waste too much energy on
"designing" an interface. As nothing'll use it.

But sure, trace_show(), why not.

I mean, if people go and open that file and confuse the system, they'll
only have themselves to blame. Besides, it is debugfs and root-only and
so on - if you wanna do damage, you already have root.

So yeah, let's keep this effort minimal and only address valid use cases.

IMO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
