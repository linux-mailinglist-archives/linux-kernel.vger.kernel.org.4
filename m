Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC995B58E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiILK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiILK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:58:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E4371A1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:58:21 -0700 (PDT)
Received: from nazgul.tnic (unknown [185.122.133.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF1601EC050F;
        Mon, 12 Sep 2022 12:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662980296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HBGEKRVi6GnTZoe5iU3wb3WPn7GzuD2bxWQyJZUD8jg=;
        b=j9tfwJQS5aX4Y/9p7hZlUaX9QTDyOS6Bp+BVNeB3xpfSMJZLxoZ+CesJ663WV0TYabglmu
        sl06USDKmGSEzVkngGFGKJw2oUlVvUsvBRwMiem09DAFGWW0bPXJhEf6S2tPTAxwmwTODK
        xGgTPgu5nJPtpnEG/ExuPrhuC5pReTc=
Date:   Mon, 12 Sep 2022 12:58:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manikandan Jagatheesan <mjagatheesan@vmware.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: Performance Regression in Linux Kernel 5.19
Message-ID: <Yx8Q1L3jNAJxa84L@nazgul.tnic>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
 <YxxCMSYaI/o3QH03@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxxCMSYaI/o3QH03@nazgul.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple more notes after talking to tglx:

So this works as expected. The threat model where the guest needs
to protect itself from malicious userspace is there so if the guest
emulates a CPU which is affected by retbleed and the hypervisor exposes
SPEC_CTRL, then the guest *should* enable IBRS to flush the RSB.

It is a lot nastier if the guest emulates a CPU which is *not* affected
by retbleed but the host uarch is - then the guest will be vulnerable
and it would not even warn about it! So people should be careful what
they do there.

In addition, if the guest trusts its userspace, it might disable IBRS
in order not to suffer the penalty but that's left to the guest owner.
The default setting has to be secure.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
