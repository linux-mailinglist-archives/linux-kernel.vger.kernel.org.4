Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7976D5292
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjDCUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjDCUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:36:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71A448E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:36:29 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9C9A1EC01A9;
        Mon,  3 Apr 2023 22:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680554187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dURY1xCpHXDLXAfUlVyn8rjCxWMcqqi+PH/vEcs4z5g=;
        b=ICr5otNGdMU0EdM8Cn5TYhOfU1Ydt/YWGbdIIhReI0kzu/52rRpi/D/kxSXXfA35D2lBj7
        yx34UcFvFEgkTRbLYLEK40/zhwrtMBq6prlIXKUUeeXfKXCnOp7SjI9mEhgjON3asyB+hc
        euVlPMWcWWNC476TW8bMOATeRolUeyU=
Date:   Mon, 3 Apr 2023 22:36:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Message-ID: <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:40:38PM -0400, Yazen Ghannam wrote:
> I don't think pci_write_config*() sets the PCI Error response like
> pci_read_config(), AFAICT.

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64631a4..c4caade434a7 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -181,6 +181,13 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 		pr_warn("Error %s SMN address 0x%x.\n",
 			(write ? "writing to" : "reading from"), address);
 
+	if (!write) {
+		if (PCI_POSSIBLE_ERROR(*value)) {
+			err = -ENODEV;
+			*value = 0;
+		}
+	}
+
 out_unlock:
 	mutex_unlock(&smn_mutex);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
