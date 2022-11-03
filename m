Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2561732B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKCACR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKCACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:02:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F45598
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:02:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2kT32cJYz4xG6;
        Thu,  3 Nov 2022 11:01:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1667433722;
        bh=31iurRyfa4zXHGbVOXuCKxTdBrIQn+fBDXQE7fkQ3YQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EJ9I671/xYV8EKoDea0eoD7YmsLG9C3ul8CcFANkB+8jLL9nzmRtDAtj9tkXCMKGh
         23stO8K6u/R7J335Roodwtx93MgJ5oRkJdN0VQ3+q3pkfoQ34S0NRy5kFiNArjXpoW
         xAoRaBfRLHTDWzRa3NhqFukc0G/5Mu7kTuLurKlD9uoouUu/Vd2xCghz81s3g0iGNR
         pzq38D52XsDfvxPUfkNph3Bo92gDajz7E5dJKflPpGh2EfOqFDZIjgSZwaTKAF+L54
         RiPtP5YFtCC73UFFPCQ+uNOJnTce62Qc78+mHqIeRxHwkn1FDl7JOleRLJ4DTcAEuB
         E5jTCzUQ+wKdg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
In-Reply-To: <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
References: <20221028143346.183569-1-sv@linux.ibm.com>
 <20221028143346.183569-3-sv@linux.ibm.com>
 <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
Date:   Thu, 03 Nov 2022 11:01:54 +1100
Message-ID: <87tu3gsy6l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 28/10/2022 =C3=A0 16:33, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>> In a subsequent patch, we would want to annotate powerpc assembly functi=
ons
>> with SYM_FUNC_START_LOCAL macro. This macro depends on __ALIGN macro.
>>=20
>> The default expansion of __ALIGN macro is:
>>          #define __ALIGN      .align 4,0x90
>>=20
>> So, override __ALIGN and __ALIGN_STR macros to use the same alignment as
>> that of the existing _GLOBAL macro. Also, do not pad with 0x90, because
>> repeated 0x90s are not a nop or trap on powerpc.
>
> By the way, do we know what the instruction 0x90909090 is on powerpc ?=20
> Is that something valid or not ?

According to objdump it's:

stw     r4,-28528(r16)

cheers
