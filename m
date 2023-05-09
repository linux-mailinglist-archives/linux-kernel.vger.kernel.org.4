Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE96FCE43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEITIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEITIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:08:00 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE840C8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:07:57 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4QG72v0NH2z1r2sF;
        Tue,  9 May 2023 21:07:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4QG72t5sZZz1qqlS;
        Tue,  9 May 2023 21:07:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id yso-XuuckmCF; Tue,  9 May 2023 21:07:49 +0200 (CEST)
X-Auth-Info: w4NQfO3soUsw8RkOB5e7u4hvvdQvUWQgRbXNQVjJq0PodgIkJvk8KeWFGS7X8Z2g
Received: from igel.home (aftr-62-216-205-77.dynamic.mnet-online.de [62.216.205.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 May 2023 21:07:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 463252C1D3C; Tue,  9 May 2023 21:07:49 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
In-Reply-To: <20230215143626.453491-2-alexghiti@rivosinc.com> (Alexandre
        Ghiti's message of "Wed, 15 Feb 2023 15:36:24 +0100")
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
        <20230215143626.453491-2-alexghiti@rivosinc.com>
X-Yow:  I want EARS!  I want two ROUND BLACK EARS to make me feel warm 'n
 secure!!
Date:   Tue, 09 May 2023 21:07:49 +0200
Message-ID: <87wn1h5nne.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That does not work with UEFI booting:

Loading Linux 6.4.0-rc1-1.g668187d-default ...
Loading initial ramdisk ...
Unhandled exception: Instruction access fault
EPC: ffffffff80016d56 RA: 000000008020334e TVAL: 0000007f80016d56
EPC: ffffffff002d1d56 RA: 00000000004be34e reloc adjusted
Unhandled exception: Load access fault
EPC: 00000000fff462d4 RA: 00000000fff462d0 TVAL: ffffffff80016d56
EPC: 00000000802012d4 RA: 00000000802012d0 reloc adjusted

Code: c825 8e0d 05b3 40b4 d0ef 0636 7493 ffe4 (d783 0004)
UEFI image [0x00000000fe65e000:0x00000000fe6e3fff] '/efi\boot\bootriscv64.efi'
UEFI image [0x00000000daa82000:0x00000000dcc2afff]

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
