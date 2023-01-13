Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281C66A628
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAMWo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjAMWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:44:50 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B788576AE9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673649883; x=1705185883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBHvLdmdEqZp7wzKBhxjpIb9vAX0WonjjojON8von1o=;
  b=F/JLVVWRAJQZw88OwKtsyF1+8F3y0ZjRAvf3wzbwJmbs8uyOKt5rePTa
   +wkctw2Tw8rr1CeaczlkEQabrhpGOwRI+IsuO8Hi3ZWd7UHYZFdd2Dc8Z
   Xn0oxY76qcltUGCVzeaBir9NDce2tz3MLn61YDv9/kF4KX1dKYy00lHrc
   TsIQhRuLBU71qMBmVOcmlprYUetSw3RmnnIX8k/MIsz7ujSYzMiXAV223
   JUfH/IYf+Db+1BvIwkanBLELSseh4XwBm+4jz+lCYnjFMaNDFOjC2TdDY
   K1pPTp4uUaBUVxBhbIh/Et4km/0/bm1bUunvdvPpbrWOqCMR617TQ1b9X
   A==;
X-IronPort-AV: E=Sophos;i="5.97,215,1669046400"; 
   d="scan'208";a="332771926"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2023 06:44:43 +0800
IronPort-SDR: f6fvtnyMXra4RvuVXH66RfkhoQyljJ0yR4h+1zHC7IbjFojVhnvqdkORBIDYBPVJw+SQw5bcQE
 Q+Crcc91k68gZkmPbBELrhpUz49JYfdMPNngPE1E09IpTpfRviMpvoJDfC3UH+BsBOqa6K0oHK
 gvoZnpIOEVOLPa4S8A75ykvA86ZMmYkM1Cq0bfjdKK8sGOTAqPQXXJj56UTPFgoX7+T07vScXa
 BBycqHlgt1u8Nb2/K5x3TL5LqgL130HSnHUyRmZmhsWkfQ/IOCXgonPqhecKYM8As1pZoGCUny
 9dU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 14:02:28 -0800
IronPort-SDR: ESOaaBL0BVbemqbunwNMaDEFBIXiitnLeP5A82bPNj1IquSgVeoBSlYeHHrmopWPtkZW0bGF3N
 85JUbWkibgUN+lpcmi/mci67ZvmBEAYkFcTEMAujTubsP2SEpLtH3y0Lfax8fdETCLoceagE+Z
 wHgZ6BELtgfyQoOpQePS7MsxPllhaXtZ05GjI/Y/PKqrxg4s9R5limsp+xopQmQ4k5VkuWxid2
 4t0Wn9VX/umHXnlR/YFRrT+UGbskhAmg8VPABvWmNxYMCKzP/Q9N/KFxGdZHCP/DQZlh4PAmxy
 8zw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 14:44:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NtxLf5pHKz1RvTr
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:44:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673649882; x=1676241883; bh=eBHvLdmdEqZp7wzKBhxjpIb9vAX0Wonjjoj
        ON8von1o=; b=G5+1uxPSZXiJqDV6/5jXuM/M+u4VUC5IAL9ilNbq5Ubiyz2+Hnk
        GPFMlYXvDR4teG5oZvNuYLrCkyAisBAZof9niKpKIpGOkyScLxlRzuMYvU7xMC1r
        fCqonayPbhrBJUZI6/kSHrB59Toq6ZtbEpDG8ZK/F98J+dj51D48KfQAWIW38Rib
        AypzEjLhgu9JvXbeOUFVeDVzrui/emjjs7SaRvnDhgta3BTK1j/P5yVg9MsMIX1R
        9VuEUqoKeF3Tvq28LMZUDU/9KveqJYQuDPZp+ZT+PUn94epRrMp78B+KLW1tukY3
        XiKNA1vKFg8yp5RFE9FtCvuAoa7XftG2png==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id slmrM55hM_DF for <linux-kernel@vger.kernel.org>;
        Fri, 13 Jan 2023 14:44:42 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NtxLd6sGBz1RvLy;
        Fri, 13 Jan 2023 14:44:41 -0800 (PST)
Message-ID: <c2ad2551-e179-f0fc-28dc-8e3871b4d06b@opensource.wdc.com>
Date:   Sat, 14 Jan 2023 07:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ata: Don't build PATA_CS5535 on UML
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 13:37, Peter Foley wrote:
> This driver uses MSR functions that aren't implemented under UML.
> Avoid building it to prevent tripping up allyesconfig.
> 
> e.g.
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3a3): undefined reference to `__tracepoint_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3d2): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x457): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x481): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4d5): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4f5): undefined reference to `do_trace_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x51c): undefined reference to `do_trace_write_msr'
> 
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Applied to for-6.2-fixes with a slightly tweaked commit title.
Thanks !

-- 
Damien Le Moal
Western Digital Research

