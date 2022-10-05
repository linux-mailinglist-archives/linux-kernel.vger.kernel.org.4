Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242355F59B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJESRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiJESRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:17:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D924DB53
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:17:20 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7a3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7a3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A02581EC00F8;
        Wed,  5 Oct 2022 20:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664993834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1QPQd+EnuOTeYGPetCW/aGGWtQExvkeO5yOk/y3UQtc=;
        b=qBjGbYpczljEpZfWyKy3Oas+OVcBdQ+PyieDFXj+wPij7UE9gUTUYTj9AcYIZTSEqoByMs
        mAtJwHFf+8SJSES8UsyB27/JsfE2dHeQkAZ/6PePDBY8F8nLOY2M+rhfCYLGLu+nxDbh5p
        E0nZxigZglmi64htJV2CU/qqf7CWxC4=
Date:   Wed, 5 Oct 2022 20:17:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS: Fix the trace_show() function to output trace_count
Message-ID: <Yz3KI5qY70rvJV63@zn.tnic>
References: <20221005161645.309068-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005161645.309068-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:16:45AM -0700, Tony Luck wrote:
> The /sys/kernel/debug/ras/daemon_active is used to indicate to some
> kernel code whether there is a user mode consumer of RAS trace events
> to decide whether to print to the console.
> 
> The intent was that reading daemon_active would give the same indication
> to users. But the code is broken and does not display anything.

Huh, looking at that Fixes commit, it says:

"One can track which daemon opens it via "lsof
/path/to/debugfs/ras/daemon_active"."

# lsof /sys/kernel/debug/ras/daemon_active
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
tail    13339 root    3r   REG    0,6        0   27 /sys/kernel/debug/ras/daemon_active

So it works as advertized I'd say.

> Add a seq_printf() to output the current value of the trace_count.

Now, if you want to cat that file, that's a different story.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
