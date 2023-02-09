Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313EF690105
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjBIHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjBIHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652DD3EFF9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:14:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so3566411ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peBY+HBlVZ8ZkvrSDoKKy0AQZ0Ydjnp4NTJQOD0LUtE=;
        b=fkaxIkSHmLjq+JftR7TsfPbiauz7Vn6O6EnheFTIp90dhq73+8q9oOJNlwHPBuMyjs
         /RrucsRntMGarzh2pgYuijZaMEfgOEDreTDYnKOXATsIZ4KOcSv7znXEwo/GUeArnf14
         rqxKXu7rgyQ55BcgR7MJHLolbobDX8BWmkm4QVb3fgHzs6zCUth8lF11gVYEXBLp8un3
         IrBl12FocE0C07WGYgqmG6gF8GeOD1nAMCZMGsEpd5+l8mFHprZEQFu9R9k4iFBY8awE
         utR12pNl/oUCBYwMpLrwwRNTg0gwPz/ZXQFs8BHMWWaPTuSJNp9rMmWbk+P8lgW//HXx
         jRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peBY+HBlVZ8ZkvrSDoKKy0AQZ0Ydjnp4NTJQOD0LUtE=;
        b=pfyYqvpjUq8+Vd39dg3XiTniI+ufYV94kSghH4asvX3zC8aWM2MoiU7PiE6dLOtviK
         FqFWE2JKTCvdg7ulXkoMZ4DYrOLr937EuP+Wafw7ssH+OzRTnyomv5Fg8FI5kzC3NQX3
         1JCZOBhX6Z7X7haoMhhY7YsnpIpFZT2+zG2Hd8Jq5g+2irfTEBjnjD2I62w6lyiQ9H2L
         m9Yxclq6N8TxGzUw/4VOdagt7TlrdSWcSYg/6izci4Nih+1HVg793P/WOWOUC5RtcjZo
         INtFjb38DJXCvsXqx/Ru8ZaKqkAdBWjWngVdRNGaFKNwygAvVac594WwERvLzm40URIB
         aXMw==
X-Gm-Message-State: AO0yUKWoro0AnNXqwR1k9lHddyb/vwxAmDuSnRpq1zrkc2hX/Y7TYLQc
        KD4wcQ9JU/z0iO7UjbLreIaNLg==
X-Google-Smtp-Source: AK7set+gm66PMORBWMw+4wP4Y0UArCDRRxflnUcTYgIYxG7RJk6eu83PziSQxhhjh71dxmf9b47bJQ==
X-Received: by 2002:a17:907:8a03:b0:7c1:458b:a946 with SMTP id sc3-20020a1709078a0300b007c1458ba946mr14926713ejc.0.1675926856553;
        Wed, 08 Feb 2023 23:14:16 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id z16-20020a5096d0000000b004aad0a9144fsm346878eda.51.2023.02.08.23.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 23:14:16 -0800 (PST)
Date:   Thu, 9 Feb 2023 08:14:14 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/2] tee: system invocation
Message-ID: <Y+SdRrwSq/a9OgGr@jade>
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
 <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
 <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
 <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

On Wed, Feb 08, 2023 at 06:09:17PM +0100, Etienne Carriere wrote:
> Hello Sumit, Jens,
> 
[snip]
> > > > > >
> > > > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > +               if (ctx->sys_service &&
> > > > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > > > +               else
> > > > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > >
> > > > > This system thread flag should also be applicable to platforms without
> > > > > registered arguments support. IOW, we need similar equivalents for
> > > > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > > > too. So I would rather suggest that we add following flag to all 3
> > > > > call types:
> > > > >
> > > > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> > > >
> > > > The main reason platforms don't support registered arguments is that
> > > > they haven't been updated since this was introduced. So if a platform
> > > > needs system threads it could update to use registered arguments too.
> > >
> > > Are we hinting at deprecating reserved shared memory support? If yes,
> > > wouldn't it be better to be explicit about it with a boot time warning
> > > message about its deprecation?
> > >
> > > Otherwise it will be difficult to debug for the end user to find out
> > > why system thread support isn't activated.
> > >
> > > > The Linux kernel already supports registered arguments. An advantage
> > > > with the current approach is that the ABI is easier to implement
> > > > since we have distinct SMC IDs for each function.
> > >
> > > I see your point but my initial thought was that we don't end up
> > > making that list too large that it becomes cumbersome to maintain,
> > > involving all the combinatorial.
> >
> > You have a point. Etienne, do you think we could give it a try at
> > https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
> > would play out?
> >
> 
> Indeed I miss that...
> With the patch proposed here, indeed if OP-TEE does not support
> dynamic shared memory then Linux will never use the provisioned TEE
> thread. This is weird as in such a case OP-TEE provisions resources
> that will never be used, which is the exact opposite goal of this
> feature. Verified on our qemu-arm setup.
> 
> For simplicity, I think this system invocation should require OP-TEE
> supports dyn shm.

It's not obvious to me that this will easier to implement and maintain.
Looking at the code in optee_os it looks like using a flag bit as
proposed by Sumit would be quite easy to handle.

> 
> If OP-TEE could know when Linux does not support TEE system
> invocation, then OP-TEE could let any invocation use these provisioned
> resources so that they are not wasted.
> I think a good way would be Linux to expose if it supports this
> capability, during capabilities exchange.
> Would you agree with this approach?

No, I'm not so keen on adding that side effect to
OPTEE_SMC_EXCHANGE_CAPABILITIES.

The way you're describing the problem it sounds like it's a normal world
problem to know how many system threads are needed. How about adding a
fast call where normal world can request how many system threads should
be reserved?  If none are requested, none will be reserved.

Cheers,
Jens
