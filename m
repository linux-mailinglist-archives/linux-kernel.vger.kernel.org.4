Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B663744428
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjF3V6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjF3V6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:58:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33643C1F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:58:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3984902e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688162280; x=1690754280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG0hwR/YJu67kWtnANEbUEQK/5fjQu8DbldxOC2Vvw8=;
        b=GufFu96ensIgCOxTtY6Iy8CuG94cVYrHIt0XQx4DxLs5kAtCFyjBPt3IFW/ayeS0VL
         O+N5cTyYLfWwkUwPu5JYQF2Tlk1JXPsNwD8UTMNfwkNcffmS+19eWJYJNoHKImH4KVjh
         zNnuNRnamqGCmg5dVCJ/YF026OX9CvH/gJsnKqaA1JRz/pginEx1ttOuZq8P+SgHn+5x
         OUBT2JQeq3boCgB7F5jblwBjKRkQXXlnh4C9v7ohE8DmfO7fUdpOlC6w6o2nUm9Dh1H3
         yruQdTp+/KbUYCUkB3aMj+TMsc7+mcplOVaITXyquG47sT/+22MJpEsZ/rJrgE1SCFB+
         YzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688162280; x=1690754280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG0hwR/YJu67kWtnANEbUEQK/5fjQu8DbldxOC2Vvw8=;
        b=i3hgyTo+kIOaWwnUaaWiN0MOdFTCYxaknuQtF7nDr0k+alMlu+RXt0xNMrtD2qmFxo
         6wcJuMCh67gzLCFvdUBbcdp+jCg6+ZueHKzqYvNK3CNHQoY4eJ+YlFiH87XIubxo4wCm
         22zfDhWjTTt0JLcacvOoHDTUJk8GvmclUHCUrRsXX2JYPi3EZ+I+DYvEzaFCSzSlbJ9P
         VwIe3/v+jU+SLq1N+6E6PXLc7CcRO4dbQfKGwIONkcW7aouxSCARY9KkPQtBlFhJCTnn
         ZZaHv/PGSMe+fXplI/9WxNIUpMj2vbU4GhnO29rfAN5ihAevTClNDlrx4PiVkWov+ad6
         QdIw==
X-Gm-Message-State: ABy/qLbxzNOqAPV9yE81Qwaoh0qF+lMp2q6j9H7crXVGxL18zAlQ5DGz
        5+amcCpBu76SVTJodqDFnImHxxJeCtSiqdlhWq7iBQ==
X-Google-Smtp-Source: APBJJlErcH2Vqh20jSjJGGlb9PDjFbHudImBHXsqb2BZk/LTF20VtsQO0qiQBYAgA0UAQ0dvvhoPE0iwBYWaJmnLYlw=
X-Received: by 2002:a05:6512:3586:b0:4fb:61ea:95dc with SMTP id
 m6-20020a056512358600b004fb61ea95dcmr3061888lfr.7.1688162279907; Fri, 30 Jun
 2023 14:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <20230623222016.3742145-3-evan@rivosinc.com>
 <20230626-hardcopy-upchuck-7c37f1a6ef7b@wendy>
In-Reply-To: <20230626-hardcopy-upchuck-7c37f1a6ef7b@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 30 Jun 2023 14:57:23 -0700
Message-ID: <CALs-HssoL9grnv80OGzUP2rKF9H5YPGt6M0xBHHwdhEf=iLt1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: alternative: Remove feature_probe_func
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 6:07=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Evan,
>
> On Fri, Jun 23, 2023 at 03:20:16PM -0700, Evan Green wrote:
> > Now that we're testing unaligned memory copy and making that
> > determination generically, there are no more users of the vendor
> > feature_probe_func(). While I think it's probably going to need to come
> > back, there are no users right now, so let's remove it until it's
> > needed.
>
> How come this is done as a separate patch, rather than delete the dead
> code as part of the probe addition? Ease of review?

Yes, it just seemed like a logically distinct change. Thanks for the review=
!
-Evan
