Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2B6FFE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbjELBCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjELBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:02:48 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7297287
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:02:44 -0700 (PDT)
Date:   Fri, 12 May 2023 01:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hercules-ci.com;
        s=protonmail3; t=1683853360; x=1684112560;
        bh=eW8VYt649iHlSfC7rA85sOfcTbUxdoz43qnBQi+euQs=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=I92RvO7rmW9Owqcp3XwfOfWeAUaxO9tbBuw+hC9Cd0ijPbBpiBc1pI/ooLuz0qM9R
         oX8opZWoz+I84jfeOJ9OWxR6r1DfMuDeqSMrgkoPaslNsiJ7U7D3+YDULke69D5Y/L
         emOUvKTaXG4Qb3Tglps6pcNH2gtVIgzcMvPscNcLh2bcFDh1iMB1/jNqEtMaK2N2t9
         xTB/RYtjAXWJM5H0r5Umwy6gBbekCJc18cY9tFvLpCGaarwG1bGI5KcRfPH8oP3EVW
         eTJUTSip73c0TJkXnMoX6w+fZmrnrrLueY3Q02VLuEv6Ow1AmZKObOcnzt1OrhmfGc
         WQDcjELanrBxw==
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Snild Dolkow <snild@sony.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Robert Hensing <robert@hercules-ci.com>
Subject: Re: [Regression] mmap with MAP_32BIT randomly fails since 6.1
Message-ID: <190c5b1b-df67-eb54-1559-706ed4e5719a@hercules-ci.com>
Feedback-ID: 43583703:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that commit 58c5d0d6d522112577c7eeb71d382ea642ed7be4 causes
another regression of allocations with MAP_32BIT.
Reverting it fixes the reproducer from
https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.=
com/

Do you think this commit is somewhat safe to revert?

The following may be superfluous, but adds some context and might help
someone
find this thread. It merely confirms to the observation of this
regression in
https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.c=
amel@spotco.us/

 From what I can tell it also fixes my own use case, and

 =C2=A0- The program I maintain,
 =C2=A0=C2=A0 https://github.com/hercules-ci/hercules-ci-agent/issues/514

 =C2=A0- Another program, also Haskell:
 =C2=A0=C2=A0 https://github.com/aristanetworks/nix-serve-ng/issues/27

 =C2=A0- An FPGA interface process. I've found them because they list the s=
ame
 =C2=A0=C2=A0 commit id on their blog.
 =C2=A0=C2=A0 https://jia.je/software/2023/05/06/linux-regression-vivado-en=
/



On 3/2/23 19:43, Liam R. Howlett wrote:
> * Snild Dolkow <snild@sony.com> [230302 10:33]:
>> After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago, I
>> started getting (inconsistent) failures when building Android:
>> While it claims to be using 0x22 (MAP_PRIVATE | MAP_ANONYMOUS) for the
>> flags, it really uses 0x40 (MAP_32BIT) as well, as shown by strace:
>>

The same applies to the dynamic linker in the GHC Haskell runtime system.

It also uses MAP_32BIT, in its linker, and reports the error

ghc: mmap 4096 bytes at (nil): Cannot allocate memory


I hope this was a somewhat useful contribution to the regressions
thread. (also hi, I'm new here)

Cheers,

Robert Hensing


