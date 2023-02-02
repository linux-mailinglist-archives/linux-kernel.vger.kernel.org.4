Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C468778F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBBIcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjBBIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:32:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB068129
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDFB619E5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CADC433EF;
        Thu,  2 Feb 2023 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675326736;
        bh=em+SA8bH+Ubycp8Mf1txaZ7e8DD8A60wBth/RmYKOBc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=u+5WKahB1r6X27Df3qzWXCmH1Ssws9qhIS5elNMhpfG2fNEd5hBYm41/xm5JERarP
         SQgY3E1J+aLBWYsYOZvSfZvx3LCMBi7OvW7IUz2q9e2x3LDxsC9WMRFZcrPVB8X9Oa
         sSr/Vyfww9U2vUMKQpwMW8sHYozZrHPR8fPWNmJCQtCqEIl+NtfSjxcDJWIvQsvc17
         44m+xq/z2kFk1L6zaJ84niYG19C/uMgK83+/k7C2mzHRwjJb7ARXUj3i77KUaEPJok
         ClHfWe8w9UFlQNs9hehcNpne1OrBFmflqvqWIWGhtT7nt9wG4LmOqOVlMnsWrKqPTK
         ptIANM7k7Gg+Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, liaochang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an
 illegal position
In-Reply-To: <CAJF2gTTn52FWRU9-ZqDLpTUe0BkLgttP3NOyk-PzxJbbX75cPg@mail.gmail.com>
References: <20230126130509.1418251-1-guoren@kernel.org>
 <878rhig9zj.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQHDmT=XWE=j8+5Y5ogKh4qNMpXCwAa+7wXEkBit0ujXw@mail.gmail.com>
 <87357pravt.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTn52FWRU9-ZqDLpTUe0BkLgttP3NOyk-PzxJbbX75cPg@mail.gmail.com>
Date:   Thu, 02 Feb 2023 09:32:13 +0100
Message-ID: <87ilgk79iq.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

>> > -               tmp += GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
>> > +               memcpy(&opcode, (void *)tmp, sizeof(kprobe_opcode_t));
>> > +               tmp += GET_INSN_LENGTH(opcode);
>>
>> I'd prefer sizeof(opcode).
> prefer sizeof(opcode) = 4
>
> GET_INSN_LENGTH(opcode) returns 2 or 4;

Sorry for being unclear. I was referring to the sizeof in the memcpy.
