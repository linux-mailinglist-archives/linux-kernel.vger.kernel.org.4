Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D895EC0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiI0LUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0LUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0A46D85
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:19:45 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e757329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e757:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70F61EC058B;
        Tue, 27 Sep 2022 13:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664277579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sh92KicTDh4caqpKkqA808K5SVahDD/Q8fFa9qaLWr4=;
        b=NgY0WzvQkkzu5MW68ZDDIcuV4ZDbsPWHe6Ea6G6DMmWyYU9vEc9VIxat/9KrpbSzohoO4T
        I890t20ZAuG8NWX0e5bK82z7sN0jhVlFGhMPVsNeuLbkOhNcCTcI1IH2WjJPtBVx56jzmL
        C+FFp+HdbIyl//i7IKrn1bjLTVyW1Gc=
Date:   Tue, 27 Sep 2022 13:19:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzLcSOS6ZLIoPwBl@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com>
 <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
 <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:14:42PM +0200, Juergen Gross wrote:
> Yes: cpu hotplug.

You might need to elaborate here.

Because I see mtrr_ap_init() on the AP hotplug path:

native_cpu_up->
do_boot_cpu->
start_secondary->
smp_callin->
smp_store_cpu_info->
identify_secondary_cpu->
mtrr_ap_init

Which then means that we could check in mtrr_ap_init() if we're on the
hotplug path and still get rid of that stupid bool...

Close?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
