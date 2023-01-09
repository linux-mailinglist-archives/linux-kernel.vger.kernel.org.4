Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521D662FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjAIS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjAIS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:58:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9641CB31;
        Mon,  9 Jan 2023 10:58:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50DE31EC0354;
        Mon,  9 Jan 2023 19:58:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673290697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T/C2ZNsdnbD7anTm7jFesx/2sE3BiumYPYtc/1Ha8co=;
        b=b1yYS9IVnAWfK1sWk9+HU/hMRjCkilHzvuC+7tUeignRByPme3+dlWe93egoeYGgrLjg8D
        UpF84JnHIegvsMtVRUnveeZhE7oVOwMMgQnne97xRMV7hzsOMKAaq2jBaMAaPWx2yplRlw
        L6SYWz8JYVfj8QS0fZr2jT4OJ6gkpnc=
Date:   Mon, 9 Jan 2023 19:58:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring
 Event Configuration feature flag
Message-ID: <Y7xjxUj+KnOEJssZ@zn.tnic>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230109164405.569714-5-babu.moger@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:43:56AM -0600, Babu Moger wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 00045123f418..db5287c06b65 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -308,6 +308,7 @@
>  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
>  #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
> +#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configuration */

If those flags are meant only for internal kernel code use - it looks like it -
and userspace doesn't care, pls put "" in front of both in the comment like the
others above them do.

This way they won't be visible in /proc/cpuinfo.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
