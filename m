Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECF67D3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjAZSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:19:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EC62D09
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:19:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so7364744ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eU4ffLLmoKUMoD8VgioPFjzuswerU7BADU2iY5BFLXw=;
        b=Clh2cMUjmWblxdE0F7lpyV2bxZd0CUhw6ZKxtbHeVTdASRlJ/loo1Icjcfari2lWLP
         IXs5Upi6Qxpq3zk/O55KxK11yMIiKW07UIQ4t3finDSlzKCo4EzzjwgXcdhImfDhhhHq
         zM6X01WylFV0TTOKi/Imd5rzMUBQnpKZJT4SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eU4ffLLmoKUMoD8VgioPFjzuswerU7BADU2iY5BFLXw=;
        b=PLP9PZQ6htjluEbICuKBIh7lMoi53+9UeIhGi0Yaj+PXVVHSPNKVWh6BgV5SU5FaQh
         EngAUuRv4EUiX+JE2IEwqM9PJdzb+J7TJVQr8YA1MFbuma1X1cXSSQpp7/TN+hGz/IdH
         yb5ewrZcfvP2ymJcpxGp3UsfG2+mvTcOTK+htV2irD2HxpzLqOg6/lLyLpObwJPoV3SN
         SSrqYHxXeYhaPm1nLCFM/nIXKyoUrYPyLxLokPYl/KR03abK+KVySbHR7pMfGgu3Aymc
         wy9XrAOZQS+IVbkeDdKHZ0XTPI/4msMrPuuNkxNFiGtmfcwXbkoemzAS5wiJTJ5kdRWE
         MA3A==
X-Gm-Message-State: AO0yUKVTimWToW5D3P///YKTa4LNTVx8qYcJT3ZCKsMUhbhttQywPLFl
        9rqsm/Yye2L4cXk8qk06G+x+fXOxozHYSEVGMnQ=
X-Google-Smtp-Source: AK7set9x0c93TzCy0UlcXaknyzbEMMuN0Y34LEKEGxihBYl/a9h2inKAz0Y4lC3iw5Ic7E3cw+d5Tg==
X-Received: by 2002:a17:906:2ad8:b0:878:7e6e:65bb with SMTP id m24-20020a1709062ad800b008787e6e65bbmr1039113eje.26.1674757172630;
        Thu, 26 Jan 2023 10:19:32 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090685d100b00878644b89b4sm920433ejy.202.2023.01.26.10.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:19:31 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id qx13so7311861ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:19:31 -0800 (PST)
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr3879889ejh.78.1674757171231; Thu, 26
 Jan 2023 10:19:31 -0800 (PST)
MIME-Version: 1.0
References: <1522976022.11185.53.camel@perches.com> <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
 <3de4cbc2198105bcbc09ee355cd69a8b8756b89c.camel@perches.com>
In-Reply-To: <3de4cbc2198105bcbc09ee355cd69a8b8756b89c.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Jan 2023 10:19:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSH8Dqfp2XVTeBrtAxf+2ZN_4pMjYOHwUt9i4NOGTkBg@mail.gmail.com>
Message-ID: <CAHk-=wgSH8Dqfp2XVTeBrtAxf+2ZN_4pMjYOHwUt9i4NOGTkBg@mail.gmail.com>
Subject: Re: git source files with rw permissions
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 8:07 AM Joe Perches <joe@perches.com> wrote:
>
> Maybe time to do it again.

Thanks, done.

                Linus
