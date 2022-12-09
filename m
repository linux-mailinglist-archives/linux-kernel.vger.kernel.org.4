Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640D647B84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLIBeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLIBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:34:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DBF87404
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:34:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so3288177pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSSgeTw9Yz+FfvbZuDB5LbCT2ojj7LN7YobQNJ1KUoo=;
        b=EjP//kJK7hYquIZQrKzwY9FwPb11Yn1wPk9KJeae5TVrzXZyWmsA66pgeGGWcg34jX
         +zYUPxBZjBMRSblRJGEf6ztPnX8kj/f9wEeDLT+o49lKtnSxYzEF0vG/J+YDI4sUFWgs
         R+Xj85hZjtr3/rrF1O/QctWerzPW8S68i89xV1wPdup/imOl1ViopZCj708NVre1PNPY
         Q9pun6uBtt+2DN7vHnfVNnRrPUUG9yeP5doUirYI2SjQq3usxj6JVdOl5sw4q58IoeD7
         Ahf25imVPbTM9HZCCwFVoWiOPrlZsnw9pGhE0R6HdDt9l24KAMKKj/7HkX6eGHSnly8H
         NOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSSgeTw9Yz+FfvbZuDB5LbCT2ojj7LN7YobQNJ1KUoo=;
        b=a0r01kbA0nqPjIHqj6hvnxXN3zICmaTfdn/S/6ycIkgSDooU0hYLajsF8nlbHTJL00
         696lsQsuYMykqiefxzDEOgbfH5e/NKI/I0VrfDHn9ibtk20XydNOX1AsCfL8KfyKvV7X
         PJgj+g/10QzCDWYqs+6aIzcvunjV5heEJU3V/KVjv75ux77kPwgxf8fUCWWAugVenaCi
         BKb2lb1dmuMYjTmqgEecONi3s7STCiC1bHVJRdxttG2eURvYXlNy06iA8FP79iZqo0w2
         bVLG4tq0+skAMBE1RMXi9r2FjOCkrU9GLmEVafCKY61oz/1ygqbGCtOgIRzJUj7mjV53
         1gZA==
X-Gm-Message-State: ANoB5pk9QxvWGWa2mXCk6+RVvCifZ53NakcdRUzqDHY4WdwFqXieH09L
        P3NjS7GqvZ60/eX9ut8UclsVGQ==
X-Google-Smtp-Source: AA0mqf7sYRwq5zCxeK0/EntfYrrLqZzWVn8Do+CBDaVntVRbI0oKgUj23CX4Dy+wtSyG9GBGvuBuAA==
X-Received: by 2002:a17:902:7402:b0:189:58a8:282 with SMTP id g2-20020a170902740200b0018958a80282mr1698209pll.3.1670549667630;
        Thu, 08 Dec 2022 17:34:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b0018703bf42desm71602plw.159.2022.12.08.17.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:34:27 -0800 (PST)
Date:   Fri, 9 Dec 2022 01:34:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Adamos Ttofari <attofari@amazon.de>
Cc:     dwmw@amazon.co.uk, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: ioapic: Fix level-triggered EOI and
 userspace I/OAPIC reconfigure race
Message-ID: <Y5KQnyZYkfGkBIvR@google.com>
References: <20221207091324.89619-1-attofari@amazon.de>
 <20221208094415.12723-1-attofari@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208094415.12723-1-attofari@amazon.de>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022, Adamos Ttofari wrote:
> When scanning userspace I/OAPIC entries, intercept EOI for level-triggered
> IRQs if the current vCPU has a pending and/or in-service IRQ for the
> vector in its local API, even if the vCPU doesn't match the new entry's
> destination.  This fixes a race between userspace I/OAPIC reconfiguration
> and IRQ delivery that results in the vector's bit being left set in the
> remote IRR due to the eventual EOI not being forwarded to the userspace
> I/OAPIC.
> 
> Commit 0fc5a36dd6b3 ("KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC
> reconfigure race") fixed the in-kernel IOAPIC, but not the userspace
> IOAPIC configuration, which has a similar race.
> 
> Fixes: 0fc5a36dd6b3 ("KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race")
> 
> Signed-off-by: Adamos Ttofari <attofari@amazon.de>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
