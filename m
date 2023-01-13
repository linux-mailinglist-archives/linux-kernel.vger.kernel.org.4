Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844876698BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbjAMNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMNhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:37:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9231ADB9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:29:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id v6so9319877ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0f5QMMpTkEKk52qUURo39uH9J+aB7uiIV/6ucG6Tfs=;
        b=kJ9AFHOEisHmki1tAL5LTT++cPacHSXbycFwAqs9J0v3cScB/yzYi14MtGxu4hNgaC
         sx5tvDvRERQr3TVkzeCpoufY7J+aVvKvpgc1w2gBgc1kk5KANO0nhcJw7Q8OwbguwQYb
         N0N1MP1AIORjA2XYYedvK2mTv8IozL2wCSjU3mGEagxRsDSU14J7vF70zV97nXy1VZDT
         vkJ2xJ3Svto+Dk0m2iUHcrPWqwobnGzJDxpPn8Ds63Dd1DEfcih+KfTXYaTXatokJIu+
         y9k+qFV+pWkJUQAj8PnucO2H4eEMnyeF7502Oo2IouKJTbuLeGAizYfbCPwF6+Fj170u
         LJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0f5QMMpTkEKk52qUURo39uH9J+aB7uiIV/6ucG6Tfs=;
        b=yNqqhp6NEMsW+6M9yNmpakKic48FkfM0v2uSl3FCpOfIxOcXzrgEnL9ZrxCnElWh2T
         6vAmASnInbEOAGWcMATy6fOWY5V98+7fuPpM76GkU+k5qH+j9VzeRu/nrY2OWtgzD0PS
         zOoj4H5CeX+e+sZ61ZAnzJD9CpsGBWHmqMVGiPqqsDbgHvkoHryPcawjWbf987gg9XQX
         10dCpnXijLNhlzTi8uGNQ3DQhQns/njlY6H42FGQTWHK6YyWV27/S1A7K2jBc1k1BFL/
         fiDkPUBD7MtZn+4X8ZdTW1bFPD6FHluVkBIgZ6IDSgRbEjPufxpYA174LhM8mSRHQyd8
         vCnQ==
X-Gm-Message-State: AFqh2kra9aiNtMiLPjw1x7cLcP2pE+LKHy+v+bLZF67bTKrFO8afnGdj
        N1//mzvmCwlfrW0HDhcrxPk=
X-Google-Smtp-Source: AMrXdXsHt7ClWtEjsslfXX67nokTTAXNfyvPtoQnHqpEufLra9vanY72o83/F07eBqiRrjqfOCHFUg==
X-Received: by 2002:a17:906:910:b0:7c1:9519:5cfa with SMTP id i16-20020a170906091000b007c195195cfamr64143989ejd.77.1673616575542;
        Fri, 13 Jan 2023 05:29:35 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id cb1-20020a170906a44100b0084d199d7f08sm8495293ejb.21.2023.01.13.05.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:29:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Jan 2023 14:29:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
        chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 0/5] x86: Enable LKGS instruction
Message-ID: <Y8Fcum+SkeQB9B4H@gmail.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <Y7/5YPxbRE2AWgT0@gmail.com>
 <Y8Afy2J0io8F510i@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8Afy2J0io8F510i@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jan 12, 2023 at 01:13:20PM +0100, Ingo Molnar wrote:
> > 
> > * Xin Li <xin3.li@intel.com> wrote:
> > 
> > > LKGS instruction is introduced with Intel FRED (flexible return and 
> > > event delivery) specification. As LKGS is independent of FRED, we 
> > > enable it as a standalone CPU feature.
> > > 
> > > LKGS behaves like the MOV to GS instruction except that it loads the 
> > > base address into the IA32_KERNEL_GS_BASE MSR instead of the GS 
> > > segment’s descriptor cache, which is exactly what Linux kernel does 
> > > to load user level GS base.  Thus, with LKGS, there is no need to 
> > > SWAPGS away from the kernel GS base.
> > 
> > Ok, this looks good to me.
> > 
> > I've applied the first 4 patches to tip:x86/cpu, as the instruction 
> > exists in a public document and these patches are fine stand-alone as 
> > well, such as the factoring out of load_gs_index() methods from a 
> > high-use low level header into a new header file.
> > 
> > Planning to apply the final, LKGS enabler patch as well, unless there's 
> > any objections from others?
> 
> Nah, I think that thing's bike-shedded to near death. Let's just do it.

Ok - applied the #5 patch to tip:x86/cpu, for a v6.3 merge.

Thanks,

	Ingo
