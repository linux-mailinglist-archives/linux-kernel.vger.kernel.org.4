Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8817E73A0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFVMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:21:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA110F2;
        Thu, 22 Jun 2023 05:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOOU3mpPZvcULR7amGDZlGq7Qka4ubk7BSGYsqZcPbgAypQNWyjoQ8VXtKb8j3G4ReSCnr+j7mEmtXokwP0nj0DR/EeQNy5lK9M0/NG0TfRioXygxrEW/1tEowlq/KSUlB2Rld7cEiEw+Nt7zNbrR7f4QNGyOndW8D+Duieb360WTmrBUcAfoNqLHBMXVDVWfuCWDBfk/tgDQ6svYsBUOEYd2mXXq+OtCPMvOXxzt6sfofl+COZMYFPjjRBK0P6oH1wnhMk/Im1ERbRchGz+Lx4rnVHcpVs1ksCZD4LaAbrEqpaubPSqDYOvkrufpCId19O3yfgbmt/cWAcJeM8TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHG2R3fqM7ZyySYD0bGSf/Pr26QKEsVMEmNbx3I/eLE=;
 b=MGmfyIy8c956xtlAXuxPjme9uuXQq6KVekwBlOU3dfVQv0ei1+pNqQcX5l6DG0NdBmdrfqvu/mgZRvEpWGDkxz8jpKC6tLX2cx79IGA0ANb9oVwc71lR85OI/6GEr2c3fqIkQpkqrthmnsy545O4SUgGlFcK6FZfGVRGoQfGmNgge5zk1cVJK7mHAvkBhB42Ry/MbT4GYz6PReBG/UPevie3cVpMfM/pWMjM+0GloCpiTHuET+CWmrEW9dGbv4z2rhWZVIX+xanrjG6uIzCxxIkSNlYdnZ1akxj9zF7IW8Xr6dwPuxy7sYj5hTYpnVbhjeSVcpminCalXFUeqNbmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHG2R3fqM7ZyySYD0bGSf/Pr26QKEsVMEmNbx3I/eLE=;
 b=cJhJ7e7aZhCjxTbW9cYFMlBBo4s/TMJaW1wM66sRfD5pfekXu5MOIg4eYbGSVndCt9j+dtZbaUxqFQu185joKnv9jw18h174eOLIk2MyC8lECo7YOETyc9K6VIXCeJmfWrwey7tLWfyZjVHncEluI8OdzEHBl+rrrnRRxk9YpzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS1PR04MB9407.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:21:36 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 12:21:34 +0000
Message-ID: <39388ce8-44d8-8869-965c-a66f855fb4ab@oss.nxp.com>
Date:   Thu, 22 Jun 2023 15:21:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v1 03/14] net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
References: <20230616135323.98215-1-radu-nicolae.pirea@oss.nxp.com>
 <20230616135323.98215-4-radu-nicolae.pirea@oss.nxp.com>
 <e77a1ddc-feec-4de8-972f-4929e0bf2fc6@lunn.ch>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <e77a1ddc-feec-4de8-972f-4929e0bf2fc6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::15) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS1PR04MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a4a5ab-4af9-4c8e-b7d9-08db731b3817
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXrAgwPc9zmZ7sAFfaY8fJ83NDiAoGfX84ZQ6uTmvc42QMfzfUeg2+/ozG1W4i+QZGGsB1W+o+u3jSNdh1ISQLmTWOwJo1C6MfBHD+vI33qdbhfLWAtFL3QuMvXPDJe8k8wUTUaRC0noABOq8dD7n61a55ud8fc+kqsASgeImEwGFmD0jgXI24VGt/VKlFbMe8l2MN4eEfs+3oGwCPVgb3mGbQ9IrksHzbz7y8O4+zMbUD+GQ5zQnZRoSeidqUG4X6b3WzeAKTf1MS0ckozUioi19rXkM0JpV2NSntDr2R0waKGcaqw3El3CGllWliR+ABo0MqaXCdbaK4JqWS5EgVtifVgbosEurR+oUf83fW9aid4zkxxYgDIZUZxyj54uquT6gA0KbxQTl9GGSwioacIl1FtUCFC3Phax/+Zy2h0c2c589EmqJ2Rq8jTtww+ungI6syk3Etr12frZNhHTbNbTe+xnDkD/TSbNbgs/TeOrHkSd/uRWT7QxUDPxVnV8zLbbvcUBg9GUhOqia1dSxiTziVZRxMaH2Y0FoJS+AwGSKQ0y5GTedq2CRCyxObIMH9SMzHy0tLYVQpcABna0y7t4iWz9CGeoxGkbt/MwJGY4cVXEaqScfIsefl9yeOJzBRiCbQqsNKHpZ0QkUmehUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(8676002)(8936002)(316002)(6486002)(186003)(26005)(41300700001)(7416002)(6512007)(6506007)(53546011)(478600001)(31686004)(66946007)(66476007)(66556008)(6916009)(4326008)(31696002)(4744005)(2906002)(2616005)(38100700002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEQ2SnpvNmNCMEo2Z1pLdi9XeFQ3bWJjd3lDUHd5djgzVlpsMDlQOVRrYXo5?=
 =?utf-8?B?ZlpXRkVQVjhpWm1CWkJVNUtxQTd0UU9GdmZqb0hUa3RTWUhZMEJyRk5UZTBR?=
 =?utf-8?B?YnNHVFpCYXpHNnY3UGlGOW5HN0JWZGVjbWgzY29UZCt0OHhyNmlHQ01qeXU3?=
 =?utf-8?B?SlpiUnFwa2lXVWVYQlcxQklDUnRzeXBvU0pKcnk0VnFBK3JkSU1iYjlJbk9p?=
 =?utf-8?B?Qy9pamtocnJIVldHS3p5UzBlY3pockJhdUFRM3VkeFBKMUphVEkwOUhQeW9a?=
 =?utf-8?B?Zk5WUjlJY2NTdGZrVGtrZzhCR1JuSlZONEFIWnozalF3NkZGT3IxMDZCVHhP?=
 =?utf-8?B?S2g1NHkxS1I1bGE0WG5CUG9PWVZ1TWFWZ2JRTUtQK1E0bFQ1dzgvM05qWWlY?=
 =?utf-8?B?UFBLTlhnclNPeW9jcFlHeEMxK3V4M0tyV2hOV3ZXWHE5Z25rWVNVVnIvakpB?=
 =?utf-8?B?K3U2dndrWjdFZ3FTNnNnd21xanhTZlpqLyswNjVBamkzOTZPY0JhV1RmWWU5?=
 =?utf-8?B?OUYyOGlSM1I4dUc2dWN0NXE5OWhmTkFiQ0VGYmdIWmpERnI0K01obHZUSSt4?=
 =?utf-8?B?cmMyQWU1WGQ0YUVSNjBycnUyMHNLT3dJNjlTSFp5U2FEb3R6a0pGTDE1QkJz?=
 =?utf-8?B?TjQ5UmNDMW01UmdMVzd4dHBNcUxldkc5UHdUNHIxMHB5NW5OVWdWMUZ3cmlZ?=
 =?utf-8?B?OXdHRHloMmNWd0lrR2ZEYVFTSTZtN1p4WGNkZFFXazk5bmVZdEc4Nm4xbFI0?=
 =?utf-8?B?cFlaWlZQY0xVNGYrVDR6dkFtWDlyWE5WV3J3UDZOQXJkbTlKSnZ0aVkwOXYy?=
 =?utf-8?B?azEvV3ozbHpBUUlpaE5YbEtZRUN0Q081eUVPWkEyVzRvejJLYVFia3NrNCtu?=
 =?utf-8?B?SG1CUlNDenJyRnhadHdqMDFoMURSRWR5ZndweGpnVmdNL1dBenFvS0J1SWNj?=
 =?utf-8?B?RTNjN1dWekVYOHphemJWUWJkWEFISDcvM3I5R3JKRzk4RkpIeVpseWdJMFB1?=
 =?utf-8?B?bklDeVFLb20zMWVrMkV5MlVsTW5rYmdUVERlejNPUjdWMzFvWlNvckwvamJB?=
 =?utf-8?B?M29Rby9xTWNoSmQ0KytsdTBJTGJSdjZOL2RzcWlod2tzOWNjeE1tME05VjNJ?=
 =?utf-8?B?ZFdENVROUUdUNWdBSS91VS9aSW5BQjNJOHoxSU9NZm1Kd1JrWEYrenZxY0FE?=
 =?utf-8?B?MWJPc0Voa1dhWkVIUkxTMFpTcVRGdEhnOW90djU1RkMzdGNsdlNEVENBUFJC?=
 =?utf-8?B?NG03SG5KMGZjMXVROVk3OW82MTlSUStSMGFHUktpYWl3TkZlTFVabUt0QWNh?=
 =?utf-8?B?R3JxZEN6cklEQldWQlBFT3lTTU95eS92WHNCSCszYnRiOVFNNFZGdDZKRHhx?=
 =?utf-8?B?elJ3T3JTcktGYmpoMDZpazlsY2pOU0FFRjhXUFhmQXArakw4RXNVTGx0bkk1?=
 =?utf-8?B?Sys1Q2FMN1BYUU03ditIYjZMR0lid2RrNE1heEFtRGEwdzNsZzRxSjdGUW9U?=
 =?utf-8?B?ZmVQOTFZUHNQYml2SWhWS1lQRzZNSnNLSzRNc3dXaC93T1B3OEYyZVoyUmJr?=
 =?utf-8?B?QU93OHo1YVpDVEtmbHliZTlzMGY0OFdDT2h5SjBwbWFIWVZZeFVBMHpscU5Z?=
 =?utf-8?B?QWVjMEs1MFhja1pHanBSTHdKMWt6QTc3WTNzOHkrdzlJNGxBdGc5VWVockdO?=
 =?utf-8?B?eXBuTzBBWStJeGV4disvb1JyVExQMnhrd0hQa1o1UGkvYlBBSmc1MlNjU09R?=
 =?utf-8?B?aXBqUis0QVJGOERVUVg1MnRjREg5cmRPa0NyTGhKZjRodVlXUTZwbWR0bTlu?=
 =?utf-8?B?UGFqTkdJUjJiWmh0WnRGdXdVYmhINk9FUC9vK2h1ekJycGd3Y3BnWFQ0WXBI?=
 =?utf-8?B?UTRFamp0NWxXdmZLL3Z1ZmZ5a3h4M0cwOFMzeEU5aVdPcnBnOU9ZRjZ5dW5n?=
 =?utf-8?B?SFdMM1hmaXBNNjd6RnlXNXJoMDN3UXRxMGNMZE9DTXN4QTMwTzJCMkltWWhV?=
 =?utf-8?B?QTFIeTB2VCtUdy9HT0pEd0pMWG4zWU56eGdXaEkwVkFUR3JWK0dBYkZKYlBv?=
 =?utf-8?B?ZUFCSFQ1S1lLb1BteHowYWZ1UVFZWCtkOEhoR1piWjU5TnRHVkhvUCtJeGNS?=
 =?utf-8?B?eFBkZlVSak9WQThBdWp6SlhXaCt4ZGFqTkF2dHEzM2JTTW84YWJUbTdWb0wr?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a4a5ab-4af9-4c8e-b7d9-08db731b3817
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:21:34.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdxcIrnWb56N7Y0iwz0oxKMsNG3Cb0GfosANeelo+eQKgkodUr1f2YRCqzKtV+0T8YfZZEhpTnQ+7J7FnuIxHUReIgArR/D3Sp+FZqXIqGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9407
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 23:39, Andrew Lunn wrote:
> On Fri, Jun 16, 2023 at 04:53:12PM +0300, Radu Pirea (NXP OSS) wrote:
>> RX BIST frame counters can be used only when the PHY is in test mode. In
>> production mode, the counters will be always read as 0. So, they don't
>> provide any useful information and are removed from the statistics.
> 
> Hummm
> 
> I wounder if this would be considered an ABI change?
> 
>          Andrew

It can be considered an ABI change, but will not break the userspace 
compilation. A functional change will be introduced anyway because these 
counters will not be reported, but they don't provide useful 
information. These counters will always be 0. In the worst-case 
scenario, we can add them back.

-- 
Radu P.
