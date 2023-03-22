Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19466C5A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCVXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjCVXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:32:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DBB1ACF8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679527956; x=1711063956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/sMDVlPS5fB9EHCZTtEBdVrU91EFHxBPiTjA7AnR9GU=;
  b=ONv8PcJru8fWM767KXVBC0JdwOJ8jpYL5Baq9Z4qT/yxmsSKRZEWgsYf
   KMq//XCg7gMa6efPbT5vMtKo6AGiyyiki6o8XOWnH6pB5GBgoz1ldiN44
   YOI+zGdNMfyS3hoFfdSPEOkYra3klK+84IJVoLvTFT4LQi2YbkCQDGs9p
   Kr60Ydxd0bcxdFTItwC5knck9603zMV34tZYUG5iOh+Du9he6Mk8/2dHF
   yfPEuyKmXtGAI0zDrbQqE4WtDniT2fAOQXZOWa8KaMbFzRjWVNihEvAQG
   eULUbiYR6ASk5jLPOvdo+1uh62BYMe5ggdmx/4xTR/mDWO9oA7jKGTRk8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330695454"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:32:35 +0800
IronPort-SDR: XJnKbO7NQ9ypa3GYQEmU0qfqD1kYBryOrRJ1qhbT35EygWahWDRNOWW2h451+pq05Mc0ShJuH9
 YNNG8A2rBBYxb4rBBU7zY6tDMVbQAjgAjcYFApLnC7g27RfI7v+PaTLPMQRoqMbA04BdrNG70f
 0pH1LzmSAL69sl37KWTTCaSAmqvGQ/7XfUDKgHVybSwI19Tx+SeGDmRo9nljDQnEuNBWiTLhPN
 8885bsEQn4fwbEqpWOypVDbDeY7e/6rnXMxM8piAvwnmmtpTeNkzPiSnt/dVyi/5UNu0eh8ctS
 92Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:43:11 -0700
IronPort-SDR: y/+VFnoOMvyL7wMfPlAa8c2BeFHB85mZIp/t3W2Sx66rWdNnVaIt/s65AcJK1/7+4JT9olMNmm
 OtzmI14Qw/feST2e15OrB7ksUfnmmFXwGRt0D4+HisMTms7esFGeMF7Qeh9akezQMndDGl/HLO
 QuTn9Lr5KAIyLsGhqyu3ZVJY3U4Px2eaehPRKxktlMB/jjqdFR7suIUrDioBgl1hAzAZt85tVp
 CLDaMp3u+Hv9+jgDvgv7kI9OUgAAToM5Z0QE0Ft+38zC1zpzRMtv+4XB5tnI1LBs1jKOgoYUKY
 +U4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:32:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlBW2zlrz1RtVw
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:32:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679527954; x=1682119955; bh=/sMDVlPS5fB9EHCZTtEBdVrU91EFHxBPiTj
        A7AnR9GU=; b=TewiAhSCtGFAJ3EYSH4tyoW5+Oz7koC8deXt17QnsbIjHzyj1qC
        YgEAxG1mLuExMfsBi96LtQiatsHUV0CRbAXL6go2mmefK60b4yRXpnfzfya5iDkS
        j7xiQ9YPk7Up9Gc+kZ92EZD59Bw06eQk/TO2Ym+nEKrGyinTS7LLP/ckJnCgzYIp
        ei04vzysF0pSmjcOkq3wo8kDo3gObq0lNakakeQO4U+lVkPO1EBT4htzWD9J0dPm
        26ZKHUdh6RRqCXz0ArcupAwk+gRRMWvjy03mo+sZxoDYgdi1eXV7bY1yOYQlKCk8
        PnDDVNLH7hqxBzptFObe50bnxk+AhxVurxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DthvnNJdqEQK for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:32:34 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlBT6XDgz1RtVm;
        Wed, 22 Mar 2023 16:32:33 -0700 (PDT)
Message-ID: <52151084-ceda-c8f9-2151-00ac5f50c651@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:32:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 02/10] f2fs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 01:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

