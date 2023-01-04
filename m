Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6065D1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbjADL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjADL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:58:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DE1E7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:58:53 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18EC91EC008F;
        Wed,  4 Jan 2023 12:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672833532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UKl/CVF+4GJS0LDdyX728sU1J1aGkocy2OklfcAdRtI=;
        b=VcttLkPNy9K1xNdWfFV7Yz0KEUwXXic9v2XG1jbmKgXxKVSo4wcHOiMPPS/Y09Wr2p5SCF
        2pmDtdw/423IjVUdnSQ/yOxlJdQFacJj5lXUfKDExPe/KfWSxHLfgoaUswfq1pSyDkPKwR
        +8kZx8fwKmnCVLzKEVBMtns1UtQy+9g=
Date:   Wed, 4 Jan 2023 12:58:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 1/2] x86: Check return values from early_memremap calls
Message-ID: <Y7Vp+EPq5wkGr5mi@zn.tnic>
References: <20221110154521.613472-1-ross.philipson@oracle.com>
 <20221110154521.613472-2-ross.philipson@oracle.com>
 <8e62a029-f2fa-0627-1f71-4850a68ec6b6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e62a029-f2fa-0627-1f71-4850a68ec6b6@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:07:53AM -0800, Dave Hansen wrote:
> On 11/10/22 07:45, Ross Philipson wrote:
> >  	dt = early_memremap(initial_dtb, map_len);
> > +	if (!dt) {
> > +		pr_warn("failed to memremap initial dtb\n");
> > +		return;
> > +	}
> 
> Are all of these new pr_warn/err()'s really adding much value?  They all
> look pretty generic.  It makes me wonder if we should just spit out a
> generic message in early_memremap() and save all the callers the trouble.

Well, let's see.

early_memremap() calls __early_ioremap() and that one already warns befofe each
NULL return. So I guess we don't need the error messages as we will know where
it starts failing.

I guess we still need the error handling though.

I.e., this above should be:

    dt = early_memremap(initial_dtb, map_len);
+   if (!dt)
+           return;

so that we don't go off into the weeds with a NULL ptr.

Or?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
