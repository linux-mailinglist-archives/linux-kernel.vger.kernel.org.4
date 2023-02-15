Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65694697A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjBOLBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjBOLBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:01:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4F37B54
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 311AFB8211B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A77C433D2;
        Wed, 15 Feb 2023 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676458880;
        bh=IMpmER3plSrPEyPwHBO12hKRit2F+CRHQYxnU1U6els=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rqBMGlSiJgKY90EQOFovxSh9ADuPOUNWZE+X8gR/i0cEFSHTbrgeywn70TtcxC0UA
         3ZFJXPubTVzGnIC4YT+KbY0JByUFpPwssZ3d8KmDhypEQdZlxF3VMh5ie1ZU2p7G/Z
         e2T4e4Hi8xjpH6KrZJhgnJvza88+U00MkKN3KX25JEtrwFobB+TZM900Qvk6jWDXGY
         YXV1urK78wjt8ZESoCp53dq5xuCg1z06hXDeUFHaW+6T7Ut5HGAQ16otXKyf7416lW
         2Tv8aSUgE3+xdBkO84wNS9CsCo05PkTX8j4c2a6MepFonn9+aG9beW3kiyvHZ2tE0j
         tnYvWZcHLudBg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Changbin Du <changbin.du@huawei.com>, Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hui Wang <hw.huiwang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v4] riscv: patch: Fixup lockdep warning in stop_machine
In-Reply-To: <20230215034532.xs726l7mp6xlnkdf@M910t>
References: <20230202114116.3695793-1-changbin.du@huawei.com>
 <Y+wlula69tYrSZjQ@spud>
 <CAJF2gTQBiE7d_RiNjxoyx9gppYQxXBLeNhEsX04tjtjM_56gRQ@mail.gmail.com>
 <20230215034532.xs726l7mp6xlnkdf@M910t>
Date:   Wed, 15 Feb 2023 12:01:17 +0100
Message-ID: <87wn4j42gy.fsf@all.your.base.are.belong.to.us>
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

Changbin Du <changbin.du@huawei.com> writes:

> On Wed, Feb 15, 2023 at 09:24:33AM +0800, Guo Ren wrote:
>> On Wed, Feb 15, 2023 at 8:22 AM Conor Dooley <conor@kernel.org> wrote:
>> >
>> > Hey Changbin,
>> >
>> > On Thu, Feb 02, 2023 at 07:41:16PM +0800, Changbin Du wrote:
>> > > The task of ftrace_arch_code_modify(_post)_prepare() caller is
>> > > stop_machine, whose caller and work thread are of different tasks. The
>> > > lockdep checker needs the same task context, or it's wrong. That means
>> > > it's a bug here to use lockdep_assert_held because we don't guarantee
>> > > the same task context.
>> I'm trying to delete all stop_machine in riscv, from ftrace to kprobe.
>> When I have done, we needn't this patch.
>>
> Which approch would you use? I looked through the riscv-spec, but didn't find any
> description abount concurrent modification and execution.

CMODX is not specified for RISC-V yet, unfortunately.

This has been discussed here [1]. Maybe we can start with stating for
which implementations Guo's approach work?

[1] https://lore.kernel.org/all/CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com/
