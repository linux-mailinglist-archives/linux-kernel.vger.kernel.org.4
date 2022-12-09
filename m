Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C4647FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLIJPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLIJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:15:06 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662FB63BB7;
        Fri,  9 Dec 2022 01:15:05 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id m5so2029567qkg.0;
        Fri, 09 Dec 2022 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkNH16lJK5cpr24W+e3TLKkQ6NF2d3FSfHC2JAxh0HQ=;
        b=Vf7EfaprR2FWXYZoEFr4nULXvhAg4vH8fh190XoleOgARKjNI6S/4gBKL+lr7kpPCA
         k6ZYcRYGca2Z6aEQJ9BhJQAMSgRCP1hNO0/u1IjGXeeWEJUsvesHDOhZmqQpw/dMT0uo
         MEINBE9gU5aypPv0dsAuRSUYpvIE3JvRWFB6EgV2OP3v7WTwfKAustfbnW+N/7k5n3ME
         Xg02XDDsh3RMWW97xp0dawrQ3l2kWh2uZ0GXkGJgLEjmgTszL0jHokHt8AzUDv72f1uC
         yqu1Y61pSnjVgMioJt7GPK9R5EyAtAVEt6hrHvurPpxPg3dYqKZhkGLwX51CtPNYOW42
         jz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkNH16lJK5cpr24W+e3TLKkQ6NF2d3FSfHC2JAxh0HQ=;
        b=WJzca9eR2aYdL+6IkcrpZhSbvcWy9Sa974Tjx4l01Cqg64TQZ1DhI2QJgW/BM5Jnc0
         +bvfFfTskM3rCOPgpeXNszYmU+oZZ7ph4VUB5KiVNPMjkwH6kqC+C/BuGUuKbUGJZ3Iz
         gktRrAP34C7D500MnGIBl7bW3jDcIVLkm6luIGuP26zYz2kzOP5FA1bGaf8W0Eyda7/8
         XtZvKeRT2zinrEyPLKienjXAohdeuVpQTni95e4lRsXA46n1NaPuvdPzbrH1tcEwEpBz
         wylssH+1YaTrryfq6LSF1UNbVrLtgBwST4xQ/TrXKF8Sm4Ol7OsYUCIfGmmaUSvYRa1h
         KKIA==
X-Gm-Message-State: ANoB5plcDx6LDAZlWM/grpyfQIZ772dlT6R4Buy2sunXiXQcPoaEFd1T
        G0p2cK2TduKQ/3jQpeEaDYPp5oM0fMYh37mZGe0=
X-Google-Smtp-Source: AA0mqf76KaU82jdzpPytS9dB0ixtuhTvtbM0RObogfcPc99c9cNqkOE5Bgt9rgcbICQRaUjO5wAFpKRZTLcL+7HlVlM=
X-Received: by 2002:a05:620a:1aa3:b0:6fa:b56f:7ede with SMTP id
 bl35-20020a05620a1aa300b006fab56f7edemr83702189qkb.383.1670577304190; Fri, 09
 Dec 2022 01:15:04 -0800 (PST)
MIME-Version: 1.0
References: <202212091545310085328@zte.com.cn>
In-Reply-To: <202212091545310085328@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Dec 2022 11:14:27 +0200
Message-ID: <CAHp75Vcp_RmibkkSW1dCcypKU3okyRXbj8JrbRVFtErhuuAWJg@mail.gmail.com>
Subject: Re: [PATCH linux-next v3] x86/platform/uv: use strscpy to instead of strncpy()
To:     yang.yang29@zte.com.cn
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
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

On Fri, Dec 9, 2022 at 9:45 AM <yang.yang29@zte.com.cn> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.

...

> +       strscpy(arg, val, strnchrnul(val, ACTION_LEN - 1, '\n') - val + 1);

Instead of  -1 +1 you should simply use the sizeof(arg) as I mentioned.

       strscpy(arg, val, strnchrnul(val, sizeof(arg), '\n') - val);

The returned pointer by strnchrnul() either points to the '\n' or to
'\0' and when we subtract pointer to the start we will get the exact
length of the string. In case it equals ACTION_LEN the last character
will be replaced by '\0'.

Where am I mistaken?

-- 
With Best Regards,
Andy Shevchenko
