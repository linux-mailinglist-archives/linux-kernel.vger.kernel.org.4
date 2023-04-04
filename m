Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF83E6D6D61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjDDToX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjDDToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:44:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779F5252
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:44:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so135176536ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680637450; x=1683229450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JHiQLQ4dqHoCx9VI6e9yGRcga3qGDdfBjn0lgNBieM=;
        b=OHW1YE7CnqLehmIKlGxDAaoPGmF8m+0t+Lj/KLuQl/xaIfg17JICEEnTi4VEH8qTYd
         82frSjRAWG7DbXuEASWBeGA/CWAMt36cPTyfqQ7pdqhbgr94d4Rzo2DQrWU6GSTfEkxn
         9n9lnJKYvLuQHWTufSo0B9TzTWqcLdAMji0w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637450; x=1683229450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JHiQLQ4dqHoCx9VI6e9yGRcga3qGDdfBjn0lgNBieM=;
        b=bL3jnjmArfhI/gn7kIjanRkwfigm3Wq7LednRLmTI/2b57lsi9F4Deji0LKoUb4fAs
         rsmC7U/dmB8A/GxYC975dbUm+3hpVrbnz+/8JtadK5bGoGPMs64bdq8WBZMJPwhD+xZL
         hjYl8bCwr8jjyrUtVhj11aql33BvZVJtaJNWeIgwjWt21jBpFBTQi2oSRylqEzXQXS4S
         zTEZZwvfMKhEXjn1NbB0/CY/RB+BdkjXICwPxCcpQ8sh4uaKDwNQVR9Oxdy2KZBkVQqT
         7nibALSLkg0ogQj6eDdfjN7n9EzaCz6CmxaXnyMbiYLRyQdBcuEVKXmRuiED8Aw3DQ4y
         5s4A==
X-Gm-Message-State: AAQBX9fBCWjtZ9nnNDMHpbHCn8E9hMAO7YwkQEfgA8kCDR61C61QPjqh
        XOoctGqq2YjGcXTQugCIBttH9g8jrKRPRC2UOHiGRw==
X-Google-Smtp-Source: AKy350Zk6u6QrmscBMUoJh4YU5za4AmkwwuDPcBK9cssi/sCeaOefFReUV9pX5dS/Q4pqa1c5ko5Ig==
X-Received: by 2002:a17:907:3201:b0:949:55fd:34fa with SMTP id xg1-20020a170907320100b0094955fd34famr272996ejb.39.1680637449644;
        Tue, 04 Apr 2023 12:44:09 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id um4-20020a170906cf8400b00928e0ea53e5sm6328569ejb.84.2023.04.04.12.44.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:44:08 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id r11so135166821edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:44:08 -0700 (PDT)
X-Received: by 2002:a17:906:3b07:b0:935:3085:303b with SMTP id
 g7-20020a1709063b0700b009353085303bmr343112ejf.15.1680637447927; Tue, 04 Apr
 2023 12:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi92YtfjcczOm20_mYkWZwKKjn+dCcrx8BL9n9f55MY5g@mail.gmail.com>
 <f78f2735-b533-4912-8cbf-0f545ce23fcf@roeck-us.net>
In-Reply-To: <f78f2735-b533-4912-8cbf-0f545ce23fcf@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Apr 2023 12:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRya_yH3YZ_P0o392K2DEbgTpQ-43GmkojJgADKxXPoA@mail.gmail.com>
Message-ID: <CAHk-=wjRya_yH3YZ_P0o392K2DEbgTpQ-43GmkojJgADKxXPoA@mail.gmail.com>
Subject: Re: Linux 6.3-rc5
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 7:08=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Finally ...

Yeah, well, I had to take the fix directly (and another that Thorsten
had been tracking) because the usual channels were not working right.

But yes, finally.

           Linus
