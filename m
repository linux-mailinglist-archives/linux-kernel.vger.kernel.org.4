Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F411F5B9C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIONwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIONw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:52:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97D98D2F;
        Thu, 15 Sep 2022 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663249947; x=1694785947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPl8JULjiE6znvBSZ8XCagbyNoT+W5D+8RTaxBC14CU=;
  b=EEjcmOPeHpvXCoMf38dRsop01r5uQRL0ggCQ3qW6TDfjJSqd7McEFReW
   1j/pcOgAOB2Nw7KSEwXDTzvMXnHQNAHH3YRxk+ZcGWy6wuuTvKlLfHTiW
   JRWkahZCNbUiHKxEqn7+uwoHMqcd9dsrPsbnW8rk+qv64Y9X6RdF+azqu
   9xJy3rCCX2Cvn6w+KmvWK9NEL7Pgx7xKdkQtzXUdXCXkuvi3NIK4ABtoz
   pWritBpTlpZvT2PPlBmUYFf204qQYfJdzNbzMejz8FfGxhFLRfko68kpI
   Cb1TDXlTb0iOKsYnXg/SmNvCNIhEx7DeRCOgHdGzX7n2GV2J/8RgLMwnN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324978888"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="324978888"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="619700757"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2022 06:52:23 -0700
From:   wen.ping.teh@intel.com
To:     dmitry.baryshkov@linaro.org
Cc:     bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, dinguyen@kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        wen.ping.teh@intel.com, will@kernel.org
Subject: Re: [PATCH 0/2] crypto: intel-fcs: Add crypto service driver for Intel SoCFPGA
Date:   Thu, 15 Sep 2022 21:52:19 +0800
Message-Id: <20220915135219.670329-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2d24ed07-5501-5ee9-e2a9-34ef15216e28@linaro.org>
References: <2d24ed07-5501-5ee9-e2a9-34ef15216e28@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wen.ping.teh@intel.com=0D

>From: Dmitry Baryshkov @ 2022-09-15 11:46 UTC (permalink / raw)=0D
>> From: wen.ping.teh@intel.com=0D
>> =0D
>>> This patch introduces a crypto service driver for Intel SoCFPGA=0D
>>> family. The FPGA Crypto Service (FCS) includes a large set of security=
=0D
>>> features that are provided by the Secure Device Manager(SDM) in FPGA.=0D
>>> The driver provide IOCTL interface for user to call the crypto services=
=0D
>>> and send them to SDM's mailbox.=0D
>>>=0D
>>> Teh Wen Ping (2):=0D
>>>   crypto: intel-fcs: crypto service driver for Intel SoCFPGA family=0D
>>>   arm64: defconfig: add CRYPTO_DEV_INTEL_FCS=0D
>> Hi,=0D
>> =0D
>> I just found out that there was a previous attempt to upstream this driv=
er=0D
>> 2 years ago. It was NACK because it did not implement crypto API. Please=
=0D
>> drop this review.=0D
>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg44701.html=
=0D
>> =0D
>> I will move this driver to drivers/misc.=0D
>=0D
>I think the proper solution would be to implement the existing API first =
=0D
>rather than adding a set of custom proprietary IOCTLs that nobody else =0D
>is going to use.=0D
=0D
Could you explain what are the existing API that you are referring? =0D
The FCS driver doesn't have API. Instead it uses IOCTLs to interact with us=
er-space application to perform Intel SoCFPGA crypto features. =0D
=0D
Thanks=0D
Wen Ping=
