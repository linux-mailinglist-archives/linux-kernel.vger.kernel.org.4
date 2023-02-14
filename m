Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C063969724B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjBNX7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjBNX6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:58:45 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FF303F3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676419102; x=1707955102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0wzbE5dbKeg6zwPSACvcz44HHBT+V6cdN+UmWihI6ko=;
  b=OWZqBZpUmrVzNT1mCBaKi7s82Gnb4GvJ0UaaPK4EBFEeXshG80JqYT6a
   GELin8EyMImX6y9ZZqaXzgD9S5f/Ag/UqGmirRDjynZa9yYCh0zxN0qnc
   NMOqimKhGdrcA/wdrrguElstRkPAI+gC/Y+XihrmD6z1rHy1yGW5jCyTZ
   y9WouDwk89a38qrk21XEDPOoL0vSkEyJH8YwZ+N8SzLL53e8PTYuo1xMu
   Tgx8dc3Oju3YGDSEc5bBSWnqOE+qw8Il9JY/a/fgiB5JGvpAEErF4ixzk
   nwlxzcEO2cN2/uTPGajV49VdHmqETTwCSCsaSdY0aY2SE0QipWNiIdBUs
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223337714"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 07:58:21 +0800
IronPort-SDR: PQEN+zc2YGu+L3e4+Nw/pCp2JqogGD+9eSSQlTRYiEzaf2AflzY2msOjABnu/GqLyYFPpgyoov
 4cc+3yhuePvdVdTU6iPztNmFGhybzCGU0kf34y1Qwr4VUnAk3OyJqgSh221ohEY4eXvRuO9Yda
 mQdoR77V9BZpB+Zni1ctVS8nnLcZIkQm5DHidWxpu+hcolqhgXH/qbaqVBs4fuAjLGgSKWfLg0
 HWqPAAVaWatYXCRKq+kJ0fzVomFJL/Ya6jwStbUOkGMVwtTbhopjh1/hvPGPC9y7zmTPBnAtQO
 Y0M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:09:44 -0800
IronPort-SDR: 5F6wrASeRVfwGvrhSv4rTeGQ6ow8Bb3qX6S8tix84fhwFGrHT7oLccsgbuGKO2fPK91Ok5iEbX
 UnYUYxJHiShEwFyprso6ABFnke3rLT4Q+eMTh3Cu3zzkJ758OK0Uef5Iw5+50tXZtPR4LDCTHG
 nCNeULcC8/8EUHltwierpJRqLtwHIOso+rZAauRuMtr4qoGxKnOMT/1azdAB6r3BkblE1PTdvf
 LtoLLtpSLUpysrmJzLFKvFwW7KEAboyA443A0Gcg93qnxjL3ZTetXOeGCc/LJ9e6jSjDiYXFH9
 o9I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:58:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGdSs0q06z1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:58:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676419100; x=1679011101; bh=0wzbE5dbKeg6zwPSACvcz44HHBT+V6cdN+U
        mWihI6ko=; b=nhXWsH1w2yUI7rcUShKvBVvquthT7csOKjfHohg73oprsbOPmZJ
        Trnzjb3ZgU+4gk8qjDRxw2Tv+ixOPtvRt8n7rLaJzbqMg/3thVaZ7sZBr18jZUA/
        z0bg3UCtvtxN0rm793uev6UJIGaHtwItlwcdvZM0vEr9zq58xCQ4raacivhrKfUN
        HGA1RE6kMSO631u9NgPoqWoqxW17YH3kPmumVgmdLn0SAPWnqCb2QBrIREBy6oBJ
        836YHVC4u7NF6G4re+p0Twqs9a1IsJVL53mo8JU++ISQiEPHdMDhmby5ryWH4vS2
        qY0DzbxL0XEGslkDq817CK8CfgyFUqrMfdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ao18ssFgKc5B for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 15:58:20 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGdSn36S3z1RvLy;
        Tue, 14 Feb 2023 15:58:17 -0800 (PST)
Message-ID: <f8db1d50-5771-44e0-cb39-64425966f35f@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 08:58:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/9] PCI: rockchip: Assert PCI Configuration Enable bit
 after probe
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-4-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-4-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Assert PCI Configuration Enable bit after probe. When this bit is left to
> 0 in the endpoint mode, the RK3399 PCIe endpoint core will generate
> configuration request retry status (CRS) messages back to the root complex.
> Assert this bit after probe to allow the RK3399 PCIe endpoint core to reply
> to configuration requests from the root complex.
> This is documented in section 17.5.8.1.2 of the RK3399 TRM.
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

