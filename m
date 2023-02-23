Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020866A0385
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjBWIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjBWIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E42BEFA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677139505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+ueFbDYI2fCK6KAGkfWDv0qOw1/uXZTIg/vtWRlPiU=;
        b=cq26F0Z+wJIM66dgiU3PXLHLYmxaC5g8BmUEIg9pNep9Su9pbvqoZxEqiZi5hzZ6jDmRSl
        8VyJI7h+9/e+IO0i9nwqHL18WrE4H82XgO5dgsKsiaaMWCIswfXJuk+SrT1ylDkP7ODFdW
        ITs/lk9vV8DFG6lOpgJeJ7PSiOIQEvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-Jp_cEiK_MYCaFKqcqQN_Rw-1; Thu, 23 Feb 2023 03:05:03 -0500
X-MC-Unique: Jp_cEiK_MYCaFKqcqQN_Rw-1
Received: by mail-wm1-f69.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso4012376wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+ueFbDYI2fCK6KAGkfWDv0qOw1/uXZTIg/vtWRlPiU=;
        b=eBsbHSFz+ZuYCIA4JMh+df9U+xjbWmh56uVwlj5VMPbDDTIPPjeZVSCqR6fdn+37BD
         Kjmu5ZPfYyzQzAB5R/WkiN9J3iuo9I42vYnT5AGvZnJl9M3UIQLXzsWNJZU6YjGgW1pG
         UPjygKsVlETXjEsqk0a4ZZAjRFGDbLAMmY0/kYEW04gWK07j2CTB32t3zPX7qIEd9AYW
         mrvFJpSNA3d8SQWK18aKjR+P+7Zse1amZnWyW5uFDj9bGmtYeAp6Qc+xO8mnLJbfwrqP
         T1l9+hua1OtlAvDhT4AdoEjpWz/26EAsPHsZYLKFZ0CIRltRD40QtsZtISRORsIcaovA
         8DYg==
X-Gm-Message-State: AO0yUKWQBjTLhUeXunBWKMg70M5iN0k1xgp8QrMsgKcCk61AOYhAuDsz
        V9/fSxT4lwFdPMPo/EEdrz12rf7SdAxQeIO+l8EYKs+ea1ZuBHHjcyV0RDT+xcQ87/+/rUo3qTp
        8N5M004XMPwxAtXoxPbyc/8nH
X-Received: by 2002:a05:600c:3093:b0:3dc:555c:dd30 with SMTP id g19-20020a05600c309300b003dc555cdd30mr1930917wmn.27.1677139502051;
        Thu, 23 Feb 2023 00:05:02 -0800 (PST)
X-Google-Smtp-Source: AK7set8C2KkhdFOu+LnX9wVb8yRJ6czYkak4zwJwTlRC59nu1vtOB2+Qi4rT251F92cwGEsPeVo5bw==
X-Received: by 2002:a05:600c:3093:b0:3dc:555c:dd30 with SMTP id g19-20020a05600c309300b003dc555cdd30mr1930899wmn.27.1677139501762;
        Thu, 23 Feb 2023 00:05:01 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003e1f2e43a1csm10728694wms.48.2023.02.23.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:01 -0800 (PST)
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
In-Reply-To: <DM8PR02MB8169E16569616870A583B376F3AB9@DM8PR02MB8169.namprd02.prod.outlook.com>
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
Date:   Thu, 23 Feb 2023 09:05:00 +0100
Message-ID: <87356wn6xf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vikash Garodia <vgarodia@qti.qualcomm.com> writes:

Hello Vikash,

> Hi All,
>

[...]

>>
>>No reply from Mauro and Linus chose to not apply the revert I pointed him to.
>>That at this point leads to the question:
>>
>>Vikash, did you or somebody else make any progress to fix this properly?
>
> We tried with different settings for the registers and arrive at a conclusion that
> the original configuration was proper. There is no need to explicitly configure
> the secure non-pixel region when there is no support for the usecase. So, in summary,
> we are good to have the revert.
>

Perfect. Thanks a lot for looking at this.

> Stan, could you please help with the revert and a pull request having this revert
> alongwith other pending changes ?
>

Other fix posted is "media: venus: dec: Fix capture formats enumeration order":

https://patchwork.kernel.org/project/linux-media/patch/20230210081835.2054482-1-javierm@redhat.com/

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

