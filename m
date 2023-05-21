Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2570AC86
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 07:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjEUFiU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUFiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 01:38:18 -0400
Received: from tulikuusama2.dnainternet.net (tulikuusama2.dnainternet.net [83.102.40.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0912B
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 22:38:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 58B8820A1D;
        Sun, 21 May 2023 08:38:15 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.92
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from tulikuusama2.dnainternet.net ([83.102.40.151])
        by localhost (tulikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id R8ZWNftgSxvj; Sun, 21 May 2023 08:38:15 +0300 (EEST)
Received: from omenapuu2.dnainternet.net (omenapuu2.dnainternet.net [83.102.40.54])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 1ADF5208D5;
        Sun, 21 May 2023 08:38:15 +0300 (EEST)
Received: from basile.localnet (87-92-194-88.rev.dnainternet.fi [87.92.194.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by omenapuu2.dnainternet.net (Postfix) with ESMTPS id C19BC204;
        Sun, 21 May 2023 08:38:12 +0300 (EEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace vector
 management
Date:   Sun, 21 May 2023 08:38:12 +0300
Message-ID: <5677700.DvuYhMxLoT@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230518161949.11203-21-andy.chiu@sifive.com>
References: <20230518161949.11203-1-andy.chiu@sifive.com>
 <20230518161949.11203-21-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Le torstaina 18. toukokuuta 2023 19.19.43 EEST, vous avez écrit :
> This patch add two riscv-specific prctls, to allow usespace control the
> use of vector unit:
> 
>  * PR_RISCV_V_SET_CONTROL: control the permission to use Vector at next,
>    or all following execve for a thread. Turning off a thread's Vector
>    live is not possible since libraries may have registered ifunc that
>    may execute Vector instructions.
>  * PR_RISCV_V_GET_CONTROL: get the same permission setting for the
>    current thread, and the setting for following execve(s).

So far the story was that if the nth bit in the ELF HWCAP auxillary vector was 
set, then the nth single lettered extension was supported. There is already 
userspace code out there that expects this of the V bit. (I know I have 
written such code, and I also know others did likewise.) This is how it 
already works for the D and F bits.

Admittedly, upstream Linux has never ever set that bit to this day. But still, 
if we end up with the bit set in a process that has had V support disabled by 
the parent (or the sysctl), existing userspace will encounter SIGILL and 
break.

IMO, the bit must be masked not only whence the kernel lacks V support (as 
PATCH 02 does), but also if the process starts with V disabled.

There are two ways to achieve this:
1) V is never ever set, and userspace is forced to use hwprobe() instead.
2) V is set only in processes starting with V enabled (and it's their own 
fault if they disabled it in future child threads).

Br,

-- 
レミ・デニ-クールモン
http://www.remlab.net/



