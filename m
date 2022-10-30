Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAF612C05
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3Rsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ3Rso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:48:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694AC14
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:48:42 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e745329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e745:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 115E41EC02F2;
        Sun, 30 Oct 2022 18:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667152121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YlajMgapSk2mwP7YDnDVHVyG5vc0AJY3t+6wwDRwE8w=;
        b=oqUfRDDb5LJOPecXiy0/SpXpn665HPEMub3cszxCc9spXv70wJred6EbeVRYfMv7WRKNkO
        4aiaCphBBYtsfcySyJvSFQJDb4at0ZDM1NmhCiCcpcUPsf1NN1un4zx96vLfECIH5hpNHi
        rvNo4gPGVw4R1MVA02rAmsLnTs16Yso=
Date:   Sun, 30 Oct 2022 18:48:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
Message-ID: <Y1649fb9LagjBtYI@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-17-jgross@suse.com>
 <Y15o4o8j6zbQuaQJ@zn.tnic>
 <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com>
 <Y16osqK3kbCz8Sf3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y16osqK3kbCz8Sf3@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another randconfig build failure in the meantime. Pretty easy to
trigger:

ld: arch/x86/kernel/cpu/cacheinfo.o: in function `cache_bp_init':
cacheinfo.c:(.init.text+0x1): undefined reference to `mtrr_bp_init'
make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make: *** [Makefile:1236: vmlinux] Error 2

the reason being:

# CONFIG_MTRR is not set

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
