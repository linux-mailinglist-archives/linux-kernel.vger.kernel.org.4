Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249C61FE61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiKGTMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKGTM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:12:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5228E08;
        Mon,  7 Nov 2022 11:12:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a5so19122210edb.11;
        Mon, 07 Nov 2022 11:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvL/1cFUsL3p3X3LC8k460k8YFidRmeQtOlvn66hT5c=;
        b=L9KbpQy8GmRLe8WezLbdNadTVnX1iELu6qPXRgi3FtSkeS0cHYjxUbwxxhZUjAXf2r
         YRUfcgA7jrgfDAt5yq7E5hqv/euUeQLaatyYF8+YCPrSvwCDp9VhLFc28vUZpPhJkFM/
         U3SDwV32EgkskScgs/pchyFeDu87L77tn1oCQ79pJ6hw8TcbTTQh84B1jVXetPfvKQa9
         YMai1q8Vf8taf9Ktlj9UYdMX7RncfGQA0Y/w6N/ro8+pqGhMdMfPLFkmrAil3kRsqKuK
         /MJOKF6KPvb/ygCKsZcJ5H9CBY9FkLBEbK94pPqKhK9BoJJfnsY7vKjawhV6zTtAqsAJ
         LvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvL/1cFUsL3p3X3LC8k460k8YFidRmeQtOlvn66hT5c=;
        b=oyiWLgStL8fZ6b2MoXfhXC+g/RioEH5tgOENwvy43LfjVcJsFe5/D9jT0wk/e74GE+
         5ZbjqahsHXertxo6p4lUOPt0skpFRoVau3TW8V5ozRsKPF6Yz5z2grJ1HUlgGnDlMmU9
         m1X3hHxbeUogYALn+pGOSrM3x2XYDeHzeNI1GRAJfirw9hhpGoT3o08jTYu2IWQn9JWa
         WU1zdUEYJpQ7ZBjUwa9v0YSDqJ9nL5cCSrmXw5CTQdDia2Njz+hHXODQe/oCVC4aPHvl
         1TAwCEM2xLSJnOVk4SOs6H52Z9FMaX4hyMijAI/HgmIfsYYW/DKoMQxqeGPjCzgRkvw4
         +jmg==
X-Gm-Message-State: ACrzQf3z6nRNfjOzgswOB5vkItqo3bth3qi/ln8NxICKg17EdDI45PgH
        NshFx5dCroq7jN0hyiBRACcaX9ogPTSQAg==
X-Google-Smtp-Source: AMsMyM45BewjPXyzYPbE2qLoXyx+2V33Q8EG3+MjSy4qWA1xQl9O/BIF27MyIvjPTTeXeOK2sXCBLA==
X-Received: by 2002:a05:6402:1052:b0:459:2c49:1aed with SMTP id e18-20020a056402105200b004592c491aedmr51731588edu.212.1667848343564;
        Mon, 07 Nov 2022 11:12:23 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id o17-20020a170906601100b0073d83f80b05sm3790021ejj.94.2022.11.07.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:12:23 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>,
        Bastian Germann <bage@debian.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bastian Germann <bage@debian.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: allwinner: a64: enable Bluetooth on Pinebook
Date:   Mon, 07 Nov 2022 20:12:22 +0100
Message-ID: <2320960.NG923GbCHz@kista>
In-Reply-To: <20221105153319.19345-2-bage@debian.org>
References: <20221105153319.19345-1-bage@debian.org> <20221105153319.19345-2-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. november 2022 ob 16:33:19 CET je Bastian Germann napisal(a):
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
> and uses PL5 as device wake GPIO and PL6 as host wake GPIO.
> 
> Enable it in the device tree.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Bastian Germann <bage@debian.org>

Applied, thanks!

Best regards,
Jernej


