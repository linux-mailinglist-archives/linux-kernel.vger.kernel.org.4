Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4EA6415FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLCKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLCKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:38:57 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7759FC8;
        Sat,  3 Dec 2022 02:38:55 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC32B723;
        Sat,  3 Dec 2022 10:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC32B723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670063935; bh=AcvliI0lkNH/1gvzi1wuMUNaRNRaEKyutJ7x8ZgHioo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CHCA02xMNduX7UNI7ipKcoRy8ZCNWX2Db2OFXlJYv4tgtTeJeXByBswOeU1PEWu1/
         KkGWdqySGqwF+0OGkLS+Oy5Ept6k1UJTHkIq+AUQcj+rnsGSq0HVHiNKweDwUHUOp9
         XOn/rlfrHkfD2moHIkXbvLpOJVIg79/dY60f3XhyKDh64H1bG1P0EODCMnJ0QHWcWq
         EFJAVY3zjG+IzkFRVKdR+gQxRzx/F6nxhlpBkF2Mdgb3JOPRzMzk09DVaoZlySONlw
         AfA7jaUoLSmQaMOQZ1UD3f7ABR93ySW/3+osU1G+CFY948I4zGWUIHLpCtTB2moRmF
         EfsDMEAMKmINA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: note that counter access is part
 of the uABI
In-Reply-To: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
References: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
Date:   Sat, 03 Dec 2022 03:38:49 -0700
Message-ID: <87359wpy9y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Thu, 01 Dec 2022 05:51:10 PST (-0800), Conor Dooley wrote:
>> Commit 5a5294fbe020 ("RISC-V: Re-enable counter access from userspace")
>> fixed userspace access to CYCLE, TIME & INSTRET counters and left a nice
>> comment in-place about why they must not be restricted. Since we now
>> have a uABI doc in RISC-V land, add a section documenting it.
>>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> Based on an, as yet, unsent v2 of my other uABI changes. I don't expect
>> it to be applicable, just getting a patch into patchwork while I don't
>> forget about this.
>> ---
>>  Documentation/riscv/uabi.rst | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
>> index 8d2651e42fda..638ddce56700 100644
>> --- a/Documentation/riscv/uabi.rst
>> +++ b/Documentation/riscv/uabi.rst
>> @@ -3,6 +3,13 @@
>>  RISC-V Linux User ABI
>>  =====================
>>
>> +Counter access
>> +--------------
>> +
>> +Access to the CYCLE, TIME and INSTRET counters, now controlled by the SBI PMU
>> +extension, were part of the ISA when the uABI was frozen & so remain accessible
>> +from userspace.
>> +
>>  ISA string ordering in /proc/cpuinfo
>>  ------------------------------------
>>
>>
>> base-commit: 13ee7ef407cfcf63f4f047460ac5bb6ba5a3447d
>> prerequisite-patch-id: d17a9ffb6fcf99eb683728da98cd50e18cd28fe8
>> prerequisite-patch-id: 0df4127e3f4a0c02a235fea00bcb69cd94fabb38
>> prerequisite-patch-id: 171724b870ba212b714ebbded480269accd83733
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> I think I merged the last one of these, but if the doc folks pick it up 
> that's fine with me.  Otherwise I'll take it when it comes back around, 
> so folks have time to take a look.

"Doc folks" applied it, thanks. :)

jon
