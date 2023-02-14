Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD53696CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBNSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjBNS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:29:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1552E829;
        Tue, 14 Feb 2023 10:29:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D370EB81EC2;
        Tue, 14 Feb 2023 18:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8614C433EF;
        Tue, 14 Feb 2023 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676399389;
        bh=oQROITW1uKecfEo2cGdUy6SKWCigHCuMd3wvoPcK/Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpBfb/N7GqHlXo7xtxu5LoZyyUht86rqLf73Z3PeLujJU6jGBfG4Crx1t8FD0bkFr
         cpbiPz0/QDlZfYRI4h2P3lLrmD5Z/xbGq7cs4Ut0xjuJi4YzSzkvOMMKpBtebTlCtL
         l4e1AgnghjvPjyVVks0KpZOXqFcPu3BTc7mr5i2f6zK8LRTHRiYvESRTTFIvkhp+LF
         VuUuwaRBMKyTuPkTeqMUDJ4+UTzBxdWeQgQAGNmVm18KuHS/90CWYpvajdj9AOJsed
         2UAZeIOgM0zNiULRxmya9V9eCoG8CCRRUJHb21auhUA9pbURPxp8PbGI4vjFY9YHnJ
         dx0ZQ0blYHc8A==
Date:   Tue, 14 Feb 2023 10:29:46 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: Re: [PATCH v2 00/24] cpu,sched: Mark arch_cpu_idle_dead() __noreturn
Message-ID: <20230214182946.x64fakiyfrjumuy2@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <a48ebe98-82b5-8f7b-8327-4e60bdb231c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a48ebe98-82b5-8f7b-8327-4e60bdb231c8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:25:50AM +0100, Philippe Mathieu-Daudé wrote:
> On 14/2/23 08:05, Josh Poimboeuf wrote:
> > v2:
> > - make arch_call_rest_init() and rest_init() __noreturn
> > - make objtool 'global_returns' work for weak functions
> > - rebase on tip/objtool/core with dependencies merged in (mingo)
> > - add acks
> > 
> > v1.1:
> > - add __noreturn to all arch_cpu_idle_dead() implementations (mpe)
> 
> Possible similar candidates: panic_smp_self_stop, nmi_panic_self_stop
> and kexec.

Agreed.  Any volunteers?

-- 
Josh
