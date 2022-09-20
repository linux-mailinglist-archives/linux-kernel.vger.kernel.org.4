Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE95BE743
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiITNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiITNiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C35A2E1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663681088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ptul5F+oi+h41DyVRco1I/MopxWAXfTqNQ2MFX3lkw=;
        b=aSEFEdqrgeDCK4bMzYmyGj2o482uidpLYcPZmq5Fz2vHlfM4iAGfuMexO9DY/HhlfwyKE/
        4eBuzT5Ed5rpOsdT95EHjBRoJdvnxgmQ1ZOMUC6wZ/U8IawOFE5Rx9/moNdQ45mYOO7X74
        V6jX9o3UREW8NQti2/dWy6KsM859d08=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-PiiZodm8Oq6lNJzMs_JJgQ-1; Tue, 20 Sep 2022 09:38:07 -0400
X-MC-Unique: PiiZodm8Oq6lNJzMs_JJgQ-1
Received: by mail-qt1-f198.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so1844125qtk.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5ptul5F+oi+h41DyVRco1I/MopxWAXfTqNQ2MFX3lkw=;
        b=6KGI46wYFkFypdmfI5oecdo3dpHchicnkjvDPfUtJvB0zytpZ8GSjXLlk6CiP3KPsA
         6vbXvzUe47ppTTe+dVw2Mo2MNPOja8UIlFvWFTYEopm09nK6ZygnfrrH5C/HKcjTVyZY
         20qC8GA3HfjsCvFABXDB+t3Nstoe/AlgIUIti/zkt5aD0Blo0xU6vofJdresM7tDjDRw
         0cr9AzFOog8J2bhD/XXIRim/8ddw8EikMvN6FCOawWFXk6Xcpk13z0rx2zI/Yah4SFOJ
         wvtjQABthkECQc2UBxrVYb/NFRN7bbZW/w1ru0hAHToGCtc6IfxF3kzKLHqCc+MnrdXs
         zqfg==
X-Gm-Message-State: ACrzQf3KyPh/30hNgKuMOCkKRfqcfay2Q2x75+63GvVrfRAflWvpMYqU
        uNsnWJBdSS243JXElNLd1XCurv4BYhLXLSE1EmpaKFmUcQtTsbuTXs1kNllhdwMoWB9Lp7sKVYr
        KaRIh7WGLzYNWDABVfNlIE/0+
X-Received: by 2002:ac8:59c8:0:b0:35c:e115:b18d with SMTP id f8-20020ac859c8000000b0035ce115b18dmr11456585qtf.123.1663681085599;
        Tue, 20 Sep 2022 06:38:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6E77qWjrb4O7Hq4zvnJnGvSPaIHOB3HS5izLjI11yyG3poqQh+gGyGGwkM2TfWtP/1afoIQg==
X-Received: by 2002:ac8:59c8:0:b0:35c:e115:b18d with SMTP id f8-20020ac859c8000000b0035ce115b18dmr11456440qtf.123.1663681083862;
        Tue, 20 Sep 2022 06:38:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id bj7-20020a05620a190700b006b9c6d590fasm148570qkb.61.2022.09.20.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:38:03 -0700 (PDT)
Message-ID: <be11181df759bce03b0bc049d30fd925d5229718.camel@redhat.com>
Subject: Re: [PATCH net-next 3/6] net: ipa: move and redefine
 ipa_version_valid()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alex Elder <elder@linaro.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Sep 2022 15:37:59 +0200
In-Reply-To: <b26912a7-0770-4b1f-4cf4-bed81298cbdb@linaro.org>
References: <20220910011131.1431934-1-elder@linaro.org>
         <20220910011131.1431934-4-elder@linaro.org>
         <d98d439ef5ee8a1744481bf1f076fbed918c3cef.camel@redhat.com>
         <b26912a7-0770-4b1f-4cf4-bed81298cbdb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-20 at 07:50 -0500, Alex Elder wrote:
> On 9/20/22 3:29 AM, Paolo Abeni wrote:
> > On Fri, 2022-09-09 at 20:11 -0500, Alex Elder wrote:
> > > Move the definition of ipa_version_valid(), making it a static
> > > inline function defined together with the enumerated type in
> > > "ipa_version.h".  Define a new count value in the type.
> > > 
> > > Rename the function to be ipa_version_supported(), and have it
> > > return true only if the IPA version supplied is explicitly supported
> > > by the driver.
> > 
> > I'm wondering if the above is going to cause regressions with some IPA
> > versions suddenly not probed anymore by the module?
> 
> That is a really good observation.
> 
> The way versions are handled is a little bit inconsistent.  The
> code is generally written in such a way that *any* version could
> be used (between a certain minimum and maximum, currently 3.0-4.11).
> In other words, the *intent* in the code is to make it so that
> quirks and features that are version-specific are handled the right
> way, even if we do not (yet) support it.
> 
> So for example the inline macro rsrc_grp_encoded() returns the
> mask to use to specify an endpoint's assigned resource group.
> IPA v4.7 uses one bit, whereas others use two or three bits.
> We don't "formally" support IPA v4.7, because I (or someone
> else) haven't set up a Device Tree file and "IPA config data"
> to test it on real hardware.  Still, rsrc_grp_encoded() returns
> the right value for IPA v4.7, even though it won't be needed
> until IPA v4.7 is tested and declared supported.
> 
> The intent is to facilitate adding support for IPA v4.7 (and
> others).  In principle one could simply try it out and it should
> work, but in reality it is unlikely to be that easy.
> 
> Finally, as mentioned, to support a version (such as 4.7) we
> need to create "ipa_data-v4.7.c", which defines a bunch of
> things that are version-specific.  Because those definitions
> are missing, no IPA v4.7 hardware will be matched by the
> ipa_match[] table.
> 
> So the answer to your question is that currently none of the
> unsupported versions will successfully probe anyway.
> 
> > Additionally there are a few places checking for the now unsupported
> > version[s], I guess that check could/should be removed? e.g.
> > ipa_reg_irq_suspend_en_ee_n_offset(),
> > ipa_reg_irq_suspend_info_ee_n_offset()
> > ...
> 
> I'm a fan of removing unused code like this, but I really would
> like to actually support these other IPA versions, and I hope
> the code is close to ready for that.  I would just need to get
> some hardware to test it with (and it needs to rise to the top
> of my priority list...).
> 
> Does this make sense to you?

Yes, very clear and detailed explaination, thanks!

I'm ok with the series in the current form.

Cheers,

Paolo

