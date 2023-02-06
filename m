Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D458568BB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBFLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:13:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF61F5E8;
        Mon,  6 Feb 2023 03:13:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC4FE1EC0464;
        Mon,  6 Feb 2023 12:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675681995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mX/9cBBr41N/UkSQ+JfhMgAXYIGR7yk/ubpwb/VTs1o=;
        b=HIByOg4D+uVRRDmeFeVf7odLQb8VjVvKoeRJTtLZM1AJM2uJa7p/T3bL81jeA9h4hWIltv
        iUF+RaAD/ZAy5/XQ8oVgJdrct8Mq/vnPBKkCDw5gchnLE1Epju9k2/0WZrA+zX380AKkTZ
        MI3Pf5H6LAJ+LmBO+mbVWhL+MqCmyQc=
Date:   Mon, 6 Feb 2023 12:13:11 +0100
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
Message-ID: <Y+Dgx7EeRufHdx17@zn.tnic>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <Y95hWVFyw7TM1WSB@zn.tnic>
 <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
 <Y+DM8BZUi6a10hXY@zn.tnic>
 <1d808c21-f54d-1506-d95a-0276430aea8d@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d808c21-f54d-1506-d95a-0276430aea8d@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Silvia,

On Mon, Feb 06, 2023 at 06:55:21PM +0800, silviazhaooc wrote:
> Thanks for your reply.

You're welcome.

First of all, please do not top-post when replying on a public mailing
list but put your reply under the text you're replying to. Like the rest
of us do.

> As I mentioned before, Nano has several series. We cannot test if all of
> them have the bug.

If you cannot test if all of them have the bug, then testing the
stepping as you do is wrong too.

You need an unambiguous way to differentiate between ZXC and Nano CPUs.

If steppings >= 0xe belong solely to ZXC, then state that in a comment
above it so that you can exclude Nano.

If Nano starts using those steppings later, though, then that check will
become wrong too.

So I need a statement: "this is how you detect a ZXC CPU unambiguously"
and then use that method when enabling PMU support on it and *only* on
it.

Makes more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
