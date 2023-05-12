Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BB700EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjELSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjELSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:41:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A60BEC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:41:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24ded4b33d7so7104099a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683916880; x=1686508880;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/koMj+9kCWnn+HpYnU02beKNw32OHAll5JRoBttwWow=;
        b=UIhGNBCTmqrch9vZbwJdVHFCubylnX3lcJyBGWavwa7JY8D/CttT9kGCDbOafsAU5t
         vRGkZetPBOTBep0hAclU+TvrJrsGAcm/cmzfx87RHZxbSOm/1zOHCe1nI8Z1CWv1Ps9D
         D952EwlqaD3t3yacv+04O0gQbGqwleDPiwJAfoDvrdUT6jNeoX47UMmTa5Nhrxp9KLTu
         JlBCktj76+eSbrUIG9171EIYm1HesTFO1GehE0SGP7Zz4cud4wCc0eSKdVsUSQ1gmH6f
         qpkn9CtmJbzw5p3uYmUZ0UnZpWrgxx2rYRHTfZBYjywgnOZqECdRQJFMHKa48i7ms19Q
         y94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916880; x=1686508880;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/koMj+9kCWnn+HpYnU02beKNw32OHAll5JRoBttwWow=;
        b=JKm2A/4plMiMu9xMtg4BNydT3AYfSXcO251i168B6UNfXTRFVG3xOlIkS9RtML56sY
         jkgwbhs2vshNPY3CnjZ7rrR5m0aj7F9+plawwaj+N6IbTe6Dc6pHmvoaV/dNYd2+ecOG
         198NanzEswVUO5Y1NPOEBVDamnx0j/Yli9YAXy8ow9dPCAyPV0zcW/IeVRbH2L67dkn3
         rBXsHeoNoPLf14OEMT44VA/eIwXbPYcgS+8Wfha+wqEpY4JiIXcDUxNGN9LjHJsF36dh
         8Skj7sWm1psRjJWDKauYneiSNHXDGc7smmHOJ3YXGBpyvwBMar+NJ7/DoJQkAG7csGqm
         VPdw==
X-Gm-Message-State: AC+VfDxBJ/oFiTn1hKjV6/N/H4+2znaD2jvFo0yCgvEo4JlPwVX/qw8P
        ziuv8uq9R0roB+RopZxFzxPtSQ==
X-Google-Smtp-Source: ACHHUZ7tzMVQBdyjPy08WAKw09bAKD7sofw01RBIRabRo3XqbykGfqUcjR5vOU1bPn+AEZQv0/dWSA==
X-Received: by 2002:a17:90a:ea90:b0:24d:ee3f:b682 with SMTP id h16-20020a17090aea9000b0024dee3fb682mr24863163pjz.35.1683916880378;
        Fri, 12 May 2023 11:41:20 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a020300b00250c1392ed3sm6500634pjc.55.2023.05.12.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:41:19 -0700 (PDT)
Date:   Fri, 12 May 2023 11:41:19 -0700 (PDT)
X-Google-Original-Date: Fri, 12 May 2023 11:40:58 PDT (-0700)
Subject:     Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
In-Reply-To: <87ttwi91g0.fsf@igel.home>
CC:     alex@ghiti.fr, alexghiti@rivosinc.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-c528747d-5f47-4e42-b6db-f9db4e756ff9@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 11:18:23 PDT (-0700), schwab@linux-m68k.org wrote:
> On Mai 09 2023, Alexandre Ghiti wrote:
>
>> On 5/9/23 21:07, Andreas Schwab wrote:
>>> That does not work with UEFI booting:
>>>
>>> Loading Linux 6.4.0-rc1-1.g668187d-default ...
>>> Loading initial ramdisk ...
>>> Unhandled exception: Instruction access fault
>>> EPC: ffffffff80016d56 RA: 000000008020334e TVAL: 0000007f80016d56
>>> EPC: ffffffff002d1d56 RA: 00000000004be34e reloc adjusted
>>> Unhandled exception: Load access fault
>>> EPC: 00000000fff462d4 RA: 00000000fff462d0 TVAL: ffffffff80016d56
>>> EPC: 00000000802012d4 RA: 00000000802012d0 reloc adjusted
>>>
>>> Code: c825 8e0d 05b3 40b4 d0ef 0636 7493 ffe4 (d783 0004)
>>> UEFI image [0x00000000fe65e000:0x00000000fe6e3fff] '/efi\boot\bootriscv64.efi'
>>> UEFI image [0x00000000daa82000:0x00000000dcc2afff]
>>>
>>
>> I need more details please, as I have a UEFI bootflow and it works great
>> (KASLR is based on a relocatable kernel and works fine in UEFI too).
>
> It also crashes without UEFI.  Disabling CONFIG_RELOCATABLE fixes that.
> This was tested on the HiFive Unmatched board.
> The kernel image I tested is available from
> <https://download.opensuse.org/repositories/Kernel:/HEAD/RISCV/>.  The
> same kernel with CONFIG_RELOCATABLE disabled is available from
> <https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/kernel/standard/>.

Sorry I missed this earlier, there's been some other reports of boot 
failures on rc1 showing up but those were all a lot more vague.  Just 
setting CONFIG_RELOCATABLE=y doesn't manifest a boot failure on QEMU on 
my end and I don't have an UNmatched floating around.

Alex says he's going to look into it (and IIRC he has my Unmatched...).
