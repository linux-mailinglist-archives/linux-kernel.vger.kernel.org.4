Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C4716531
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjE3OyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3OyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:54:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A28F;
        Tue, 30 May 2023 07:54:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f623adec61so47876155e9.0;
        Tue, 30 May 2023 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685458440; x=1688050440;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP27oe6YRkTmUSFag2bWsNftLiVcxV5TwwZBiMn8rPI=;
        b=BbZp328QYvFDMdyEBRjOtAnaOclV0kL0oOPIlL8WdPHLXQWlTjdM0IR/FuFx3AVfdG
         mzib27Q5zSjiZuXTMAtbmQziNuPPYV+Pz3I7vfcrm2n3qf3ZRGTFwubNUgx+vm+dPnrL
         0gAT1msaREHYNqQPBnTifKYkDWi6qggkgvWfELNvDhlXtJK3k1rvO28MpTVePfRTqJmU
         knNwGTN0JmG3TNL6LCVySqm/4X04Op+cKfk9YY0kmcSDponkEgvtJZQMPlpDmmvk0kpR
         3IiNs6jkLONPjaycgU8JmiWHDm7GTweNL8OtZNZOhdlE1V+y9egLPNOjk6WvtVGkudmH
         wKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458440; x=1688050440;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP27oe6YRkTmUSFag2bWsNftLiVcxV5TwwZBiMn8rPI=;
        b=ZUhssjudF6P4PYMLj8gCAQdYiAlgxqJu8HJ4dYwQvjrecK3yapBMfwqbgbK12VXCud
         plZT2ShG2W+nW4NeuV8YL+vSYCLzD7o0DldhXYLWBX2+D7cs68YRExPwyyBAeStbQYlu
         /FKsNbptyopkKuF9SIjdyK3Prp+GVHpdHnozQf7y23cDB1hrBI/Wav+Blp9gNvSEEhyW
         ABVLFGn/rNZUjq23IdM4v557ZXVpdcOD5GskeBQcpgB0/z53UeiH740XNdIdBvMobyUQ
         2vcRHkx2oHwXshyZDpNvmpPxWQuTu6NBmB9kRawAiK4J2Si1oM1NjjiF+1db8juKYmfU
         kVKA==
X-Gm-Message-State: AC+VfDzzqnPMb3aqm0H2Qaa+E+edO7/jwJqEnTa/K2kGQnDlYUswCUlt
        v90lDaYzSMq5OtGeC2U5yZG0V9IA03g=
X-Google-Smtp-Source: ACHHUZ5HhsFfn1Gke9lAM7nWeq+tYkssfIuQiiuqMBrcEVRmApYu3uMXIdKAzH4ZMURaJrE7+NaH4Q==
X-Received: by 2002:a05:600c:2290:b0:3f6:89a:94c8 with SMTP id 16-20020a05600c229000b003f6089a94c8mr2032423wmf.24.1685458439652;
        Tue, 30 May 2023 07:53:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm17709352wmj.12.2023.05.30.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:53:59 -0700 (PDT)
Date:   Tue, 30 May 2023 16:53:56 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] hwmon: (nct6755) Add support for NCT6799D
Message-ID: <ZHYOBD8QTgjsdWWJ@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hello

I have tested your patch against a 6.3.4:
sensors
nct6799-isa-0290
Adapter: ISA adapter
in0:                      832.00 mV (min =  +0.00 V, max =  +1.74 V)
in1:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                        3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                        1.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                      760.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                        3.30 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                        1.67 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                     560.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                     552.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                       1.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                     480.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                     408.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                      808 RPM  (min =    0 RPM)
fan2:                      589 RPM  (min =    0 RPM)
fan3:                        0 RPM  (min =    0 RPM)
fan4:                      809 RPM  (min =    0 RPM)
fan5:                      510 RPM  (min =    0 RPM)
fan7:                        0 RPM  (min =    0 RPM)
SYSTIN:                    +33.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
CPUTIN:                    +38.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                   +39.5°C    sensor = thermistor
AUXTIN1:                   +19.0°C    sensor = thermistor
AUXTIN2:                   +20.0°C    sensor = thermistor
AUXTIN3:                   +73.0°C    sensor = thermistor
PECI Agent 0 Calibration:  +41.5°C  
PCH_CHIP_CPU_MAX_TEMP:      +0.0°C  
PCH_CHIP_TEMP:              +0.0°C  
PCH_CPU_TEMP:               +0.0°C  
TSI0_TEMP:                 +52.4°C  
intrusion0:               ALARM
intrusion1:               ALARM
beep_enable:              disabled

Part of dmesg:
[16453.196174] nct6775: Found NCT6799D or compatible chip at 0x2e:0x290

So you could add:
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
