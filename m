Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580D372CCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjFLRfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbjFLRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:35:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA4173C;
        Mon, 12 Jun 2023 10:34:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso6002165e9.0;
        Mon, 12 Jun 2023 10:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591194; x=1689183194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esyl6jzMRR4lZSA3WE4oL1Kro8j80YPpI49aTMDzi9o=;
        b=fEh61iYJowCfZ7y3zLIcInFizyWBcBHIQj1S2ZJvTME8BzaKR3a3q/dILxgnQVOtFw
         ajhW85NhDlhEbalKrN4zg2xE6rZzysdKs9Pw7gUlsRj5KfkCBK8mi36rQOWmA6p+6zjJ
         CR3ijWcbI/0wG+bdFVW543GUda9RqxQHgXxYFC8Dk4SL2AmmhO1EdxASHwOYWJ5LmCCn
         0pF/8Mm6A4fGGGR6eTx10+bRVCmOd4MOiAYrxVuacpVE1IAaU18aVDX8Hn0flMhw7C2M
         Y30/fVn0DyBlMrZAPUFaJFjpfQ+SwOxzklCcsqD1bADXqt8GzjAUX761x9dXLHFUYNqU
         4eRw==
X-Gm-Message-State: AC+VfDzSe8374QYbxNTw+/TBwiw0oreLyUmkI+4qR1ULKaxKt3bb4w7q
        QVynnrTnEyrqeJzimiD/okYQ0T9sMWUz4I+OGuw=
X-Google-Smtp-Source: ACHHUZ4OlZEYUv1+IIU50jLzQYo6ib+ZJQqR1NQyv6ZYBhJY3/kk4nMCB9uyr6Kmh8VijFRU2JarKxeDygZ++Pk/gG8=
X-Received: by 2002:a05:600c:4e4b:b0:3f7:e7c9:4039 with SMTP id
 e11-20020a05600c4e4b00b003f7e7c94039mr7942400wmq.4.1686591193371; Mon, 12 Jun
 2023 10:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201249.31147-1-leoyang.li@nxp.com> <CAJZ5v0i1nspPuHuUoLsWOz7MLnnB8bv=cXYbFcv0a=okBxBg3w@mail.gmail.com>
 <SJ1PR11MB6083D48DECD2C43B5F1ED4EBFC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083D48DECD2C43B5F1ED4EBFC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:33:02 +0200
Message-ID: <CAJZ5v0h6dqtvh7bUx_yrGnt32dcye-m8Yu5-FfUYZ4WgRoP9rg@mail.gmail.com>
Subject: Re: [PATCH v2] apei/ghes: correctly return NULL for ghes_get_devices()
To:     "Luck, Tony" <tony.luck@intel.com>, Li Yang <leoyang.li@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Jia He <justin.he@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 7:26 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > > Since 315bada690e0 ("EDAC: Check for GHES preference in the
> > > chipset-specific EDAC drivers"), vendor specific EDAC driver will not
> > > probe correctly when CONFIG_ACPI_APEI_GHES is enabled but no GHES device
> > > is present.  Make ghes_get_devices() return NULL when the GHES device
> > > list is empty to fix the problem.
> > >
> > > Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper module")
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > Cc: Jia He <justin.he@arm.com>
> >
> > Boris, Tony, any comments?
>
> All of the callers are expecting NULL for a failure, not an empty list. So this looks OK to me.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.5 material, thanks!
