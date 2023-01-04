Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF365CFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjADJtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjADJtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:49:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D95B19C02;
        Wed,  4 Jan 2023 01:49:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jo4so81287055ejb.7;
        Wed, 04 Jan 2023 01:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1oNRW1cGJQQReSYi/ZQ8ERmnLQ2tK8+sfHV1Fnu4AsQ=;
        b=pQBzfXE2nfgS9cuj64iVl9iLzAQXlmMuXHI1TE1lksdqJDfcdAH7PGmIeE0l7mPK3J
         mEITQ0ZdwENwEySxSv1WUvmfNIviWmXfuE5bQxftyTpDx1JZ1pVyjc6M7yAYGQ1bqJi1
         G8jG/YFon4PMkJJq38BPj2P4MzSWzbGmGsMdu76jUmpaJ3aLHaSb4oMr6YKCzjYNzIfh
         og1csQJZrtl/Fi7KSd79bEkHtCV+iWImrnXiEfXZNS6dnV2TJm2WOlkjg7JPzutQtgJs
         NAwJGRkZRnRWAneJGH1eMkcLP/KwVm+sMvkqInFdyFOqL1z1n2AYowPb9oZLJIhZMLhJ
         j32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oNRW1cGJQQReSYi/ZQ8ERmnLQ2tK8+sfHV1Fnu4AsQ=;
        b=VIc+tQCNEEIOoD9BzaSoEKzWZGFxJn7nRwxyzjv39+C2dB9JHa8n9F1vUffFiUEQX/
         Rgt+7WZNW8pDPvQS5u04tqgyDDCEzaQl4qrsKgGJQ313wR7tkYdzTljmQShdP6haQTPv
         FUlpemcy3cJRwRgf1SNRf+RWUgdJqf6IK3Y0oYCRPvNZEGVSYT8wK1U9qYpX8tSSE6TA
         JbY54B8hL0TAuUniCfWrOU543diD0hAmyW6KgtN5ETcZkeBG9uCJNTwTgtURFZcd5Tos
         HVAkhaAtEh3msfERbbM58BsUAE08QLVZNB+X//Oy9NKsMqb99mu4sx5EIehCXV4Sj+3w
         qJEA==
X-Gm-Message-State: AFqh2koKDSc/l8CsMFVCG7JrcmAGvaljcTqH5i6EFr1kk4TByEls66Fg
        giC0ta7IbYZ0nCysowkNKjBunvGympE=
X-Google-Smtp-Source: AMrXdXttG+EoWUW+sa5tampPMDoAEVDU+I1njWdndjI7/wp6ng0FQIB9yIewFK0dVqfGWldknbJuiQ==
X-Received: by 2002:a17:907:d311:b0:7c4:e7b0:8491 with SMTP id vg17-20020a170907d31100b007c4e7b08491mr41897603ejc.61.1672825739951;
        Wed, 04 Jan 2023 01:48:59 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906310100b00738795e7d9bsm15146582ejx.2.2023.01.04.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:48:59 -0800 (PST)
Message-ID: <52ed3964aacb4ae8fc7ff8416cbddb4110902196.camel@gmail.com>
Subject: Re: [PATCH 0/2] of: Fix handling CONFIG_CMDLINE* even without
 /chosen node
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Rob Herring <robh@kernel.org>, Geoff Levand <geoff@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Jan 2023 10:48:58 +0100
In-Reply-To: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
References: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for looking into it!

On Tue, 2023-01-03 at 12:00 -0600, Rob Herring wrote:
> Commit a7d550f82b445cf218b47a2c1a9c56e97ecb8c7a (of: fdt: Honor CONFIG_CM=
DLINE*
> even without /chosen node) moved the processing of the kernel built-in co=
mmand
> line (CONFIG_CMDLINE) from the early_init_dt_scan_chosen routine to the
> early_init_dt_scan_nodes routine.
>=20
> The current powerpc startup code does not call into early_init_dt_scan_no=
des, so
> processing of CONFIG_CMDLINE never happens, even if CONFIG_CMDLINE_FORCE=
=3Dy.
> The result is an empty kernel command line, and mounting of the root file=
 system
> then fails with a kernel panic (not syncing: VFS: Unable to mount root fs=
).
>=20
> Let's revert the above commit and redo the missing /chosen node handling=
=20
> within early_init_dt_scan_chosen().
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

The series looks good to me,
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.

