Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DD63B605
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiK1XiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiK1Xhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:37:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E931F97;
        Mon, 28 Nov 2022 15:37:45 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o1so7509253pfp.12;
        Mon, 28 Nov 2022 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzjy94C9/gJqjCbWNPcmTBhrv0q0j8JlXM29h05f5T0=;
        b=mdmn2w2APMqAv+RPXs4Yvsxee2cUQNuX1cMgGtfoYVE7lFUmblemj2391ec2WA8xd+
         zQS7jUXkE/WPlQT8yDislSdupYYdcZbPjStG57lW+jJHxMQWzkw6g+niOscP53rf1eEH
         KqeoBGtm+CR3wJG0NbRCMSNY5DhHIXfB2n1f9XNGr2mr0XTupxs1M+gZn8UW3yf5c/lp
         usHItmzAfWDZOC13xTlzx1gwx+V3YTVEjB3MRMrKGCmCdXpgaZufqE0lo0OjaJQLwXIg
         OeRijrv4QU6NHk49dYAQ74KCidvHV91P597ZGr50jX7mrIxKq3zcT5TfDAUIs7NVQBDd
         X0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzjy94C9/gJqjCbWNPcmTBhrv0q0j8JlXM29h05f5T0=;
        b=r9s+hUDb2geluTYDFRTF2jJR7VjBZLIAnR5VcG8nnBx1tmzFl4wQvN0/19///vMMFV
         NFlCJ0LZzxY5icvahwLxmbL7TzFDoK17Tipitv3lbsjIBoh448XfwWz7NWjq5VGZwZWV
         jqeou1qErajM3AcqqN/mOqs4IAtd1/TVljb/xj084/FAobhPk98pTvfOsUDVJ6D28ECy
         6/xHmp+afYU3icgLE+Ynycf9/MDHru/NuwQreU/BdJLVsegNDp4fgX2iylMP6SFgpsMv
         7kfIhH2S29WY38RSooPFXvXos2/qX82r8UCdYFIGcq8w0/4vPKACZlQNJSse/cnk2wD1
         omjg==
X-Gm-Message-State: ANoB5plL4CL7VIRJIQxfR8BLbOapUhtpo/SeXD7P1wppzmWN5gx4kQFs
        E6mr7/3G82BtFhLmZKHw/p8=
X-Google-Smtp-Source: AA0mqf7nGvrFAzfuCZG1/bv95MHKSntBdS9k/sXKIw3ILbxK+YHtHwZ6qpJIzxMCovh+S7fh3jabSQ==
X-Received: by 2002:a05:6a00:1ad2:b0:56c:235:83a9 with SMTP id f18-20020a056a001ad200b0056c023583a9mr55555866pfv.6.1669678664848;
        Mon, 28 Nov 2022 15:37:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090abd0100b0021885b05660sm28311pjr.24.2022.11.28.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:37:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: dts: Update cache properties for broadcom
Date:   Mon, 28 Nov 2022 15:37:42 -0800
Message-Id: <20221128233742.501267-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122163208.3810985-3-pierre.gondois@arm.com>
References: <20221122163208.3810985-1-pierre.gondois@arm.com> <20221122163208.3810985-3-pierre.gondois@arm.com>
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

On Tue, 22 Nov 2022 17:32:07 +0100, Pierre Gondois <pierre.gondois@arm.com> wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Acked-by: William Zhang <william.zhang@broadcom.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
