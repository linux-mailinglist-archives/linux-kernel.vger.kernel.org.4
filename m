Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E3E730D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjFOCxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbjFOCxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:30 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617226B1;
        Wed, 14 Jun 2023 19:53:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DA1D6ECD8E;
        Wed, 14 Jun 2023 19:53:27 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1TuKSNZEzzml; Wed, 14 Jun 2023 19:53:27 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1686797607; bh=W6yGQPaKblXM6pB5IEmuGlSyN4iL12QpXtqEw0PdKVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEsa9H0hkL1veqdXruONDggfIJB7rY2gXThff1FpaS71jzXtY3dcIvZ8NNCvewIkd
         5gTe2UN11dC257p7AINUDKZqP02lW7PZwd2wkxYLHNQOEOWi4WQ4taKJFMjGKNXCmw
         Da0IsCerX894BVP3rYuYEJcA7rpgFpG9diWKDaDqQ7E1ql6ryzHOeQICElTlLpIAek
         31o0bMxAgn2S9q55GBYE9JbeAWmzvqoiqT1jGXYQkrSN7P4CFG5K/7ER/+TbVyjqor
         dE+BIOuwYyb74kojIvdKnkNDRt3xancNmi8yTMXtf7obEQo/PTcV1yGhutBYoY+DDw
         ZXFJt4xw7UdXQ==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@oss.nxp.com>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Date:   Thu, 15 Jun 2023 04:53:17 +0200
Message-ID: <4844567.31r3eYUQgx@pliszka>
In-Reply-To: <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek, 15 czerwca 2023 04:29:01 CEST Peng Fan wrote:
> On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
> >
> > [...]
> >
> > Ok, I misunderstood. I thought that was for failing registered thermal
> > zone.
> > 
> > Would enabling the site in ops->change_mode do the trick ?
> 
> No. ops->change_mode not able to do the trick.
> 
> devm_thermal_of_zone_register->thermal_zone_device_enable
> ->thermal_zone_device_set_mode->__thermal_zone_device_update.part.0
> ->__thermal_zone_get_temp
> 
> The thermal_zone_device_set_mode will call change_mode, if return
> fail here, the thermal zone will fail to be registered.
> 
> Thanks,
> Peng.

I think the idea is not to return a failure in ops->change_mode, but to move 
enabling the site in REGS_TMR/REGS_V2_TMSR register from 
qoriq_tmu_register_tmu_zone to ops->change_mode. This way the site will be 
enabled only for actually existing thermal zones, since those not described in 
the device tree won't reach thermal_zone_device_enable.

S.


