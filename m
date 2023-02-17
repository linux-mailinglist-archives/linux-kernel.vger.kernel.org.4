Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF67669AF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBQPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBQPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:08:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5CB6F7FD;
        Fri, 17 Feb 2023 07:08:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ee31so6911255edb.3;
        Fri, 17 Feb 2023 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XUILxJkgGPNaMRl2JbRx7qYAbvRZIGjpLxeN912ccY=;
        b=G4X6wgf7AEX//7Db1yuig5RhDz/ee6wAdskoyteqSRR2eG/YE8FdI7IYVazfcHugni
         fvacc3m2qfGycjJPeLioj1IWhBtVd2uoV9GYHd9bKMP/mlOqicPP+aNZ/70d4GurbLZw
         g1zPJOd50omQxw+3drQPmJRO2J6uZPEbp2Vhce3GCeO5cwf8Awr9rXcwn2klWt48dV9O
         2Pg7ecD+Cf75HF530Y1ILKXVWJNcl4hWDyX+WPHL1whLXncbdga8Jgo37IbMX4pnifJr
         10KOaHQXZtQgp1N2GYtOLWeU6ljFMcsxaMiW7nIRPlX8iFEaiNI6VolqDMPH0aAbeO/Y
         MHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XUILxJkgGPNaMRl2JbRx7qYAbvRZIGjpLxeN912ccY=;
        b=FXfVVQi8DzAZkYCIyQdu8vOgDicjMXORrXjr6tjxp0mKZ4Z2CMDkN6Z9KCHf01JE+g
         163irNYubtekQgaZs9EF3iItcTr0oD1wQ+jAQjF1ZlFdSMClEOeAfl73D29p/mSUOXQP
         4aS0eB/isphwTULC6/OgcrfXEMdHKFHZpLP06EYYrlBgNn9sUn7lJ+bNd4t4sR8fg2cW
         L6orWOocXsbRwQcse7P32Bf6JwCW+r3hVWCbxWs2IifyyfMAkmO6TL2nEar6/DYBjrB+
         OcDsu/YaebS9FKSbGBFvQsfRiYXtUjG+Zhk6/TXCH3J6BednoxcKJpozYOzoS+dT0u+a
         gxyA==
X-Gm-Message-State: AO0yUKXSBA6KV6gtd0Oldr9TpEnvHfX55dqZRKqvyIZqLYCW7Gv0+pvE
        nePhgzNmhPanu2LYgJIerGo=
X-Google-Smtp-Source: AK7set8u6obZlXK/SaRdt9ibfXZIbRe2VxSJpVCjm54J7DNn3RllHsKwpaWO3Ucyw9xqCgqLwy5bPw==
X-Received: by 2002:aa7:cd63:0:b0:4ac:dac1:3f91 with SMTP id ca3-20020aa7cd63000000b004acdac13f91mr1492923edb.18.1676646490338;
        Fri, 17 Feb 2023 07:08:10 -0800 (PST)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t10-20020a50c24a000000b004aee5dbabf9sm35555edf.24.2023.02.17.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:08:09 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org,
        jarkko.nikula@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        William Salmon <william.salmon@sifive.com>,
        u.kleine-koenig@pengutronix.de,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: (subset) [PATCH v7 00/10] Designware PWM driver updates for OF
Date:   Fri, 17 Feb 2023 16:08:09 +0100
Message-Id: <167664644976.3317584.11838750253013149302.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Fri, 23 Dec 2022 15:38:10 +0000, Ben Dooks wrote:
> An updated set of patches for the Designware PWM driver
> split into PCI and OF versions. I think I got all the
> review issues in this set.
> 
> Sorry for the delay in getting this out, between conferences
> and other absences there has been little time to deal with
> this set. I will be now out of office until 3rd Jan 2023.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
        commit: 0f03bf300833c05d914ab7f5ab3d8bc8564e9912
[02/10] pwm: dwc: allow driver to be built with COMPILE_TEST
        commit: c901a57e39db555ad7950fd61e1470cdecc8e654
[03/10] pwm: dwc: change &pci->dev to dev in probe
        commit: 8f3c7ab881ed7329003e10a2dd58f735abda2259
[04/10] pwm: dwc: move memory alloc to own function
        commit: a4218d7cf8978f397e731d1f15ef33d28f77e42b
[05/10] pwm: dwc: use devm_pwmchip_add
        commit: 7a77daf8223e772a225d6aa6202a5b1ae2392caf

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
