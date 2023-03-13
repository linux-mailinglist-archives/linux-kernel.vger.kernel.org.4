Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146CF6B75F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCML10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCML1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:27:23 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6855A928;
        Mon, 13 Mar 2023 04:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izZ4BZlwJdoF2CqLopDhSF+wVX7PnIxCw4LaJZtfNSoMhSZLzQYinWG5Gt7NIVXjG8JHpirYjE37OYfdaW/CYtHolT8fanIFeN/y1Exy12w+3OCXhxiaEm3WDYRA97Fjs8Ha5S8MJOPfmetKYoUozrN2J9DQ7HZPJZZmcz6VrEj5WEI88qUSUMy+abf7c1WxzXJnQdinLdaqAcXODQegsYGYMNBTBCUBJpQ+gOyhmziwbzYz15gQFFVFm23a3ABb+GDRPTA13/qRtsaxF+RBDNf+s3WdU6FmNhKzbiSF+RkZ0+3nNJP0jkn4t8apRgU38iLi/yJs+y31yqPcD27Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T0kwTzsZPxfUjbixtY99+gV75uvpsnvzU7wev6w7X0=;
 b=Agc6shVCbxXJ+qSqiUV0vqHj/h9MfPgyvqtgkXW7WSwwQNzd61ZsMKXpWXMnwHXcXyy0JxKEOcFKqSaSlmaVsPFKQP0JVQ8z2qbf50M5nbV6mr11ZT4y0waxclLu40pKAwvzftsGNU4aku0/wze7uifnRHqjwFUUA5lRlxuzi54Zh/FKu1WYIvlWr10rjxOQoblZ8E4wuVVPaoWfoMqzgOw9lXr1X2fbbBQ1yYzuoTTpH9IPF4IM/Nqk2QLc2Pp9nLPBl8RfSfpq+PU3kb5zcGMCn/ExwU3yFQTpNuGPXJlYAu8Y31a1Ypn1Mu3jKDnEcPDJI5rQZNSLqApBW05hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T0kwTzsZPxfUjbixtY99+gV75uvpsnvzU7wev6w7X0=;
 b=KyRpaje2C5RaxBVbL86bdz7oxQ5I/Gp8YDCchPz8dpaNm9NPv35edSbPvmkxoZ9xqwGpD7UuCeVnv9WWRRX5e07vdM+sZBjAQZztRB2E5DQELjfO8JMzUFXaMg6JZxABEx6C8bJ6dpjOSZutF+1CwZGZaGen6N4YX/460bePi6X+SsWOqtBxysRTACOqFx0/ANg0mH3gECHooJdvM1UmEVhMVNtEMp90XZmk/2sZxZDZAyRxYbBhE/fIXc3ME5qnljKhaIR8lFUtiem7gZzgMVKaPBFcNokm1qw8zwAWxqkbjEb3wYBugcwiacxD+wvIfshBDFA5tYBrNpDIglMP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:27:18 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%4]) with
 mapi id 15.20.6178.024; Mon, 13 Mar 2023 11:27:17 +0000
Message-ID: <79c3cf69-8acd-e6de-c168-329954a14841@suse.com>
Date:   Mon, 13 Mar 2023 12:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Jarkko Sonninen <kasper@iki.fi>, Oliver Neukum <oneukum@suse.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
 <20230313082734.886890-1-kasper@iki.fi>
 <e426ae4c-4e49-5773-e8da-919fa2e3dc33@suse.com>
 <3c53eca1-ce62-e98d-ee52-269a09480658@iki.fi>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <3c53eca1-ce62-e98d-ee52-269a09480658@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fced05-bc14-4282-c2e3-08db23b5e6ee
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7zpF1dUKnbpPDrGgs3wUakJCl92M0tYR9dS8MNfjgsudH/Mi1dOtdjZuHZQ1qdt8VogGMgu79mC91J5iB4EeDWnZH/LO1Xak1P9uSjz3WuUma8YY3brIVSink84GAjoTqXgv5WnYbFEYpTkK0P5JH/04HUmr+e70ZP0oIpJzDr/bLtYLjq1AiqllrDSuUFN7+xNcWKyM3vgXf3H0wxBHp2emsI4mOlR3XW6rTBh2/v+D8Gh7z90TyGv0Anvnhwfhu8vDLf2k1slhveOM5dkgbaXvPPeZdxBzE2vWK9XO6Mrr3kJh7X/mhymUH2FUpGhV7gFS19uOc/3AdunlKhz3/cKbSP63+ULnJur3R2XohpfenVRSXJxT1LqljC5bfB33PuU2z9okoDYSAFxo+SzKOnmJyw5woWNC9a3Se2T8WUmbJwxSMk73a54+FFX62ybrRg1XxS19ob7lubmpKSmSOKcpUHYAoxT3rbjdEG4h1bnALbxXhvNgh8ELqiUQKgOUETgh5CcIchl5PE+UEuoWoBEeDjx7e8hh8qZQI8ZULBwbEPoy/mQBkIkadvJDS5xwbPQeVZGq4QuVSmfIEbz/PMwTwT6FomEfkDakzwUt4Z449NdOnzL/AssOAKcNnNFCVe4qNqo8fEYMi8Y56bxwZ4KiTEQWRLwbJgRN5qcwwfp9xc6mY2YgPP6uuQCOdcbH/uskKPijOIpB8/VS5bjb5AZDcLFjpjpj15cXZ0r6/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(31686004)(86362001)(41300700001)(5660300002)(8936002)(66556008)(4326008)(66476007)(66946007)(2906002)(4744005)(38100700002)(36756003)(31696002)(8676002)(6486002)(6512007)(54906003)(478600001)(316002)(6506007)(110136005)(83380400001)(2616005)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJDRGZZaVUzSm90b09qcStBOFA5YWNlRFlzNG9ZaytjUXF0WFRRRlF4NU1J?=
 =?utf-8?B?RE9ZVERDQUl1N3lSc3pUWEQzUnNsb3BUZXRjWExLMEZwdExSeXQ4VmpXT1Av?=
 =?utf-8?B?dStwQWNKM0FkS2E3TDhia1FmU3M2NDZBM21QYUQ2V1cxM1ZQdm45VzdYRTRN?=
 =?utf-8?B?K3I1MmtENUJ0QlR6N2pkS0U2NGllKytxV0FYNkc5ZnVnSUV6VExGQjN2THM4?=
 =?utf-8?B?Y3poSkpmTlBhQWhoK1E0QVlVdERudFFvbC82My8wQ2xVdFVZSVllRVZkSzZV?=
 =?utf-8?B?aXpQaVh5Vmk3ZDBFSnB0dWNWYisySXFKYzdZenRtQlRTcmJ5UHo5WmFOaFF0?=
 =?utf-8?B?aHhOL0kzcXNWTUhHZ0JGendjeWFZNlNteVlpbWhFTkQ3NFZaa1hybVNvY0lO?=
 =?utf-8?B?S0Z0N2o3N25kVldxN2N3NlljcGZpZ2JxUzBjdDExazJIMjF1c1RTTmlVRHR2?=
 =?utf-8?B?YXpXL2d2U291R0FoWEFJS1B0ZW16TlcrTWRSMkh2ZmFpdG9YN0tlcmJITWla?=
 =?utf-8?B?aWlCaFExVlZ2a0t0VHl1aUNiNnVFVTlDb083MlAvWVhNZ2Joamc4RXdzVDRr?=
 =?utf-8?B?TjlrZ1VtN01yMDZONEFBQk9RcGpHSExQRjF4cW01Q0ZRaUcyckdBVXAzMVJZ?=
 =?utf-8?B?K204R0RpbjdTK1plcmFNdkZlUXJsZFJGM1krL2t3aDdRNWJVdDNWSkgzc3No?=
 =?utf-8?B?emV1NmU2eVlUa21zT2hsMHl5UVl3VG5EQ2dPTUhHRGpWYlViQjNUYkFOcm1K?=
 =?utf-8?B?T24zcmlzNkF3d0NHRTlLVEVTbVNPK0F6K01wRmNNS1ljQk5mV2JmTnFGZGpO?=
 =?utf-8?B?Mi9RM2J5TXJUZTlhQS9xa0lCZDI2TWtGY0NraTk2Ylhoa2w0ZFN3Y1kvNzhN?=
 =?utf-8?B?T3dmWjdrWmJzejVlRUxVQWo2b0s3NUFEc0k2NkljVE5PQnJwT29HWUlOUUtw?=
 =?utf-8?B?M1NoRThSYkFzeG9sdTdabnpvM0N4UVEyS3o0a3lZSm5iWVFSMkQxTlFKUDEy?=
 =?utf-8?B?VWVpaU1XaVRySERrUXRGV3JJQmJYTTBmalFmaURRTFNTaGVNa081YmlwR1hU?=
 =?utf-8?B?ZkRkVzJ2V1JSV09xNlJKRUllNE9ucUk3QkxoMGlOQjNnOWVCTTh0V2FXbElo?=
 =?utf-8?B?Mk1zL0I3QnZJenFkR0R2OGNYNXRRbmg4cm03WTNaRFArSkxUVEd0UWx5Y0Fi?=
 =?utf-8?B?SHcwRkdCemtmR2lLM3NDVm9IemhQRW9PdHRYS3haemdsNStpSzdPRS9mbUVD?=
 =?utf-8?B?SXN0UEttVnJNRjZyUVppdjRlQkQ5NzRMY2hJdkF3bU8zbmxHbjBTb1VwcjFS?=
 =?utf-8?B?WG5IVGpwd21GRWhaNGFvYlRIcnlySTZTWjR6bGM4djNxT1B3ZGNZelZMbUdp?=
 =?utf-8?B?cHpyS3dVNXBKd3VsVVduVFZiWXlCN2N5bzVjeUZrL3JvcllnZHJmMzdFbG5v?=
 =?utf-8?B?b3FXQUE2V3ZjSUdIM3dwK1oyZXNLZVlDQzVkSTRaNlRiRllIVjhrdmNiSjVC?=
 =?utf-8?B?ZzFWeFI3UkJqK2VMRTFKYTBMb0ljMzF2SGlXQWRweTVYdzRpQ0VMY0pUaWZZ?=
 =?utf-8?B?ZnRxZVQvdmpKL2dtU0pXb1VmZ0lqa3dLcCtkTDFvVnhGRm1kUExhM0M3TGpS?=
 =?utf-8?B?K0JFUExxd1BYamN6c1Mvbllxa0xSSFR6SXRFSDFZN3lXOEdQckJjZnFNS2pX?=
 =?utf-8?B?aC93Skp4M2xMTGswZmRYb3VwZnpVVXJLUnZZWlBlbS9PeHAwaEN5T2hVNFUy?=
 =?utf-8?B?d1pKdVJmbW9mY0kzellrdXFLWWU2eEEzcGJhVzVIY1k4c2FJL29hR0syc1dL?=
 =?utf-8?B?UlNKTWJwdTl5MjRuOG9taG53QjhGNkYzZHlDdDUwalJ2M0NHaU5OV3BLOHoy?=
 =?utf-8?B?LzNFRTFhSjlHT294eGU2anlKSUVUNWQ2bTBSYlhVNFZIMWVzd1F0cmhWb2Fy?=
 =?utf-8?B?L0lBdC81TWZMYU1wZ1l5cWtwLzAvT1pXOHd2N2lNOEx3T284SmJlUnhYMEJI?=
 =?utf-8?B?VjdQVGprWVdwQlJiVFFpbW5tVTJTUXg2bVA0NmU0UG5ZeDNQbm5TakNwNjZl?=
 =?utf-8?B?V3l2R0MzeXRaMDI5YWt1NWdoN2FZUHVpSWYvZEpFWTFYSGpQanB6TEFnK0hj?=
 =?utf-8?B?UFJCT1dqNndJT28xeHcxWFBubVMrMmNCcXhRZlVEbVdQNkpyOW0vNkp6WW9z?=
 =?utf-8?Q?S2rXbx/KKSOiw3ZVXFFD9984ZtEooGfHfZkUnrPIHJUX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fced05-bc14-4282-c2e3-08db23b5e6ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:27:17.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3FllfC43w4EkHCMD6UVMsIA/U/fLYc7kfCuGqAb71r3pnyS2NuFCeBATVBh+PltZDSBWfYQ1kCrl2xju9xV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.23 11:47, Jarkko Sonninen wrote:
>      Hello,
> 
> It uses only one flag from the struct from user. Would it be better to store only that to state ?
> 
> Do I need locking at all in that case ?
> 
> The whole struct is stored just in case, if someone would implement other functionality later.

Well,

1. would you be happy if you were the one to implement additional
features and found that you'd have to reinvent locking?

2. That would mean discarding the values given for delay_rts_before_send
and delay_rts_after_send. That wouldn't be nice.

It seems to me that all our algorithmic complexity goes away
if you just turn "lock" into a mutex and just take it.

	Regards
		Oliver

