Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAE619201
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKDHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKDHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:30:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE829C96
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:30:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a14so5850606wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=orgUum75kO3mxGZKGpA9/prw1jAc40FrjMlN50pgpP8=;
        b=iV29rlj5LEzTTuolIj6HfjVxTpts9vywAncmtY33E8bL3TvUTOxTqR+r0TS7FXHAqn
         Lq/qZUGSJnZgm7VP+BTyGm9CFfSuV8B6c36Sy7+wDvu1AGjq39dyuTMfRBgjteHBLZd7
         TZWxDJ9WoHdmJaWDpoobJWz32Em+Nx9nTg8KQ1wgpl1AM2yz5Eof/+RwGlIdQRb2ObBD
         AScw+6Y2icp96gbEW9GQzpCGgphYx0+Q50zJQX/bSr7A69xsi1vItqinv4vAKfIgu3V5
         fcu7cRuGt/1DBNYfowMSzIYUsYX10I67VU4jJeU85aIjAXUxMZK99Uh4/fSQOViwnYQk
         AP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orgUum75kO3mxGZKGpA9/prw1jAc40FrjMlN50pgpP8=;
        b=ihZnophBFFfUC7npcifu3KX2yyYtIX4PT061wFrk4BbJblqzdjJQgiGg6Dmeq+JdxE
         fmg1imLSaEHj1pqWXlS1OnySt4Zhbum6VvK2J1JfMbAUc5+jh/wQQYqv9BzhUqJl/Wvx
         VIN162t4MtKn87NQQXOyo2LNwnUD44IPIm3AeBZbRPl8iwPsobBQS6VdPQrZsQhItXpz
         e8XyWfJTKyx06pWVkjNhyBgBOLSS0JPwkDlVKRWoJuaaDQnYXH0GbijrCeC6c70yhOWO
         eomlrLnlRxylmW0d+og7zaOYAeXTJmN3YHNCW3bIL9e/K+1wqwdxS0qlPc829GrMKIcG
         H58Q==
X-Gm-Message-State: ACrzQf0HEQnaeC/RtIlSTjGtrQm17pAxEudU7LDn7cWOtPUKnnlKMK6w
        2Bi5/Bk4ImkCpF1IxOsJaHErCQ==
X-Google-Smtp-Source: AMsMyM6HO7azKIgRXgvhDjn9z4jfxA3QL9eOdmQYZ8skG4pF0vM71JR0bJOOgP1RFq7AEwM9PShlZg==
X-Received: by 2002:a5d:6181:0:b0:22e:3db0:67a2 with SMTP id j1-20020a5d6181000000b0022e3db067a2mr21962144wru.257.1667547048514;
        Fri, 04 Nov 2022 00:30:48 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id l6-20020a5d5266000000b00236a16c00ffsm2701107wrc.43.2022.11.04.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:30:47 -0700 (PDT)
Date:   Fri, 4 Nov 2022 08:30:42 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] crypto: Remove surplus dev_err() when using
 platform_get_irq()
Message-ID: <Y2S/osIvNJzs1jU5@Red>
References: <20221101021751.89362-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101021751.89362-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 01, 2022 at 10:17:51AM +0800, Yang Li a écrit :
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/crypto/rockchip/rk3288_crypto.c:351:2-9: line 351 is
> redundant because platform_get_irq() already prints an error
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2677
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Hello

The subject should start by "crypto: rockchip:"

Otherwise it is:
Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
