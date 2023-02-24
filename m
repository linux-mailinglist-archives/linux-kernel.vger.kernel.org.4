Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D56A201C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBXQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBXQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:56:13 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919D63A28;
        Fri, 24 Feb 2023 08:56:13 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jo29so344217qvb.0;
        Fri, 24 Feb 2023 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUkUWtrXiLo4qYaXDaVs8ZvydqkJfRfk6fAOlcKEJsw=;
        b=ezFJGM1hHFN9qCKm9hFFfXns4wrecwjN4nbd6e7Iy7qqaKJk/Chdi+Rtb8j4H8jqND
         UNqUIuVVm2WoA8nbT55V3d6HcBsuqp9HWgRKsROcmKQF2mGlS5uep2a9df1gE9wwsz5a
         rJjHWzLD2x6Qx+4a+ABGhlIio5cwrVypG2m5FqtVRpbzI4nCWWq2BF/RpUgW3TGJRhHg
         qYESw/2Y97h8gxix8daD29qq0yCBrkBmlJSIU68P7M4XFe/Lcb7+SfFjSGZnWZX9t8lk
         Ai31sEFyGkZySC8pwwv5fi5evtjWgJwuzE2PA62biYYNUZYPFoZBbJCZDJi5VSjDPWa4
         V13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUkUWtrXiLo4qYaXDaVs8ZvydqkJfRfk6fAOlcKEJsw=;
        b=uqSV/R8FiVgOk7ZDINA1tfL8yTpngIHDsM6tqylxmukjPNRdpB9OT/LFvJLQXC4Oe2
         8p2OTfs6SjEzdIo7jATd9wnoQVGDIPROSOYfWH9lcAfWozNz/H96zwYYtUxxNkODhu47
         Xms5LCJLEvrDhvbIXzXV5eGynZz603gGnfJ8mjIwbK8P6V9iZ0RkpEc7whLQo0A26b3L
         OKF7vAbfobxJl/voxNt4vkWzfZFyxeUQ+/zuyS6yWlOOBK+R2b9QNhky29iBB7Ii1ZzU
         3WdYf1m3HSPxIyNnrqivaGaT2ocE9ssA6YxCUg31/trSsSRxZDkA9pAZKQ69vq1MDDwm
         quCQ==
X-Gm-Message-State: AO0yUKVPm5NfNBpFyxIZst4VesQcFRrjRysrdkz/lD3Rh/YgxgddSzIs
        DnqXGmPDY1kcjQtDsNNiNyxcfx2E5+dw4IwZpxM=
X-Google-Smtp-Source: AK7set94EEqnta+h3dkGqwT3ndEx2n69ozij2dvRR5g/Cc7FrxNSN4SGrdqPR20UJ+49L/Q1ig8TeG2PvrfjbKhEoRw=
X-Received: by 2002:a05:6214:5e13:b0:56e:a4c0:cf64 with SMTP id
 li19-20020a0562145e1300b0056ea4c0cf64mr102406qvb.3.1677257772126; Fri, 24 Feb
 2023 08:56:12 -0800 (PST)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 24 Feb 2023 08:56:01 -0800
Message-ID: <CAFXsbZqnstOLFBrVVa7aFLSGCPNj4VkjExqq1XUoRdUUuBKdog@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/msm/adreno: Use OPP for every GPU generation
To:     dmitry.baryshkov@linaro.org
Cc:     airlied@gmail.com, Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        konrad.dybcio@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        quic_abhinavk@quicinc.com, Rob Clark <robdclark@gmail.com>,
        sean@poorly.run, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I may be missing something, but looking at the code path for a2xx,
it's not clear to me how this would work with SoCs with a2xx that
don't support 200MHz for GPU frequency.  For example, the NXP i.MX51
requires the A205 GPU to run at 166MHz while the NXP i.MX53 requires
the A205 GPU to run at 200MHz.
