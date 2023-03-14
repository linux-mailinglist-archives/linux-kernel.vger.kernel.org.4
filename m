Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B156BA13E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCNVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCNVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:12:26 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3841A950;
        Tue, 14 Mar 2023 14:12:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f1so13434552qvx.13;
        Tue, 14 Mar 2023 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678828344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG084GwXz6cysy5AMBK1B3RKzUbSV2cHDK8o7Mn60XE=;
        b=BdoLE9YoaHF23WrZsI0r+eIhj8Og8v3+V4XWiJuSR5mY1e3jH3k7udVascQyko/qpt
         jrr5xFKI4mVDarnw+JV7hzLNlhaDJcOuQYvthcDrVsxc8s4FSFH/lzE3q8TGolVF2DTw
         P6jA7cQqYcttC3CzFmXXBBreMKzE8IxfUROJaOpIaXpnl0MGL12itESLinABPJvhMLjS
         lkvXBsJYNFQCfV/2pkso4Q2slUx+SeIP8nZweJHOx2DiQNYbn0IjX9ULPEyZ6aSUlvuw
         SOwl2XYhLSHJ9HTsOyFwD7gsa/ZuI4ZucQWQxnf5QjYDcWayo0d5LKokFC3JMSHbTOoI
         /42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678828344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG084GwXz6cysy5AMBK1B3RKzUbSV2cHDK8o7Mn60XE=;
        b=z5/RW5UpbiBdE7YR2rwlRYtmo56f29jnZMdJmVcphqawUufp7s/MWVVS7ebBGM1gZK
         zrSD2w2OWnZWdVZIYsI4Bbso1b6tfuT3rKXKZCp/GDBPMDgseli5MPEIpOiQxDe3RagT
         XDSpo2hu3ty7Ma6MunVN4p5EClJ+0RH+fyXIKLgAknRzAhJLXjOum9hvNeuogr7NvxmW
         K1YdcBM0683Fcqhi+KiM/yq9KRX9sQUZDXbtGCMBs7W5QqQciDs2aVtikmlOG2LwU9jd
         gLuUGUK/0TmuR0dpgeK1P4x6+lybaserVXAeJ1afxs2lZzhgV35qmoFIvfZbX5MAAGAZ
         0i8Q==
X-Gm-Message-State: AO0yUKVXvmbi1Q7oAd0e+giB0C6EYOyWHt5zAFZiMwIsfokFle3lhpNU
        Pdr9yYoD6td96WneaI4H+YA=
X-Google-Smtp-Source: AK7set+FCYoEzSdscIT16d679U5alIy3GCQR4KkyJtBWnKOQ3haJU+XgJ+xXZthBhKvA71OShB7gAg==
X-Received: by 2002:ac8:5c0f:0:b0:3bf:c994:c9ae with SMTP id i15-20020ac85c0f000000b003bfc994c9aemr36629897qti.16.1678828344450;
        Tue, 14 Mar 2023 14:12:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2-20020ac84102000000b003b691385327sm2544798qtl.6.2023.03.14.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:12:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@vger.kernel.org
Cc:     drv@mailo.com, ssengar@microsoft.com,
        kumarpraveen@linux.microsoft.com, christophe.jaillet@wanadoo.fr,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Miaoqian Lin <linmq006@gmail.com>, Liang He <windhl@126.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume code
Date:   Tue, 14 Mar 2023 14:12:20 -0700
Message-Id: <20230314211220.1636066-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224215249.239405-1-f.fainelli@gmail.com>
References: <20230224215249.239405-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 13:52:39 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Since 2018 these platforms have supported entry via the ARM Trusted
> Firmware using the standard PSCI SYSTEM_SUSPEND function calls. Remove
> this legacy code.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
