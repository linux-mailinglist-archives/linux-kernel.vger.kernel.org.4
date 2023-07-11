Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AEA74EC76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGKLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGKLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:14:17 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726998
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:14:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4EF6240005;
        Tue, 11 Jul 2023 11:14:10 +0000 (UTC)
Message-ID: <a7bb09c9-870a-d8f2-23c3-7f6fd2c68e2b@ghiti.fr>
Date:   Tue, 11 Jul 2023 13:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] riscv: correct pt_level name via pgtable_l5/4_enabled
Content-Language: en-US
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        bjorn@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230711105202.842408-1-suagrfillet@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230711105202.842408-1-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,


On 11/07/2023 12:52, Song Shuai wrote:
> The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
> But if downgrading page mode from kernel cmdline in 64BIT, it will
> give a wrong name.
>
> Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
> that should be "PGD":
>
> 0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         3G PUD     D A G . . W R V
>
> So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.
>
> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>   arch/riscv/mm/ptdump.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 20a9f991a6d7..cfdd327981ee 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -384,6 +384,11 @@ static int __init ptdump_init(void)
>   
>   	kernel_ptd_info.base_addr = KERN_VIRT_START;
>   
> +#ifdef CONFIG_64BIT
> +	pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
> +	pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
> +#endif


You don't need the #ifdef here as pgtable_lX_enabled are always declared.


> +
>   	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
>   		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
>   			pg_level[i].mask |= pte_bits[j].mask;


The Fixes tag is wrong to me, if satp mode is restricted by the hardware 
itself (not from the command line), the same problem happens. Maybe that 
should be the sv48 introduction patch? Or the sv57? It will be more 
cumbersome to backport with the sv48 introduction though as this patch 
won't apply as-is.

Otherwise, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

