Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3A62B664
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiKPJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiKPJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC9226118
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668590507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EOhbuo2gRM/DssIyTkIu890ZZZpDw/V+Xymwp3BqTI=;
        b=J91mp6ypBtqEwO8nB5fwF+wjCzvjuoJNoyK3x1fu4kOZjDWLLsCN9WS4Buur34BJT4F0lQ
        KScivbAEgUAK7vBrYDJibB59RjmElbPScpmjsafMt+X+SXeFEtuB0eAzfzfoSND6Dv9iGs
        nIeijqyWyevoonL18O+YmiiSOG2KXgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-uOQedpW_O6CEWnrnC23RhA-1; Wed, 16 Nov 2022 04:21:45 -0500
X-MC-Unique: uOQedpW_O6CEWnrnC23RhA-1
Received: by mail-wm1-f71.google.com with SMTP id c1-20020a7bc001000000b003cfe40fca79so285223wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EOhbuo2gRM/DssIyTkIu890ZZZpDw/V+Xymwp3BqTI=;
        b=jsKkQodpbtJwTUaLJJHXmS7CFKO7OF5gVVM9KcTlr6ZS7PIULa1jg2s1M61HERdMQO
         qrp8q1sKubKr8BXuWsABAP5SU+IO2ggnOwG4kZeScidxaRtS9mXgo4cGwFtk0W12KEze
         wvfMBt+eFQe13etMkT80RUEoJKr8WdJ0Nzgze48/j1j+vw49aSrO5gzCJj6Te2Yys3Ut
         bd9P9UTKDVsI4F7E1fRuKnN+QK86s3OEOgrLzdSXjgWpWz9Nhl8wG4010FcWooiDYRTF
         8qbwzMuIIoxNlQo+pUNmpjfFbTTcAITOsLk/ZDLMKj6WiRFLEjAKUJ0dlSXjMSgGU9n6
         iqIw==
X-Gm-Message-State: ANoB5plbVM04sytQvbX9CRZcTbAVSrZ1IRvQ2fkS3GfVAvnNj2GxSf+A
        V+E/Z9S4TbNWhwE+FMkldkYlmGPDvyo4gKv7A/aeX3HBUJwJNn64mfFQf7twCl9Ck8pmOl1sEVC
        rYpfdVBimRHIR5xoNPZ3+Orai
X-Received: by 2002:a05:600c:54ec:b0:3cf:8443:e4a with SMTP id jb12-20020a05600c54ec00b003cf84430e4amr1518259wmb.27.1668590504434;
        Wed, 16 Nov 2022 01:21:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf49QFmou4lunmLxHQn36tqy8/rLrUnxj3S5xa0/8E8EOoMtE4mnY2S/BAQLRycObOfX9ZpmOg==
X-Received: by 2002:a05:600c:54ec:b0:3cf:8443:e4a with SMTP id jb12-20020a05600c54ec00b003cf84430e4amr1518242wmb.27.1668590504174;
        Wed, 16 Nov 2022 01:21:44 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm1516316wmq.31.2022.11.16.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:21:43 -0800 (PST)
Message-ID: <f764c7a1eb4a9fe294f04ea48db2dae9c18116c8.camel@redhat.com>
Subject: Re: [PATCHv5 0/8] Virtual NMI feature
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>, pbonzini@redhat.com,
        seanjc@google.com, jmattson@google.com
Cc:     kvm@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, thomas.lendacky@amd.com,
        vkuznets@redhat.com
Date:   Wed, 16 Nov 2022 11:21:42 +0200
In-Reply-To: <fc8813c6-0091-8571-d934-e33d7d56123d@amd.com>
References: <20221027083831.2985-1-santosh.shukla@amd.com>
         <d109feb8-7d07-0bf1-f4ad-76d4230ed498@amd.com>
         <869d05b2ce0437efae1cf505cf4028ceb4920ce2.camel@redhat.com>
         <fc8813c6-0091-8571-d934-e33d7d56123d@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-16 at 11:10 +0530, Santosh Shukla wrote:
> Hi Maxim,
> 
> On 11/14/2022 8:01 PM, Maxim Levitsky wrote:
> > On Mon, 2022-11-14 at 13:32 +0530, Santosh Shukla wrote:
> > > 
> > > 
> > > On 10/27/2022 2:08 PM, Santosh Shukla wrote:
> > > > VNMI Spec is at [1].
> > > > 
> > > > Change History:
> > > > 
> > > > v5 (6.1-rc2)
> > > > 01,02,06 - Renamed s/X86_FEATURE_V_NMI/X86_FEATURE_AMD_VNMI (Jim Mattson)
> > > > 
> > > 
> > > Gentle reminder.
> > > 
> > > Thanks,
> > > Santosh
> > > 
> > 
> > I started reviewing it today and I think there are still few issues,
> > and the biggest one is that if a NMI arrives while vNMI injection
> > is pending, current code just drops such NMI.
> > 
> > We had a discussion about this, like forcing immeditate vm exit
> 
> I believe, We discussed above case in [1] i.e.. HW can handle
> the second (/pending)virtual NMI while the guest processing first virtual NMI w/o vmexit.
> is it same scenario or different one that you are mentioning?
> 
> [1] https://lore.kernel.org/lkml/1782cdbb-8274-8c3d-fa98-29147f1e5d1e@amd.com/

You misunderstood the issue.

Hardware can handle the case when a NMI is in service (that is V_NMI_MASK is set) and another one is injected 
(V_NMI_PENDING can be set),

but it is not possible to handle the case when a NMI is already injected (V_NMI_PENDING set) but
and KVM wants to inject another one before the first one went into the service (that is V_NMI_MASK is not set
yet).

Also same can happen when NMIs are blocked in SMM, since V_NMI_MASK is set despite no NMI in service,
we will be able to inject only one NMI by setting the V_NMI_PENDING.

I think I was able to solve all these issues and I will today post a modified patch series of yours,
which should cover all these cases and have some nice refactoring as well.


Best regards,
	Maxim Levitsky


> 
> Thanks,
> Santosh
> 
> > in this case and such but I have a simplier idea:
> > 
> > In this case we can just open the NMI window in the good old way
> > by intercepting IRET, STGI, and or RSM (which is intercepted anyway),
> > 
> > and only if we already *just* intercepted IRET, only then just drop 
> > the new NMI instead of single stepping over it based on reasoning that
> > its 3rd NMI (one is almost done the servicing (its IRET is executing),
> > one is pending injection, and we want to inject another one.
> > 
> > Does this sound good to you? It won't work for SEV-ES as it looks
> > like it doesn't intercept IRET, but it might be a reasonable tradeof
> > for SEV-ES guests to accept that we can't inject a NMI if one is
> > already pending injection.
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> 


