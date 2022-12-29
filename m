Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389E6588A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiL2C0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiL2C02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:26:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6392112084
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:26:27 -0800 (PST)
Date:   Thu, 29 Dec 2022 02:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1672280785; bh=ma/Nzifri2/2lcnUbcJQtDKR1prjLqpoLwiGi4kse+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myggsIwD29wKaSzJi6/sb8Xw+bbmVxz3MLtgPg5fSSe1+I+h6J7PXpXpE5pClRZWV
         /f6wZQb2pW4TufWovV6AZ9KHILzJSSgGLnOtuVOm9tosf1rk9nsAvdbtb7YYXDzoYa
         l1cdGWdAxSkImXaXF50y8u4Sjotob/HurNR9l1cM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     linux@weissschuh.net, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
Message-ID: <20221229022622.khboqwfe23e7u2en@snowball.t-8ch.de>
References: <20221216-objtool-memory-v2-5-17968f85a464@weissschuh.net>
 <tencent_43594597A42ABAAF0EA365888306E8429F08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_43594597A42ABAAF0EA365888306E8429F08@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong,

On Thu, Dec 29, 2022 at 09:33:32AM +0800, Rong Tao wrote:
> Is this likely to cause most RELOC failures? As shown in the following
> example:
> 
> 	#include <bfd.h>
> 	#include <stdio.h>
> 
> 	int main(void)
> 	{
> 		printf("%d\n", BFD_RELOC_S12Z_OPR);
> 		return 0;
> 	}
> 
> The BFD_RELOC_S12Z_OPR equal to 2366.

I'm not familiar with libbfd, so please correct me if I'm wrong.

To me BFD_RELOC_S12Z_OPR looks like a value that is only used by libbfd.
objtool does not use libbfd.

The only values that objtools should see for the relocation types are
the R_* constants from elf.h as they are used by the compiler and linker
in the raw elf binary files.

These never exceed the value 255, one byte. Indeed they seem to have
been explicitly chosen like this.

$ grep 'define R_.*NUM' /usr/include/elf.h
#define R_68K_NUM	43
#define R_386_NUM	   44
#define R_SPARC_NUM		253
#define R_MIPS_NUM		128
#define R_ALPHA_NUM		46
#define R_ARM_NUM		256
#define R_390_NUM		62
#define R_CRIS_NUM		20
#define R_X86_64_NUM		43
#define R_MN10300_NUM		35
#define R_M32R_NUM		256	/* Keep this the last entry. */
#define R_TILEPRO_NUM		130
#define R_TILEGX_NUM		130
#define R_RISCV_NUM		59

These _NUM constants are the highest actually used values, plus one.
So all real values are smaller than 256.

Thomas
