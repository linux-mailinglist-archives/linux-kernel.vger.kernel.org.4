Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5572CD35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjFLRuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFLRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:50:36 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D8A1;
        Mon, 12 Jun 2023 10:50:32 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9787d11a410so98279666b.0;
        Mon, 12 Jun 2023 10:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592231; x=1689184231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvyyw0RH8M6wqUGKw3iOenKs+/MxXTFepExt8iHfBqM=;
        b=iA39MQU5re4n+sweXAr064qhrHr+XJx8jIhpRZJ3dnBFZaohWC/DqAAnPYP/mWxZTK
         dti6XmXam9QQtoXae7slArIVhS+/LvvallbUfTGjWdGiN4acAyTjsXZlshL8GYbJ5U3q
         aa12I422OCK/YvpbgsKzV+D82jVMuX3EMARHG94qvFj4Ki4KcyoMm5h5sP6a1jXsjrJq
         InkU5C6nUYpC4zRK1flBCHNsjmBEDtAP9d1rcGHEPk/4+FOY+FpZOkUlv4b2Gl0k9rs6
         b2doU5nlQlrvkzVxyVI7u6EbUwOrZsJ4ouOFUvqNJbtYQQ66sJ/YfU55L1ZAVp35nFxi
         RcUg==
X-Gm-Message-State: AC+VfDyEoReiC/U7vUwIZWvUBTe7AfJZ3tk3bSS7fXu8/EawpQWq4USn
        zDs4R7eaOxt/1dbE3xkxkR43nFDEe7Wuv3VPHfLyWIt8
X-Google-Smtp-Source: ACHHUZ48EwYeJ/hSMZnwj4sh7Sw3R37wzvPOsSt8Oh7LDPDCuTIxgM51IrMmr4+YgLo/RDdy9XTvKwb38fBxVT1NRiM=
X-Received: by 2002:a17:906:7a03:b0:977:cbc4:5d8 with SMTP id
 d3-20020a1709067a0300b00977cbc405d8mr8767410ejo.4.1686592230594; Mon, 12 Jun
 2023 10:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140000.385223-1-rui.zhang@intel.com> <202306062334.5Z1NkD1F-lkp@intel.com>
 <62b7e97ede85927cd523578be0b702723043d92b.camel@intel.com>
In-Reply-To: <62b7e97ede85927cd523578be0b702723043d92b.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:50:19 +0200
Message-ID: <CAJZ5v0higwL64NP4tFfOwVog1daSBsUTdh+M5ocZqDi14cYVDQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        lkp <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 4:23 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2023-06-06 at 23:45 +0800, kernel test robot wrote:
> > Hi Zhang,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on rafael-pm/linux-next]
> > [also build test ERROR on next-20230606]
> > [cannot apply to linus/master v6.4-rc5]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Zhang-Rui/powercap-intel_rapl-Fix-CONFIG_IOSF_MBI-dependency/20230606-220222
>
> This is a false alarm from the robot.
> It applied Arnd' patch first and then applied this patch on top.
>
> I think we can ignore the lkp robot warnings for this thread.

OK

Applied as 6.5 material, thanks!
