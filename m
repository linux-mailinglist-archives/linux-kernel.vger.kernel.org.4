Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D973488B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFRVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFRVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:17:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EB1B1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:17:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687123075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95V82FuCk14L4o23xW0SJ3YkPbN9/vpBfmhpOLByVJ8=;
        b=SsvvLK4n/Gaa5VbGZ9GxksdY2mrE+pKF+VCO4Dv9QVpj8FNUJYpcUsP0CkXdnCa/8hKfTZ
        uU1kT3AbkbLv9AlFXI1r49/SNp2W3MXYDLKS3HKbhlFP6bJqZXFynNny71YGYUhpQIgQ0K
        CR0DMp9M4S5ITtaSYY5/SPchqIhIWQ7mpiIRPadbqgfqQzJy+UzLDlZ8wb0VFfRLY8cF6/
        wUvF592l4cRlDQNPNUGv6K7Lk+QK+3EFxLAwRB91nMq0RqYgEnfsPZ+MfLPu/vYNburX6T
        QYF8q2FvfNMcNmELkS3agprGDqcm4P0TgmfN51aU3ebe7mDYtQvDpVKfV5XJnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687123075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95V82FuCk14L4o23xW0SJ3YkPbN9/vpBfmhpOLByVJ8=;
        b=+uoNM3ie6XohdMXjT6HbhEXzk+3cxRp3khWNQgcIIpgew6FKbgIDbmCKaDy0hjeYAb9FxU
        l4uhXFiQzTuGwKDw==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v3 5/5] x86/entry: Make IA32 syscalls' availability
 depend on ia32_enabled()
In-Reply-To: <20230616125730.1164989-6-nik.borisov@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-6-nik.borisov@suse.com>
Date:   Sun, 18 Jun 2023 23:17:54 +0200
Message-ID: <87mt0wqxkt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:
> Another major aspect of supporting running of 32bit processes is the
> ability to access 32bit syscalls. Such syscalls are invoked either by
> using the legacy int 0x80 call gate interface or via the newer sysenter
> instruction.
>
> Ensure that if ia32 emulation is disabled (either at compile time or
> runtime) then those 2 syscall mechanisms are also disabled.

AFAICT there are _three_ mechanisms for 32bit syscalls, no?

>  void __init idt_setup_traps(void)
>  {
>  	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
> +
> +	if (ia32_enabled()) {
> +		idt_setup_from_table(idt_table, ia32_idt, ARRAY_SIZE(ia32_idt),
> +				     true);

Just let it stick out. The 80 character limit is history.

Thanks,

        tglx
