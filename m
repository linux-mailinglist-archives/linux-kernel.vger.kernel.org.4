Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB296B01F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCHIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCHIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:48:43 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3A93E02
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678265322; x=1709801322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nKMxQoiaejKfmdpJhbMJCkmPnEhIS9AxPbvCXG85D28=;
  b=dnTdD0X6FQjigMzUYaw67Xzrqeo5mzc0Jxr6JMzFASF+34GKyRA/LiGV
   44DC5/csEucLG2D0IDw2qfYXUXJTzxXnslyP3L6remkzznec8Pwe0uifw
   MVPb4549HCKEa4Ykd7n/Nt+5p6AXZ1KCgbjmtqGQoHHv58/moONXImRci
   zKb5IxKG/PQtenHR1Z/m5oqJZPGP4mEkzqLyPtcGhYC/axVqkh7yXMh2n
   n/gVBknawS3YPga/z/FToNBiSlVjE2poO25kjVzegmwGtzy3RbdZi/H+x
   sp4DNyWnwFK2554gBk2DTct6AbR9iPxkxqdsgh06keKGFclgYgTxKAPEC
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="225101356"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 16:48:39 +0800
IronPort-SDR: jJk+bAAV/ktFO6gAJb3RPdj4ZguYkYB9Hou4t1vlaHkR9OVqf2snr6Z4aKO4pmq7Sg0TswHWly
 VtW4caszTP8sKpIWzTxvtFJ3BPUNYPnxgoWPCAq1SBkKVZw3LF10YnF0hygPzowrOCbxX3cG0l
 hQPNMKaN/f96DSVM1NxOYutoxAqnjqVhzTE+ZEKNrVAUDAxvMMWmhwycTf4xaPWRb3lAVxbvrE
 jJQiDdI+QPdxuQ8wLGCqY0quPRPptzl8Lh3Z0dyPuz+yrjgrKZtsN9qHHq0qEsp6j9JZq1hUxB
 o5E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 23:59:36 -0800
IronPort-SDR: xhCEcmWKRv4Qglc7HOVpjPBDWJqzgqRt1GY+qIPzLaOIvn2+ltODMinf3lBp/4Y9Npae+mMAO0
 NhuIiK16i745F8pAMkc5U9DuLJg6B+56vBzJ03/+uPJG9SorKLRA/xNGJR3CmtxOsf6aa98Yj5
 vhvqcRmDvwBLtnCr1jF3SVpequNWINv/wGC7dJ14Gsdg2GDa5S+LAFoaokcULThxACDiTetuVK
 /7f6ov/RwFEqDK69wNjlaQ3ZbYAbxgv61q6yAT7R7aUzEqtrTFa3QWSIGIE2cnhywkojQlFJkB
 AOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:48:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmF32smFz1Rwtl
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:48:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678265318; x=1680857319; bh=nKMxQoiaejKfmdpJhbMJCkmPnEhIS9AxPbv
        CXG85D28=; b=BmgjmQi1AEDeztx+T3AeCww/VpJukjqB5Nx9MioJPqMkTFv9jfD
        wwF+oQPUI0hn5EjIK6bHCEaZm7l68tMvHvu2CUlJs+/AulrL/gsmNk9NQihiwKQE
        viDJZQVugkGh9I/VeGd6xP2Z6BTEYs6C2+CiFAZTcBks9HOeflzKMZtz2XCwNPzA
        ezLi5DGA1nidVeI8rgRz7btQ4mgtS+NsnBajlkcRpTSAUOCci4txm9PpmSgYAjE5
        fdkkSfnkuMUHu23n5U5c2oN05E2QP4gctBPjMpe99KXy7uIQcW99FBIajURXu51/
        j6ybSueyMv6d7htQ6GXwO9hw08kw6OVqStA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eLrHQVYswNir for <linux-kernel@vger.kernel.org>;
        Wed,  8 Mar 2023 00:48:38 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmF140Qhz1RvLy;
        Wed,  8 Mar 2023 00:48:37 -0800 (PST)
Message-ID: <b121dbf4-abc4-07ce-f0b1-52050fce3818@opensource.wdc.com>
Date:   Wed, 8 Mar 2023 17:48:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
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

On 2/23/23 00:59, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs three reset controls for Pro4 SoC, or two reset
> controls for PXs2 and PXs3 SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to for-6.4. Thanks !

-- 
Damien Le Moal
Western Digital Research

