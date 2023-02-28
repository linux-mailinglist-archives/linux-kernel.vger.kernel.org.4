Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B06A5CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjB1QEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjB1QEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:04:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3274222DB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677600229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWMAworI50CQabTilrteqDasDy+XoVkceugkq8E6Pr8=;
        b=E28+0VgeUfH/TkeUbfmj2Fgr2FyimH3FwujMavEkRUVt+nBYJUlBr2Me6F5hpG+j/b/PyC
        8kaomLAzyCo1U3XSSnod6KSAG1AX0s46ZXhP3W6JJBq3VnwDWo5rP9Sn4qJTpJjLXtPJPS
        nguFQ/fN5fPlWviWjHdUG23bOcYFkVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-OIBB_mTcOaal_WTAYKfLdA-1; Tue, 28 Feb 2023 11:03:46 -0500
X-MC-Unique: OIBB_mTcOaal_WTAYKfLdA-1
Received: by mail-wm1-f70.google.com with SMTP id n27-20020a05600c3b9b00b003e9ca0f4677so4410154wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600224;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWMAworI50CQabTilrteqDasDy+XoVkceugkq8E6Pr8=;
        b=Ur1wJqr3m2Wha4a5FnkhmNX9YKLmY7i9VsqsLIyzykT1BWoGAC6W7MtcrO2EAGWDaq
         uCTXXx9Ziw1GQLFZO6n5fOy/sHuyZdRQgUmL2P9ZGzKDWlNIpPgcTDtsuV9aydsFTZIa
         sDSrWjSwvQSXSlO+HfL4HWRKYYZA25fAUk0++AyaQ2Nbv2f1EFZVBUkQCRt7a4U97QJr
         wZJAbr0QroR2XcrwoovKSmfBrHaDAdhlwfEKUdMADLzJYPvIHU+LpA0wHglEKlM/8qbc
         mAT2DrHQHnCFwmJAuKkNljJV3RMV+8hBT1oTjy71rJeKZNipV6lvURA6BTMfyMbfGShk
         nu9A==
X-Gm-Message-State: AO0yUKUOVZEFZlqgZzPwvRsfBJ0aUxs8rFf2qWBS1uGIt4V66DJMvIRI
        VHCcZM5J9LhddVG9Bja5yxpYb2sA4nlvxNbYIcTOlC2F6HgygLDAOxIX2c4Ln8CJzROQTQZR0/M
        0uEw5fVnw1A8K9A1t8jjcPdeb
X-Received: by 2002:a05:6000:1c5:b0:2ca:fd48:7c1e with SMTP id t5-20020a05600001c500b002cafd487c1emr2573784wrx.48.1677600224598;
        Tue, 28 Feb 2023 08:03:44 -0800 (PST)
X-Google-Smtp-Source: AK7set9v0g4E7whTc7rYOu89mROUSRxzGr6QXBdhfOQaLBzNnR8lC5RcL1m+NJS3PUR1LZvjFt2e1g==
X-Received: by 2002:a05:6000:1c5:b0:2ca:fd48:7c1e with SMTP id t5-20020a05600001c500b002cafd487c1emr2573757wrx.48.1677600224266;
        Tue, 28 Feb 2023 08:03:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b003dc1d668866sm16485490wmi.10.2023.02.28.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:03:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Vikash Garodia <vgarodia@qti.qualcomm.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
In-Reply-To: <87356wn6xf.fsf@minerva.mail-host-address-is-not-set>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com>
 <6f97a117-0d9c-e21b-9adf-50f2233ba9e3@leemhuis.info>
 <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
 <CAFOAJEdBbzqkGVqw+vgNYNxyaTHwvjFyskTwjycP820L2tOctA@mail.gmail.com>
 <b548da46-bf91-6f1c-4b63-4002109056bc@leemhuis.info>
 <9a0bfef8-0b5d-f4d0-a8a5-4bbcacc5c0fb@leemhuis.info>
 <DM8PR02MB8169E16569616870A583B376F3AB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <87356wn6xf.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 28 Feb 2023 17:03:43 +0100
Message-ID: <87edq9hj4w.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Vikash Garodia <vgarodia@qti.qualcomm.com> writes:
>
> Hello Vikash,
>
>> Hi All,
>>
>
> [...]
>
>>>
>>>No reply from Mauro and Linus chose to not apply the revert I pointed him to.
>>>That at this point leads to the question:
>>>
>>>Vikash, did you or somebody else make any progress to fix this properly?
>>
>> We tried with different settings for the registers and arrive at a conclusion that
>> the original configuration was proper. There is no need to explicitly configure
>> the secure non-pixel region when there is no support for the usecase. So, in summary,
>> we are good to have the revert.
>>
>
> Perfect. Thanks a lot for looking at this.
>
>> Stan, could you please help with the revert and a pull request having this revert
>> alongwith other pending changes ?
>>
>
> Other fix posted is "media: venus: dec: Fix capture formats enumeration order":
>
> https://patchwork.kernel.org/project/linux-media/patch/20230210081835.2054482-1-javierm@redhat.com/
>

Vikash,

Could you or someone else from QC please Review/Ack these two patches,
since it seems that Stanimir moved on and maybe is not working in this
driver anymore?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

