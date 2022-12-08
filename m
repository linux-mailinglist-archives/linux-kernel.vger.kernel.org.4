Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E563646C22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLHJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiLHJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:45:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821546F0C3;
        Thu,  8 Dec 2022 01:44:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so4090247pjr.3;
        Thu, 08 Dec 2022 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/Emp09knqBNxRTTwFh1sCpdBzWk1Ouprc7t0L2CgVk=;
        b=Pq11+FsHjGG8Az6tOT9WcePPzcDHBje8vWx4fI2puH56KR7nX2Uav8UG8cPphh9QbM
         ltP5cDSuB+kS+YKKFI7mc6EKUVShdf3WQ+mLHzxbCicTQTzTSAsJV/1/qnMPpEJ5mHEx
         iZrq08eoysCY7MF6gSgwNPN76Iv60rejL4yn5N8/F+wnEXBrQ8CoIWz+bDp3QGrAuKl8
         5xzr3OF98OgtQ89VLgiXflYz2kRLFvmpBOJvVGdpFpwNDpCIjLJ3w+PBVycc8cbB44/p
         N4Ly3xsij44mmzCLjnPZusEgcRFCb0V1l9G3DuoztZm5m83FqncR9z/v/IZaLPqt+Gg9
         hogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/Emp09knqBNxRTTwFh1sCpdBzWk1Ouprc7t0L2CgVk=;
        b=6ZPLT5p/NpNTHdm/m29zQe4384o5VVU1CBRZ1kecWqUKj0ZwnmRb8Sk7UJeTKN2oTk
         37HIG1Xyqb+T0OTAKVww0MUQsRPC/U9Vsm7CvkRTIW6Rv9XMyZIJaw131PRcZGY0kORT
         M5pDQRlv4D6va0PPLKRnpEfbInDalb15OE+3TyYRnUB5rELeXnfWd82sRWFO2MIBUcqF
         7StCwDuLqX3sy65/ghi9b0Nm/A/eGvheOOdwC+6+y52w0ui04ydRYQxxCaz3ukZgLLtm
         4kdLGX74SiVe5OXx5uC2PQ80616odpcbhAktRJUFGRBmQU21o8cBDMIYFXwZPcvmm1jC
         SUEw==
X-Gm-Message-State: ANoB5pnc/H0hWFWvttIR787nt2l82vXl/eoTlMqXC7ykibp30Ew8yu0R
        l07RxB8rrp35B1omVVilcNE=
X-Google-Smtp-Source: AA0mqf7bHMxyHK2zgIT4sKEuCyHuvyQMN1pYQmaRquo1ls9vwy29OQKWwc2TmLVTSRXniVfOQxSk0w==
X-Received: by 2002:a17:902:8605:b0:186:ab03:45d with SMTP id f5-20020a170902860500b00186ab03045dmr1640598plo.47.1670492697533;
        Thu, 08 Dec 2022 01:44:57 -0800 (PST)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:587:6b8b:a82b:6c3c:f5f2:a035])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b0017d97d13b18sm7113331plf.65.2022.12.08.01.44.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:44:56 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:44:50 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] Add Richtek RT9471 3A battery charger support
Message-ID: <20221208094445.GA14085@cyhuang-hp-elitebook-840-g3.rt>
References: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:50:06PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch set is to add Richtek RT9471 charger support.
> 
> The RT9471/D is a highly-integrated 3A switch mode battery charge management
> and system power path management device for single cell Li-Ion and Li-polymer
> battery. The low impedance power path optimizes switch-mode operation
> efficiency, reduces battery charging time and extends battery life during
> discharging phase.
>
Hi,
  This patch series was pending almost 2 month.

For the below question
Does it mean to remove 'sysoff_enable' attribute and no more discussion?
https://lore.kernel.org/lkml/CADiBU39FMkDOrMHXTQF+0JGX2tDn_iVXCb19jM6MopnKmaXOpQ@mail.gmail.com/


v7
https://lore.kernel.org/lkml/1664531079-15915-1-git-send-email-u0084500@gmail.com/
v8
https://lore.kernel.org/lkml/1664549409-4280-1-git-send-email-u0084500@gmail.com/
For v7/v8, it may be my fault.
Because I could not get any reply, that's why I try to find any missing header or code
defect to be fixed. I know the version tags make others confused.
I'm sorry about that.

Still hope to get any feedback for the finalized v9 version.

Thanks.


> Since v8:
> - revert v7 for adding irq wakeup capable, i2c core already did it.
> 
> Since v7:
> - Add irq wakeup capable.
> - Add missing header 'module.h' for MODULE_DEVICE_TABLE.
> 
> Since v6:
> - Use 'ATTRIBUTE_GROUPS' macro to simplify the attribute coding.
> - Explain more details for sysoff_enable attribute.
> 
> Since v5:
> - Remove one line wrapper.
> - Merge header content into source file, remove header file.
> - Remove 'charge_term_enable' sysfs entry and merge it into
>   'charge_term_current' property control.
> - Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
>   Following by the below discussion
>   https://lore.kernel.org/all/YxAVAt2eWB3NFlrk@google.com/
> - Recover all the change in sysfs-class-power.
> - New a sysfs-class-power-rt9471 file.
> - Remove 'charge_term_enable' sysfs entry, directly integrate it in
>   'charge_term_current' power supply property control.
> 
> Since v4:
> - Remove the line for the owner field in driver.
> - Add the documentation for sysfs entries.
> 
> Since v3:
> - Move unevaluatedProperties line after $ref for binding patch.
> - Add Reviewed-by tag for binding patch.
> 
> Since v2:
> - Remove the properties for interrupt controller things in the binding documentation.
> - Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
> - Add regulator min/max microamp to allow otg vbus current adjustable in example.
> - Specify the active-level for charge-enable-gpios in binding example.
> - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
> - Specify the member name directly for the use of linear range.
> 
> ChiYuan Huang (3):
>   dt-bindings: power: supply: Add Richtek RT9471 battery charger
>   power: supply: rt9471: Add Richtek RT9471 charger driver
>   Documentation: power: rt9471: Document exported sysfs entries
> 
>  Documentation/ABI/testing/sysfs-class-power-rt9471 |  32 +
>  .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
>  drivers/power/supply/Kconfig                       |  16 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/rt9471.c                      | 931 +++++++++++++++++++++
>  5 files changed, 1053 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
>  create mode 100644 drivers/power/supply/rt9471.c
> 
> -- 
> 2.7.4
> 
