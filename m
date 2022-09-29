Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371955EECB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiI2ER0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI2ERV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:17:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9C122062;
        Wed, 28 Sep 2022 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664425040; x=1695961040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wFlxZMLVP1hnVG3Oy50gkOZI84xSvz1wJ7g0p5WA184=;
  b=IYKDkz6Jny4+D3ZvUOFZUzhl0frowUcemWwqvIq7eC2CVv2fWAEvktmN
   kXfmwKnZDBnFvO/845eX2k2Pmm6Eo/5HhvqLg8hgctJFbwGpA+cB8o9xn
   AkoRQ67zpKzimM3HwqXnz0cm/H+nQGoSXqGyLPpKwK+h+QkcfAQOrTOQf
   KD5wNoaWyf5xsBT7s0IgbYCT/yTgP4f+kiTo2y+97BmeZy0ONUbivLZGr
   jwndJa2vY6c3WDIc/9Epl32jayLyTUBfYodA7hoYPzk+01KPBhh48YOlL
   5oMoaWysD4DiORJi1aO7E6OFWBNnS6VNdFehyBA3SC1meFMeWuCl936JL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363632708"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="363632708"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="690661734"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="690661734"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2022 21:17:16 -0700
From:   wen.ping.teh@intel.com
To:     dmitry.baryshkov@linaro.org
Cc:     bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, dinguyen@kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        wen.ping.teh@intel.com, will@kernel.org
Subject: Re: [PATCH 0/2] crypto: intel-fcs: Add crypto service driver for Intel SoCFPGA
Date:   Thu, 29 Sep 2022 12:16:55 +0800
Message-Id: <20220929041655.3239948-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <806d5fc4-fb37-c60c-a11a-f73e5e21afb2@linaro.org>
References: <806d5fc4-fb37-c60c-a11a-f73e5e21afb2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wen.ping.teh@intel.com=0D

> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>=0D
>> From: wen.ping.teh@intel.com=0D
>> =0D
>>> From: Dmitry Baryshkov @ 2022-09-15 11:46 UTC (permalink / raw)=0D
>>>> From: wen.ping.teh@intel.com=0D
>>>>=0D
>>>>> This patch introduces a crypto service driver for Intel SoCFPGA=0D
>>>>> family. The FPGA Crypto Service (FCS) includes a large set of securit=
y=0D
>>>>> features that are provided by the Secure Device Manager(SDM) in FPGA.=
=0D
>>>>> The driver provide IOCTL interface for user to call the crypto servic=
es=0D
>>>>> and send them to SDM's mailbox.=0D
>>>>>=0D
>>>>> Teh Wen Ping (2):=0D
>>>>>    crypto: intel-fcs: crypto service driver for Intel SoCFPGA family=
=0D
>>>>>    arm64: defconfig: add CRYPTO_DEV_INTEL_FCS=0D
>>>> Hi,=0D
>>>>=0D
>>>> I just found out that there was a previous attempt to upstream this dr=
iver=0D
>>>> 2 years ago. It was NACK because it did not implement crypto API. Plea=
se=0D
>>>> drop this review.=0D
>>>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg44701.htm=
l=0D
>>>>=0D
>>>> I will move this driver to drivers/misc.=0D
>>>=0D
>>> I think the proper solution would be to implement the existing API firs=
t=0D
>>> rather than adding a set of custom proprietary IOCTLs that nobody else=
=0D
>>> is going to use.=0D
>> =0D
>> Could you explain what are the existing API that you are referring?=0D
>> The FCS driver doesn't have API. Instead it uses IOCTLs to interact with=
 user-space application to perform Intel SoCFPGA crypto features.=0D
>=0D
> The FCS driver doesn't. But Linux does.=0D
>=0D
> For the hw random generators we have the struct hwrng/devm_hwrng_register=
().=0D
>=0D
> For AES, EC, etc. there are corresponding Crypto API. Based on your =0D
> patches I couldn't guess if your hardware is more of a TPM or a generic =
=0D
> crypto "accelerator". However Linux has support for both kinds of =0D
> hardware. Most likely the right interface is already there (or almost =0D
> there). In 90% of cases 'a custom bunch of IOCTLs' is not a correct one.=
=0D
=0D
Thanks for the feedback Dmitry. We will look into the available Linux crypt=
o API and how our driver can use them.=0D
This is will take some time but we will try to check the proper solution.=0D
=0D
Thanks=0D
Wen Ping=0D
