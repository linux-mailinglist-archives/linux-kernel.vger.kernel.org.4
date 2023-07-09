Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFD74C66D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGIQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 12:32:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57888D1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 09:32:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so4637013a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=gAn+QFrFr5ulawjYCYTO7VmTQzHU5lgWSC5NEnzugmdYhNVwnmToW+MQ4reDvuq6l7
         PzP2nnDKMv8tyPbAMBaFVMjpeYKtX/i/KRcWvIp4fd9RpwmjkD31sHkkt+5HXaKSjBzT
         4EDltBMvryK/qN2k9UurMRUANtYKeMK9ETJQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=coHFKc5tkGaAU+eRjF1+ePVhZzHKd1pwEgwSDjsLwbXKyyrgkKiJwIEB3G6huF8dt2
         9NfqipYXXKHYMUcZBuVOb58uiYMdeSgVQfWyaQ78cLUB1YK+LJHh+mrs9yN4RwY6Jcgf
         /ujA3cHef+n+Y6p0z/hiHx6Xs6qukoUGsUA2enDRYHmuFs7BB558ctBTQaBse6m6bye2
         8ygsosXgGyGWBxvjUVa+D+D6971P+iNdsKW8EmZ/KxmRc33DNlRrAQtNViyCPRBBe5qP
         PeI1gVZjUGaeRIhUsrQSQUU2RvSXsXrllkRwGzaaa6uA9UrYplyUR44Y6U5N7Ulcidnt
         ux0A==
X-Gm-Message-State: ABy/qLbe/XlS6Qjv1eLYdl2+JhBTltWDRP/6fPqYl6l2kN4pBbvt51UA
        3UBo2pPm3ri2aLA7rugz1dr7i0tJMuSo+niZWUO78S5j
X-Google-Smtp-Source: APBJJlEtr5hsrWH/5Qq5OhFgz/mltRuoLjej38rvM8Li2M+xHQo1+4at9cjIEtyHPRrb2pr6MX1cgg==
X-Received: by 2002:a05:6402:481:b0:51d:f589:9cbd with SMTP id k1-20020a056402048100b0051df5899cbdmr8441477edv.39.1688920324748;
        Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906264f00b009893650453fsm4995539ejc.173.2023.07.09.09.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3141c3a7547so3756925f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
X-Received: by 2002:a5d:54c2:0:b0:313:f22c:7549 with SMTP id
 x2-20020a5d54c2000000b00313f22c7549mr8377726wrv.66.1688920324114; Sun, 09 Jul
 2023 09:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com> <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
In-Reply-To: <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jul 2023 09:31:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 03:55, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the regression list, netdev, the net maintainers, and Linus;
> Johannes and Kalle as well, but just for the record, they afaik are
> unavailable]

So I will release rc1 with this issue, but remind me - if it hasn't
had any traction next week and the radio silence continues, I'll just
revert it all.

From a quick look, "revert it all" ends up being

  fd006d60e833: "wifi: iwlwifi: remove support of A0 version of FM RF"
  a701177bd4bc: "wifi: iwlwifi: cfg: clean up Bz module firmware lines"
  f4daceae4087: "wifi: iwlwifi: pcie: add device id 51F1 for killer 1675"
  399762de769c: "wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices"
  31aeae2446d5: "wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants"
  ecf11f4e4950: "wifi: iwlwifi: also unify Ma device configurations"
  bfed356b4fc4: "wifi: iwlwifi: also unify Sc device configurations"
  3fd31289d5de: "wifi: iwlwifi: unify Bz/Gl device configurations"
  e3597e28a2fa: "wifi: iwlwifi: pcie: also drop jacket from info macro"
  0f21d7d56083: "wifi: iwlwifi: remove support for *nJ devices"
  c648e926d021: "wifi: iwlwifi: don't load old firmware for 22000"
  a7de384c9399: "wifi: iwlwifi: don't load old firmware for ax210"
  a13707f7c845: "wifi: iwlwifi: don't load old firmware for Bz"
  508b4a1baeb3: "wifi: iwlwifi: don't load old firmware for Sc"
  5afe98b2e299: "wifi: iwlwifi: give Sc devices their own family"
  19898ce9cf8a: "wifi: iwlwifi: split 22000.c into multiple files"

since clearly nothing seems to be happening on this front, and summer
vacations are only going to get worse.

But we'll give it another week. In August huge chunks of Europe will
go on vacation.

                    Linus
