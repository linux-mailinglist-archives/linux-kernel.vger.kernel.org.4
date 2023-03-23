Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8316C631A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCWJRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCWJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:17:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB331F493
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:17:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679563036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cHsaK8lsctTLWgEZK+p2RULrU67jhFmAPVGpC5jpv4=;
        b=D3tYgpwWqrfAgXuC3Jt3CFAIc6D+MtvQd9xFVvPKtJE15kOBKpW36w4WCDcc021hu7K8pP
        mZUNzdFX8WBKWnbLPjKhffNsDDgBHv9z28smRjma6RidqFEylL3EvxFP2XP1k38Ve7dO7h
        +nLzOdFmSbF8uvJwtcl/vNhkr37bI5HNbswDJhfFFWC6tckbqf2EwdiSxuL0DkHgbb4P+P
        fgQgZ+slP/SyOcZFMDxQWB/TQoAX7wpCMwe3Q9FKX8aXXSXDmAH8Lt0LRmD48YwwGfzH03
        Y4WcY/9SCcTx44N/chz1h8NmRWF6DCiV5RAT5sq217GqwJXYCwe66Q5I2FJzow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679563036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cHsaK8lsctTLWgEZK+p2RULrU67jhFmAPVGpC5jpv4=;
        b=s7JouwHpQTmw7zQXTdCkNgbIYFCzRhE7BxqFO19+muKAOgdTkzXDfTrID0YGs1IWLEOGRL
        pAWc4BdtflpVmwBg==
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/sev: Get rid of special sev_es_enable_key
In-Reply-To: <20230318115634.9392-3-bp@alien8.de>
References: <20230318115634.9392-1-bp@alien8.de>
 <20230318115634.9392-3-bp@alien8.de>
Date:   Thu, 23 Mar 2023 10:17:15 +0100
Message-ID: <87edpf9690.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18 2023 at 12:56, Borislav Petkov wrote:
> -bool cc_platform_has(enum cc_attr attr)
> +bool noinstr cc_platform_has(enum cc_attr attr)

That's not sufficient. This function invokes static functions which the
compiler can rightfully put out of line resulting in a noinstr violation.

Thanks,

        tglx
