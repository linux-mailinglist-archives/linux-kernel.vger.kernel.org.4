Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D181D7502F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGLJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjGLJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:23:30 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958A1FC0;
        Wed, 12 Jul 2023 02:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4N3QyM5zpD+kcd5xd5RIygTR7gJVMM7gptGbFweGorpwAu+ImyoGfBTKVJ7LsXpj8YVj/hp+LdQzb2J4DJIiaFldPmpj7k0BDzUL1/AdOkbvZ8yxBNX+0O+39tCQJyNjtM0XS8pV3wHxFo+Eifcdi6kzm0c7fPRw3hCnfyfhtqbCCL2qeqeqMMTCOhhQZLkz22IGUW9NZu3ITnmJ+nkYKfOuNlUvBbVH1mFz3JZ17RQY19iAFsDaDmynUcCV3VXQVBR3pLgUXZgFQrQmPXqc5ZbXbTklmLzK9L8yucAxfimjKtDOsTNcnvr4oyQFml1LD1dafuAM139Xmyv9OKDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r14JdlGq9wO7DZaId8kEv3tXjWCVTkO5GdaJxzSTIP8=;
 b=XUiCXR+wd9cYbxSfr94+cDT39BC+uvUEimVv6fAIYnUKWWWTD8w+7oVdB0Z/r419QTngysbGuedDb7ECMSLHJLu7p4tIeN3Yln+pN0AgTPbtFm5IKnKQLjJNH0kTeRIefGBwt4tXkU9s25kuwuHYvybB3uwz+k9wqMyfsn3atEGIRmhBbsAkQuaOQZTwmqW7LgelzM+s/2oHws1xcSeKmaaHzz1aM1ELi1ljzyNkggOpfO/3FTh3Bm6YkBOKWiDwyB/4RERehe3Tcu2ztON8Kzi5Kdvp692ow5Fo36+qu8tTpVPJxFizb5e5jDaSumnzZyjNlHMDGWvdAt1PWD6O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r14JdlGq9wO7DZaId8kEv3tXjWCVTkO5GdaJxzSTIP8=;
 b=eUNeHFdTLcQojcaoeshV+Q8/lRKF/hjpfMzpQkNd7FP28Vdvm93GpceykaNupyfeLujlbFW7QtPGXv+L3pvOnFHyMcszQ3DJoqUw/yZV4LYLs1Ai9WAjiW563BBzpwvdmYqSJX7iuFwCkASL9ouEw733jC+ZO636nRjlry3cADepcmzlowTg8oC3cmgOccDBhb2GWs1SNEeBaLgVGKlL/UuvoYFghw5xNN/5wn7Nklla0PLNKQ3zhhKTpsokWTWvhRjFS1X1LHil+fDU5ulgSUdvG93eX15wAJXV/ITZCc5awlFF3DE1o6dUDJQYSJph0fyLx39uhlv1uHHikJXbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:22:21 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::a31f:d35c:5ef8:a31b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::a31f:d35c:5ef8:a31b%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:22:21 +0000
Message-ID: <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
Date:   Wed, 12 Jul 2023 11:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>
Cc:     Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
 <2023070430-fragment-remember-2fdd@gregkh>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2023070430-fragment-remember-2fdd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf5eb5d-29d3-41ff-854f-08db82b97ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v02dXPbeNHRZtjV0E/0bhPTiDoynXFu0r9RYk7AFjsMgxpAtRJFreG6+9bkU7qC+kn/jZ4f2sRcGmbEiEfh2h+T6n6mH85YEp5ZOwsUrUwdul1ooLb6kkXAWyYa4D/r8MyKNhAEH9DvDEVOL8KvwbjXfFzvUvuwpRn7+2xRm6zlAPYP2WftJAT7pjEfC5F4azUhnWMRZcKdNgZS4unpL3pksGVt3egbdOD39WeggKYg4kXcigqsNxe6Opfvt7rvplo8kaoORWcBmZnEQ3iMLJyrK5dLwStLSq9J0R22eYJQE08x6lwk2V0oniBTyMQ477LPWGBHwe10Ds92R9+qiDOAKCxyW+KUmUlD44cAw9DG+yvkVCYaMQi+u+y3NPXdIYRC6POBmNxBh5g2xskdx6zO0ha71/PZbjPtQi8efZ0t5Ft4Mk1B3mbfwCaQ22DXqpmrpqA5pXmbAQc4sYW0OqyZXjDBMwkFeh/leENAE/wR4eeXNYd5bRZQmIYHhFtauOs7YJcUbLhIhnXQ++nWc6G+MKPyocgXT1mrck93epfCGPAGPknSHeljvmiqtKEjRqRHERlsGm8UxjI2gSfvqH5vpGcgS6EsZQd9CI0EbQxiW2akDaMJsqSpcb6z1LjetiQCY2yzgxmC/yhN/4SVBIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(6512007)(316002)(6666004)(6486002)(54906003)(4744005)(4326008)(478600001)(110136005)(38100700002)(36756003)(2906002)(66556008)(66476007)(66946007)(83380400001)(2616005)(5660300002)(8676002)(8936002)(31686004)(186003)(7416002)(41300700001)(86362001)(31696002)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Rtei91ZnBBai9uRENkU1NWU09oSFZqS0dmMkMvSWdvMElibTVQNjhRL1RB?=
 =?utf-8?B?ZU5LbFBaWHlpRmNiWEkxZy9HVWw5dlR5RUhFOXFJcGVQdFlUeDRrRHc4ZVBX?=
 =?utf-8?B?bnN6MEdaWUdpUlh6YU55Zzh6Q3Z3TzFKUlEvVUpLc1V4dTNhTTU1OE1MdnAr?=
 =?utf-8?B?aTRySUlGMFRid1R5Mmh5elpPWkRBQStudXVHSkZXOHVpOUdnQWo1S05jV2VS?=
 =?utf-8?B?NkY3WUpsSWV1R01hcThGeTRVR1c2TUFxY04zcC9SRjVLclVXT2p5VjR4TG9G?=
 =?utf-8?B?TDRmS1BPakpHb09GZlg5K3RRR2lQTXoxNERTVCs3UGlqVlEzbmtzNlExQ3ln?=
 =?utf-8?B?cjIwaFVPS0g4WGtPK0dPVnNGOHVFaU9uczhpaFV5Q2U1b1ZhbWpKa3pzQWdq?=
 =?utf-8?B?bDNPbk53RVB3UlpMT21TYmh3Uk1TL1ErdW54cThvc1ptdEZ6N2thbkpIcGNR?=
 =?utf-8?B?T1dNUzlNNExtV1g5NmVXTmVFclpWZk1yV24vaENoZ245SXJXR0xnVG5RNzBK?=
 =?utf-8?B?UFBRYVVBMm1kSFB3RFVpMXB6N3djR25xcW8xb1hxWTdIOTF1SnEramhZejVy?=
 =?utf-8?B?bjBDNWhWTnk3T2kyZGZqcENBRllDZU85RWVGMGF2bUl3aDRLM0hHcEtidjhO?=
 =?utf-8?B?QWV4aXk5Zk9IVzVpYmh5S3F6bXE3bW1POE1vQUROZ2VDejRadlIvV0xHZ2lL?=
 =?utf-8?B?eldhQTlaR3VzV3pmMDNMNlVqMlJEVXZNa2dYcTVYbnhMZjhVbi9NaFhtbWpP?=
 =?utf-8?B?L1F0dHhxUkRiVzdQVE9kN2JneHRjN2pNTjJOa25nMzk1YVRacUtzRWRmUHVO?=
 =?utf-8?B?ZDlxRHJ4eU1WMlBxRlY0cnFQNERxOTJFZXBhM2ZtRVNIcEdjV3Nucm15cmlr?=
 =?utf-8?B?L3piRER2K0xUanpkQW1IaEpmVk9nTkVpeEdmZmpra0MwQ0RWRzNkcXA1VVVR?=
 =?utf-8?B?UFdzZllqMDUvcHhueDFuQnVmK0V6SnpIWEdhTU45elczdHk0VEhCWVpCZm44?=
 =?utf-8?B?U3NvMi9uNDRCd0FmelBLQjNSVnFpOTVCdk9xN25tdzRPdGpobTgzSitKNFA5?=
 =?utf-8?B?UFQ4RHNXdGQ3YkVNalE5NERWbVlUV3JlT2puNEdyUDU0NjRBUnNQQ1o4Vk1a?=
 =?utf-8?B?SFlMWVVLOXVlS0d4QUZBSWZmVk9GNzBQcGZSMDR1Sy9YQXJpTEpIMmdYQXRp?=
 =?utf-8?B?VTlvYnlNYi8zNExLMktJVFBWNVZ4SEhmZ1dmdklPNHFNSTFFWFRnZW1Pd3Fu?=
 =?utf-8?B?L0VyMnpEUGFjRDY1V0R2L01WdlZEWHRMeTdoOGh4SXdBY2tsa1pzcEtoVWFU?=
 =?utf-8?B?aVBUYVFkYkR5QytPdm1Qb0pwWFFCeXpxdE53Y2hLZU1LYysySU5VUXdJK3M5?=
 =?utf-8?B?VTByZDdKODJWaEZpd3E5b2NJRFh6MDlGaE8yMldCSkZQVzhhcXE1bUJGWHFX?=
 =?utf-8?B?ZFNuRlh5MVNIY2NVMHBjaWtjMkUyazdTbzJESDRwZ1FEVHptMkpUclZNS0Vo?=
 =?utf-8?B?L1A1TXFuQTVRRkZDQ2VqbDlOS09BOGVaMFpPbzVnNTNxU3dTS2djS1p2ZmUy?=
 =?utf-8?B?U3dUWGcyTkFjUC9KVWZEcXFnd1pTbVpneEcrOHBiVnd4eVRpaHV4a2lBdlQ1?=
 =?utf-8?B?L2VVanpEQXhXc29nWm1ubE04V01pRHBWQlYzMzg0RXU5MWtUaHIrZjVDSmdW?=
 =?utf-8?B?UTJUY1lOYnIzeVRFMFNESnlYVExvK2h6Rm5CRkwxUjh4OGM1ZC9UUHFENkJX?=
 =?utf-8?B?VndJeHAwTFJ1NlFPQkhUU1Rla1NTUDF2amFjeFRaOVF6aGdJb2ZlbHBFeUd0?=
 =?utf-8?B?M1VsdXMyMWEwMzh6TmE4alY1RmF2QWFSZSttblZ1OUtRVTFtbXlkRVZGUUI5?=
 =?utf-8?B?QThXUDhyNGYxcko1Zm1tLy9DNzY1ZDI1djJxa0R0WVBFSjhMQTRISUw3S0k1?=
 =?utf-8?B?enZ5QnVmd2p0bnluNE5sS0dkbGdQQ2NrOGZWSWFLblM4b04zZUV0UUJJczdM?=
 =?utf-8?B?Tjd3UG5JL1ljTGY0UFp1dlJZMVlPVkF5emViRGsrckc0VEJVbVgya2RFa2N2?=
 =?utf-8?B?ZmdyYVhwdzVhY3hRYnQ4T01qSEJCWHhLcFRwRUFhanNHeU55dHhaYmgzdzV0?=
 =?utf-8?B?RDhocnd3TGNUc2RESTY3aklaT1dSUkRGNkFMcWMrVlhrMFBXUE5TUlp0RVpT?=
 =?utf-8?Q?rMt/yYKjuMZmrvr3aDfTwAg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf5eb5d-29d3-41ff-854f-08db82b97ea1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:22:21.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MEwJvTtjwpcZmPiGRNGdM3yn0ER5nTboVJuEOTOX+4lWGC4uEa2sIEIA0lRpRbIZbrblzkvzIj7JZNbXv4xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.07.23 08:47, Greg Kroah-Hartman wrote:
> On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
>> Hi all!!
>>
>> I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
>> The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
>>
>> We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.
> 
> Again, you have to fully trust the other side of an RNDIS connection,
> any hints on how to have the kernel determine that?

Greg,

it is a network protocol. So this statement is kind of odd.
Are you saying that there are RNDIS messages that cannot be verified
for some reason, that still cannot be disclosed?

	Regards
		Oliver
