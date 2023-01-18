Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC89670FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjARB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjARB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:27:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0933CE33
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:27:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bj3so31045391pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nIKn+mjTOyaw7oYAqM6VZKaiRDNDz61Nt/7Rj2z1BI=;
        b=qGZzcOXLu0FbgGjL5piUb5jTQduasxBpKM/jyb4tJs9xKtN12lUPc9yFHF/DKTeQ/A
         CwIFjwBIeoZvTD1hQz4EIJ8VtLAHBgUe1tfkiHHE46uDNYe1ZcRtE5hl3mso3aQ5AtKU
         BmhJxdigjnXUe4G0uXWWGjtfjFGiWn+20yWT0dmOOFkM7V2Wq/ZCCYGI97KVKvmtOC3l
         cwUaiclnkMb2GQrpiFsYD/o961X76p3WqQfXoyfB99IUaDbTV3SLcqRXDW4UVP8qK/H7
         m6CfKg7m6i56iGYFNNPyq5KZ18/ObmauPWszXqpHED3YTw7AXfDKrFjJm2uigX9qccaR
         Tzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nIKn+mjTOyaw7oYAqM6VZKaiRDNDz61Nt/7Rj2z1BI=;
        b=HqS90F7pOrhYbUVGOCS+EZdrxlPCljjVT8VaYeNbPyBzKYH3ID1wPTZBdClQ7LH9KC
         tcbt5NO8LvPsXEr5TCHPodrrr+ieKnp2LHQgdOTdoriSc1Od9UIrb3OD6qGlO1LC4zCU
         kZr19wZENnfBz78SMM5W9dWQ/XXVRiooFYTHthVhP7G6gGdaeUegESRSKCFktTXoAb8m
         suRfyvf10AE+v1k3J2GxtsawRgZkql13vK9CxK14tA9pRhEhgPbk/2Fjjd3dnsi1i/qr
         yZVKLxOeGO8dQoz8krfE3hKt4AFyxaJ6zgXX3z2h+6IcMC+aW5uJdjxILaMHzmWh7Xll
         2MOQ==
X-Gm-Message-State: AFqh2kpjXnv7rjxicdXXu2sd5MBPcfwwopT0KgpydtC19VRbbQLpjwzE
        qxBgeEzwij1jKfp3ajtypfHgku9Ra33eyn4O
X-Google-Smtp-Source: AMrXdXtjHnm119JHGEWlVS/W/4yVt15DKqhdxOIzLp58H8TMc13vhHeKOtp5RxHarHERytO5ZQBcIA==
X-Received: by 2002:a17:902:d409:b0:189:6624:58c0 with SMTP id b9-20020a170902d40900b00189662458c0mr2356707ple.3.1674005260722;
        Tue, 17 Jan 2023 17:27:40 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm21784578plb.248.2023.01.17.17.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:27:40 -0800 (PST)
Date:   Wed, 18 Jan 2023 01:27:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 17/20] kvm: Remove "select SRCU"
Message-ID: <Y8dLCJKXn5fL/2Iq@google.com>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-17-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113001132.3375334-17-paulmck@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements from the various KVM Kconfig files.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <kvm@vger.kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org> (arm64)
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Anup Patel <anup@brainfault.org> (riscv)
> Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>


Ugh, my apologies Paul.  I didn't realize 0cd7e350abc4 ("rcu: Make SRCU mandatory")
is already in Linus' tree, i.e. bundling this in a single patch was unnecessary work
for you.

Anyways, since there isn't an external dependency, this can go through the KVM
tree.  Unless you prefer to take it directly, I'll make sure Paolo sends it along
at some point before v6.2 final.
