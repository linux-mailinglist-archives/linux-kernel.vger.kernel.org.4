Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83C63B5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiK1XfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiK1Xe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:34:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD2326EE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:34:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59F8D1EC04AD;
        Tue, 29 Nov 2022 00:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669678494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=12Jz0asduvf1c6TL+3azPftaorUR/sBfylrXZrFp+zY=;
        b=MkrUrgs6bTJSLgq9LoicH5MyKYfcYBiZtS7m4+h0sNDQ1/yP28lsjyxXnhpvQmfGSKN5yh
        9kUDGzpHDZPfFGTuMOVvMHtMll457wM4Fl7nTiWHqAk7WBODok8xwEesRusAlyQ8HK5U1E
        XMTvIRlabnWvg8xFfmsKlrlnODDfq+w=
Date:   Tue, 29 Nov 2022 00:34:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y4VFmvTOkRgVmxtc@zn.tnic>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
 <20221128230219.urqiol42rikdhy2u@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128230219.urqiol42rikdhy2u@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:02:19PM -0800, Pawan Gupta wrote:
> Yes thats a cleaner approach, except that the late microcode load will
> ruin the MSR:
> 
> microcode_reload_late()
>   microcode_check()
>     get_cpu_cap()
>       init_speculation_control()

Microcode late loading ruins a lot of crap already anyway.

Then I guess we'll have to look for a better place for this on the init
path - I don't want any more hackery in the hw vuln nightmare code.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
