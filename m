Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33A873B528
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFWKWy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjFWKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:22:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE95172D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:22:46 -0700 (PDT)
Received: from i53875bdf.versanet.de ([83.135.91.223] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qCdw4-0005ig-99; Fri, 23 Jun 2023 12:22:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Stefan O'Rear <sorear@fastmail.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Date:   Fri, 23 Jun 2023 12:22:35 +0200
Message-ID: <1961474.usQuhbGJ8B@diego>
In-Reply-To: <c01ee919-9abb-4796-9ed4-9bb4565dc863@app.fastmail.com>
References: <20230228215435.3366914-1-heiko@sntech.de> <9132027.CDJkKcVGEf@diego>
 <c01ee919-9abb-4796-9ed4-9bb4565dc863@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 23. Juni 2023, 05:06:44 CEST schrieb Stefan O'Rear:
> On Thu, Jun 22, 2023, at 4:35 PM, Heiko Stübner wrote:
> > Am Donnerstag, 22. Juni 2023, 20:58:37 CEST schrieb Stefan O'Rear:
> >> Are you aware of "3.7. Vector Fixed-Point Fields in fcsr" in
> >> riscv-v-spec-0.7.1.pdf?
> >
> > oh wow, thanks a lot for that pointer, now I understand your concern.
> >
> > So in vector-0.7.1 fcsr[10:9] mirrors vxrm and fcsr[8] mirrors vxsat.
> >
> >
> > On a positive note, the T-Head cores seem to not implement the full
> > vector 0.7.1 specification after all, in the documentation I have [0]
> > fcsr[31:8] are declared as "0" and uppermost bits are [7:5] for the "frm"
> > field.
> 
> Given that the pdf you linked does not mention any vector CSRs, I am not
> confident that it provides a complete and accurate description of vector
> functionality in other registers for the C906 with vector extension.
> 
> Assuming that you have access to such a chip, I would be much happier with
> the proposed "just a comment" approach if our understanding of the behavior
> were confirmed on hardware (specifically: csr_write(CSR_FCSR, 0x700) should
> not affect csr_read(CSR_VXRM) or csr_read(CSR_VXSAT)).

For one, you're right that I should definitly try to confirm this on hardware :-) .

But also the VXSAT and VXRM CSRs are actually documented in that pdf
on page 335


Heiko


> 
> -s
> 
> > So I guess a code comment should suffice to explain :-)
> >
> >
> > Regards
> > Heiko
> >
> >
> > [0] 
> > https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
> > 16.3.1.3 浮点控制状态寄存器（FCSR） on page 334
> 




