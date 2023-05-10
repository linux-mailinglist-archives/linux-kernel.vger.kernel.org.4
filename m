Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC36FE43F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjEJSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjEJSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:54:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB9128;
        Wed, 10 May 2023 11:54:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so11425773a12.1;
        Wed, 10 May 2023 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744889; x=1686336889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpps0vuMSlTbVQSBZ3c03u7OEs5zj2+Xyh6XKEwYQRk=;
        b=T9SSHxghDSA53XZUgiO0MzcDudpZJHg7tVnkzMeB7cDUoCg5Frs9+NwvhbF/9kkoLC
         klfiu6RIv31S57mDxkeGjsZaZ35N5PjMJ5cPsCAVyHQtgYFzPtjuIW5TDy+OIfiUbe8w
         4/nMjgBAz/FglLT+02TUMv/Eifaw4d0EynnRH+MjOrK3ZQmVbj+FNscUd8dZaQWrkEdH
         BN21P7TgTmgPMk/WtxQexmnrCEdV6h7kqz8EUDrrxc3tGUTzOzVHpuAMK1wd4EgOeBxd
         zX/BgydfsqeCOkarw56CooCg0Ix8QbsWi0kqokBo4eZvppj/QjcggYPgmpCHggCqaRjn
         Sg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744889; x=1686336889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpps0vuMSlTbVQSBZ3c03u7OEs5zj2+Xyh6XKEwYQRk=;
        b=EFveUK3tp1sPwSZMYAtuPyvcbxS/DRn3ALGUCAYWUDy5JCO0n+6hFqQXMDNkIdhdi9
         PI3c3Na53q6HORmvGC5EYVfTiF5lOJTBu1hhXPeT+DUvelUMOTeUPG9ZTIW79Jp+2qJL
         cygGG4vZgMt1JUYGILLHWkqlERsxiyVFMXwrM2jJUV7RzcQ9qYVHFfLH0bwupjG7QIYA
         m1M4ougbdWqzHNGR76lYWFjpz2/xBWgkvK5TaAeMivOc7e92EvF0nfyhSlfldqJD9ps+
         1qbQUmEDkdTcyN/wJt9f9E1zyHdJIG3eGCfl6HAcfgqkT2LCzYds9DOzHZn4Rnnxyify
         FHHg==
X-Gm-Message-State: AC+VfDwfRdsscPXs01DmskOMU/sk3rUhOxiOuCXFD8HmBCgTxw9jtxTT
        BKb4lpqAOBQEuJ3lpZSKQ10=
X-Google-Smtp-Source: ACHHUZ4NAD8Wr3jSfg4mRi6MrmEydNrcDgkDp7wpSSCh2F4XtqVw74F5RsRQ5mvzdo/DOMGiZh3FAQ==
X-Received: by 2002:aa7:cd76:0:b0:50b:c5b0:4de6 with SMTP id ca22-20020aa7cd76000000b0050bc5b04de6mr13966850edb.9.1683744889194;
        Wed, 10 May 2023 11:54:49 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id y15-20020a50e60f000000b0050bc27a4967sm2160813edm.21.2023.05.10.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:54:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, wens@csie.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andre.przywara@arm.com,
        Ludwig Kormann <ludwig.kormann@ict42.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
Date:   Wed, 10 May 2023 20:54:41 +0200
Message-ID: <2284225.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230510111528.2155582-2-ludwig.kormann@ict42.de>
References: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
 <20230510111528.2155582-2-ludwig.kormann@ict42.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 13:15:27 CEST je Ludwig Kormann napisal(a):
> Document board compatible names for In-Circuit ICnova A20 ADB4006
> development board.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


