Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979E73ECA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFZVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:10:27 -0400
X-Greylist: delayed 1219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 14:10:25 PDT
Received: from mail.genode-labs.com (mail.genode-labs.com [94.130.141.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44172D9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=genode-labs.com; s=2018-03; h=Content-Transfer-Encoding:Content-Type:
        Subject:Cc:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jbCUOAiVO0YSBCCI9yI/HDo8SclOd7PhW9mxIZosxMI=; b=Kpb5w5WQykIA1efRNmo/TIeUr5
        K90iAL9wD83FOjDrNMvRgWZJMsQ1qI04dgtYV/W1WAJmQptEkeJjBf+aw/13A3wQmOF27v0R3oLDV
        +32Oqa8FP8suLAfaXX+VuRPJAVNF18vGYfWkNbcwJoQnyVWZVyXZTob08lvTv98rmr0sdWDKx6azv
        kgZIWT8o+1BFDvs1SZVCCeVqCQAJ0XkN2vhzleQ3fXuAfnQiHg1u0qRaxv8NRZR0cKPBH+Buv8LXq
        vViK+ItGUrpeszOxfULxuoeSRs+NzWM7calsuRBZuMe+1mgrpHhTLMfbZnFLHUzgG7ps1xsF/dSvv
        mPd3yJag==;
Received: by mail.genode-labs.com (Exim 4.95-1-g73e85c617) with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (envelope-from <Sebastian.Sumpf@genode-labs.com>)
        id 1qDt9c-008qFN-Vf ;
        Mon, 26 Jun 2023 22:49:45 +0200
Message-ID: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
Date:   Mon, 26 Jun 2023 22:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [Bug report] __arch_hweight32/64 x86
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developers,

I recently stumbled over a bug in the inline assembly of '__arch_hweight32' and 
'__arch_hweight64'  in 'arch/x86/include/asm/arch_hweight.h' (present in 6.4 as 
well):

! asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0",
! X86_FEATURE_POPCNT)
! 			 : "="REG_OUT (res)
! 			 : REG_IN (w));

The 'ALTERNATIVE' macro checks for the popcnt feature. In case this fails the 
'__sw_hweight' C-function is called from inline assembly with rax and rdi as 
intput/output operands. However, the code does not contain a clobber list of any 
callee safe registers that might be touched by the '__sw_height64' C-function. 
Therefore, these registers will not be restored upon function return by the 
compiler. This leads to varying exceptions/bad behavior caused by the thus 
corrupted registers later on.

Kind regards,

Sebastian


-- 
Sebastian Sumpf
Genode Labs

http://www.genode-labs.com · http://genode.org

Genode Labs GmbH · Amtsgericht Dresden · HRB 28424 · Sitz Dresden
Geschäftsführer: Dr.-Ing. Norman Feske, Christian Helmuth



