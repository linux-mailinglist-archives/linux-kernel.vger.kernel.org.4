Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CB6D38DE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDBPoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDBPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:44:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE33592;
        Sun,  2 Apr 2023 08:44:31 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DE171EC0464;
        Sun,  2 Apr 2023 17:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680450269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vQcaoKs/WxKbULaS5V6K0JDkCQY6Irgs3SFQbr71L4Q=;
        b=iVMRLK+q6loLxDv3MSGsW2KkKCZ8v16oUEr8Gwh6NALthDikMK68MLvhysoI2hOq6BXseI
        HsN35LZHkIa0xhz8KAFNx0dEYYg/uTFtYYRSQPm8Zq6KuwiTqmpwPw9w2SLNRmCO+38ti/
        /q+/6JoOhm9IChvyQ5i/BZkLtRRiVMI=
Date:   Sun, 2 Apr 2023 17:44:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Message-ID: <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
 <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
 <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 06:10:09PM +0100, Jeremi Piotrowski wrote:
> Since the AMD PSP is a privileged device, there is a desire to not have to trust the
> ACPI stack,

And yet you do:

+	err = acpi_parse_aspt(&res[0], &pdata);
+	if (err)
+		return err;

You don't trust the ACPI stack, and yet you're parsing an ACPI table?!?!
You have to make up your mind here.

Btw, you still haven't answered my question about doing:

	devm_request_irq(dev, 9, ..)

where 9 is the default ACPI interrupt.

You can have some silly table tell you what to map or you can simply map
IRQ 9 and be done with it. In this second case you can *really* not
trust ACPI because you know which IRQ it is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
