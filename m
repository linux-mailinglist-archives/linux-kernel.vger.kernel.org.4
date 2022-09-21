Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281315BFD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIULyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIULyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:54:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A9115C;
        Wed, 21 Sep 2022 04:54:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so9433144wrx.9;
        Wed, 21 Sep 2022 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Gm0rzX0C2VtueedqY6oyqUEL0KO+3EFqhigkVvANuMY=;
        b=m716+RhwFQujGe+RzkJCE1Od2LTIec4PvVl6l4NfPom4melvVT3xQ6pXvAeU933Pb+
         ASrqpe67ibMWf0b+aKwQK5+LQ1e1G+JC146clhdx6j3XQevv/FWssty6+bwYpe61Oy7a
         YcKV7V8NBYrKy4DoamDp+dPNfbELR8kCVMOJH0UfThJc7A/CAV+QLWqeILuLRA8aiRBd
         fAvJrBDaMv57YBu4jI/AGY7Gb1Eirm7JQzT2FzH8XQH3B1IMf5sd6tyuEPV/eBvAOM6y
         wGFNjAGo/CB58aD18But9zZHUrXvBnI2aRV5Majkdrq/ZFtuG19yZROqq58N3UEQveUB
         tAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Gm0rzX0C2VtueedqY6oyqUEL0KO+3EFqhigkVvANuMY=;
        b=DMBEvmZc2qMWTxSrKw6GmIlMfrTvb/3masl6k95JXHpvuBo9wkoS3BcXgB/WLQB+J0
         1JvsKVJ6RQZRNUyjyPcvBM6RG1Fg9tEjW4JMZovQvcUPDPSChO4EXsPZy+IJznbbKdyR
         aMyCiFIZMu0jh2z1UydYjH5EvNVhgzQyJXmFj+1pKk3ApJNVpUCTiRCk1+xnXu0nsdE+
         03N9dHd+joVMneCgZ0Kmi9mSCDKWzpjfEuYqfV9FZtILAq79wTWJyCMKfK24kYRUnfRG
         08qZ0HGWw2fC5nE96pzk2tFn8Sa3KCdD3t9/ZawlN4b1GVG7ifMKO++9OFKwztBYdlT+
         /ISQ==
X-Gm-Message-State: ACrzQf2QRRqk7c2CwWhFcxKwLpYO7Phwjop+tQeGzFAcCmzCXSqc+P5m
        GbrW/VuPwUeIEaqdmm3hhm9xtokXnOA=
X-Google-Smtp-Source: AMsMyM6+bLaCCLfq2Y5Gvku94ch4fAR7cPcVVUAclbpniaRgBr/TItFM9zB1YWmXyaAc/ycMQLLlcQ==
X-Received: by 2002:a5d:59c8:0:b0:22b:237c:3e1b with SMTP id v8-20020a5d59c8000000b0022b237c3e1bmr1636584wry.635.1663761269897;
        Wed, 21 Sep 2022 04:54:29 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600c364f00b003b31c560a0csm2487422wmq.12.2022.09.21.04.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:54:29 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:54:27 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Eliav Farber <farbere@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220921 due to 94c025b6f735 ("hwmon:
 (mr75203) modify the temperature equation according to series 5 datasheet")
Message-ID: <Yyr7c4IjjcnWZ3mr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of arm, mips and xtensa allmodconfig have failed to build
next-20220921.

Error from xtensa and mips build:
ERROR: modpost: "__udivdi3" [drivers/hwmon/mr75203.ko] undefined!
ERROR: modpost: "__divdi3" [drivers/hwmon/mr75203.ko] undefined!

Error from arm build:
ERROR: modpost: "__aeabi_uldivmod" [drivers/hwmon/mr75203.ko] undefined!
ERROR: modpost: "__aeabi_ldivmod" [drivers/hwmon/mr75203.ko] undefined!

git bisect pointed to 94c025b6f735 ("hwmon: (mr75203) modify the temperature equation according to series 5 datasheet")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
