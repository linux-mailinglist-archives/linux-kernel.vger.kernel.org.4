Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C556B288E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCIPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCIPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464CA17FC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678375137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9yFC6UG6Qb69zCObh92ltCysfwKAZhk1RaD2VUDs0U=;
        b=dH8PZj1ac1/EgN/32jsjQRyEc0AS8hMJEkbrJWg8PI2ezdP6/4k8YsR3YVksLSoYIKUqWm
        u+6OxWQjk3AiKINxkkLY0McOKpIQvUxXf+qVm/+G6YnWvjreI2Xd8XnOL/3xS1m4q82Fcm
        dbdbKWozIjRWJeJt/TxI0rKgyuDp4HQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-gw5Z39ttNXmMRGLN0sytHA-1; Thu, 09 Mar 2023 10:18:56 -0500
X-MC-Unique: gw5Z39ttNXmMRGLN0sytHA-1
Received: by mail-wr1-f69.google.com with SMTP id m7-20020a056000008700b002c7047ea429so524961wrx.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678375135;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9yFC6UG6Qb69zCObh92ltCysfwKAZhk1RaD2VUDs0U=;
        b=tBsUvbibtS1kvg8CkZ36FuRC4aAAV89+D6b2/+Oe3qmbeqBALTqwSNO4JKIjsc61Xr
         MziLocClulYHS1VaeyCZpai48SOJbtIRG2U0wA5klETp4kck6RkQolU23RN1VMZwnxXQ
         DHm64Z4qq/gguneWsgfiFe726AUBdea2vT2poNX5ZDKeSTuly8grcin6gK2Te74GdJ1k
         GnTZLCt2mtYOSTXpSQNAoclnZNTxBxyjya0Qe9SuKGaX62HU34JX+kLQPi8G+gpqIC9u
         NECRFXFZMOYncO2D6dBwKZNmboIq8BuzyjFcNAw8+7pjfD+ZRmmA97wzo6U3FyiLcQTg
         1PRQ==
X-Gm-Message-State: AO0yUKURar44B3qtLwua3BXkv4o6Y6z3puF51KiyVe1VQ+fdzLzKkDrb
        ooYzw5XoCSU9BHNy8usVYIE9aM4+Fo1c5+xRZkJPTb5Q19mlutDqxALq9BHc+i2ZcUdeKvodOri
        lzLUUfW7PQGdWKaem4EZRk0Zf
X-Received: by 2002:a05:600c:198e:b0:3eb:36fa:b78d with SMTP id t14-20020a05600c198e00b003eb36fab78dmr19471524wmq.23.1678375135004;
        Thu, 09 Mar 2023 07:18:55 -0800 (PST)
X-Google-Smtp-Source: AK7set/hSS1pZuG+MnQuREyxGPFkGYBqTYNoS6/zwRI22k5tqtoTJHGML2449NbBIDvfKh+VFM7Fmw==
X-Received: by 2002:a05:600c:198e:b0:3eb:36fa:b78d with SMTP id t14-20020a05600c198e00b003eb36fab78dmr19471510wmq.23.1678375134671;
        Thu, 09 Mar 2023 07:18:54 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b002c569acab1esm18202922wrm.73.2023.03.09.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:18:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jordan Crouse <jorcrous@amazon.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>
Cc:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
In-Reply-To: <20230308181245.nbnwkdtdnsldd65l@amazon.com>
References: <20230210081835.2054482-1-javierm@redhat.com>
 <20230303220918.qr5ydbin3nye3qtz@amazon.com>
 <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
 <3d0315fa-14ca-dc34-81ae-467d9ed5133d@quicinc.com>
 <87sfeh0yjn.fsf@minerva.mail-host-address-is-not-set>
 <CALE0LRvR=DjUp2_DBuPQkEr9jvzGH4Mx4-7=rc6zOw1APQdyeQ@mail.gmail.com>
 <20230308181245.nbnwkdtdnsldd65l@amazon.com>
Date:   Thu, 09 Mar 2023 16:18:53 +0100
Message-ID: <87ttyu54wy.fsf@minerva.mail-host-address-is-not-set>
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

Jordan Crouse <jorcrous@amazon.com> writes:

> On Tue, Mar 07, 2023 at 05:20:18PM +0100, Enric Balletbo i Serra wrote:

[...]

>> >
>> > But regardless, I think that it would be better for a driver to
>> > not change the order of advertised VIDIOC_ENUM_FMT pixel formats.
>> >
>> > Because what happens now is that a decoding that was previously
>> > working by default is not working anymore due a combination of
>> > the default being changed and S_FMT not working as expected.
>
> For my part, I was using the gstreamer v4l2 decoder which for some reason tries
> to verify it can support whatever format it gets with G_FMT *before*
> trying a S_FMT. I can't confirm or deny if S_FMT currently works or not.
>
> That said, I entirely agree with Javier. While it might be more
> bandwidth efficient, QC08C is a obscure format. It is far more likely that the
> average open source user would rather use a well known output format and, as
> has been mentioned, once S_FMT is fixed those in the know can use the other
> formats if they are working with other Qualcomm hardware blocks.
>

Agreed. The rule is that the kernel shouldn't regress user-space and the
patches that changed the default format certainly did that. So from that
point of view I think that this patch should land.

There's also Enric's point that NV12 is a more common format and supported
by more user-space programs. That's why think that regardless of the S_FMT
situation, makes sense to revert to the previous default behaviour.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

