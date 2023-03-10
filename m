Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1066B4D75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCJQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjCJQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:47:07 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A4612C401;
        Fri, 10 Mar 2023 08:44:37 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-176e43eb199so6463100fac.7;
        Fri, 10 Mar 2023 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pv4U+2qJx++wtxYGFaFQz/09rJpl3rLoLpy7o0aVpu8=;
        b=oYwmeSlbhPPUKvCUD8TIjD/sSBIXQGT8uQi+ZUwO/jzfg9rHtee0ZPcyN5AmRIZmYj
         50C+upuCinBb+CUcctBNhDC17I8CAoEXeU5u+4U/+AXRWjBoCH7CszN8Sx8m+oORRNf8
         e1bsZ7WA0wjsfh9MjHf/Cu0kPyzXlaW0PhSzdJEPfZ+YihdNh7GqJxP4f5h0CqYdvoF+
         p9sA7R8M9X6oct9Klg5syifGgwsBVkAPC0Nm1ZJ4UN024X/cMdmXpANHHlLhUksAmQZp
         0XbpwMiiaq4QApvh2JLQX/r1M4R5CMsgLlXSc4tbirGSRjKQksaihNLUhZl2TJV7wdKv
         snpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv4U+2qJx++wtxYGFaFQz/09rJpl3rLoLpy7o0aVpu8=;
        b=GGwVALLbqrNCrfJCHMyxtR+0fqy8PdfLhA4hjwtJwVagYOKchfsHs5EhdpxpVzy61H
         AAgBy5BCumH8mUy+7tZMbcs3spIrQ/NaDfSXtBuTuiNlNUbwpoDEpe89xI/23/YjaIuI
         XoJSbFO1vBFRYqYXE0UAhxgPgx3oE8+oGN6WN27rpcKIhddx9ZisuGBzZWiGNewsC9hI
         5mouBdZnyL9ifagK5Lyk/xtpqQv3dItQGVQIvbyIG6UsldPhbx+Bec+usIKSYHyvxrWD
         j2BvYo04DblMcl+kMHRR9noSUdGinrZWNzUH6OdsIT/BiLGc2eth+ug2yaAwgmDi2n7A
         HIFQ==
X-Gm-Message-State: AO0yUKXM9Sv/as1BlqTtEkNNMfhjQbynZprrMZL1Qc+ywZlFhD0hZCV7
        NzfC0viqpEJSJc0Iu+joLd4=
X-Google-Smtp-Source: AK7set83hhga4fkteTS1Sl7TxhoxPwVYjj6XhbanH7ws2DBryQEJ3dEFmHorQ99yq9U3pgSAg1DylQ==
X-Received: by 2002:a05:6870:6388:b0:176:5de9:9b8 with SMTP id t8-20020a056870638800b001765de909b8mr15831795oap.40.1678466675382;
        Fri, 10 Mar 2023 08:44:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i2-20020a056870044200b0017293fa734asm184309oak.48.2023.03.10.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:44:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:44:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Ekman <erik@kryo.se>
Cc:     Jean Delvare <jdelvare@suse.com>, pauk.denis@gmail.com,
        ahmad@khalifa.ws, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) ASUS PRIME Z590 boards support
Message-ID: <ae1ddc06-941b-4f13-8f46-6188cad4aa2c@roeck-us.net>
References: <20230227090312.91091-1-erik@kryo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227090312.91091-1-erik@kryo.se>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:03:11AM +0100, Erik Ekman wrote:
> Tested on Z590M-PLUS.
> 
> dmesg log:
> nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
> 
> sensors output:
> nct6798-isa-0290
> Adapter: ISA adapter
> in0:                      672.00 mV (min =  +0.00 V, max =  +1.74 V)
> in1:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in2:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in3:                        3.28 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:                        1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:                      808.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in6:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in7:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in8:                        3.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in9:                      528.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in10:                     672.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in11:                     528.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in12:                       1.21 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in13:                     992.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
> in14:                       1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> fan1:                      971 RPM  (min =    0 RPM)
> fan2:                     1525 RPM  (min =    0 RPM)
> fan3:                        0 RPM  (min =    0 RPM)
> fan4:                     1094 RPM  (min =    0 RPM)
> fan5:                        0 RPM  (min =    0 RPM)
> fan6:                        0 RPM  (min =    0 RPM)
> fan7:                        0 RPM  (min =    0 RPM)
> SYSTIN:                    +36.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> CPUTIN:                    +40.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> AUXTIN0:                   +26.0°C    sensor = thermistor
> AUXTIN1:                    +8.0°C    sensor = thermistor
> AUXTIN2:                   +22.0°C    sensor = thermistor
> AUXTIN3:                   +25.0°C    sensor = thermistor
> PECI Agent 0 Calibration:  +40.0°C
> PCH_CHIP_CPU_MAX_TEMP:      +0.0°C
> PCH_CHIP_TEMP:             +55.0°C
> PCH_CPU_TEMP:               +0.0°C
> intrusion0:               OK
> intrusion1:               ALARM
> beep_enable:              disabled
> 
> Signed-off-by: Erik Ekman <erik@kryo.se>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775-platform.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index 76c6b564d7fc..1a00f4a542fe 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1122,6 +1122,9 @@ static const char * const asus_msi_boards[] = {
>  	"PRIME X670-P",
>  	"PRIME X670-P WIFI",
>  	"PRIME X670E-PRO WIFI",
> +	"PRIME Z590-A",
> +	"PRIME Z590-P",
> +	"PRIME Z590M-PLUS",
>  	"Pro B660M-C-D4",
>  	"ProArt B660-CREATOR D4",
>  	"ProArt X670E-CREATOR WIFI",
