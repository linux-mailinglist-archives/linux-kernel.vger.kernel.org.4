Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15876C5A83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCVXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCVXgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:36:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E523A49
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528168; x=1711064168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AwL0lpa0BGrmVgQeZv6ZCbP7r3t5dc6HGVJ71kVO95k=;
  b=g2zRTHpxtmCBZnF8Un6FQt1MqIi39J6OtUatf4zX0cO/SxOCBGvEG4uZ
   rPlcN0TihBqcX9NpHpFoN7LSgtHy6Mw4ujUkHUEbiFSBWPNl/Utd0m/U6
   6ZNLU+Q2/8unv0mlzuPv+NhE0I47rXabb9zUNXLGFdrObxO6OC/+R0A94
   s+JGH4r1z2tRN2rqdefIX33xAaxQoOdUOnRVyngJstjRPyNAv6/XJCx8S
   EYDilMSJkFNP0zXG0KBO6tvBnQ/TtQgwkVVkjwh6je4hqhH0eoDA8T65S
   btSMUGiO0XSyMqgkE3rrst9UuGlAiHcjeQrY5enU4iZb1lkeZdpd1ipWi
   w==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224559475"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:35:59 +0800
IronPort-SDR: HvSwxatP6fLdJQoz9/J7tggoh9QKtcMW/Va76gZfbselMBthn8yRVcmqwd7WjLEMJ+AsJQTrTA
 Y4AvEdN8TI5uAuCD1yYE7dBbUnmYyqP2JY0iVXHall5ILqKfkAroDZN0en+ufxL2xGK5WbJ90g
 xItyAmrpO7llT9QZmSMPEsCUa/JebZlLZ+RlLPyTnEX1p3wiHKV6weCEwtWAGYc3ehleVIN7xp
 ZPX1O8/HpVuGsJvpxBUfetVCyL5ml7Rs+7ZvF9Ha8mRpqBr4TZbA1y2oNgHYouCpDZz3FCiyr2
 VOg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:52:16 -0700
IronPort-SDR: IoGc56m7xfhs2PvAf1P24z+UtdjbozRFzYqe+ym4/yyMzcz8s6H0WXYx5AlLPLJ7MSkEYcqXC0
 Ea5bEia4HYu64uzNLdv4kPYPn6J3CgVhMICGflXrd5c1GF8FhITOaTmxXNC8fOhzP5SHkfCnrM
 HDE3OKxfUG/7QLD42dqVWRXt9JQz2Bqo0938/u+AvUF3eNM7Vom8J3IcPbXG6XmDND3zRzYGad
 6j1kbLAWmylkQ8NclFr+3YJH6vzbZPutm2n7ElSl7FZBLXXK8E8xSYRTGyyt6FOD6dcVljSHdZ
 Aes=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:36:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlGR3fXLz1RtVq
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:35:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528159; x=1682120160; bh=AwL0lpa0BGrmVgQeZv6ZCbP7r3t5dc6HGVJ
        71kVO95k=; b=Lr67VrgbhC3s4IgaiuiL0vs8D/Ua4kh5dhomRxE+jz5XkgQxabc
        WENMxVoUqNTX0w5G5TnD5ksMVtSvckj6Xp2NL5E0XVFJG2SOBtgYIwHbOFX4K+vQ
        +NoOq6kwFqV0/4S7uKo6hs/sFauEla4COXtc0fSND2ZiM8mhMykGj/l5cBcqqRj+
        Q/CEYai6sh8Jw2JMTtDQ1+OSMXDahFrlybdMVOH7jZNj8ECG2T1jHpoBMIeW55Dg
        ++dhr630HKnph5txVv+d84WopPGJdXB93mQWoLh+SkKyW8EVXa7U8QfWBdPI8Yyt
        ozti80ANiztAyiZ+otUmXm0VIb5s7AC3Zlg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JWm98AX0YEUJ for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:35:59 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlGQ1Zpyz1RtVm;
        Wed, 22 Mar 2023 16:35:58 -0700 (PDT)
Message-ID: <26051414-f4b2-a212-8cc2-f9559c51bbfe@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:35:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/10] xfs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-6-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-6-frank.li@vivo.com>
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

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

