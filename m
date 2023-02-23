Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9416A0C38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjBWOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:52:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A059424
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:52:31 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD4D41EC06F0;
        Thu, 23 Feb 2023 15:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677163949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OeGccNjEKIzTcdNPG0OK8Ij5ep1oHfZDb+0nQEmJ8ac=;
        b=di6slqu4z7knGSd162T6wARwGYrk/V2cILlZFAPTqeHz3IwUy3MVFyG7rA+8NxOjal+T8d
        5IT7O73fUAPlPW8yYAMyyRcWJN2tRi+JE97YvXJCOkkMAUYUO0N4cEe0BWxFMljKwfCVhH
        vJGzol48LX3PvW8klT0AS/0KqFryKXQ=
Date:   Thu, 23 Feb 2023 15:52:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        jpoimboe@kernel.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        corbet@lwn.net, bp@suse.de, linyujun809@huawei.com,
        jmattson@google.com
Subject: Re: [PATCH v2 2/2] Documentation/hw-vuln: Document the interaction
 between IBRS and STIBP
Message-ID: <Y/d9qajJnR/ZcHvB@zn.tnic>
References: <20230221184908.2349578-1-kpsingh@kernel.org>
 <20230221184908.2349578-2-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230221184908.2349578-2-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 07:49:08PM +0100, KP Singh wrote:
> ... Consequently, STIBP needs to be explicitly
> +   enabled to guard against cross-thread attacks in userspace.

needs?

That sounds like something the user needs to do. But we do it by
default. Let's rephrase:

"Systems which support enhanced IBRS (eIBRS) enable IBRS protections once at
boot and they're automatically protected against Spectre v2 variant
attacks, including cross-thread branch target injections on SMT systems
(STIBP). IOW, eIBRS enables STIBP too.

Legacy IBRS systems clear the IBRS bit on exit to userspace and
therefore explicitly enable STIBP for that."

Simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
