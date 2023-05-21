Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7770AC7D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 07:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEUF1g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 01:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUF1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 01:27:34 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 May 2023 22:27:29 PDT
Received: from sypressi2.dnainternet.net (sypressi2.dnainternet.net [83.102.40.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59749FE
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 22:27:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id 77CE51382B;
        Sun, 21 May 2023 08:20:42 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.92
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from sypressi2.dnainternet.net ([83.102.40.154])
        by localhost (sypressi2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id bL63GhnjK1Ib; Sun, 21 May 2023 08:20:42 +0300 (EEST)
Received: from luumupuu2.dnainternet.net (luumupuu2.dnainternet.net [83.102.40.55])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id 18A8112DC9;
        Sun, 21 May 2023 08:20:42 +0300 (EEST)
Received: from basile.localnet (87-92-194-88.rev.dnainternet.fi [87.92.194.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by luumupuu2.dnainternet.net (Postfix) with ESMTPS id C6E8B74;
        Sun, 21 May 2023 08:20:39 +0300 (EEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v20 24/26] riscv: Add documentation for Vector
Date:   Sun, 21 May 2023 08:20:39 +0300
Message-ID: <2915864.UkfCvvTAve@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230518161949.11203-25-andy.chiu@sifive.com>
References: <20230518161949.11203-1-andy.chiu@sifive.com>
 <20230518161949.11203-25-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Le torstaina 18. toukokuuta 2023 19.19.47 EEST, vous avez écrit :
> This patch add a brief documentation of the userspace interface in
> regard to the RISC-V Vector extension.
> 
> Signed-off-by: Andy Chiu <andy.chiu at sifive.com>
> Reviewed-by: Greentime Hu <greentime.hu at sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen at sifive.com>
> Co-developed-by: Bagas Sanjaya <bagasdotme at gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme at gmail.com>
> ---
> Changelog v20:
>  - Drop bit-field repressentation and typos (Bj?rn)
>  - Fix document styling (Bagas)
> ---
>  Documentation/riscv/index.rst  |   1 +
>  Documentation/riscv/vector.rst | 120 +++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/riscv/vector.rst
> 
> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
> index 175a91db0200..95cf9c1e1da1 100644
> --- a/Documentation/riscv/index.rst
> +++ b/Documentation/riscv/index.rst
> @@ -10,6 +10,7 @@ RISC-V architecture
>      hwprobe
>      patch-acceptance
>      uabi
> +    vector
> 
>      features
> 
> diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
> new file mode 100644
> index 000000000000..5d37fd212720
> --- /dev/null
> +++ b/Documentation/riscv/vector.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +Vector Extension Support for RISC-V Linux
> +=========================================
> +
> +This document briefly outlines the interface provided to userspace by Linux
> in +order to support the use of the RISC-V Vector Extension.
> +
> +1.  prctl() Interface
> +---------------------
> +
> +Two new prctl() calls are added to allow programs to manage the enablement
> +status for the use of Vector in userspace:
> +
> +* prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> +
> +    Sets the Vector enablement status of the calling thread, where the
> control
> +    argument consists of two 2-bit enablement statuses and a bit
> for inheritance
> +    mode. Other threads of the calling process are
> unaffected.

I somewhat wonder who is/are the intended users of this new prctl(). Are they 
the run-time (libc)? The main program? Libraries using RVV internally (think 
OpenSSL, Nettle, FFmpeg, etc)? The init system?

Library code doesn't typically know how stacks are allocated and how signal 
are handled (on alternate or normal stacks), since signal handlers are 
process-global state. So I figure that libraries should keep off off this one.

Conversely, it would be impractical for programs to call a Linux-specific RISC-
V-specific in or around their main(). And then libc presumably should not 
override the configured policy that comes from sysctl or from the parent 
process.

So I guess that that leaves just the init system (in a broad sense) then?

In any case, I think the intended use should be clarified with proper usage 
guidelines. Otherwise, what I bet happens is RVV-capable libraries just 
blindly invoke the prctl() to "enable RVV", deafeating the purpose of having 
the prctl() in the first place.

-- 
Rémi Denis-Courmont
http://www.remlab.net/



