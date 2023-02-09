Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA06914C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBIXkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBIXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:40:24 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB86D8EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:39:56 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so2648064pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aea3HsUxNusgQ3zGvDAU8d2cl52XwYgouqtSnWkqbdw=;
        b=458+ljGEBNM56QQtoF0+6PY3fNuNOVbyG9JRJz5PylYrYcsdutOuWL0VK/m6ILnSdX
         yn9CBoVbApyoJmuoTmEoOrob+HzBnUGF9rO8INpp37gag784dD5zH/lTzP9YCO2xvO4Z
         Qy/jtfTbgidsnGUgCwSP3Er5Q4q0O21RxVfqe7vg2PW+uz7cNFNlewfMPAvPNU0F2aKc
         r+lIF3DHzKmja6DGCq+Fhk6dXSkf7NEZY/PG/yY4ku/AWkNgMT1F69N3E0cul8A8jlXj
         pcGsvaeGYYbOHAFjMjrB6VG1mKYWEs71zLlyrMzyrkLv0mGecU++n19I881I9NV+f5kZ
         /pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aea3HsUxNusgQ3zGvDAU8d2cl52XwYgouqtSnWkqbdw=;
        b=a34IeLwzAbkaVaO4+18mKFmZEWww8+OBHbh0O89V/BfZJMYMzjVoCX7TfaLV7nxuxF
         3dO9AgKmlDhF9YAlvSaZNfz+Wql3P+bm2c85hqXFHyUV1ez6kO5mcXooeSxMGJVfafca
         UFgPnSjUoybZdAaNt67/eYDLlDgU/mGTHXhWaMtC69fuHGvG2frfJe/DffmPnn62mH0o
         sujjkR/wtlK/yiN0n6VlrzXkduq7qMDf9MDA9K5Ih1BoWm3Bd1LyA+9Kjr6IkkNR0OQU
         wsJLV9K3SAixIJJ0kl7hVwv9Gpf/K1oHr3hCLrXKpouZZAKpIMDLiXncgQIEinRg2NOh
         Rn4A==
X-Gm-Message-State: AO0yUKXTiwh9J9jnJOkR7jOx3t9v2MeZzy8uKB7nShCgsimHAKxB1BJL
        9TDa4fgX0u3wlMGLMY/9GO+racHC6IKlA7e5
X-Google-Smtp-Source: AK7set+X2eCiOkDYQx/Q7+txzbDHxpSSxEwFLyCSu7sXdR1b984T2SoqWJM+IMS1Rv7dKWmm1AYh3Q==
X-Received: by 2002:a62:4e49:0:b0:5a8:4a4e:78e8 with SMTP id c70-20020a624e49000000b005a84a4e78e8mr5380392pfb.7.1675985970137;
        Thu, 09 Feb 2023 15:39:30 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t18-20020a62ea12000000b005a851e6d2b5sm1959310pfh.161.2023.02.09.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:39:29 -0800 (PST)
In-Reply-To: <20230204063531.740220-1-guoren@kernel.org>
References: <20230204063531.740220-1-guoren@kernel.org>
Subject: Re: [PATCH V2] riscv: kprobe: Fixup misaligned load text
Message-Id: <167598585273.27143.7764875060371575014.b4-ty@rivosinc.com>
Date:   Thu, 09 Feb 2023 15:37:32 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ca426
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, liaochang1@huawei.com,
        bjorn@kernel.org, jrtc27@jrtc27.com, guoren@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 04 Feb 2023 01:35:31 -0500, guoren@kernel.org wrote:
> The current kprobe would cause a misaligned load for the probe point.
> This patch fixup it with two half-word loads instead.
> 
> 

Applied, thanks!

[1/1] riscv: kprobe: Fixup misaligned load text
      https://git.kernel.org/palmer/c/eb7423273cc9

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

