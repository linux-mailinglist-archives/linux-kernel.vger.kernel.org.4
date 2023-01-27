Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2467E5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjA0Ml7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjA0Mln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:41:43 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F337B432
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:41:12 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u72so5799420ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAikRR13dTkUr1t3vMZlpkFDzeprSZfkzxiq8MolwCo=;
        b=GMvsxzcW2ruEf4qvPhkFOAmmaB8qF09GWO6xT0aDY36VaANjPRJTpsZSZ7/n7s21Og
         iULIwuMMxR4IWSGTf7bC0bstDXMwAikmXIlwiNKdDPgbJ3SJv4G9WSIqzrD15Gp0oRyH
         0GJ86RI0egiqdaOb4gDFrVNfnwZdtyO5Tl1ut2fy3MnKsBzL2GCeBR8y3qtUhjziWJ74
         fOWF4EyULdXlkPA4ko5NFVRV40hg6rGj8Ris3Flt55HYV8y2/oohAOHuZZw5KStcyCgU
         vZX5KePjqxXmorOOjGsXyMWemmqWsGAOJw99gRda6nOc5t3WkBZ1Y9k7tMbYtHvi8nMB
         poZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAikRR13dTkUr1t3vMZlpkFDzeprSZfkzxiq8MolwCo=;
        b=c2ac+eVkRyMmtsQokH90g3cPElEvwY6rCBnXK03x1ZFf53kUbrG6x7bIMm33QfkK7o
         8dvrH+9kNLMUXZyyNFPCyVuHWPsm3e5fWRd08iTvvPR2upBENKKSJhEdXE+kb5ZWkyXi
         c+HZSLqD1QbeonDGaFv3JbSqh+mmItddGUKRqgJvbn6lZUf66y+wbfTzqfLxjCZWMi96
         V+bnjK7aORNyPAQb48hyzyeG7PN3s73D7dB0drOCBNuIkv+ST9D86LYRRjTPt6ic1g2w
         BGYyCbyks8fmAM1cM1Azd4uNBKoHFTUfKrqEjYjJQIqUwDj1RWm+HS0hEzEKOn6QEY8w
         3dsg==
X-Gm-Message-State: AFqh2kpALOmlcB4HAEJLcbc81bbi9/87FKcKQ5uxa2Ixt3umVBNfASPB
        UeyPE3tFUWTaZA7vV38JDATsX037RwXOP61Q7fPClayTD8tXdw==
X-Google-Smtp-Source: AMrXdXsLGmMYxS4Lv/7/nNDt8nMdm5gK8FPg+SMZ7iNaHRfX5eFWqNJS1S6nAZnXfvLQmUS9rLByVhmZPlL5e6wxC5w=
X-Received: by 2002:a5b:38b:0:b0:7ca:9b40:72a7 with SMTP id
 k11-20020a5b038b000000b007ca9b4072a7mr4926787ybp.130.1674823270471; Fri, 27
 Jan 2023 04:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20230121134812.16637-1-mario.limonciello@amd.com> <20230121134812.16637-2-mario.limonciello@amd.com>
In-Reply-To: <20230121134812.16637-2-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:40:59 +0100
Message-ID: <CACRpkdb5J6Jnob7ZdjZVGnVvNj7bf_zred04UyN4cevvo5QZ=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: amd: Fix debug output for debounce time
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> If one GPIO has debounce enabled but future GPIOs in the list don't
> have debounce the time never gets reset and shows wrong value.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied for fixes.

Yours,
Lijnus Walleij
