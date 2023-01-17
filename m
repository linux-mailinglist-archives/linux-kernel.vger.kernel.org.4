Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D862B670E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjARA2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjARA2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:28:23 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D8227A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:51:19 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30HNolh0197671
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 17 Jan 2023 15:50:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30HNolh0197671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673999449;
        bh=UwGfyMlw4giOD9m8ihmxG3EEyoF9yMlymNA+0LMhS6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zh1TZtnnq1wv0KnEV+I/BjgyDlGIgpweX0T29YhnaH0K4NFsk1+3kFDKHs8W7dtpM
         fuvrT/b4REnfMmHfHNbAOG6H2UJjbeuT5E/Nsnb5cFPy+hnjQp8/PDy85p6ZmFq2zR
         lBh0Ne7pmlmSqX3fJetbLNTN03NXaepjI/EYOtQNf3rDLqCdBiDVofcKB5lKhdXGsp
         Jg0rGPdCAsPsKy0ceR91X4/OQKqoo3LK7sGHhSulczzVluP672mJqls5OlrSMu8L/S
         tHnqGHaokzACJML7mrCH+oXFwzv8A9htwCB8Gw3Qwckz6Gb2nvU4TAqbUjXlfwWBLG
         9/3gCm5FfosQA==
Message-ID: <9a5b63ce-aeaa-77cf-0e36-53ee472a1656@zytor.com>
Date:   Tue, 17 Jan 2023 15:50:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 3/3] x86 mm, x86 architecture (32-bit and 64-bit):
 arch/x86/mm/kaslr.c: Adds 64bits version of prandom_seed_state
Content-Language: en-US
To:     David Keisar Schm <david.keisarschm@mail.huji.ac.il>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jason@zx2c4.com, keescook@chromium.org,
        aksecurity@gmail.com, ilay.bahat1@gmail.com
References: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
 <295dceed7bef2391f86e751b9bfc9a34347062e4.1673470326.git.david.keisarschm@mail.huji.ac.il>
 <9fc36447-5534-b93a-98d2-0999820c0def@zytor.com>
 <CAD0z2U1Y1CR_erAj+akPbVF2jxicdQKQfqWPc69fwL-rvSu_fQ@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAD0z2U1Y1CR_erAj+akPbVF2jxicdQKQfqWPc69fwL-rvSu_fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/23 13:16, David Keisar Schm wrote:
> 
> Because (the way we understand this), Kees Cook prefers to keep the 
> original API, so that a fixed seed can be injected at will (for 
> debugging). Seehttps://lkml.org/lkml/2023/1/6/772 
> <https://lkml.org/lkml/2023/1/6/772>
> 

This bothers me, because with FG-KASLR is *exactly* when a bad PRNG will 
shine through.

	-hpa
