Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD195BB190
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIPRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIPRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:21:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51E3D58DF3;
        Fri, 16 Sep 2022 10:21:04 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.35.69.86])
        by linux.microsoft.com (Postfix) with ESMTPSA id 995F62057C51;
        Fri, 16 Sep 2022 10:21:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 995F62057C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663348863;
        bh=A2ida2JImgsK4UkeYzeFjOJ0tiwuK8bnCdPdCjm9pt0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KYZtP4gviHGMnnV8Py6fBB0q97vzSmjwM0mh0A7YEkX6r+JJsTtmevZef37AZRmrW
         jqQM+pwWFUeuhEKC9mTKJ+TK4VSrZFZ91mjysl8Qm6arIDSV1SL6V3hUB1w7rfjvlu
         gUHI28DL+rg7ANZdVzP84ROKc+m3UX6rbX0lh3XQ=
Message-ID: <4dc8b1a8-d7ef-844d-b48e-76fb8b91d96a@linux.microsoft.com>
Date:   Fri, 16 Sep 2022 10:21:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] crypto: aspeed: fix build module error
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Neal Liu <neal_liu@aspeedtech.com>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
 <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YyRS/71B4veWJgyl@gondor.apana.org.au>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <YyRS/71B4veWJgyl@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2022 3:42 AM, Herbert Xu wrote:
>>> Does this still build if both HASH and CRYPTO are off?
>>>
>>> I think this it's best if you do:
>>>
>>> hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
>>> aspeed-hace-hash.o
>>> hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
>>> aspeed-hace-crypto.o
>>>
>>> obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
>>> aspeed_crypto-objs := aspeed-hace.o	\
>>> 		      $(hace-hash-y)	\
>>> 		      $(hace-crypto-y)
>>>
>> aspeed-hace.o effects only if either hace-hash-y or hace-crypto-y.
>> If we put aspeed-hace.o in aspeed_crypto-objs, but hace-hash-y and hace-crypto-y are empty, apseed-hace.o is just an useless driver which might still occupy system resources.
> Apparently it doesn't build after all, at least not on m68k.
> 
> So please either adopt my suggestion above, or come up with another
> way of preventing the build failure on m68k with both HASH and CRYPTO
> disabled.

Curious why compiled on m68k? It's embedded controller in ARM based
Aspeed SoCs. And there's "depends on ARCH_ASPEED" in Kconfig, need
some additional dependencies?

Regards,
Dhananjay
