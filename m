Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584B72684C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFGSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFGSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:18:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1551FD7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:18:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so64164551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686161909; x=1688753909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ/p0iLnlO9hRGL6F3e88TDXKCDJ3Ln5sjh3/Y6FySE=;
        b=zDSxFnUbIcCjqY5ly3/D4UTfuVwXpVyLZrw7RvR1qPR5BIGmN9aat/Y68xabimzaUY
         3M7aOc5RUo5y8Jorgp9FtZqmAtFvfWhXe2Q9IJjp6+zyUVw1/P4SNfGWSp6YcY2v+Gly
         ymQRaIWlAjqyFEWHYtETDUE9a6OIjVSvcK1cHjd+B1qDDYmCL4R6qUDjysbpZ20d6g2U
         latCjJ4S/Dfy2SaE1Zc3YjHUkDC+TXDYzJSYiBMDCqdCcxY2xYnnWQF0oIdl38qA5YLT
         U6By/Jq4Dny7Zfxr8PSW958EUNkW3uxA3U8YKQ6SGY+lA5T9LjuA7zJ+2qYCsWSHx6cb
         jfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161909; x=1688753909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ/p0iLnlO9hRGL6F3e88TDXKCDJ3Ln5sjh3/Y6FySE=;
        b=JDoZNYaTVge5ObQjUP0kQG0t/pCOeB+zHWXo9uJlreaYLRvw7dihE20VwuA4zXDu0J
         SAWatz4452cFLvFPk1Dy9LOtyxnY8agfJ9xJuh0YKP/LfYe5b+S4kOfClRbHv2rU8kBP
         KHi6jMQeNd+nnwh+l/Vnbp5kOOkBpow/zZvt4yxVZIC8VpH+gM9SnIwPMUynJQ2nr2lf
         9DacwJ4z4EAP9Zacmt04GeFIo+bI0moLzr7raOqycOkuKcY59ezJ5LeOG1VKppEUSFhw
         276Pzi1H99KaHpRmXMLup8c3xGteD99u9qjw9MS27b1aYt0mbpOInlSSZ1gcP1uG/vG8
         Kv/w==
X-Gm-Message-State: AC+VfDzqPMpvZYT7hFo0xsVOtZECZjv8UubnoYTvgN/1xt8hugnYnNNB
        XHcrYX/tTf+wa7Xi4kszSHpfPHKMYns9DSj6gL9RCg==
X-Google-Smtp-Source: ACHHUZ7O/DzwvluFFUAPOsziiJROquhW9PuTOb0JgHUU4X3wehygZbwll0mktA0KGDG2rx48BQYxIaF9Qy7l5t/4fx4=
X-Received: by 2002:a2e:730c:0:b0:2b1:ed29:7c47 with SMTP id
 o12-20020a2e730c000000b002b1ed297c47mr2455880ljc.8.1686161909028; Wed, 07 Jun
 2023 11:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com> <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
In-Reply-To: <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 7 Jun 2023 21:17:52 +0300
Message-ID: <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.06.23 18:59, Ilias Apalodimas wrote:
> > On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Jan,
> >>
> >> [...]
> >>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
> >>>>>> As you point out you will still have this dependency if you end up
> >>>>>> building them as modules and you manage to mount the efivarfs before
> >>>>>> those get inserted.  Does anyone see a reasonable workaround?
> >>>>>> Deceiving the kernel and making the bootloader set the RT property bit
> >>>>>> to force the filesystem being mounted as rw is a nasty hack that we
> >>>>>> should avoid.  Maybe adding a kernel command line parameter that says
> >>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> >>>>>> this either, but it's not unreasonable.
> >>>>>
> >>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> >>>>> basically this issue mapped on reboot/shutdown, I would really love to
> >>>>> see the unhandy tee-supplicant daemon to be overcome.
> >>>>
> >>>> I have seen this error before and it has been on my todo list. So I
> >>>> have tried to fix it here [1]. Feel free to test it and let me know if
> >>>> you see any further issues.
> >>>>
> >>>> [1] https://lkml.org/lkml/2023/6/7/927
> >>>>
> >>>
> >>> Ah, nice, will test ASAP!
> >>>
> >>> Meanwhile more food: I managed to build a firmware that was missing
> >>> STMM. But the driver loaded, and I got this:
> >>
> >> Thanks for the testing. I'll try to reproduce it locally and get back to you
> >
> > Can you provide a bit more info on how that was triggered btw? I would
> > be helpful to know
> >
> > - OP-TEE version
>
> Today's master, 145953d55.
>
> > - was it compiled as a module or built-in?
>
> Sorry, not sure anymore, switching back and forth right now. I think it
> was built-in.
>
> > - was the supplicant running?
>
> Yes.
>

Ok thanks, that helps.  I guess this also means U-Boot was compiled to
store the variables in a file in the ESP instead of the RPMB right?
Otherwise, I can't see how the device booted in the first place.

Thanks
/Ilias


> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
