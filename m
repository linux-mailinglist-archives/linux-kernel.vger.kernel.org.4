Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C08746189
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGCRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGCRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:47:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B241CA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:47:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6985de215so76312811fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688406433; x=1690998433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrPiqsH2v+fZYTv75jJiS+9QuM/0suNaTnIbRveJ6a4=;
        b=Jir9P3sMBmhbMjMpQZxaLsebk8i9hFaIljYhbysly471ikdLzuBIeC+KH2N14RCIPS
         b2W8dkUrSq2wY5SCQ9NVDJtpgmL6e5OScTLl+T/8tbrqB8E+YQB3Aw2lIy7bqOF0tPO+
         UUky9e9aVaV/+Y8AkeTeyJdURv+h+Tci5JOSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688406433; x=1690998433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrPiqsH2v+fZYTv75jJiS+9QuM/0suNaTnIbRveJ6a4=;
        b=UZEv2kSASz5zEfpr09Gv2lBYcqhViKbCVy5x3ZeBxAX3T0FUJKk9Oi+iE+O9YXarRe
         snPKQE7uCq5QomalbpiP+WdvvcFWgdgvPWh/JnGSTjGaGQ8BpM1ZBjO8QBc3hg01337m
         8P0ZSYDyIo5Hp979N2XaLQWoevaqU60+WNQXBxHVCDY1B7DeWLmVoiG176ZwImH2fg11
         bGpj2/htrqhCIGAlMuL5S45VQ5iFVduuEw90GBio+hFoSxZRUDor51GPmicRBaAEAh8g
         RZX1+/W/zjxuHIhDmXyo55xlGcYOmBQKoqzzUFOyiPAbZxbQyy49qytDD/STjTG+MAqQ
         CEkw==
X-Gm-Message-State: ABy/qLZvgqb8TWcciynzdRexLBanJEla/JKh2I6ZvEZ1YU+YFQYsFZqF
        fskpyzjXavRZWq+5/IVPRiF1mU7frH++1YMzLuWMRehv
X-Google-Smtp-Source: APBJJlGTW5E4iNhTCHkqEJqvY/IY2LuSMnLoArVZbvXseqSlOZ/IOQ/jaIGYHL9Z/61LoeaLZUB/fQ==
X-Received: by 2002:a2e:9b97:0:b0:2b6:a19e:5168 with SMTP id z23-20020a2e9b97000000b002b6a19e5168mr7530009lji.39.1688406433660;
        Mon, 03 Jul 2023 10:47:13 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cfd3000000b0051e06693590sm2670105edy.91.2023.07.03.10.47.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:47:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so5250801a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:47:12 -0700 (PDT)
X-Received: by 2002:aa7:c453:0:b0:51e:d3d:6498 with SMTP id
 n19-20020aa7c453000000b0051e0d3d6498mr3425756edr.10.1688406432318; Mon, 03
 Jul 2023 10:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020> <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <20230703-dupe-frying-79ae2ccf94eb@spud> <CAHk-=wg+jqA6nt36TxAfoqWskRAzhVfzBejcK6PNYXC+QcwyiA@mail.gmail.com>
 <20230703-regalia-preachy-136bf396e320@spud> <861qhoyk3x.wl-maz@kernel.org>
In-Reply-To: <861qhoyk3x.wl-maz@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 10:46:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijh9Gi14SRe0riD8Y9EdPpo3MNU_XDu8vpjY6xWdNhpQ@mail.gmail.com>
Message-ID: <CAHk-=wijh9Gi14SRe0riD8Y9EdPpo3MNU_XDu8vpjY6xWdNhpQ@mail.gmail.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
To:     Marc Zyngier <maz@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        lkp <oliver.sang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 10:34, Marc Zyngier <maz@kernel.org> wrote:
>
> Comparing with what we do on arm64, a less radical change would be to
> move the IPI init after notify_cpu_starting(), which explicitly
> enables RCU usage.

Ack, that looks right to me.

              Linus
