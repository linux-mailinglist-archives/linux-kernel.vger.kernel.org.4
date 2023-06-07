Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233187258EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjFGI6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbjFGI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205926AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:56:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686128156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpvU/VMM03E2+eM90PuDFm3nk7nWddaXa439gEnZ/AU=;
        b=kAZd/W3Zjl3r/u07MxqNf/Wu4R0A6Rb9QytM7xaOtUOTUFfvuAsEhvJN9HekERWAn+Y39p
        kAKhlaoL/69fzL0o+XibhxdDmJk9KRVWI4Yo0mLGqAIUu6b9tgmNzW02vYmwILNsYKcbjz
        ddQTGLN2EE9r6wtP1fuCXTLWKAo96BBBMBzWj1eRbtIlV3WE+NboIm5rUqNYPJ9YBCmvqE
        36RnMLMTk/9IRtXLd9IQa0+5D+nxR271M1w+kOKl8MxLhk/I/8SG3YVZak9J/xMrNxjjA/
        po/kr/RKWMVLiTD8QJYqWnRb6leAYACLLcdoOh2xUtxRCecfrsfbMCzja4Mu2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686128156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpvU/VMM03E2+eM90PuDFm3nk7nWddaXa439gEnZ/AU=;
        b=AM1EZgtY35YffOG8PbOlVGTpWyrKhnCLIGUTjS+pycFFXJVCuG4x/HCHvl+EuD9OWBtwQf
        3yM0f3S5DgjMhACA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 1/3] x86: Introduce ia32_disabled boot parameter
In-Reply-To: <20230607072936.3766231-2-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-2-nik.borisov@suse.com>
Date:   Wed, 07 Jun 2023 10:55:55 +0200
Message-ID: <87r0qnk5wk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
> Distributions would like to reduce their attack surface as much as
> possible but at the same time they have to cater to a wide variety of
> legacy software. One such avenue where distros have to strike a balance
> is the support for 32bit syscalls on a 64bit kernel. Ideally we'd have
> the ability to disable the the compat support at boot time. This would
> allow the decision whether it should be disabled/enabled can be
> delegated to system administrators.
>
> This patch simply introduces ia32_disable boot parameter which aims at

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> disabling 32 bit process support even if CONFIG_IA32_EMULATION has been
> selected at build time.
>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/entry/common.c      | 12 ++++++++++++
>  arch/x86/include/asm/traps.h |  4 ++++

New command line parameters require documentation.

https://www.kernel.org/doc/html/latest/process/

Thanks,

        tglx
