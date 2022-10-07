Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4F5F7C70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJGRsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:48:16 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD6D2587
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297HlvLc3872399
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 10:47:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297HlvLc3872399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665164878;
        bh=uvU3Of4Cg/ZjEcnpqFHyTgWJfnfLANAKmiV2V7/g69Q=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lEKtQYs0yFOpfIxtTkewQKMBlJLgwvdEJsIxjrjHHOrZlgFvp2UoNiGKW5/rEDFUO
         9FoqMn4YRlAPTs+D9ZbT2NXQH+Uz+pBhCpzAv4JV3f9SpMfp6rSqzPbayhuzNzsIUO
         /w9AWkh/ajkv0qgLCxgcwxJ9fBNWAkJ7HbhmVim6sAEKr3dVF4PJW1HOs5/c4FezOk
         HKKeBEp1T993eAi2LgCNuNi732HL4TvNFTaiemMFzKTvETSQiJEq+uK7I2qYYkOPyf
         sq5h5LPyHmyd/U/qQ//Wbpws2q3ri0MhCNHaZdqdvKLeuxh2PR6W5zYngYBfLVqyu5
         c+EyGDZo2X6+Q==
Date:   Fri, 07 Oct 2022 10:47:55 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/6=5D_x86/gsseg=3A_move_local=5Fir?= =?US-ASCII?Q?q=5Fsave/restore=28=29_into_asm=5Fload=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0A8mWvT0mLm3nVD@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-5-xin3.li@intel.com> <Y0A8mWvT0mLm3nVD@hirez.programming.kicks-ass.net>
Message-ID: <40F2C08A-574D-43A6-81D8-B8B9B7963F14@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 7, 2022 7:50:01 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> =
wrote:
>On Thu, Oct 06, 2022 at 08:40:39AM -0700, Xin Li wrote:
>>  SYM_FUNC_START(asm_load_gs_index)
>>  	FRAME_BEGIN
>> +	pushf
>> +	pop	%rax
>> +	andl	$X86_EFLAGS_IF, %eax	/* Interrupts enabled? */
>> +	jz	1f
>> +	cli
>> +1:
>
>Why the pop,andl,jz ? AFAICT our arch_local_irq_save() doesn't even
>bother with that, why does this function=2E

They pop and and are needed for the sti anyway, and so might as well be le=
veraged here, too=2E
