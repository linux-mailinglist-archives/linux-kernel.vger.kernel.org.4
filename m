Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90275F2802
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJCEhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 00:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJCEhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 00:37:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132E1F2E9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 21:37:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id ay9so5807303qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 21:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BvAlvanR3o7fXwx9KEh86a8oE8coV41tHMYXTm6mxvI=;
        b=nsLU8NdaXsSd/W61Jc2+eOY0OKIQkyGMKj5oGWlPAndHS2M+HF6uBSe+oPNyQAjvk9
         v2rq7d39Q6KucH1zaGV+ejvoiyvCOTleSkmyMGoWyBjf3wRAnud/vntV05OErzo+Aw34
         1fsfaIiY+LLEBxMvl1+MlIVloqgjN6dgfXXl6koB1gOFzDOfWHgjlTSC5pND/POUOnUv
         K9YpuSBUZww4m3pIv+9oXOUQIVkzdHjsK6OpDNSacCmCHirrQKFWjIDudyLWEdunpaut
         g82Np1YobhWhU4nucWrwTSOfji/dHvZ9mzb4iLSUaASXhv+HsVytsg4CvLdWRDRCCrws
         vWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BvAlvanR3o7fXwx9KEh86a8oE8coV41tHMYXTm6mxvI=;
        b=0qEOT+4q4hW0P7SJAZUSTdJJUoHOgS8x0fO1k7i8W+qQ7lViVBQuCMk5UhF+HDh7IL
         QX0I/COL93elmG7vlCBV3lQI5NOnqSg3TOjbKgSo5Pqsbdedhp85Tq+ZeeFU1oyp+o2o
         B8VvNE5CF2CupnfxXHJo7h+IVMFujeMz1tggrSxN14DCLCs4a26d8f6XYnEc8U4a+jTv
         Hqro18zLXutPdcsgl5Fq3qoqOtYPX8J/v2UheG7ceZOMe2cM+YeuZpsgy1M/OlXW3QdQ
         8Vcyr49vCnEahotzzYkqtz2eD71+nCYCiJeAw4MYdIavvIrD2AomooqmngNuQiAv17yx
         yc/w==
X-Gm-Message-State: ACrzQf0rVhYKAoDYNBK/5RHki4sugJMWaHMqzGSd+RoIWMHbY4NzKv+4
        S6pMGu9Ak0bGBJ2WnotjViDXqrXqeHtAfAS0jIKkOAUX0KMVeQ==
X-Google-Smtp-Source: AMsMyM5Ztt/VxNlvaOYQvQLHOHvlYqVhf5VigvFxWXmC81iKMpkY36bXzW3+VfKnu23HeokGiLuY8vwWw6k+VZtsIvA=
X-Received: by 2002:ac8:7d14:0:b0:35c:bdbe:5b97 with SMTP id
 g20-20020ac87d14000000b0035cbdbe5b97mr15029892qtb.272.1664771828453; Sun, 02
 Oct 2022 21:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJedcCzjWw6v5Nt42jsCStdpwHuz13D+q-CD=6ycVWBczY+4mg@mail.gmail.com>
 <20220928033340.1063949-1-zyytlz.wz@163.com> <Yzmds3DXu32EeSO5@kroah.com>
In-Reply-To: <Yzmds3DXu32EeSO5@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 3 Oct 2022 12:36:56 +0800
Message-ID: <CAJedcCy5TbdskDVK5Z2-Bm9gTG+sbo1KkFn3_2n65Sno7xG+ag@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, 1002992920@qq.com,
        airlied@linux.ie, alex000young@gmail.com,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        security@kernel.org, tvrtko.ursulin@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That is a horrible way to make an api (and it should be a bool too.)
> Now every time you see this call in the code, you have to go look up
> what the last parameter means.  Just make 2 functions, one that does the
> "is error" thing, and one that does not, and that will be much easier to
> maintain and understand for the next 10+ years.

Got it. I'll figure out anothr way. :)

Thanks,
Zheng Wang
