Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE969E33C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjBUPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjBUPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:18:50 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931139775
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:18:42 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 2661B2000C;
        Tue, 21 Feb 2023 15:18:35 +0000 (UTC)
Message-ID: <e8b16a7b-8221-2e36-bc8f-92059d083b6b@ghiti.fr>
Date:   Tue, 21 Feb 2023 16:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] scripts/decodecode: Add support for RISC-V
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20230119074738.708301-1-bjorn@kernel.org>
 <20230119074738.708301-3-bjorn@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230119074738.708301-3-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

On 1/19/23 08:47, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> RISC-V has some GNU disassembly quirks, e.g. it requires '-D' to
> properly disassemble .2byte directives similar to Arm [1]. Further,
> GNU objdump groups RISC-V instruction by 2 or 4 byte chunks, instead
> doing byte-for-byte.
>
> Add the required switches, and translate from short/word to bytes when
> ARCH is "riscv".
>
> An example how to invoke decodecode for RISC-V:
>    $ echo 'Code: bf45 f793 1007 f7d9 50ef 37af d541 b7d9 7097 00c8 (80e7)
>    6140' | AFLAGS="-march=rv64imac_zicbom_zihintpause"  \
>    ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- ./scripts/decodecode
>    Code: bf45 f793 1007 f7d9 50ef 37af d541 b7d9 7097 00c8 (80e7) 6140
>    All code
>    ========
>       0:   bf45                    c.j     0xffffffffffffffb0
>       2:   1007f793                andi    a5,a5,256
>       6:   f7d9                    c.bnez  a5,0xffffffffffffff94
>       8:   37af50ef                jal     ra,0xf5382
>       c:   d541                    c.beqz  a0,0xffffffffffffff94
>       e:   b7d9                    c.j     0xffffffffffffffd4
>      10:   00c87097                auipc   ra,0xc87
>      14:*  614080e7                jalr    ra,1556(ra) # 0xc87624          <-- trapping instruction
>
>    Code starting with the faulting instruction
>    ===========================================
>       0:   614080e7                jalr    ra,1556(ra)
>
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=10263
>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   scripts/decodecode | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/decodecode b/scripts/decodecode
> index b28fd2686561..8fe71c292381 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -93,6 +93,11 @@ disas() {
>   		${CROSS_COMPILE}strip $t.o
>   	fi
>   
> +	if [ "$ARCH" = "riscv" ]; then
> +		OBJDUMPFLAGS="-M no-aliases --section=.text -D"
> +		${CROSS_COMPILE}strip $t.o
> +	fi
> +
>   	if [ $pc_sub -ne 0 ]; then
>   		if [ $PC ]; then
>   			adj_vma=$(( $PC - $pc_sub ))
> @@ -126,8 +131,13 @@ get_substr_opcode_bytes_num()
>   	do
>   		substr+="$opc"
>   
> +		opcode="$substr"
> +		if [ "$ARCH" = "riscv" ]; then
> +			opcode=$(echo $opcode | tr ' ' '\n' | tac | tr -d '\n')
> +		fi
> +
>   		# return if opcode bytes do not match @opline anymore
> -		if ! echo $opline | grep -q "$substr";
> +		if ! echo $opline | grep -q "$opcode";
>   		then
>   			break
>   		fi


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks, that's very useful!

Alex

