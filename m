Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F306017E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJQTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJQTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:40:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0D69199
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e793329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e793:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59A401EC0531;
        Mon, 17 Oct 2022 21:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666035610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BwDzUZUJ3Ncqn9W3MzLUnrmHphgpLYPe0ymvG0+hE2g=;
        b=otdJFus0QrWjMwUVuGJrSSQfbkSfAvXBEOnvl6arnKZv56FdBWW2HJJ0KYWbOKJHmntAZv
        hT82mvD0uWdBVTo8GvyRq7I5YMdhyWdy48xyr5EE6fvMO485O3yecctO8aJEtcudMxj5Lm
        wbsevnO+bczJtsQLV3n/G626r1JHdn0=
Date:   Mon, 17 Oct 2022 21:40:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Message-ID: <Y02vmRn1Uz6/NMFF@zn.tnic>
References: <Yz3KI5qY70rvJV63@zn.tnic>
 <20221005194644.311204-1-tony.luck@intel.com>
 <Y00wIFEN9h9YPGe1@zn.tnic>
 <SJ1PR11MB60835DDCB1F3EBC8B6DFA2F7FC299@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60835DDCB1F3EBC8B6DFA2F7FC299@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:09:23PM +0000, Luck, Tony wrote:
> Agreed. It needs user to interpret the answer. The filename would lead
> them to think "1" means the daemon is active, but its actually just a count
> of how many times the file is concurrently open (which includes the
> "cat" process reading the file).

Yap, exactly.


> Should have thought of this earlier ... changing user space semantics
> is hard.

AFAIR, at the time we cared only about there being at least one
consumer... thus the binary test, is there at least one or not:

        if (!ras_userspace_consumers()) {
                print_extlog_rcd(NULL, tmp, cpu);
                goto out;
        }


> How about:
> 
> 	seq_printf(m, "%d\n", atomic_read(&trace_count) - 1);
> 
> with a comment that users reading the file only want to know if anyone
> else has it open?

Yeah, doesn't work either:

# tail -f /sys/kernel/debug/ras/daemon_active &
[1] 3019
1
tail: /sys/kernel/debug/ras/daemon_active: file truncated
1
#  cat /sys/kernel/debug/ras/daemon_active
2



We really need something to say, "I really am a RAS events consumer and
not some random file opener."

OTOH, if one does that on ones system, then one has herself to blame
when errors don't get logged and disappear. I mean, why would one even
do that?!

Then again, I've seen weirder stuff so...

Question is, what is your goal with this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
