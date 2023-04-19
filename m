Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E76E7A67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjDSNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjDSNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:15:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72ECC3A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:15:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f0a0c4e1ebso33630925e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681910115; x=1684502115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAXLfpBdEAZ7L9LyE2Dg6CDtrTU5pXyCTIUvkFoTHg8=;
        b=ZS/dsr8o5NpgoYkkfd/3H7xxe/kLwMYGVOQy8b4vjCn8zoRO9L5pS/krQwN1MS6WX3
         WjePneq03bl0lTuCybclj+9X3iXjEH+z849HJl/IRV8unddHgiCz6p1gAeIxqlOwTNXH
         TqnxA5AfMf77kUjGYm1Zk6HeSuw8Ox0YyeSXX8pBev6nGKGuszSJugwP6Yo32+rxBKGb
         DJ1+/iLWVq0s2c6r+UzzrgqzAy85zcGnueQxtr8Bfx5qe7m5IAZSjtE/ZFfVxnLJzW+z
         KrjeyQ3Ya2jqQ2JPVZ19oH5QOd9XjX5/9BiDKVQ5qbyggSM7kGwjXKhW0cZPsol1Y+BA
         3ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910115; x=1684502115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAXLfpBdEAZ7L9LyE2Dg6CDtrTU5pXyCTIUvkFoTHg8=;
        b=gGxNabKde92hCiwTOO6QtxfVIrmXWYxFnKoQp0fp4gCIvP3BWYKXgkLKGYBsrZwMrd
         7ZnTqVdDzh4L4S4POuNeUVb6DkYB4vQiuYlemM9Sm4vKvdECyXrVrz5NDxIcDHUkTTIr
         7PEUJzStCytwPPhZduJUD0jyl/sZC7jvIBgQ/jJ96NfXv5YIoraE4N2u7iLGqrKHIAAJ
         PUczKoyP0W5xHQKdnoZyQnmOFvugrkkeEso2YkoOKNZaE2TfLwiBSExC/0I53gqwHl+f
         fN0dQsiwuRcWsGpWBFRxVaYhhRrhPg6MpUHr7CGXAxKtOcHRLfxo14s3RsNSvC8j9ifB
         iLsA==
X-Gm-Message-State: AAQBX9det3TJUl4fIFCbWeI/28tOcpaAN1YX9eQlb/Pf2xFef/MgpgED
        GwJP98n9EPAF4/cEs4I4r/A=
X-Google-Smtp-Source: AKy350aPlsjK13S7C71KRWT/oio7uG4H/s8dmBtZ5+MH8hC6XWxHMi8d+uyiP3QrliiFBV539Q/y1Q==
X-Received: by 2002:a5d:4242:0:b0:2ef:b7cc:289a with SMTP id s2-20020a5d4242000000b002efb7cc289amr4229298wrr.7.1681910114853;
        Wed, 19 Apr 2023 06:15:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:6273:6c76:9697:9b4c? ([2a02:908:1256:79a0:6273:6c76:9697:9b4c])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b002f0442a2d3asm15804492wru.48.2023.04.19.06.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:15:14 -0700 (PDT)
Message-ID: <d96519fb-9e12-5a81-a60b-384dcb286f28@gmail.com>
Date:   Wed, 19 Apr 2023 15:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: BUG: KASAN: null-ptr-deref in drm_sched_job_cleanup+0x96/0x290
 [gpu_sched]
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <CABXGCsPZxgpFzAVN=eFXu0WV+Jk0vB4rv4p+Jt31C841LcqV=A@mail.gmail.com>
 <CABXGCsO0sST8+MvQs=T1JP49ogRsaHPT9gMQZGJ3dY7v3m0H8g@mail.gmail.com>
 <CABXGCsOTEpJG_0NWdGXRvcXQ4iTav6AUJm-U4SQb-vVzjoL6rA@mail.gmail.com>
 <10b2570f-a297-d236-fa7b-2e001a4dff12@gmail.com>
 <CABXGCsPcPY8dqZm0aF4c1p0ZvMYHy+NksMrZi9xK0=WdE5_osA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsPcPY8dqZm0aF4c1p0ZvMYHy+NksMrZi9xK0=WdE5_osA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.04.23 um 15:13 schrieb Mikhail Gavrilov:
> On Wed, Apr 19, 2023 at 1:12 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> I'm already looking into this, but can't figure out why we run into
>> problems here.
>>
>> What happens is that a CS is aborted without sending the job to the
>> scheduler and in this case the cleanup function doesn't seem to work.
>>
>> Christian.
> I can easily reproduce it on any AMD GPU hardware.

Well exactly that's the problem, I can't reproduce it.

Have you applied any local change or config which could explain that?

Christian.

> You can add more logs to debug and I return with new logs which explains this.
> Thanks.
>

