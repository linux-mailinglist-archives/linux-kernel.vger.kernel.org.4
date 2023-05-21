Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2277B70AD25
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjEUJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C32CF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 02:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025FE60DE8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 09:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED62C433EF;
        Sun, 21 May 2023 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684660532;
        bh=J6QGR+R9nb0MwoXrY/wVlgZDi2AoSc1og9Jf61EJyDc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YVPYT6UHU0h3BbC7xXT3xJzABOj9G5nhlyVQ96KFJ6bCDcF+a0srZJb7Egs0sxAQf
         o9IrjNXTV6kNdB9CcZddF4aNPVGZP3gkBSs1zmS1yWBVzDCqAnv2Y+1KlGn0R+Ps88
         RorQaM2o2TMrWa93tO3Ahwoh7ol3IvMAW1taijxPc2tps0W0Eyz8m/xWiqe4MsY2uC
         jN7aQSIRMz1ENygz/CLpJzSK9llKsaiLK48NAwY7v9fmhTpl+BELcfYKD6U+EFgIGx
         ogJgLpod1Mhgb8GxEEYcM0D7M0yLakjf5TDyzfuk2Hd7GUo+Xt472eQLaLeCPNvvjb
         /7AkIvUWlWlQA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
In-Reply-To: <87zg62eqm4.fsf@all.your.base.are.belong.to.us>
References: <20230512145737.985671-1-bjorn@kernel.org>
 <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
 <87zg62eqm4.fsf@all.your.base.are.belong.to.us>
Date:   Sun, 21 May 2023 11:15:29 +0200
Message-ID: <87lehikpu6.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Anshuman!

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> David Hildenbrand <david@redhat.com> writes:
>
>> On 12.05.23 16:57, Bj=C3=B6rn T=C3=B6pel wrote:
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>>=20
>>> Memory Hot(Un)Plug support for the RISC-V port
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [...]
>
>>
>> Cool stuff! I'm fairly busy right now, so some high-level questions upfr=
ont:
>
> No worries, and no rush! I'd say the v1 series was mainly for the RISC-V
> folks, and I've got tons of (offline) comments from Alex -- and with
> your comments below some more details to figure out.

One of the major issues with my v1 patch is around init_mm page table
synchronization, and that'll be part of the v2.

I've noticed there's a quite a difference between x86-64 and arm64 in
terms of locking, when updating (add/remove) the init_mm table. x86-64
uses the usual page table locking mechanisms (used by the generic
kernel functions), whereas arm64 does not.

How does arm64 manage to mix the "lock-less" updates (READ/WRITE_ONCE,
and fences in set_p?d+friends), with the generic kernel ones that uses
the regular page locking mechanism?

I'm obviously missing something about the locking rules for memory hot
add/remove... I've been reading the arm64 memory hot add/remove
series, but none the wiser! ;-)


Bj=C3=B6rn
