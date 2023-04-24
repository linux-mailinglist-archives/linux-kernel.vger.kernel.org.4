Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7676ED7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjDXWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjDXWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:33:31 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E61126;
        Mon, 24 Apr 2023 15:33:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74e12e93384so254243685a.3;
        Mon, 24 Apr 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682375607; x=1684967607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybdfF7jF2R9taUkLsaqf6Dbx59gjKHcxMgzxAUyFh20=;
        b=hj+OlTPxar8ijmp5Z3JUghZFlOuv9Nw7cIq2MvqcnQh80/AkjNpJYm5WVETYa6gkHC
         qt+dH3djXVFAWyHGmRUuGDHNdjY5FWuShn0fPUGhGxuDWZmR1qqk2G5QdxXL1lJnSYNu
         R2XNfcW8xpokqTMeANQmK/elOIfyNNhyeg9pIZkCn0qxOM3RLung0+RL0eH0B22kmxXn
         qiEfN1g+0Nq4VH6Qb7cE2qBPBhGmbtbgP3XnBbBTWBArbI93iwoYUieWo2XF9sUG7nWs
         1548NpNI0bBf+20PAw8ihPsScZZDxUZ8VIVMFqEGA9YBo9bpy0gFw/RM7XEB0kb04mb/
         j1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682375607; x=1684967607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybdfF7jF2R9taUkLsaqf6Dbx59gjKHcxMgzxAUyFh20=;
        b=IcNmgLJTgiyT6DezBvPteS/HhaLaoly2u4tGFucU7eTOradfvr+czp93pZL2Y57rHB
         pf6tgFddmIXKE1X+YJzaD6hz0jNjDLnqXPTyjyEyYt6T/doI4EdQxCTqgpB7Z42qOza0
         nLRRjkJ7yVRk7Ob4/SlDlgAZiyGY41SFpkQDA0MuJ0rBgGUq2zIUq8qkb6ooH1YQSGiv
         TKKDJe3/OHd/XOY81501nDi2doHY5+a8mj6iINpWkRdx7aVz48naVpTYd/QbQKYWhC/c
         eueg2r9ybEs1PxvcZfkeqOn6yJQjrI/pnt8oFNbr3JqMuv8S5VYCCzz9+4P1rL+Pxd4v
         N0nQ==
X-Gm-Message-State: AAQBX9efuZnIvSqHvcm5OhmmOm8/jcNqr2Ob22YnR49gi92PCN4knTpY
        9eUKjwP6oiwrMx+S9WL2p04=
X-Google-Smtp-Source: AKy350asq6da/6jGKk0niuB2JsWrOG0+T/JzVosIB+JGicQbPO+sO0UY5g+rmC7XyNcjz548GA34eQ==
X-Received: by 2002:a05:6214:e6b:b0:5c7:cc77:d203 with SMTP id jz11-20020a0562140e6b00b005c7cc77d203mr24252419qvb.3.1682375607633;
        Mon, 24 Apr 2023 15:33:27 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j12-20020a0cf30c000000b00600efe81815sm3206824qvl.28.2023.04.24.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:33:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: broadcom: add missing cache properties
Date:   Mon, 24 Apr 2023 15:33:24 -0700
Message-Id: <20230424223324.4018534-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230423150943.118576-1-krzysztof.kozlowski@linaro.org>
References: <20230423150943.118576-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2023 17:09:43 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   bcm963148.dtb: l2-cache0: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
