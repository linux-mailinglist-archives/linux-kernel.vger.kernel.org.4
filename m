Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658B741DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjF2B1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjF2B1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:27:17 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ED721FE7;
        Wed, 28 Jun 2023 18:27:14 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(12339:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 29 Jun 2023 09:27:04 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 29 Jun
 2023 09:27:03 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 29 Jun 2023 09:27:03 +0800
Date:   Thu, 29 Jun 2023 09:27:03 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: rt5739: Add DID check and compatible for
 rt5733
Message-ID: <20230629012703.GA10948@linuxcarl2.richtek.com>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
 <1687942037-14652-3-git-send-email-cy_huang@richtek.com>
 <2a8732f4-13fe-476d-9ae7-b970bd82c218@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a8732f4-13fe-476d-9ae7-b970bd82c218@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:47:50PM +0100, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 04:47:17PM +0800, cy_huang@richtek.com wrote:
> 
> > +	if (did == RT5733_CHIPDIE_ID) {
> > +		min_uV = RT5733_VOLT_MINUV;
> > +		max_uV = RT5733_VOLT_MAXUV;
> > +		step_uV = RT5733_VOLT_STPUV;
> > +	} else {
> > +		min_uV = RT5739_VOLT_MINUV;
> > +		max_uV = RT5739_VOLT_MAXUV;
> > +		step_uV = RT5739_VOLT_STPUV;
> > +	}
> 
> It would be better to write these as switch statements so if any more
> variants turn up they can be added more easily.

Since the IC difference is only voltage range and step, They can be retrieved from the
regulator description.

To check DID here may not a good coding.

I may rewrite it as below
  max_uV = desc->min_uV + desc->uV_step * (desc->n_voltages - 1);

And put a switch case for DID check in 'init_regulator_desc'.

Is it better?
