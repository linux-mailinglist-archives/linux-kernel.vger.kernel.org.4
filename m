Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD05F7C69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJGRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJGRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:45:46 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4FB925B9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297HjHZh3871971
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 10:45:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297HjHZh3871971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665164719;
        bh=wi3wUYXw35qSgX019N/+AX/o+IlA3jX77rNqnjbZbZM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=TFVW5jm3iKJ9+9hIzcB/qMHmyifr9jssCw0OD7FZ2DdchsoU1eNJeDkyxSS2xyolI
         oH1rBIwBAM8VBNfzhx92gy9yHlPQltN3RXtwIZuK9cTB5LwSkZ7RpcJ6zeMBExvQ04
         vD4NfHuaGLmv/YlpbQ+s/kf0HBr7pdPDFdsoSUMP1CGMS5aHTJt1JBAMONLe/Pa9cq
         jKPJm3GJ9pgLmhc7Lq/Xj1M2hOwNHYf4Y6LQwaa5IXo1qVrT5VRUiXW8KxnPKmAKaF
         os76vzB3VlvXiIXN7ZEdpY0a9jzPmYEZoLmg0G8+Q1YJ5OZgojYxJ5oUAqaoYU38lW
         +yVgi3upvJR9Q==
Date:   Fri, 07 Oct 2022 10:45:14 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/6=5D_x86/gsseg=3A_use_the_LKGS_in?= =?US-ASCII?Q?struction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com> <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
Message-ID: <5E3D5429-33BC-4924-B82C-C731507C0F06@zytor.com>
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

On October 7, 2022 7:47:09 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> =
wrote:
>On Thu, Oct 06, 2022 at 08:40:41AM -0700, Xin Li wrote:
>
>>  static inline void native_load_gs_index(unsigned int selector)
>>  {
>> +	u16 sel =3D selector;
>> +
>> +	/*
>> +	 * Note: the fixup is used for the LKGS instruction, but
>> +	 * it needs to be attached to the primary instruction sequence
>> +	 * as it isn't something that gets patched=2E
>> +	 *
>> +	 * %rax is provided to the assembly routine as a scratch
>> +	 * register=2E
>> +	 */
>> +	alternative_io("1: call asm_load_gs_index\n"
>> +		       "=2Epushsection \"=2Efixup\",\"ax\"\n"
>> +		       "2:	xorl %k[sel], %k[sel]\n"
>> +		       "	jmp 1b\n"
>> +		       "=2Epopsection\n"
>> +		       _ASM_EXTABLE(1b, 2b),
>> +		       _ASM_BYTES(0x3e) LKGS_DI,
>> +		       X86_FEATURE_LKGS,
>> +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
>> +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
>>  }
>
>I'm very sure none of this was tested=2E=2E=2E the =2Efixup section hasn'=
t
>existed for almost a year now=2E
>
>  e5eefda5aa51 ("x86: Remove =2Efixup section")

Xin, what did you use as the forward-porting baseline?
