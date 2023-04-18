Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964FA6E6F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjDRWVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDRWV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:21:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B79EDF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:21:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud9so76777647ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681856482; x=1684448482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRUCLZpCTJva3ZJ5YvwKCeVkHO7TB40DF1q9XyINrr4=;
        b=Hlk/yOfAg8ZObQAF9HFyo2GjdAU+uGuu9DIGoZG7BwKbCF3FZOJKCydiYKbyItjtmu
         BbI3eTRdqZZJ8P8ym4SEg0069gk7JvMNWIM1ky24htEX7HkJeYAD3+e9pUyyIw0mGB+p
         HA+Mfv7ndAh9f1OGPYF/YilJ8yB5N/k14y0kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856482; x=1684448482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRUCLZpCTJva3ZJ5YvwKCeVkHO7TB40DF1q9XyINrr4=;
        b=Hx/I391EJkgr828XPC7w/UGOhqrO5S715ks7vR5C7T41flEeVJffirssvWp02WqRqv
         XNHESGBPRyCohHG8eJ2520jGxrnUfS3ijjoFBx4Es8Kd4ZT8wohhO+Kw1u7Oh43Lo6Wq
         Ul39qqLGhUEekR1uaeWvFoeSdqQu089aiDNLfyWKY1JexBxlR4X8vdtTDhqZqUdYU8sJ
         AM7mJshdY9YeOl26oTUwDIiSovWhT4pcW/UqEgzK+xDRqRYbugflwXctNAI8PAtSlQ1T
         hOvutiGgiOFfr8acg0NBw4x7+NX3f1GW5ldf9WElueF3/Nk5TR2ABumdT9buh3bD1iis
         F/JA==
X-Gm-Message-State: AAQBX9cUcf4G9Wkge5fo0ZMb5UtswlBQ6arO8Ne/NJYVJ/XLwr0JQvcZ
        2Vn1+OL3tFWpP27Me7XjC3dDd7q/VK9BQejlXcXUvw==
X-Google-Smtp-Source: AKy350YjFQqap0I29vHhZViyl15BXkwFwFm+fofHlDVLsUrYiRBK/YW7xu9Whn+9NtUF3+f0tsmjlQ==
X-Received: by 2002:a17:906:4e15:b0:94a:4e86:31bc with SMTP id z21-20020a1709064e1500b0094a4e8631bcmr294875eju.13.1681856481881;
        Tue, 18 Apr 2023 15:21:21 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b0094f185d82dcsm5653877ejc.21.2023.04.18.15.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 15:21:21 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so25977411a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:21:21 -0700 (PDT)
X-Received: by 2002:aa7:c852:0:b0:505:d16:9374 with SMTP id
 g18-20020aa7c852000000b005050d169374mr313244edt.9.1681856480915; Tue, 18 Apr
 2023 15:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
 <20230418213228.1273218-1-neal@gompa.dev>
In-Reply-To: <20230418213228.1273218-1-neal@gompa.dev>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Apr 2023 15:21:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMQLbRPQd+AmP6eiu1jnRQj6QSDnhbsetu23Fx2jW0+g@mail.gmail.com>
Message-ID: <CAHk-=whMQLbRPQd+AmP6eiu1jnRQj6QSDnhbsetu23Fx2jW0+g@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-16]
To:     Neal Gompa <neal@gompa.dev>
Cc:     David Sterba <dsterba@suse.com>, David Sterba <dsterba@suse.cz>,
        linux-kernel@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
        Chris Mason <clm@meta.com>, Boris Burkov <boris@bur.io>,
        regressions@leemhuis.info, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 2:33=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrote:
>
> From my perspective in Fedora-land, we've been running automatic
> weekly fstrim on every Fedora system for three years now[1] and
> have not received any complaints about SSDs pushing daises from
> that.

Ahh, good. So we do have a lot more test coverage than I expected.

Then I withdraw my concerns. Hopefully it all works now...

              Linus
