Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647DB68E004
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjBGSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjBGSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:30:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8A1AE;
        Tue,  7 Feb 2023 10:30:37 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7506F1EC06BD;
        Tue,  7 Feb 2023 19:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675794635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unM+sDz7KgSXzbCVAYLEm70N3Pk5L+izixqtsNk9evU=;
        b=jqOfvXZWlZZ51s5K/7R3yT8hL3AqyHKQZ3bIkq0eaVq15t//WOPnNVaGPmIII/m8WGa1E6
        MxjFJsICorR7ddXyzmsv8qP6e+DKVUHSH4IslgjmaR+6FrvlF38vbgTg5CM86QYiP8HPg8
        m0gd1b6vez7jLIDA/L8mE0q0D7oEhiE=
Date:   Tue, 7 Feb 2023 19:30:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     silviazhaooc <silviazhao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com,
        tonywwang@zhaoxin.com, kevinbrace@gmx.com,
        8vvbbqzo567a@nospam.xutrox.com
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Message-ID: <Y+KYx5XcE1IAPPoQ@zn.tnic>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <Y95hWVFyw7TM1WSB@zn.tnic>
 <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
 <Y+DM8BZUi6a10hXY@zn.tnic>
 <1d808c21-f54d-1506-d95a-0276430aea8d@zhaoxin.com>
 <Y+Dgx7EeRufHdx17@zn.tnic>
 <950c6d27-bc91-01e0-ba26-d09ad4bf7934@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <950c6d27-bc91-01e0-ba26-d09ad4bf7934@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:42:26PM +0800, silviazhaooc wrote:
> Sorry, I'm a newbie in Linux. Thanks for your reminding.

No worries. :)

> I have carefully checked our product manual for Nano and ZXC FMS.
> 
> For ZXC, there are 2 kinds of FMS：
> 
> 1. Family=6, Model=0x19, Stepping=0-3
> 
> 2. Family=6, Model=F, Stepping=E-F
> 
> For Nano, there is only one kind of FMS:
> 
> Family=6, Model=F, Stepping=[0-A]/[C-D]
> 
> So model = 0xf, steppings >= 0xe or model = 0x19 belong solely to ZXC.
> Nano is an old CPU series which has been stopped production several years
> ago.

Good, which sounds like there won't be any more Nano steppings.

> It will not use the steppings which belong to ZXC.This is an
> unambiguous way to differentiate between ZXC and Nano CPUs.
> 
> Do I need to add the statements in the source code and re-commit the patch?

Yes please. That would explain in a clear way why it is ok to test those
models/steppings. If it turns out that we need this Nano - ZXC
distinction more often, we can do something more involved later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
