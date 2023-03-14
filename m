Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F296BA2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCNW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCNW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:58:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502850F97
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678834696; x=1710370696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+E8pmmwHhgh7vdhIb+zwxnTey/wAa0W8HsUhFIWhutk=;
  b=g7XcPCfULTxkMOLzF5M6mwBHLpzEOeKfw/34+5xw12DX7gGKArU1C0nW
   CvoovafATQvd0QsLe72GxlTy2ALFXymyCmHZugbeUqUgDm7+6ITUFsMtP
   SInJomsCGHvDQ80xw7VboiMdscMLRfvWBpPDjoNzxsGqXXz49yuQ9k9Hw
   BDAReAw5wrGmnaVsJ52fk8CmxhVoNm84QFUmnpp1+L7dS8FZF5iImOGvT
   lFN8Z54DVupxPTYmdkVbO3cGkfymud1VoBw4GwqPNS8ppxc6isLs6oaZi
   74PiLLcp1amlSBhJSJzBPBNyZJ3ZbBuHEAEtFomH5Q1+Q5vmlxIIAgtFi
   g==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="223921919"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 06:56:48 +0800
IronPort-SDR: UzE43GcEm3QLRUPUjbUIWM1QyWIuN5KKtLZCj3UmoYMNi/zry0O7yJfFhGVl2CpJdNKX8z5JQ8
 U47+e1quvpy6m0f2VMraTtQHQOCEXcsYSlBrDImXRs4DC5HDWUdi4WvIWH6wKlmv++sj5EkFZI
 7NdYDDxRkhGhESfhHRS4CrsGUx8o2IJu5VL5dwE2+Zbj5x7XN+mFzyiFb8m9IJBTWS99uB2jeU
 N228hYHC59J6av8ReL/Am9TFKJW5GuEi8g1YA01L0GVUXtwz9RctG2k525im/Y7uhmvYIfo816
 hBk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 15:13:15 -0700
IronPort-SDR: rI/8bHeLhBgAPu+eYEqe7uEZ55jYOj9pOAIKWr/FkBWbXv9/a7KZGVYdjeYGfDr7HvI/z/TR29
 V3N4heA38faZw2sPx+qf3Dlq4s+zLNSg82H3LbCaVes/4CHGQTaMnFVHTLrMG6Wv/iEgwT1IUA
 6d0W+O0iMBY1M0wJcOuraeUJbsGeSwULqxLfXTqGxEg8z47lggn+g265uR64ZCbl6IWgaIZAzx
 Vds8fkSR0zTh8GiMrWsfhWU0yzPWehnxfNUFWkhGOei9gdtnYhllZ07dKZp7mw8ZBp0GeDdLXV
 Klc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 15:56:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbpmw0nmcz1RtVt
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:56:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678834607; x=1681426608; bh=+E8pmmwHhgh7vdhIb+zwxnTey/wAa0W8HsU
        hFIWhutk=; b=pb5Ubts9uFeMDy3UPBwLFJFAL6FZv2yzDlpU/CfNTgSpj5k+KMf
        shzvJMdo6TLqyeeUegM7dT0ya0VSgtw4Ubh5Rb5xCXiqbc4UMMUAAO7ZXIL1CFTY
        4inbstQ+c84/Y9bT7lfIDXBnYkKhEyj9tCbhqrv5texA/lvkBuR/smueU7EGkZDj
        lumPjmvylCfty5HRr/yu82EUadbDb7R8ZW725Yz6mpb38H51RUkIrUp4ZCeD4t/H
        /o2AG3/RKG3fBYnnlvjtAPBTXHsFG024/hxhipjr7gQg2nUULt1J+DgmvBlRE2Q7
        34JJWv9GpA04YPJI7IYXntrkAcayH16HEBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YCwC1EzU2pXV for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 15:56:47 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbpmt099tz1RtVm;
        Tue, 14 Mar 2023 15:56:45 -0700 (PDT)
Message-ID: <5d4c882f-3d7b-e97b-b36c-82c928c31d25@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 07:56:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] RISCV: CANAAN: Make K210_SYSCTL depend on CLK_K210
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
References: <20230314211030.3953195-1-Mr.Bossman075@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314211030.3953195-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 06:10, Jesse Taube wrote:
> CLK_K210 is no longer a dependency of SOC_CANAAN,
> but K210_SYSCTL depends on CLK_K210. This patch makes K210_SYSCTL
> depend on CLK_K210. Also fix whitespace errors.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org
> Fixes: 3af577f9826f ("RISC-V: stop directly selecting drivers for SOC_CANAAN")
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

