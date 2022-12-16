Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD73764F1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLPTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:45:31 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C423F02D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:45:29 -0800 (PST)
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1p6Ge1-00BQ4s-8w; Fri, 16 Dec 2022 19:45:21 +0000
MIME-Version: 1.0
Date:   Fri, 16 Dec 2022 19:45:21 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
In-Reply-To: <20221216185012.2342675-1-abdulras@google.com>
References: <20221216185012.2342675-1-abdulras@google.com>
Message-ID: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-16 18:50, Saleem Abdulrasool wrote:
> The compiler is free to generate vectorized operations for zero'ing
> memory.  The kernel does not use the vector unit on RISCV, similar to
> architectures such as x86 where we use `-mno-mmx` et al to prevent the
> implicit vectorization.  Perform a similar check for
> `-mno-implicit-float` to avoid this on RISC-V targets.

I'm not sure if we should be emitting either of the vector or floating
point instrucitons in the kernel without explicitly marking the section
of code which is using them such as specific accelerator blocks.

-- 
Ben
