Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6065F138
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjAEQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjAEQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:30:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4558304;
        Thu,  5 Jan 2023 08:30:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id co23so36693724wrb.4;
        Thu, 05 Jan 2023 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3EejsfMRPYJ8twdYT45Z3uPua4+S1LNtd+Q+9tbauc=;
        b=M17tidvmkWkYuFrf1Lwzlgp3oUKnmbk9v/FsptibpHce4ZAqpmIKX+7+UW6AAVTjks
         wRgopWPda293hciGNXg+8XT/sDP3ZgOuBT/PW5758mCviTDFDzxNKspr6lwpDvotggrJ
         9M5hg6/2Jgwf/JwvkipKBdIVdeT26Am3kAQSP4W1Q1fAyu8xOsyvWjC0OgLejsjghfI1
         vHOJdXdJE2vAXeo5CK4lPNmHhtGNU/X+DS6RTLNSke5C/CebnaLmUaRuMAhsIe+rSI5S
         pENvk5AB6SJAzxX7T8monl32sXTL+JYWbAVRIBc/DEFTpkqdCVmPl+sNV32PXh8DunrE
         VusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3EejsfMRPYJ8twdYT45Z3uPua4+S1LNtd+Q+9tbauc=;
        b=7I3MsvhSPevoKOYjWZL3nAifZbcp8z4/r3jgYE//egjiCYLClJsHgheJxH+o8hr0m5
         mupL54jhDa0QWQWNAzJsO0F6chSonjHTfccE2ryD4N93zTubpXo4uv1nsYwo1G2C0sLo
         mVe92ZGp6UM04mtMbUBye3zco2ZyihBmP99stLA9T1oOkiZLO8PyaWSq1jCz26VKo24+
         MLxd89tK/wWULYuZEZBhznQ2dbAiYhD6P5BDzavR11rX7MdPM2av7aHExQ04olX8nOkJ
         re68W+mSWwwL7ibrnJFDt7KQ8BdbWW9YoMv0OLc2GlyETHDxKers0rDWxxgNrdpFlysp
         mOjw==
X-Gm-Message-State: AFqh2koIEkAImkheK9ifEPGl7DIjzvy21vaAmLX80mlBFj8PFtwDT+nh
        FDH3jcfx0faB4X1G9H2OX+w=
X-Google-Smtp-Source: AMrXdXszLZ9BZFqJxfINjbGbG4pDRYZ8kDGOk2JHXjZcf5Xgus/zLO7jwULs6trog6IRkMTs0W2P3w==
X-Received: by 2002:adf:f183:0:b0:255:96ed:950b with SMTP id h3-20020adff183000000b0025596ed950bmr30694484wro.60.1672936212723;
        Thu, 05 Jan 2023 08:30:12 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d5451000000b0023662d97130sm37280824wrv.20.2023.01.05.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:30:12 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add crypto engine node
Date:   Thu, 05 Jan 2023 17:30:10 +0100
Message-ID: <10201998.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20221231220146.646-4-samuel@sholland.org>
References: <20221231220146.646-1-samuel@sholland.org>
 <20221231220146.646-4-samuel@sholland.org>
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

Dne sobota, 31. december 2022 ob 23:01:45 CET je Samuel Holland napisal(a):
> D1 contains a crypto engine which is supported by the sun8i-ce driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


