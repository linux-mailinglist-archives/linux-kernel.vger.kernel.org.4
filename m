Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31206DCE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDJXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:40:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BE1BF5;
        Mon, 10 Apr 2023 16:40:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h12so3319886lfj.8;
        Mon, 10 Apr 2023 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170019; x=1683762019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fur996rCaWYVGAHkL9B8t6UIa+8lHC0yv4M9nEOrYXo=;
        b=oCzfxBcreBt29EaLl+71B9b/Q9qgIZXp6nVXJ/ZVkuB6CVfBsRJFo1lAUD3/GAxFV6
         SVaBq0XwHUQ/TrhgfQF9QOmyhqqd3zQfSd8jl80BrU+bY5s0EnJc9ix5dwLvlaD/tVPf
         LlFnUsb2/Nmzgv+1PPlABYMwmnZDgH40woWrYLJFXHGmsy9+O5IPZwiwrLfcLIAT3BXS
         f/VArm7ldvG9/3oB5MrWFo70/hcUl9fJjkMmbD+Ph0W+rED701KZ70PrujsFfwa1BBEb
         G4pLZhhbAkHpTuhYZCurpub93G9rBQH7Pu7FqbOMgmPVJW9n6yyTfMzEqn6e8EowxiW6
         yiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170019; x=1683762019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fur996rCaWYVGAHkL9B8t6UIa+8lHC0yv4M9nEOrYXo=;
        b=Dh0Cgxsanp57vXlETGGj7L9Y5btRrOsymNHXWkAkjTZQWr1XRPOrPCEhVBa5jiC35I
         0P0mdAg0cr3LvEy0wpxCwPxHzf+0F0HJ1wMzOyEdFm5TGukBPMBq38mULHZmyLGtaeeW
         gJCOPguDcvydqUds5I6JKgCJsuTHnTzNxn38+autvBpdw/0kaFr0emvfgBtLeYb3oBfw
         AYPLvfBEsZYyP1x09ndb9Vb0/SR6wkr8muHg5b7m7YpPGyMEJ25QWmp+ByBgaUnK+YnT
         FkqDVd9EtLwCS3PwclPSpXhezoVh8qF6ImT7gunhahXkux/bbBEZNWTwfUmndnrsLlF+
         +0VA==
X-Gm-Message-State: AAQBX9ctrslQQanDEqvA/YB4HMNP6Ws7AEHhfSWpjJLEmDypCPw08U3O
        RZLrpfXYgUNkow5FZZz1B9tTsSuFGOg=
X-Google-Smtp-Source: AKy350Y8vHryK+xbHopzRc1cNjMjYH5S/Wo750TJjWInhOO3WY08PTqXauE7zSAidBeOMTmC84bjeA==
X-Received: by 2002:ac2:5292:0:b0:4eb:29b0:1ca4 with SMTP id q18-20020ac25292000000b004eb29b01ca4mr3506937lfm.8.1681170018902;
        Mon, 10 Apr 2023 16:40:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id v18-20020ac25612000000b004e9b4a8f738sm2284738lfd.152.2023.04.10.16.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:40:18 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:40:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        sunying@nj.iscas.ac.cn
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org
Subject: Re: Multiple undefined configuration options are dependent in
 Kconfig under the v6.3-rc4 drivers directory
Message-ID: <20230410232725.zwbccyryboxj3bh5@mobilestation>
References: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
 <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:34:58AM +0900, Damien Le Moal wrote:
> On 3/29/23 16:52, 孙滢 wrote:
> > It has been discovered that the following configuration options are undefined in the current latest version, v6.3-rc4, yet they are being relied upon by other configuration options in multiple Kconfig files:
> > 
> > MIPS_BAIKAL_T1 is undefined, used as a 'depends on' condition in multiple files such as drivers/ata/Kconfig, drivers/hwmon/Kconfig, drivers/bus/Kconfig, and drivers/memory/Kconfig.
> > MFD_MAX597X is undefined, used as a 'depends on' condition in Kconfig file drivers/regulator/Kconfig.
> > MFD_SM5703 is undefined, used as a 'depends on' condition in Kconfig file drivers/regulator/Kconfig.
> > ARCH_THUNDERBAY is undefined, used as a 'depends on' condition in Kconfig files drivers/pinctrl/Kconfig and drivers/phy/intel/Kconfig.
> > ARCH_BCM4908 is undefined, used as a 'depends on' condition in Kconfig file drivers/leds/blink/Kconfig.
> > MFD_TN48M_CPLD is undefined, used as a 'depends on' condition in Kconfig files drivers/gpio/Kconfig and drivers/reset/Kconfig. 
> > USB_HSIC_USB3613 is undefined, used as a 'depends on' condition in drivers/staging/greybus/Kconfig and drivers/staging/greybus/arche-platform.c.

Please, don't drop the MIPS_BAIKAL_T1 config. It will be defined and
thus utilized after I submit the SoC CSP support to the MIPS arch.

-Serge(y)

> > 
> > If these 7 configuration options are deprecated, it is recommended to remove the dependencies on them in the Kconfig files. 
> > If they are still useful, it is recommended to define them.
> 
> + linux-arm & linux-mips
> 
> What about you send patches to fix this ?
> 
> > 
> > 
> > Best regards,
> > Ying Sun
> > Pengpeng Hou
> > Yanjie Ren
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
