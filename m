Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62533607438
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJUJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJUJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:38:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629724D887;
        Fri, 21 Oct 2022 02:38:00 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e769329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e769:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82D441EC0742;
        Fri, 21 Oct 2022 11:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666345074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n1fViR5INKz08b2AX2t7evluOd1FEBYL4nLLbMadCI4=;
        b=qs2gkp4aJmtxjOcQKwx/G+yHdTEnttGZv3ojWJWMdtf3oX7UcemiflgKLWgarZk6MQHQB2
        koV9meyxS5O1jLHKi99mBj369nejOCC6PIebCo8xw3UEW/cTmKqaqWtSjaLaz31QtYERqs
        bZY5H0QsKXVEbDn9I8H++lfFKXYBVhI=
Date:   Fri, 21 Oct 2022 11:37:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Message-ID: <Y1JoXmC+sOSxZffT@zn.tnic>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com>
 <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y1Isg4q9Vsl8zNPe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Isg4q9Vsl8zNPe@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:22:11PM +0800, Huang Rui wrote:
> > > If I rename that the MSR definition string, that will cause lots of driver file
> > > change.
> > > So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR is
> > > mismatching in the CPPC Pstate driver.
> > > If you refuse to use this new one, I will reuse that old one.
> > 
> > To avoid changing too much stuff at once how about if you give an alias?
> > IE something like:
> > 
> > #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR

Why would you all even think about adding a new name and not use
MSR_K7_HWCR?

The other code uses it just fine, do git grep MSR_K7_HWCR.

We have waaay too many MSRs, no need to unnecessarily confuse people
with an alias or rename stuff. Just use MSR_K7_HWCR like everything else
does.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
