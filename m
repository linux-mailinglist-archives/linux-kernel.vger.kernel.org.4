Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6B6CB24D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC0X1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjC0X1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:27:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BC1982
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679959636; x=1711495636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8v/j5oydGaOLEzE1iZOLYHGbB0l++zz9C6Rd3Ol5Oqs=;
  b=V2hv7miNAMe+NhtDtWlfdav6dvJA71Aid0s2kIb2mJufbIXuILd51t+3
   DBZ9vsgiKFyMNOO+MBG/yOc/NOPlHOwArzgWCNzbLOSq0eeoiADvPRQZJ
   dTRpXPkYtsuLvQjmiW3tfG1WFtrouteSXEpPJJGwrAqX6S8ktqDJQel5D
   ay/fFVz8vBBWhcHEQ88UbHJRTh5hJ8aFpBSRv8PvfxbNC9wJ2ChPi4KTx
   PQAT1e5/MRIfOHAo6HQGpTzYXgeMr6Rq9q8VjgiTgmq2RwXghW7Ja4pz2
   CiBgp/bJDxgTxzcRQ+jYxmtHspCg4ZykwmUTOqiMg2rjrkwUEMUFIT7AO
   g==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="338704327"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 07:27:15 +0800
IronPort-SDR: 9peBoMhDboCfmy5txnvxs/tCeowMzk66+j+D2A9j+0yKofOVutezw2gdbsb8XoTkK6AcwfEaN+
 NqXFoOIXTtl+0NGS8eRLAmOGqDVUtVasgoOyVxD50oPZicWXSXgOoDUOV2DRuzbcmQ0hojCp/8
 1EoBMNxYpPTzF7zNAw/g68c3oX+m6PG/XTSvfgt1Nja5RcX8CsoywOi9VVWX7cfBPzjsXkArGB
 mrwmaQSDSk1HzOPs3hQPBwAHUpgYQFX0EcMIMSnDjhdkS0YZPRywFJdK6krxACejJpYAt9+anY
 aG8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 15:43:26 -0700
IronPort-SDR: 7aXt9Hrb7w+AN+YelXfSCNXWO5ZvqnpSPVuid5YR+uTXc9zzs0kkdm1EIQB356i3TcOWnCr5hu
 JCTR/QA/Nn54cOBt0q3hz51mOnk0uX8tGY8LY8IyVI4DPsoKVPPquz39SOUZlnsSePOt+x1Q8D
 15swUN9EL6hDmgkysdzZibEQoK2LVQmTOotIL2HuDKXKhMkOFZn0mMtAGZI0Ygwl6Pp+OInaMo
 Xw5Z2c8EnLVArdYihbPSV+z5EtizpewDCjJAQQitGIOGGRTzJbB1BXcPf71mVAGoe5rKYyFJMS
 +SY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 16:27:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Plpr26m34z1RtVp
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679959634; x=1682551635; bh=8v/j5oydGaOLEzE1iZOLYHGbB0l++zz9C6R
        d3Ol5Oqs=; b=QX3rP6A9ZXTSfRgk0Wh/idvyK1hRW541DFFqqptpOyYAPq51B61
        PFRgVGVY5U9XvMLY0bpMcY+ctYCG8aR6E+YCJa70Nky49Rupw92CEDNFglF8NBhh
        YxpvhkXzaxvGjph83LPYDRDiuyxxZAK/XVhvgVKspCAoKEllgfVYW6rHQBdECely
        FW7PTCxHp2nGgM/sbtNTH3UpxRMPfigypCUJv8jnUnBsXX9bWf9iDxKLiRTlblOh
        yLBZ2eqoVI4S2mZQbTv1fOsjtkUi9C1Ge0ujbFEjITO8YfpI94p3JhQMDzqTjCFM
        LQ5rdX/x9B8LyxYbG231DYioHRurn6RUKmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t5FYC-kfAEhA for <linux-kernel@vger.kernel.org>;
        Mon, 27 Mar 2023 16:27:14 -0700 (PDT)
Received: from [10.225.163.111] (unknown [10.225.163.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Plpr05zyRz1RtVm;
        Mon, 27 Mar 2023 16:27:12 -0700 (PDT)
Message-ID: <30066318-e9ca-0796-f671-23f4a85bb138@opensource.wdc.com>
Date:   Tue, 28 Mar 2023 08:27:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: ata: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230327170053.4100949-1-robh@kernel.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327170053.4100949-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 02:00, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

