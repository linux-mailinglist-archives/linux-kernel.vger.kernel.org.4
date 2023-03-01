Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545086A670D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCAEmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCAEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:42:50 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BCF37F27
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677645769; x=1709181769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8XAiocMESlyEQB3/IA8FOwC8IwIUE9dV7mZk2taKSqk=;
  b=HkTK+DCrE2sC20ExfZwVkKCGAfjgYK0jjc6JVvorxNOaebye0ApVMu85
   vOklKg6UNqtn/KHdqwAyjon449gIfhZF8uuFQKSNAuO/AInBQcoKtNnTR
   Ey49UC/omSl5iYb7iHvPfMApZhk9pu/8P/gwaEb+S+nPiDsbkioWEISOw
   97DGLX/tc1WDog/NPZaJT8nNXpqzWzucD5H/mXctvnp1b45YYcJLFFNnV
   3MnijAETcQ/TWzIrJ1DKxTfz9OM+ZwMUG1nvcl+LqY4wsdzDtiww8UaAK
   HUHlr791DSBnFFOx3dPJk6M0EPYDsSLIY6K2oWLLFpreHgY86ZXoEA/vE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,223,1673884800"; 
   d="scan'208";a="328813449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 12:42:47 +0800
IronPort-SDR: tYg7SGWr1HZ64Ab5+Bbw0D4plPs7PGvM2hSk7hViVB6DolZn3U9siToxTSrTcJgISH1xuKN7a3
 yOy6/Q90cKRcCr7j8t2D+XSVfhQOxkuVxCc0unxuopmAXyinDHer0wh3ehBZymA89/SMgmr05g
 JQfTVe36S6BO2976tI6868Y91jorLE6dG5pO9w3kRaK/HZyqlhMqDhXWEPonvGNM2PTim+ZTdj
 M/jRDGgJzS50ZjkbbjzmcaaQvM0dr4zht4ATc3NUJbDnzHvxRFRbj9vCjnfir4hUkZ4dTgFwaF
 6WU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 19:59:37 -0800
IronPort-SDR: WQkFuS7wFPhdYOKzTy5ViQf/fGKrF1k4d0tnwuq3miS4RSFEERR0QCcjINgvmxa8VibaIxsPiv
 P8lWKnLuo2r5KzdTeCTudGOBEEclbzpwyTHKlDi1P846jRoBmSmOhDmnZPgFHiXFWMo6SMAMtI
 5fz/w4x2y06j0/ZUGSbnkCZgpMq3H22auJomMsCeUkQpXEzZJ5w+dxUSBCgCoZGNt9JSQi7lCq
 nOnKXxYxamZgYiJNUL8PBBSPaJNrNe4khZcZyhIcEUblR62ZQ6/J8QR9F/MMNg/n6qlCAPQ030
 0fQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 20:42:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRM6Z6t3gz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:42:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677645765; x=1680237766; bh=8XAiocMESlyEQB3/IA8FOwC8IwIUE9dV7mZ
        k2taKSqk=; b=YicStjHF/bkaDIY+BCq9sFSKFwAR5vZ1XXw5KatFKMHzU+Jj2Hc
        w89sPKOiCqCpUXRLbuTQkcRqdkKinrC2SgO+rMh/F3d5Yw2fzb6VSvma0iObqwii
        bXpiSAk7mP2a/3G0uOhwnGzoGNQlTKaxQjxbfCudxk0oer+VyML5l9SFHE/FCS1I
        WJbeWnaT5VVj+5qjllUHftsz2MNAZjQgk3Aw6ECQ/R+O1+7kHJZ2CqrwWzGGYJjr
        mTFdUxR7ifbEO/FVUvsW2a5IDn+i/71NMPUkbwcoqIDP4qN0wRjnZ72KhJ9SjydD
        nZYjNC67bUVYoHnefAItYapQHGV5jZp2I8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wv9Xj2dN2gkX for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 20:42:45 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRM6X04XNz1RvLy;
        Tue, 28 Feb 2023 20:42:43 -0800 (PST)
Message-ID: <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
Date:   Wed, 1 Mar 2023 13:42:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 13:07, Randy Dunlap wrote:
> Hi--
> 
> On 2/28/23 16:26, Jesse Taube wrote:
>> This patch-set aims to add NOMMU support to RV32.
>> Many people want to build simple emulators or HDL
>> models of RISC-V this patch makes it possible to
>> run linux on them.
>>
>> Yimin Gu is the original author of this set.
>> Submitted here:
>> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
>>
>> Though Jesse T rewrote the Dconf.
> 
> Dconf?
> 
>>
>> The new set:
>> https://lists.buildroot.org/pipermail/buildroot/2022-December/658258.html
>> ---
>> V1->V2:
>>  - Add Conor's clock patch for implicit div64
>>  - Fix typo in commit title 3/3
>>  - Fix typo in commit description 2/3
>> V2->V3
>>  - Change from defconfig file to a PHONY config
>> ---
> 
> Is this 'rv32_nommu_virt_defconfig' target the only build target
> that is supported?
> 
> I ask because I applied the 3 patches and did 25 randconfig builds.
> 5 of them failed the same way:
> 
> riscv32-linux-ld: drivers/soc/canaan/k210-sysctl.o: in function `k210_soc_early_init':
> k210-sysctl.c:(.init.text+0x78): undefined reference to `k210_clk_early_init'

Arg. Forgot about that. k210 is rv64 only and while the clk driver could still
compile test with rv32 (or any arch), that driver provides the
k210_clk_early_init() function which is called very early in the boot process
from k210_soc_early_init(), which is an SOC_EARLY_INIT_DECLARE() call. The
problem may be there. Probably should be disabled for rv32 if no SoC need that
sort of early init call.

> 
> because
> # CONFIG_COMMON_CLK_K210 is not set
> 
> 
> Maybe SOC_CANAAN needs some more selects for required code?
> 
>> Conor Dooley (1):
>>   clk: k210: remove an implicit 64-bit division
>>
>> Jesse Taube (1):
>>   riscv: configs: Add nommu PHONY defconfig for RV32
>>
>> Yimin Gu (1):
>>   riscv: Kconfig: Allow RV32 to build with no MMU
>>
>>  arch/riscv/Kconfig     | 5 ++---
>>  arch/riscv/Makefile    | 4 ++++
>>  drivers/clk/clk-k210.c | 2 +-
>>  3 files changed, 7 insertions(+), 4 deletions(-)
>>
> 

-- 
Damien Le Moal
Western Digital Research

