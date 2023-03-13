Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEE6B6DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCMDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMDOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:14:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56542A17A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:14:47 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PZhWp2WmTzSkfF;
        Mon, 13 Mar 2023 11:11:34 +0800 (CST)
Received: from [10.35.19.253] (10.35.19.253) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 11:13:17 +0800
Message-ID: <e02fdfce-4574-8e7e-ec96-8e8eaa4067bc@huawei.com>
Date:   Mon, 13 Mar 2023 11:13:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] riscv: relocate R_RISCV_CALL_PLT in kexec_file
To:     Torsten Duwe <duwe@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liubao918@huawei.com>
References: <20230310182726.GA25154@lst.de>
From:   Li Zhengyu <lizhengyu3@huawei.com>
In-Reply-To: <20230310182726.GA25154@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.35.19.253]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 19:27:03 +0100, Torsten Duwe <duwe@lst.de> wrote:
> Depending on the toolchain (here: gcc-12, binutils-2.40) the
> relocation entries for function calls are no longer R_RISCV_CALL, but
> R_RISCV_CALL_PLT. When trying kexec_load_file on such kernels, it will
> fail with
>
>   kexec_image: Unknown rela relocation: 19
>   kexec_image: Error loading purgatory ret=-8
>
> The binary code at the call site remains the same, so tell
> arch_kexec_apply_relocations_add() to handle _PLT alike.

R_RISCV_CALL has already been deprecated, and replaced by R_RISCV_CALL_PLT.

See Enum 18-19 in Table 3. Relocation types from 
https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-elf.adoc 
.

It was deprecated in ("Deprecated R_RISCV_CALL, prefer 
R_RISCV_CALL_PLT") 
https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7a0ec17023c9389cbd70b1dbc1b0

>
> fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Cc: stable@vger.kernel.org
>
> ---
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>   		 * sym, instead of searching the whole relsec.
>   		 */
>   		case R_RISCV_PCREL_HI20:
> +		case R_RISCV_CALL_PLT:
>   		case R_RISCV_CALL:
>   			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
>   				 ENCODE_UJTYPE_IMM(val - addr);
>
> .

Palmer, please apply these references to the commit message.

Reviewed-by: Li Zhengyu <lizhengyu3@huawei.com>

