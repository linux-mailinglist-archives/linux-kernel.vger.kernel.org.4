Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897E86BA0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCNUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNUff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:35:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00C1A67F;
        Tue, 14 Mar 2023 13:35:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so36028492edb.6;
        Tue, 14 Mar 2023 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678826133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxwSO/LBuR46CmjoeXSfo+IWSWZ/3pwKZV8PIGQHNrk=;
        b=C4ylx+Vos6HtqYmeSZulI1EuEc8EaPUOfBPDLOFgvFEAqZLFPDAkR6+t48XM7KjrYy
         zb86bFi+M5cyq1+JMrW2h0gT/X5utpQaCzusAngPMCnM1ifzrAotuCOzP/XF2+yaaQkh
         7dycbEN4zQhpe/z3hawHy56L8Mu2SmKPZNduTRDRE9PItjeYDi083Kobx7bAVbOwKDA0
         A2qZSTNk0Tppr/6w8gVt3C/4wcT3zMJ/BrSSRvvphwOlWddyRC7NugFJAPfGKSicHAdv
         7DbnUk5173ijub6f/juCxDAMNr6Lk7toO8ii1/g1bvDzySxLQxbd9D2NpqNGcChRsxEH
         KvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxwSO/LBuR46CmjoeXSfo+IWSWZ/3pwKZV8PIGQHNrk=;
        b=a9pEpTOdM6Z+eQj17D4xIU/zGHXntXPrncqj5zrYB0cCp0X9U1IBORj7E+cSO741lp
         AzDt+uhCNrr7fO8RvOIP59WDs6+EAuTXtkP+M8n2ZQaDoCyiZKNE3MvbKpua6dSydEPH
         w/xjVHQiE4IiJnwIH6xLMMAwzI9Fpgl7gXndaPvo7ibhjR7aOokk30K7+cU5Vj01fXMt
         yBPskLTH6L4xUToserWrxNYUsLxv9j8y4mOwhS1lww1jjQSp7/t1W4sRXOL7CnwOIK+8
         yDRWQKynOO+TW9SIYbxBSJN/tuyTjylByZWyrwd1x/UPRRcFP8/sx7jtkFC6TMgAjRVX
         ZlzQ==
X-Gm-Message-State: AO0yUKUm8k23kLHTkGkv3uJ+tcuSQ+06XMHJtGXMZkUC+ENnx7U4JDNM
        ZSwIQWngwSJPj5/M+OSZrV0=
X-Google-Smtp-Source: AK7set8qAKElSfLk862Fb1U9iBFSLCsZ8OOml5T1pwcqPd2vA6HdnOUeXnTHL6GcYsNrzwpY2GGN4w==
X-Received: by 2002:a17:906:2512:b0:87d:f29:3a16 with SMTP id i18-20020a170906251200b0087d0f293a16mr4278916ejb.34.1678826133362;
        Tue, 14 Mar 2023 13:35:33 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id go37-20020a1709070da500b00927b85e48b0sm1539379ejc.111.2023.03.14.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:35:32 -0700 (PDT)
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
Date:   Tue, 14 Mar 2023 21:35:31 +0100
Message-ID: <3544095.R56niFO833@jernej-laptop>
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

Applied patch 3, thanks!

Best regards,
Jernej


