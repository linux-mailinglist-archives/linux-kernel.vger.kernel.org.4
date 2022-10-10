Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E34D5FA1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJJQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJJQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:21:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90358357F2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:21:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l19so7404714qvu.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gCXkPCufnUApTpV2R6PlJM73frkuXRqcf3yIfVONok=;
        b=MIztVJ/UcdDMRGGPnOcNP2Ta7EvfAe5S3XYt3YZEBcIVA2VHVSRHCoJRcpo57mXI4z
         Kd9BKK6SGzC1iro0Ri1olluFhWmBBL5h2jGYCRpXGbNTMKPSJG1ErhNpDV6enqwF7i07
         ZfeO0pRc8+frliaj+VhiCuo2PMqNxRjoCMUZzaHGw+1eRQLMXxfOVAjRdXzW/jzUdkx7
         gWrFb4zOUPNTMM4BjJyrMwh8fRsTm97N7TEFmt6U6w6t7dyme+fuhzR1l2pe03vyqjcC
         +7rsGu5oDIp77OnZSvO2NFg/rFcw0ukLMK9Q+5aHn22aZmPfiRzE/ihYLqQnV2Fu5T+Q
         DuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gCXkPCufnUApTpV2R6PlJM73frkuXRqcf3yIfVONok=;
        b=sITkI2AB4xqv4i4hQfFiPzr4Fh7l+gUcTYMUxQ0TShkyeRFWnoh9FSqMlfQ3uqUJR2
         TC1qoV6CHzNxcUe9o/B0L+fEVU4hQz6ijwcxfWqTJzwIESMUHbCn2eOWI3qp3vc3JO+5
         yWpALeYQWKLa/1fiB7Wq8beLdENNhyLmPlaEuV+B1iS2tseIJYnHciwyOjw8BgVBYioZ
         1sHc2annGYlPYtM+Rh2BWzBMaKkZbdhW/dTnU7kMLjcbUyc/xqLmPscG+GpEh4UGDvnR
         uhCfASwp0R/1DXzhLoA6h3q5XAa5lrB185qNytf535aDSKFLk4NFcczjc+WJiIM3c/Mo
         RQ8w==
X-Gm-Message-State: ACrzQf3JNsdk47hiZ9z6VcpYn6SVIOtbsVZaG/s3J852dfRtJDbdCN8A
        DswshCIxuLbFOa510usTzTVJ8zb/LPUVyn8KqVB17SL0sdGjrw==
X-Google-Smtp-Source: AMsMyM5wEawZge2jf3LPkVZmf8vhqfeRbYmHXltTxc6nWhwrC4Hq17e90s0DOWCITzj9421zpC1KDlEkDumJyXHyY2c=
X-Received: by 2002:a05:6214:f65:b0:4b3:f4f2:fcaa with SMTP id
 iy5-20020a0562140f6500b004b3f4f2fcaamr5835559qvb.48.1665418865590; Mon, 10
 Oct 2022 09:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221006152643.1694235-1-zyytlz.wz@163.com> <20221009201418.509417-1-zhengyejian1@huawei.com>
In-Reply-To: <20221009201418.509417-1-zhengyejian1@huawei.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 11 Oct 2022 00:20:54 +0800
Message-ID: <CAJedcCxC=Tkw59RGMw8pGmcUxkCMe41YfMJ0jBRoNT-3GswYOA@mail.gmail.com>
Subject: Re: [PATCH v2] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     zyytlz.wz@163.com, alex000young@gmail.com, arnd@arndb.de,
        dimitri.sivanich@hpe.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
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

> Return VM_FAULT_NOPAGE or some other VM_FAULT_xxx code may be better?
> Since return -EINVAL may confuse upper user
>

Hi Yejian,

Thanks for your reply  and sorry for my late reply. That's a good
idea. I'll fix it in the next version of patch.

Regards,
Zheng Wang
