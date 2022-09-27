Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C895EBF38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiI0KGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiI0KGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:06:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078031260F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:06:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z6so14225321wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=H8px/3R8axL8NB0kuXo1mcNAvKHcBV0IekUSt7wwGf8=;
        b=XrFe9HeFFNGQqRpyv4ubHMSMLmmbzPvx+XoWDo0GaQ+g/PxGvL77wBGHZBMrVwIu9b
         YzizqPkX/5IjZaALDbJSsJdJajY9Zk00UVN51RS0peAIOmiXlmC2ZpnuQMVCeNPmtMNZ
         U/pR3HBz7KLP0NT48xBtwxYjCBKK3HaEWl2y8tQCKUUi1sXofTEV2o03Mp8e6bH19Bc6
         e7b28lXcunAarB3S0hv1y+b6xH+f2+0lR/DnQWf67x+aXc9fthfnsXTtLQZb+cY6ajeW
         gdQ13QWyu8bwhCO4Ur6uppLvXLu/PG/wvD+0AlJ+5q8z2NmtbQf6T1TpgKCPU8EeE9rf
         +A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H8px/3R8axL8NB0kuXo1mcNAvKHcBV0IekUSt7wwGf8=;
        b=D3zM/VDJHL04Zr2GoARGjYq6AByAP2bIGRaECxbG2Z24ems8LQ/q1O8//4yrx8FfUq
         p+Yic0ghKfNqaFzayoKSCN3qwIKEL4oc9uth6U1QSOY7dwXQNRelA1mVnToRFAJ72EyI
         HJuq516nEnHrGnTU3umkYh0c+1ErtuTSMjxJDQT1N3ocYRHpHM878mdNoXC84uRZArBO
         QyDNY9orxEYKfyrcEu1j6pw8L3D74KSsp06mH+deJfh1X0CFiVLovoViyMLCC7KWYsj5
         ZKEbRaKr378hwy4E9T4vsgUupyeXKABoJpRfOYnZg4T6vPgeR6ZujUXSiOV9Dv6WMszf
         gRTA==
X-Gm-Message-State: ACrzQf1xm10ijOSsZmoZBFE/PDrq6alKXlp6rB+5vE/DWTfCRpLsC9Ru
        BQmGfXKEmKf0iNsBGETlolexQw==
X-Google-Smtp-Source: AMsMyM4xQbnfXIwIVJQbjZDDqmsHA+3Kk+4mFM5jJvQ2uyyHHHtWlstRmrJ06NepvzY8X6LSzd9iYA==
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr17073090wru.36.1664273161423;
        Tue, 27 Sep 2022 03:06:01 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b4fe03c881sm14225109wmo.48.2022.09.27.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:06:00 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:05:56 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>, peterz@infradead.org
Subject: Re: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <YzLLBBRiwuQnD2zc@google.com>
References: <20220725095952.206884-1-vdonnefort@google.com>
 <b5c5b02d-85ca-9d3b-2b3d-8892ab6d22a7@leemhuis.info>
 <42237005-5a6e-9462-bfdd-f1ba0c725c72@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42237005-5a6e-9462-bfdd-f1ba0c725c72@leemhuis.info>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 11:59:06AM +0200, Thorsten Leemhuis wrote:
> On 17.08.22 11:46, Thorsten Leemhuis wrote:
> > 
> > Hi, this is your Linux kernel regression tracker.
> > 
> > On 25.07.22 11:59, Vincent Donnefort wrote:
> >> The DYING/STARTING callbacks are not expected to fail. However, as reported
> >> by Derek, drivers such as tboot are still free to return errors within
> >> those sections, which halts the hot(un)plug and leaves the CPU in an
> >> unrecoverable state.
> >>
> >> No rollback being possible there, let's only log the failures and proceed
> >> with the following steps. This restores the hotplug behaviour prior to
> >> commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
> >> Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> >> Reported-by: Derek Dolney <z23@posteo.net>
> >> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> >> Tested-by: Derek Dolney <z23@posteo.net>
> > 
> > What's the status here? Did that patch to fixing a regression fall
> > through the cracks? It looks like nothing happened for 3 weeks now,
> > that's why I wondered, but maybe I missed something.
> 
> Hmm, Vincent seems to be MIA, at least I see no recent messages from him
> on lore. Odd. But well, it's still a fix for a regression and it's up to
> v5 already; Valentin already added his Reviewed-by, too. Would be a
> shame to waste this.
> 
> Thomas, could you maybe take a look at the patch?  Maybe we're lucky and
> the patch is already good to go...
> 
> Ciao, Thorsten
> 
> #regzbot poke

Hi Thorsten,

AFAIK, this patch is still valid. I don't think I do have any further action on
that though.

[...]
