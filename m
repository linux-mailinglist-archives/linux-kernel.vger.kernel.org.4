Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF333661985
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAHUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:50:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CAAE4A;
        Sun,  8 Jan 2023 12:50:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v10so8605104edi.8;
        Sun, 08 Jan 2023 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l7O+u7hpvwx/CEE2kQt2CxxFAlI3yQgMXXhNMZZ5b8=;
        b=FDlaf6HuGHd/1r8jZ2JcrzSIODO1aqOOU8QPRxTfVdcd28+Sp/p8K1uUm+WJ66t+eP
         vCE2BDQT9oyeZYP7xXVs6k6R8l1vDzdKzuMRyGEm/UozYAs/UVVw1E0j49Q5VU5mieZS
         XHhtpYeJ1mj76AbggBVYA76nx5hKOx5Zt42DflN6fMAPaFsLmRFbj140pFyzKpeCRjOe
         +8L0vej/ie/lW9+H4QRosHp03GMEiiGwi2SQBscrbeTedyAxkbDD+efVBsxLzLRa5IYv
         btO9dveEcPLEwR/0o6guaAPLnbul8qG8rhcxCYSVmLb14gZaNp7h/nBb3QGUHMTDWMwj
         JeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l7O+u7hpvwx/CEE2kQt2CxxFAlI3yQgMXXhNMZZ5b8=;
        b=BPokn7S1qtDQF/M3xNEaIwgHu9Fj7A/XSZkOcxrr5/AYesmGwjMOPUTQ65bLvd33gD
         v0u2bPNSr4Ss9M1HQviHGTU75tB2I/Nkinb765NBK0coEyMhqkb3GFP0AybVpBZOuAZh
         k9LIC3PdQ/oykPg5KJMNPZOp/koPKJng6AjNCiBlqRMjc28sspqVFj0Ag4lxdNbMGkv0
         01cZPtAhcpkTcMMt4MWRdptOgOiXNRVJUtaYb8mXEy+HofXDfWc6QnaFBHJDTAOAjsz5
         saxcrpR0DhQFIrUpGbRxtOJhi/IiNvwWdC89sSaVsAowAISErO5YhDPe1VE805mlZRaL
         mSAQ==
X-Gm-Message-State: AFqh2krmFYEgdMsdzSkQHf0QjamSG0XstqYrsUsIurIik4pIzDgA/e+s
        Re/BSOLS9Po7uFqMPz7FpmE=
X-Google-Smtp-Source: AMrXdXuI0+C7w/IwZrPvBfTWv8oEhkKKunKLQUym/99Og1HUIuARlIEDjFhaBeEwA8yQ5dkAp4HHLw==
X-Received: by 2002:aa7:d653:0:b0:47e:15ec:155e with SMTP id v19-20020aa7d653000000b0047e15ec155emr50820952edr.26.1673211019627;
        Sun, 08 Jan 2023 12:50:19 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id n18-20020a056402061200b004950ef2a09asm2871821edv.61.2023.01.08.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:50:19 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/4] nvmem: sunxi_sid: Always use 32-bit MMIO reads
Date:   Sun, 08 Jan 2023 21:50:18 +0100
Message-ID: <3511184.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20220814173656.11856-2-samuel@sholland.org>
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-2-samuel@sholland.org>
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

Dne nedelja, 14. avgust 2022 ob 19:36:52 CET je Samuel Holland napisal(a):
> The SID SRAM on at least some SoCs (A64 and D1) returns different values
> when read with bus cycles narrower than 32 bits. This is not immediately
> obvious, because memcpy_fromio() uses word-size accesses as long as
> enough data is being copied.
> 
> The vendor driver always uses 32-bit MMIO reads, so do the same here.
> This is faster than the register-based method, which is currently used
> as a workaround on A64. And it fixes the values returned on D1, where
> the SRAM method was being used.
> 
> The special case for the last word is needed to maintain .word_size == 1
> for sysfs ABI compatibility, as noted previously in commit de2a3eaea552
> ("nvmem: sunxi_sid: Optimize register read-out method").
> 
> Fixes: 07ae4fde9efa ("nvmem: sunxi_sid: Add support for D1 variant")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


