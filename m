Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99E074F00C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGKNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjGKNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:23:49 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 06:23:47 PDT
Received: from mail.vlsi.fi (mail.vlsi.fi [195.197.254.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C5718D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:23:47 -0700 (PDT)
Received: from mail.vlsi.fi (localhost [127.0.0.1])
        by mail.vlsi.fi (Postfix) with ESMTP id EEDB917E1408
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:18:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=vlsi.fi; h=message-id:date
        :mime-version:to:from:subject:content-type
        :content-transfer-encoding; s=alpha; bh=19Ha4HfwVzaKUrbb13yyrSTI
        ms8=; b=Sm4OvDnqzvGhf8DH54ymobFeJ+lPelmonbAldfWs2JzkNaMWPIEvgXOW
        N8TEYSQuM/ljeHGrF3XY8WEFydgnTJTx9AA4NE5by6PJQHC+cWrFEwOb3j9+N7zw
        oZG+hhlR/z4Ef3YoSL5hWVM+bXdm/NxCpV0sPT99M6KVvUGNoNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vlsi.fi; h=message-id:date
        :mime-version:to:from:subject:content-type
        :content-transfer-encoding; q=dns; s=alpha; b=sSv3AjAID4XF8C+0an
        9JZi4+yvccfoxpAhXNJUHX4gV92B62lsZNTj2efMv+4/y8TW6Q2ly+io3HYmcYNi
        5fD3ndKJGo1X47XapoHdfc2s5zMPTqLqdc8f3zypDVnHokAZ7oeuKhhf9Nq3y7vb
        Pwqk4MYu2ogNZ0W/Vg95M0qBM=
Message-ID: <0831fc40-267d-f974-8785-d304265837d5@vlsi.fi>
Date:   Tue, 11 Jul 2023 16:18:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Mikko Saari <Mikko.Saari@vlsi.fi>
Subject: riscv pending interrupts freezes the kernel, fixing by csr_clear-call
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux! In earlier Linux Risc-V-patches (ultraembedded 4.20-kernel) 
there was interrupt handling implemented by following way in 
"linux/arch/riscv/kernel/irq.c".
-----------------------------------------------------------------------------kernel 
4.20
  case INTERRUPT_CAUSE_EXTERNAL:
#ifdef CONFIG_XILINX_INTC
                 {
                      unsigned int irq;
                         irq = xintc_get_irq();
                 next_irq:
                         BUG_ON(!irq);
                         generic_handle_irq(irq);

                         irq = xintc_get_irq();
                         if (irq != -1U) {
                 pr_debug("next irq: %d\n", irq);
                 goto next_irq;
             }
         }
                 csr_clear(sip, 1 << INTERRUPT_CAUSE_EXTERNAL);
#else
              handle_arch_irq(regs);
#endif
               break;
     default:
                 panic("unexpected interrupt cause");
-------------------------------------------------------------------------------

   However, in current Linux version (6.5) there is no corresponding   
csr_clear(sip, 1 << INTERRUPT_CAUSE_EXTERNAL)-call anywhere, at least I 
haven't been able to find it.
Instead I did a "quick and dirty" -fix to the file 
"linux/drivers/irqchip/irq-xilinx-intc.c" and put the corresponding 
call     csr_clear(CSR_SIP, IE_EIE);
to function
------------------------------------------------------------------------kernel 
6.5
  static void xil_intc_irq_handler(struct irq_desc *desc)
{
     struct irq_chip *chip = irq_desc_get_chip(desc);
     struct xintc_irq_chip *irqc;
     u32 pending;


     irqc = irq_data_get_irq_handler_data(&desc->irq_data);
     chained_irq_enter(chip, desc);
     do {
         pending = xintc_get_irq_local(irqc);
         if (pending == 0)
             break;
         generic_handle_irq(pending);
     } while (true);
     chained_irq_exit(chip, desc);
     csr_clear(CSR_SIP, IE_EIE);
}
---------------------------------------------------------------------------
Now the interrupts are not pending and the system is not halted as it 
was before for example while using spidevtest before the modifications. 
The call csr_clear() clears pending interrupts that would otherwise halt 
the Linux kernel.
I wonder if this should be fixed somehow more elegantly? I am grateful 
for any answers. I am just a beginner in the adventure of the driver 
development, and any sensible answer is real help :)
Best Regards, Mikko Saari
