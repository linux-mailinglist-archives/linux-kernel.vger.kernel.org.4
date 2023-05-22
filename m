Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1270BF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjEVNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjEVNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:24:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F15C2;
        Mon, 22 May 2023 06:24:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d24136685so2486233b3a.1;
        Mon, 22 May 2023 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684761888; x=1687353888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y2V2Q0cxJLucJmDdXTfQhebcgzIrmzfKxBr+QyPL/o=;
        b=Vens/k+XNOXVRidZkdBScfr1iuj6hReI+9LG5w0RUKlFruHocgD/LtfjMs3eGD94Gw
         STtas0Yz5vVUgu5GPeqNjv2T1XmkbZgQhLm3DQST+evGHtv+ue7WpUlljBLwBtltcGEO
         1C1F92REvgW36kIZ7QpmMa66U3VaGRT7LuaN/aKm10gsA+zPeRVYixt7fCkHBPYzgA0x
         PDPcWGXlbN3p4NPNjqZz0NdcTMxmpXkBjcmpIzdH7jXUlX61C+U7xD81JXb0DCNpwr/9
         6eGDE+8olhmat1gQAL/Tfxkkf19vVfMFTEzolA6+yjZkzvgEZvFEqce7PYRKhYzuPj1Z
         YC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761888; x=1687353888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y2V2Q0cxJLucJmDdXTfQhebcgzIrmzfKxBr+QyPL/o=;
        b=Cn1RfOj0N0nPfqd8VjmLxKIspb8y3wJwnA31k9jnEzXbHhRtfyLNt74Izw7atgJI7K
         6yaOr4byCJltYN4azH3QYO81zrOm+mqp9aZgYxvqh6es8CsxXjYUEbt9p6w04HokUtAc
         fXexesluH83ohd15IJ1+prOUdkgoVS9Bt8gHloYGfHx1LKn6MIv1h7wN0AZ/YrEVdhT0
         hzf3zkL07qucst3p6Wa9nRJXxCSQVR7r4l1qW07VGSeLupgDlpr8avQ4rB7UaT67KdQy
         lS+0pCkWbbS4CoGT5EcCTpZVkhfUp5ioMLUObNtkGEK9B0n8otOUe6gggYkp7SYOSH06
         HwEA==
X-Gm-Message-State: AC+VfDzUQZt6/eCEunwN4AytV+JVdoUXW3qh5TpbV5qv+5bkdSRlcYcL
        kxK6kTOVRKwTUTFplVI9B0A=
X-Google-Smtp-Source: ACHHUZ4YWkyosJlmsQWEg0b99ZVNZMBpvNmyKPUd3JiRWpH56+aaR09zKny8Q4WzczAM0hm7XwBDQQ==
X-Received: by 2002:a05:6a00:2d8d:b0:64d:5f41:1e88 with SMTP id fb13-20020a056a002d8d00b0064d5f411e88mr5674565pfb.3.1684761888209;
        Mon, 22 May 2023 06:24:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79192000000b00642ea56f06dsm4150217pfa.26.2023.05.22.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 06:24:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 May 2023 06:24:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver
Message-ID: <0e49e860-6f2c-48cb-9ef7-af7891b95237@roeck-us.net>
References: <20230516104609.7095-1-daniel.matyas@analog.com>
 <20230516104609.7095-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516104609.7095-2-daniel.matyas@analog.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 01:46:07PM +0300, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305112351.DBkFfs76-lkp@intel.com/
> ---

Change log goes here. Without it, I'll have to manually re-review and
compare against previous versions and look up comments to ensure that
all feedback has been addressed. That will take time, which is always
scarce.   don't have right now. My apologies, but that means that
review and acceptance of your driver will be delayed.

Guenter
