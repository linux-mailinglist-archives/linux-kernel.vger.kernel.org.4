Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526406BA494
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCOB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCOB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:26:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4026CCE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843617; x=1710379617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AOLVY8ScLhOLSLHr/VjLvAiC26pb7LJQs/YD3vXc8OI=;
  b=camK4kA60bXTvS0N8Ix4mGX41G9Ov+biK0Wf7vBT1J3QA1fMiGQUmcUE
   0+IJGC2rrPkq1BJ6ohLTF0YdfmIWmTNQwUOKoMsXVbuPHFmig/yPHDg+g
   olEhCL/QckgC1uB+ExRzkxHKHZc0i4aXuGXmQii9EsFidCHWT3IYSOP3x
   BecfjkBNOOEDoBnfcmhKTBQN18GQE4iILyN7kpIwLjq0nNMy+8HfZnKm1
   aMohmateznfDdwuus4hcO93Ge7G+9l9czufwWzSvAAjf2/sD2Pyfv7t2I
   04awSBp4Gn/K2LFv/g2y2Wx5zJuNrKgAyI3eNVFcWkxTesQV8dvZCXNsJ
   g==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="337671826"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:26:55 +0800
IronPort-SDR: bLw39PsYgRI3R6RwSpbqZMR63jWGLIX1ff6WFporR2P0OvVNLBbBiy/KCf8R8dRweWgOMJhU3r
 Z6Urlyz9f18qn9oaFX7Q8IUDAkNY/VsjH/hXtQYDzFxtFFDsC1IG0Xds38CfmIhCQrXMs+3F01
 B8RfkncXQ6N2Nw5ZTBZm7mwvm+AiZtadT3yCzQo6FBYjrhcUYvN8K+2J8TeS7hfTPeWsrgnVTq
 AAbSWGisL7f7Z4/TfMMKr9MEUOTNTUyMuP/UrRj0r1iAU126FU1mSzcENiWW1S7OZtntKU9Yir
 Xqc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:37:42 -0700
IronPort-SDR: FVnTzEPPYOTepViDf5HogeDLmaT9Uh+74htfVMuREwfDA5+PBdMHWmiqjqdfqZ52gqdnd5Swu4
 CprzacXf51J9How5lF+0uiQ8U1QMkIEAbgNkfWt9slHjeFL/5mqS08wv9v83CYBcv/lC7GJZN8
 ikovpr3jS6n5lFWh9SgG00EkfhlOrXY6xU0E5osH87FrkuieIsQ3z8rT3Y62LrQK/XE6IJj1Hc
 ez8n7TF4VlEC3fRPQisZMbnH0+TExlt5KIG9ZKrycBqT23PyjlC9SK9e+LLwWrk2W9VHRvq2ae
 eWE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:26:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt666lYRz1RtVt
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:26:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843614; x=1681435615; bh=AOLVY8ScLhOLSLHr/VjLvAiC26pb7LJQs/Y
        D3vXc8OI=; b=rdpJw30Y1fiXHSXoIUj1CirsSMNQQrW2blOBtl+hLqoJBbmTupm
        Wtek/7LLWelcd8SB7ocHF8J3jXrfrwvALOJknPPLmFOPrbSsyFEh2qlLe28POFpf
        2nBI38Zo2hesIBCR215un2dBZdCIEMWvzUYIa8ki94mPt7JEYoJx92RNmWitVb+4
        j3PfurWSanRiyp5WiIrctPloeS2ubGlu94WfXv7EY8XwfWueGQBOY1Ow6jefm79e
        uhX5sV/V/mylXbd5vLY91yiq0anHo+VBfX3gkXCgYBZlba+sgZswnvEpDGESVYef
        UO0pfd+rMXikQSf9X+6gGqP5fPPLLVHEkrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ecbl7V5vPh1U for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 18:26:54 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt644vprz1RtVm;
        Tue, 14 Mar 2023 18:26:52 -0700 (PDT)
Message-ID: <16cc37a4-0d97-9881-9a30-a3a3efa2c244@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:26:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ata: Use of_property_present() for testing DT property
 presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230310144700.1541414-1-robh@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230310144700.1541414-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 23:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.4. Thanks !


-- 
Damien Le Moal
Western Digital Research

