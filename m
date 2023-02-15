Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A275697311
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBOBFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBOBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:05:08 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062531E00
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676423089; x=1707959089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IL5gc63/fDsz5QiSOYrQinbaMAqccro2o4wNnnC1ado=;
  b=BxDCKuXwBjdL991pghqMEJolZ0gJ8DThDv7FZzVt0rykRYjVGPFk8iyj
   PqIceMffTplbeE8uez9Ouj/OJ6BhOxPAzLc+b8igy7qjlh9LiTRIBn6bL
   H74XgHVIJFZLnz5Z3afNJObv4Swah2L74uEJRkVWb4S/Ek3nc0Uhl2ZxF
   kq2XLe1r009xN9zAG2YB1UmvA0mikflcJ1vxykw+0GFk2rsFtVZy7SWVN
   WOfN7BDrZIg3FZhT97+TIFXmhIlJ/4yY79ToTYboaTd+zhqXj54m+Sqg6
   wdROnmsQzCVLv7IZQdBAfbrIxOz7Z5Ya1w/N89sDtrtPj8LlqLmTTdFUZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223115579"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 09:04:03 +0800
IronPort-SDR: qJ/zYsMTL4Q0YAhIeRXEkqliaD32zESOqDfbNA9tHkKutTsgloiXXEXAjcmbyH2IZOiPhKAq67
 fiJybfgVaHg1un2pTV51NpbpVGgBh4Lg7YdMXpH4pEhazjUyAmzvcGapkBTgcnLJZIBWbropgB
 4pilfQ8zFYsB5/0TsJIQ/H7I5Cgx2n859kSQRcbtG/Dg6fVLGvNrKLkPP2wgJ3fwctroelN8lL
 RvhnR+wUa411dL2/DVdPJYrbt/0bWgGEFa9px+QUY3yfUiSECgIOWFxQXozkT/6V4VlpMnbOAo
 Ji4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 16:15:25 -0800
IronPort-SDR: vhfMsu+qJ2MIHecpRylcGcnFssdHDYX8Bdvw05brb7uhO2w1jBqP7Z4xh/aqRCTqSOJXIRrY7D
 6SMaiblPqkp+AOOH3afn8BHZdy3VrMYDoD7syY+regmJQV1vuKrquzt2nqBv/6bHdppYcsJ+Zo
 epJoCZ9+W5ZtVQPT1qypP79dBVOLD04hg05j5fXvtmr33UByyCVeABfW680wvLXgyv/vxX7Gjr
 1Pd8xfgSyhnrMZGaC9ggqBuWY6v4zcxwDmS+Msk6xkkKnQBZuQ175jpSRnLhUhdRji3909EMOU
 bCc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 17:04:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGfwd5SsZz1RWy0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:04:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676423040; x=1679015041; bh=IL5gc63/fDsz5QiSOYrQinbaMAqccro2o4w
        NnnC1ado=; b=Agj6HOTfciGHKemaC/kKz7iwb6CDxRZwvQyJXZ4r8/Wi/iu/Y5x
        CTHrTb+EYd1DfG81IRn+J5CowQcgNzU1UKMaSDpRmLucwnr0O/xoD9HuTSMt/y5n
        v0DHHwlbDtB0Y9RGwLVWfbNN0OXginU5IkqIA+wNb6wubkR4SonTbnAvEjNFwr6E
        Kt2dhee0G2LAQxBksA/ZC+A9yzPK87kxbzXPYEwwj6ZEukAmZFo9iqNMPblIx/TB
        HExIgo5b8PRezGXV0HLOTck0/6XCBpFIAA7mca8M2bDhHCXYHI4RXs/SQKs1vVfQ
        QLDkDMoKI9VONS4oU/tZrzHOGztVTmacCUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QILm9S16pYx0 for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 17:04:00 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGfwY4pZ0z1RvLy;
        Tue, 14 Feb 2023 17:03:57 -0800 (PST)
Message-ID: <a0a2afa5-e364-b7af-958f-3d4a34672337@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 10:03:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/9] arm64: dts: rockchip: Add dtsi entry for RK3399
 PCIe endpoint core
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-6-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-6-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Add dtsi entry for RK3399 PCIe endpoint core in the device tree.
> The status is "disabled" by default, so it will not be loaded unless
> explicitly chosen to. The RK3399 PCIe endpoit core should be enabled
> with the RK3399 PCIe root complex disabled because the RK3399 PCIe
> controller can only work one mode at the time, either in "root complex"
> mode or in "endpoint" mode.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

You should also update the file:

Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt

The example there is broken...

Otherwise, this works great for me.

-- 
Damien Le Moal
Western Digital Research

