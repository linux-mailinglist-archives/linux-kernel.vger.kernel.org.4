Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F75B44F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIJHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIJHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 03:52:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35265BE0C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 00:52:20 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98DF31EC0409;
        Sat, 10 Sep 2022 09:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662796334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2efe3qxjuoKHJbBcX/VK/9LIcKmlmOXr2/+rWhHWwPg=;
        b=qQHlsxPNVPO4F/xDU007GS0/iqMlpv3v82B4jgOqEJZ6kIVkVc2cur4H8iBCqKw/UJMgEa
        JM0BM4zubMVlIUSqOCpL+517lOJL0z+iFU+z7NBYR/OgXMH1DOZXFMeyNSDQSVuX3nwYxW
        PhessI3F9JOOdksibUU2Xn1eNIun5N4=
Date:   Sat, 10 Sep 2022 09:52:27 +0200
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
Message-ID: <YxxCMSYaI/o3QH03@nazgul.tnic>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:46:08AM +0000, Manikandan Jagatheesan wrote:
> After performing the bisect between kernel 5.18 and 5.19, we 
> identified the root cause to be the enablement of IBRS mitigation 
> for spectre_v2 vulnerability by commit 6ad0ad2bf8a6 ("x86/bugs: 
> Report Intel retbleed vulnerability").

What I'm wondering about is why does the guest enable IBRS when booting
on your HV?

I'm guessing you're exposing SPEC_CTRL and all the feature flags so that
the detection in spectre_v2_select_mitigation(), the SPECTRE_V2_CMD_AUTO
case, hits.

But then, why are you emulating a CPU which is vulnerable to retbleed?

Because as far as the guest is concerned, filling the RSB on VMEXIT
should be good enough and the guest doesn't have to do anything else.

IOW, X86_BUG_RETBLEED should not be set on the guest booting on your HV.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
