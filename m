Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8B60597E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJTISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJTISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:18:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE76149DFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:18:12 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e710329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e710:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8A081EC0723;
        Thu, 20 Oct 2022 10:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666253886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RAzpE83MzmvBXvcBI3Gzyypk58bNI4/Dj1+f80hjj9U=;
        b=ZgvHVHtW8TsewObdMr/knHmzpD0xHVYC3dLSpUgHp11Un0HKQUkY+UPWPa9GO0zGCFKlKn
        VBSATTA0bGkt4Py4yS+q4prXg5YJaPUqVfTYowDA+WK1qwgSJb2AAoFQiUBvIPcCyxY8q4
        YSd+UI7MANqq3ubTtyGM1aDW5FgSs3w=
Date:   Thu, 20 Oct 2022 10:18:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1EEObR7keIDJtVJ@zn.tnic>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1BSF8ck0RD9UpLd@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:37:59PM +0200, Borislav Petkov wrote:
> Ah ok, yes, I need to check ->request_microcode_fw's retval.

On a second thought, no I don't have to: the request routine will try to
load any new microcode but if it fails, ->apply_microcode later simply
won't find it in the cache. And that's perfectly fine.

setup_online_cpu() still needs to run on each CPU unconditionally,
though, in order to setup the sysfs groups.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
