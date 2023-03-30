Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DF6D1278
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjC3Wpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjC3Wpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:45:36 -0400
Received: from omta037.useast.a.cloudfilter.net (omta037.useast.a.cloudfilter.net [44.202.169.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B68D4FB3;
        Thu, 30 Mar 2023 15:44:55 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id i0Wdp4vGvElIgi10op7gOG; Thu, 30 Mar 2023 22:44:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id i10npY8KNON9Ti10npuRHN; Thu, 30 Mar 2023 22:44:53 +0000
X-Authority-Analysis: v=2.4 cv=fby+dmcF c=1 sm=1 tr=0 ts=642610e5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10
 a=wYkD_t78qR0A:10 a=p5TAKoIjpDPjIpOboVgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2nUW9+DxCExNvW0W3XSMSOQ4Fi6oDWM9s6D5qR+DaQ8=; b=nmEhtqRxy+yNoNhBRq0XCWI8Q1
        WmeqtLDLr7DFDJ8dsEXlagtuIBeQZL58NARsoNRZsknSDE+RdVgD6f3fIXms45dMytjee2e3tfmLf
        DqbkZ4J3AuctkTv5RGUL8n2/UUf2SpaXysBmMMIgaGjAlhAojNWl7RjHfVmBR5wMNN7IvlbjZPs39
        gBjqYNUpYCOZKdyxdD/bdHDIIbEUC8sSwM1cMrKML+AwuMNFAquNy72HVAcJZP5g5QNPJoMis/8nO
        ++kwKLcr1xFjQtvYIuexGoGenH3g4XsoNDOH6Hv+eZQ0PWVvBt5suI99IS+KPyOZE72d1IwllvXnZ
        86a4QPSw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:60900 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1phz8C-003MTK-9U;
        Thu, 30 Mar 2023 15:44:24 -0500
Message-ID: <6c2e8022-155a-ba6c-a9c7-4a7eb9f6f916@embeddedor.com>
Date:   Thu, 30 Mar 2023 14:44:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZCTrutoN+9TiJM8u@work> <ZCUzw9epJig2rTIY@google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZCUzw9epJig2rTIY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1phz8C-003MTK-9U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:60900
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMfLNSl0QahAoczvFxT1/NDhjZYFGVRBIGw2l3IGrU6ryDNV8QL9eBIr6VMuKSCuM4AnE7ymQO4IU8zm0CMfjkl4EyxmR0q18dUS30497fkZ7wz0lnmh
 caprJCBNv1QLqd19goyP2DFDCacWiqZqctWDrLWtfZ5p32tmKsvXUJjQxxjTly2SxRApmVAYb2hfkrCUoRGX4hxLYIiq3wnv2AJ7ZFn8gSDB46rts8+/qaQm
 Dd6VqHfc1yIXBxf+eIikbznfjMl5XqWofx6E+/uA7jo=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   	/* NB: we only kmalloc()ated enough space for the op field */
>> -	params = (struct ec_params_vbnvcontext *)msg->data;
>> -	params->op = EC_VBNV_CONTEXT_OP_READ;
>> +	params_op = (uint32_t *)msg->data;
>> +	*params_op = EC_VBNV_CONTEXT_OP_READ;
> 
> I don't see a good reason to partially allocate memory here.  Perhaps, just
> let `para_sz = sizeof(struct ec_params_vbnvcontext)`?  If it also makes
> sense to you, please remove the comment "NB: we only..." as well.

It looks funny to me, too. However, I think that's material for a different
patch.

What I want to get fixed here is the -Warray-bounds warning, while not messing
too much with the original implementation. :)

Thanks
--
Gustavo
