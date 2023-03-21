Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67C6C3503
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCUPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCUPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:04:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65B24710
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:04:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 107)
        id BFDB168C7B; Tue, 21 Mar 2023 16:04:07 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from blackhole.lan (p5b2ece7e.dip0.t-ipconnect.de [91.46.206.126])
        by verein.lst.de (Postfix) with ESMTPSA id 078CC6732D;
        Tue, 21 Mar 2023 16:03:52 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:03:49 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Li Zhengyu <lizhengyu3@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Li Huafei <lihuafei1@huawei.com>,
        "Liao Chang" <liaochang1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liubao918@huawei.com>
Subject: Re: [PATCH] riscv: relocate R_RISCV_CALL_PLT in kexec_file
Message-ID: <20230321160349.3b3a46df@blackhole.lan>
In-Reply-To: <e02fdfce-4574-8e7e-ec96-8e8eaa4067bc@huawei.com>
References: <20230310182726.GA25154@lst.de>
        <e02fdfce-4574-8e7e-ec96-8e8eaa4067bc@huawei.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 11:13:17 +0800
Li Zhengyu <lizhengyu3@huawei.com> wrote:

> On Fri, 10 Mar 2023 19:27:03 +0100, Torsten Duwe <duwe@lst.de> wrote:
> > Depending on the toolchain (here: gcc-12, binutils-2.40) the
> > relocation entries for function calls are no longer R_RISCV_CALL, but
> > R_RISCV_CALL_PLT. When trying kexec_load_file on such kernels, it will
> > fail with
> >
> >   kexec_image: Unknown rela relocation: 19
> >   kexec_image: Error loading purgatory ret=-8
> >
> > The binary code at the call site remains the same, so tell
> > arch_kexec_apply_relocations_add() to handle _PLT alike.
> 
> R_RISCV_CALL has already been deprecated, and replaced by R_RISCV_CALL_PLT.
> 
> See Enum 18-19 in Table 3. Relocation types from 
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-elf.adoc 
> .
> 
> It was deprecated in ("Deprecated R_RISCV_CALL, prefer 
> R_RISCV_CALL_PLT") 
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7a0ec17023c9389cbd70b1dbc1b0
> 
> >
> > fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > Cc: stable@vger.kernel.org
> >
> > ---
> > --- a/arch/riscv/kernel/elf_kexec.c
> > +++ b/arch/riscv/kernel/elf_kexec.c
> > @@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >   		 * sym, instead of searching the whole relsec.
> >   		 */
> >   		case R_RISCV_PCREL_HI20:
> > +		case R_RISCV_CALL_PLT:
> >   		case R_RISCV_CALL:
> >   			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
> >   				 ENCODE_UJTYPE_IMM(val - addr);
> >
> > .
> 
> Palmer, please apply these references to the commit message.
> 
> Reviewed-by: Li Zhengyu <lizhengyu3@huawei.com>
> 

Ping?
