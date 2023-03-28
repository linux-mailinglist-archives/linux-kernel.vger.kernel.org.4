Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36256CB971
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjC1Id7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjC1Id5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:33:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CE3C33;
        Tue, 28 Mar 2023 01:33:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16so10134825pjs.4;
        Tue, 28 Mar 2023 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679992433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eASjuq7QsT1jP8e0B7Ep9hMFmqx6RAn1FELDlXM3sM=;
        b=SIosOkaDUhjhmzZHFExwoJ5Wpc/KV5sFPxiqDz4tHq7Ugy3FaER99RpfqdXPjAUqV5
         CeJUXZdaLv+u4nLTryHSV8/oApWO30A4XVQWUqlUoW6Jec4FBG2VA8rYdv4+Woleu9P0
         GuWjqDJpNyc1GalXL6k/QU+wuIRZGZ4Adat5YgGlNb3DQPIwkauw61k0uSYhLVgJxgUa
         KXrTKPyMxUCLNBWQXSKTI0CJO4wwBBPHyIkbSmHkw1IWkpfkHG7eQbOXrTg8KIXDBNy2
         N1iIa8yRRB2trtv6Gya2Nou4crGnWXVqU9BkMDVhvJBYvKRmviC6kMPgCedYYSoWWvAR
         7/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eASjuq7QsT1jP8e0B7Ep9hMFmqx6RAn1FELDlXM3sM=;
        b=mYNAG5wkrGSzfdjz0VtJCO8Y9NO7QZA9IWXfBKx7YCkGdJQh9R5JB7RnIlB5Tpo972
         pB1icmZQGm06kIGyOrsRbu3acbULWJEDt7xdH8FmHRCPy8ONQ2gnkAH3tV6/pZWLj/kc
         CqBKOC1f+95U0flEIdPUzz1rpf0yrZrxT7rNTwyI9EW43JAw3MwAkPaSVPHcE++qnI5H
         wY0SoVbE/IVmWQW54u+LLXvT9HMnVrE9v3jCattCzl2eiqy6IppmqFONiMFNI6k9WMt7
         fuXDM9XKMJvTaAnymaBM8xHhtdFWuKZtEaAv7Zn1Z6bzbwDb4xHphQCzDQJgRTlg0DHV
         YPcg==
X-Gm-Message-State: AAQBX9fsTTxq2LpvXylPr1+ts2Tjp1ZXDUlbpnuMyMkNCsE2xUzaBllA
        MgSBL6ceFBDsoJK8bCeW1qX32vpFbw+AtEzc
X-Google-Smtp-Source: AKy350aGqfEkgasMNRB2lsZyLqmvpcd2JhSPu34Dni4d6ESTjCoYiWk/NiBwqlK/d6bq/OPfRWH3OQ==
X-Received: by 2002:a17:902:da8e:b0:19c:c9d0:5bf8 with SMTP id j14-20020a170902da8e00b0019cc9d05bf8mr18783116plx.35.1679992433287;
        Tue, 28 Mar 2023 01:33:53 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b0019abd4ddbf2sm20505307plr.179.2023.03.28.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 01:33:53 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, leon@leon.nu
Subject: Re: [PATCH v4] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Tue, 28 Mar 2023 14:03:47 +0530
Message-Id: <20230328083347.54958-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9490b5ef-3068-fcbb-0105-baf3839c21df@linaro.org>
References: <9490b5ef-3068-fcbb-0105-baf3839c21df@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

Apologies but, this is the output of get_maintainers.pl, is there something that I missed?

I am currently working no 6.3-rc3 as my base kernel.

> saalim@pavilion:~/workspace/linux$ scripts/get_maintainer.pl Documentation/devicetree/bindings/sound/alc5632.txt
> Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
> Mark Brown <broonie@kernel.org> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)

Thank you,

Saalim
