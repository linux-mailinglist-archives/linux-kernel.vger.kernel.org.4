Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489206EE47E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjDYPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjDYPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:09:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5716D319;
        Tue, 25 Apr 2023 08:08:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b51fd2972so4698749b3a.3;
        Tue, 25 Apr 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682435336; x=1685027336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnah+vNsB962Jqq4wpj/noJkznwmGjHcTtjK0qQjBKM=;
        b=aX9aClV42BFXJBgJONjt1HDkj2EWczrA2pLtMb3BaW0qaS1t+ZWZwQ3yfrq4jZfrKe
         x2rvH8oiYiQeumtahzvnqg78PVnHY6wTCmAD1RkOcR3vYibD7+I7FFhyzxNG2/wRRkrh
         wAioPiUFCwo3ap63Sd8VTp07xGKeO92DYjoW3saq7h6wQnw63m2B7BDWRus75PxKPDlW
         tAI46GZETy+JL0thJ1xMrkTD1CO9h0zhRiHr/lBeDqdbMj6dhYWWKyT7xxwVkeawAX0f
         aEka6qDKjwrYR1sNW+4hT+CXMVj5gYPps9cGc+dj2HL8sCFlYctkc+3doZGf1zmTT7h8
         XZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435336; x=1685027336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnah+vNsB962Jqq4wpj/noJkznwmGjHcTtjK0qQjBKM=;
        b=R0WnzYQl2DCC2lAgs2XO6nw2kCh1HiMJGnJo9xlwcXPruNYA7b+LNbazdFtgTHXhHN
         YWJHAE400uUY3FkcajiSxkcSoENc4++7XrgohxfH/6UQKdMwk9YJHlPRdV+1SqCIYFc6
         x91jhC63Zp7tNjByRBytkw/AGXqBdjC8rA/VymGFBzuHEsCZKWomxKKCmA/K5vvNrwZy
         arGYYC/PUy7YsxVEP7xMIfmcdCXMsFBWWMpIQg+LMoWQFK5p9qVfe7JlH5yRSgcQ0GoC
         /nvea7gINz+Jt3kVmj9rUaY81uBn1r9siQHFlczPP3op39PsNQot8AL0sp+IMSVlBmxK
         r0QQ==
X-Gm-Message-State: AAQBX9dm7WXhunqbYNDyIZR8itNqx3LI7hjg3r2SrlVd+iQygNfoFE6F
        CoTIB4TZYbHzxRNacacJBZsr0sa1Mec=
X-Google-Smtp-Source: AKy350YFC3EHpKVGUMi7ZcHLkiTL4MGdMn44hpWCoPmlj+iHle2jwBovwKUfgttGvcxyaqDPB1s+pQ==
X-Received: by 2002:a05:6a20:7d8e:b0:f2:6eeb:211b with SMTP id v14-20020a056a207d8e00b000f26eeb211bmr19752416pzj.37.1682435336048;
        Tue, 25 Apr 2023 08:08:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm9391447pfg.3.2023.04.25.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 08:08:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Apr 2023 08:08:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Message-ID: <8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net>
References: <20230420121615.967487-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420121615.967487-1-d-gole@ti.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:46:15PM +0530, Dhruva Gole wrote:
> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> it may introduce build issues with certain configs where it maybe disabled
> This is because if above config is not enabled the suspend-resume
> functions are never part of the code but the bcm63xx_spi_pm_ops struct
> still inits them to non-existent suspend-resume functions.
> 
> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

This patch results in:

drivers/spi/spi-bcm63xx.c:632:12: error: 'bcm63xx_spi_resume' defined but not used [-Werror=unused-function]
  632 | static int bcm63xx_spi_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~
drivers/spi/spi-bcm63xx.c:620:12: error: 'bcm63xx_spi_suspend' defined but not used [-Werror=unused-function]
  620 | static int bcm63xx_spi_suspend(struct device *dev)

on architectures with no PM support (alpha, csky, m68k, openrisc, parisc,
riscv, s390).

Guenter
