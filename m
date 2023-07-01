Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB9744744
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGAGuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGAGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:50:12 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B586E9D;
        Fri, 30 Jun 2023 23:44:33 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8F859120003;
        Sat,  1 Jul 2023 09:43:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8F859120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688193810;
        bh=+OUp4k88AeHBBpJ5b85k5wYaLWTZ3dDvOxuEI2GfMXs=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
        b=WB17pxcvd/iMFt1KjJhhjFkJkoG918OPBeKWzshDU4kWy8xm/sqlAE5dUbGS3JrOk
         PzEyrtj7GUgUGz/QRGcLlGKfouICmVft/aCFQL0DaGzRk8N8YKmlHEPEb1lFiob+sT
         /eMjpFVKmnwJlpJ0ZGlDdU93J0vzU0dk1GBEQxeIC0+GvXKx7Ki3NVfChpqgnZO8W0
         ciMErpzmbro+mBmkbref3JmoUQ1oDvWU2c9y4MJp+3homfmS7EsoGhIhgA0UPQ95oP
         O3nRXx+n2URG7vBYrPJy6kjr+6hiKjZ142Mm+Pxl53swhESiuSCT1Tz/dX0Mi/VZQU
         fDT/JHs6eT5DQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat,  1 Jul 2023 09:43:29 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 1 Jul 2023 09:43:10 +0300
Message-ID: <903c255f-8487-a1fc-a9bb-7632ff296916@sberdevices.ru>
Date:   Sat, 1 Jul 2023 09:38:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5] vsock: enable setting SO_ZEROCOPY
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20230701062310.3397129-1-AVKrasnov@sberdevices.ru>
 <20230701062310.3397129-14-AVKrasnov@sberdevices.ru>
 <1eef6bc9-91fc-b620-84f0-2979a197c4b7@sberdevices.ru>
In-Reply-To: <1eef6bc9-91fc-b620-84f0-2979a197c4b7@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178380 [Jun 30 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/01 04:02:00 #21597763
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll do resend to make 'b4 am' work correctly

Thanks, Arseniy

On 01.07.2023 09:26, Arseniy Krasnov wrote:
> Oops, my mistake, this patch is 13/17
> 
> Sorry
> 
> Thanks, Arseniy
> 
> On 01.07.2023 09:23, Arseniy Krasnov wrote:
>> For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>> be set in AF_VSOCK implementation where transport is accessible (if
>> transport is not set during setting SO_ZEROCOPY: for example socket is
>> not connected, then SO_ZEROCOPY will be enabled, but once transport will
>> be assigned, support of this type of transmission will be checked).
>>
>> To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>> bit, thus handling SOL_SOCKET option operations, but all of them except
>> SO_ZEROCOPY will be forwarded to the generic handler by calling
>> 'sock_setsockopt()'.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  Changelog:
>>  v4 -> v5:
>>   * This patch is totally reworked. Previous version added check for
>>     PF_VSOCK directly to 'net/core/sock.c', thus allowing to set
>>     SO_ZEROCOPY for AF_VSOCK type of socket. This new version catches
>>     attempt to set SO_ZEROCOPY in 'af_vsock.c'. All other options
>>     except SO_ZEROCOPY are forwarded to generic handler. Only this
>>     option is processed in 'af_vsock.c'. Handling this option includes
>>     access to transport to check that MSG_ZEROCOPY transmission is
>>     supported by the current transport (if it is set, if not - transport
>>     will be checked during 'connect()').
>>
>>  net/vmw_vsock/af_vsock.c | 44 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index da22ae0ef477..8acc77981d01 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1406,8 +1406,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>  			goto out;
>>  		}
>>  
>> -		if (vsock_msgzerocopy_allow(transport))
>> +		if (!vsock_msgzerocopy_allow(transport)) {
>> +			/* If this option was set before 'connect()',
>> +			 * when transport was unknown, check that this
>> +			 * feature is supported here.
>> +			 */
>> +			if (sock_flag(sk, SOCK_ZEROCOPY)) {
>> +				err = -EOPNOTSUPP;
>> +				goto out;
>> +			}
>> +		} else {
>>  			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>> +		}
>>  
>>  		err = vsock_auto_bind(vsk);
>>  		if (err)
>> @@ -1643,7 +1653,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>>  	const struct vsock_transport *transport;
>>  	u64 val;
>>  
>> -	if (level != AF_VSOCK)
>> +	if (level != AF_VSOCK && level != SOL_SOCKET)
>>  		return -ENOPROTOOPT;
>>  
>>  #define COPY_IN(_v)                                       \
>> @@ -1666,6 +1676,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>>  
>>  	transport = vsk->transport;
>>  
>> +	if (level == SOL_SOCKET) {
>> +		if (optname == SO_ZEROCOPY) {
>> +			int zc_val;
>> +
>> +			/* Use 'int' type here, because variable to
>> +			 * set this option usually has this type.
>> +			 */
>> +			COPY_IN(zc_val);
>> +
>> +			if (zc_val < 0 || zc_val > 1) {
>> +				err = -EINVAL;
>> +				goto exit;
>> +			}
>> +
>> +			if (transport && !vsock_msgzerocopy_allow(transport)) {
>> +				err = -EOPNOTSUPP;
>> +				goto exit;
>> +			}
>> +
>> +			sock_valbool_flag(sk, SOCK_ZEROCOPY,
>> +					  zc_val ? true : false);
>> +			goto exit;
>> +		}
>> +
>> +		release_sock(sk);
>> +		return sock_setsockopt(sock, level, optname, optval, optlen);
>> +	}
>> +
>>  	switch (optname) {
>>  	case SO_VM_SOCKETS_BUFFER_SIZE:
>>  		COPY_IN(val);
>> @@ -2321,6 +2359,8 @@ static int vsock_create(struct net *net, struct socket *sock,
>>  		}
>>  	}
>>  
>> +	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>> +
>>  	vsock_insert_unbound(vsk);
>>  
>>  	return 0;
