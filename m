Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6B62EE80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiKRHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbiKRHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:36:21 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1A85A11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoaP9uPeYmhPMDFdL6l5oGbwhJJYjnLOsODq0wDV4SmYq7wvZrk9nNHyjPsAFTAS5XpnKSVT4OR46aZntMsYLOrdwyBjzLYSajHZhokA8nVm5jZF5nb/sFT6/sxalJfv5dwS6+sN4T1iXZjeJNFAwFUQTiYwTZwcdaGHvNkYhQ36DkwdKcHDgyR4Aiir5KJ849m5z+zao4gEFvlVr5jIlzgwffTCbsRU94l/79uwbZmniSmbhLMGcqwaLzaA5olVIPqO2IarlCxfEdaUF/Ytxxd2Og8/yMcyguNyg9mzHmAXwPrK5IrYIzbG2LOVx/GWysN7gPrHpZ6vQlsNeptS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z7ea5Z9iV01gyTI2NFbO5Cm6k11JK+P6Gpe9r0UKkI=;
 b=hRsslaxYLfTz/AiEJ6fNPdqdS4lb6XGwlOKJs4BhNX6mKb00ZCWDIuj4sYfh30r9EuOEva5j/Q/1eJGZmbi5VW1BuP/HT9fcffeflPuA4SAefPp5FCJM+iAzdKKcHLEltPiOw1w4eTEAkrm/ko6zUmcCbbafGHqJWX8Gnp5QQG4Y+BJ0mSLsmIz/Kf0+P41Y5su5XvNXeeyaFuQMoQtDjOKJki5nc0yvwk9a4xwye4r8dvKdiiA6oS2dvOQwWgQe9Ga1/bS5Gmuhd9QZKuJgZfHSQic3YkXbDn4UEeVBP09bm6Htsiw0eipspIU624OpRNAcK3WjISZNa6kxpN4wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z7ea5Z9iV01gyTI2NFbO5Cm6k11JK+P6Gpe9r0UKkI=;
 b=41mU+9hbuH6PfFvJz1A7QAdexvH3kryAy6RkKRg//nj8abLZ5UkVyntAtuhIm5sYX2Temj38iIcIY4jaMJw9clzlq9gBdEzgKE9Zsdn9mdK3uPWjEz1zQppTgU56XBof7SSw97t7f+0NKorlC8ssVSqFTQJ54KWEPvAb7QmcBDifcYFCGjcmIm8aQKppb5zs4YZYKdZ5zj/HhkrXkrmpvem5CYr9thJCyYC2Vh/ok0Txx6W1oiwX55G2nZLS8zPK8yOwkT/JCWZ5sT3cR3v2UQeSMvznVkVXw1zfRP5FsN8wbk0iXTAEIHzJPZcUvCK4IYwODsWERMKwTQaD2TOlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 07:36:16 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 07:36:16 +0000
Message-ID: <93b6385c-63c8-1b5a-13c0-838f7c03ccce@suse.com>
Date:   Fri, 18 Nov 2022 08:36:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
References: <20221118023535.1903459-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221118023535.1903459-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6756e5-a830-456c-81b7-08dac937939c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmQ+ElxE5F1iSFxtSUZ2pPMw5gUUGC4m3grdujQSGBke2IOSZnuhwXt9gtxGiuT3MoehnUY+j2iq5UiTdIxhmXpTkRF16OABBjVj9Fa/ynnQTSxNqaLZOEGrukyVS6OrHrGeg/ICeT4Y6/yW0guNdfZGdlU0dhvWjj35we3nOI/klTFsEavmaSCuieMbGetAZO5eDREYgvnUfmCWYcRW5sodB+7onnndvRnMuw8sZkGc/tZd6PUpyTXXZnkz9IdXGqx9+VwomNIimDen/OfEUQpHXkxczmG28ert8r5NL47Q22DsmhovowmE3Mwq3jo1YaQLOLj2XSVvQ5MXnVgELxk+GG2Nmv3wU+exInlnX6tJHJ+lpA1Z/HfheR9Ibdzb+EncOiZ6mDBF/ePOXSEujaxLbxeA46cABSStY5N3Mh3AWbFw8mTqy/8KKtHmwDV8S2oXMMrkfueGq4uKktZPcEXUDdLpVL0j2yea3FKQ99EjoteomxefCnZDg3Aw9xxhlCb20pDEfmHBGobJhdefHKQbsM+ZzZwYl3tVbegaDzvWNu9eRfP8xZXdJR0ReMLM/LbIbEFbi5RqUT2hM2IXTQjLz+hSOOen0i3HnJd+0DtohEXOOxk197tpGbmfZoibC3wqNntEqaOHW8gqsuyzJT8bkrorPOmv/lkGEg4C2ABPdX2L2cNMHMf84PLjMT3PMC7P5CF/veQQs9QOClTAvSb06ZR9e4jl7yZP82Tc0qY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(6486002)(478600001)(31696002)(2616005)(38100700002)(86362001)(36756003)(6916009)(2906002)(53546011)(6506007)(83380400001)(316002)(54906003)(41300700001)(66476007)(31686004)(26005)(66556008)(6512007)(66946007)(5660300002)(186003)(8936002)(4326008)(8676002)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elgybnhhUGtzeGF1aURNemxZTWlNWXVKVXZDcTg4RVI3aFY5S2tzZ0g4Mllu?=
 =?utf-8?B?VVJIbFFVWXI0Vks1WndIbFB5dEd6MFRsYjF3K0haSTRiWDFuem5ZTFVFNXlZ?=
 =?utf-8?B?M2JNNzhzWGpTaXZGSHZhRFRRS0Z6NVBTd2JiMERKUUlQT0dWcStQS012VWVa?=
 =?utf-8?B?NzBlUmMvVjlvRW45TytjSFZHWm0rbGZadHlrZHpoeStZWUsycUhMeG4wR3U4?=
 =?utf-8?B?WkpwUVI0aXZiRk51UmlmM3B4NEYrRitTMVVkeVhrM0ZMalZSdGhzSCtTL3pB?=
 =?utf-8?B?ei9MYTErTm16cGhHRTlIZmIrSXRwVy94N0VwZFJTMlRCWVd6dml4VlhlbUpa?=
 =?utf-8?B?b3RJK2lScWhvS2tvRC9qZ1dMbmc0dTF2UWt6MWRpZkFjVUFsYjdrdU4yZWtw?=
 =?utf-8?B?WlF3ckVhcHArKytHTW1Ec0FGaHFFNUFxNGFQc2FCMjlPVDRwS0Jra093Snpn?=
 =?utf-8?B?R0FYMk4vMjkrQ1lIMElEYnVhSm5KZjVqdTlRNWRDQVNUTkNYSFlOeUJuYXZR?=
 =?utf-8?B?QTk1MDcxT08zOEhQRFI4RldZbEw0WFdkWjlPc0pWNGxWVVkwcVBqaHlrenIw?=
 =?utf-8?B?OVZrc0JKOEM0RHZ5TS9QZUlENGRuaVErd0c0b1BKNDhhOGNSSmdnNmljUXMw?=
 =?utf-8?B?ZytJNkdYRTNkNzN4cWFlTkRLTzBKRGtuTWRxQjJBMUFDemYxR2dTcVg0WHRN?=
 =?utf-8?B?blpwWTVpbkRrUEJXVHlhektDN1VvL2M4eGJ6VWVoU2NsMkFsN1o4a25vS3Bp?=
 =?utf-8?B?MGFFUVdCd1YvQ08vQVc3RHVJV2R3bTJINVJOVUs0N00wd3FlcjNOQnhXa0lp?=
 =?utf-8?B?ajA4TFFLNjBwWUNUOG0zL0REYUsxZ2UwYzhPYXBIbFJFdmJ3RFVVZHk3MUJI?=
 =?utf-8?B?TiszbnNUWDFRQVhqKzlUZ0ZaL1l3R20vdWQzNnZnQk0vZlZObzVndjFmaDBM?=
 =?utf-8?B?aGNHMlBXSWlzT0RoLzlseEdVQ1dVYmsvVnRLN2UxVVYwSzBIWEkrUkJCNDRP?=
 =?utf-8?B?VEc2OTJGY0htaWZHckpwUDFTeTFvcFZpRWQvNkZMOExHMHNhR1VJTkFKN1g3?=
 =?utf-8?B?R3hsc3p1d05mYjhIS0hjUm9DR1A5UlBiVWY3M2dXT3NQZ0xVbVIxZjgzNGpU?=
 =?utf-8?B?bWh5emFtUnFMSnYzTEFrY3RqMytjMjlEQUV0SVJQYng0RWdPNkNobkJyVDRF?=
 =?utf-8?B?Ym5yV0drck5VYkdiYldZV1BrUUtzcGs1OHhDcVlIYmtvVG4vUTZVU1NmdDYx?=
 =?utf-8?B?QkxhQzdkUnFkMGs1cCtSSncxVEhaTVFpdys4WDBiY1NMZ1A2ZEdvQ3dTZG5u?=
 =?utf-8?B?UURmZVkxM09DSWo5R3RFV0gyaUlGRjFEZ3V0d2s0MTdtK2hjWjNiSVl6MHlk?=
 =?utf-8?B?cmlBQ3Z2V09yQVJPZXRoeHNJTnlqSDYzTk9BZDBXQzNRNFYrcHhONTJPZktv?=
 =?utf-8?B?UWJwTlk4d3dod25WeFRTQlVWbkpKaERxdkhwNHRSOXhLWVRWdU83UXBlS291?=
 =?utf-8?B?NkphUzMxZlZkZHUwSTlDR0haMFRKZDY1NndHeldrMHBnK0lDNFJzNm5HUWE4?=
 =?utf-8?B?bHVqR2dtNW8vZ2JrM1VEVnh6RUs2LzN3eDJTOWJxL2Zkd2c4eXBjeGRaTzJU?=
 =?utf-8?B?NmNwVzFUeElNMXRjR0s3ZCswRzYwQlBlbHFOVXhPMEkrUWdwVXJZbW1DTm9E?=
 =?utf-8?B?RUt6TFFNVUF3NUFTUGJZVW1ab3B6R3JpNU52Wmo3NTJFdXBsK2tUVnRCdnBX?=
 =?utf-8?B?d2lJN2NSYzBPM3dsUU1HcGVPRERJWmJKTG94eVpvNTFMZ0tCdG0vNzNVM2l2?=
 =?utf-8?B?QzNWZm9oUm5LbTlPNWkwNThZazBpTUFWb0pjeW1HWmhVbGNUbERhaWZkNmpu?=
 =?utf-8?B?WVRjb2FZRkFsNzNzTTRXMTdLN1RYS2xNNU1vclBBVlYzWndpWjFHYklDOUFa?=
 =?utf-8?B?NGtpZHV4OCttZnFYMldlcVFZWTVSandROWk3RlBYdzV2QSt5T2ZPUVBlV1hq?=
 =?utf-8?B?V3NJZDNhUTVVcDJLM1lWMVpYRXhtKzlXKzlEYkpoMUhrUkdaZ2JZVnl4NnFU?=
 =?utf-8?B?ZGhxUDVyWStnanptSE81eEFZL1BMUWFSOWYreE5vK1lrWDVyb003RlJkUjZ6?=
 =?utf-8?Q?RMYhinBjZV524DQ8JWIPLDB7S?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6756e5-a830-456c-81b7-08dac937939c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 07:36:16.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxLuRRb99Rc75IQpwOHLu1jYS9ct5eRBzYk3H4PnpCo2oDtwiOFtLm6QHR704UFsCnI3WWF7xX7ROtMmADVhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2022 03:35, Marek Marczykowski-Górecki wrote:
> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> the table is filled. Then it disables INTx just before clearing MASKALL
> bit. Currently this approach is rejected by xen-pciback.
> According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> enabled.

Similarly the spec doesn't allow using MSI and MSI-X at the same time.
Before your change xen_pcibk_get_interrupt_type() is consistent for all
three forms of interrupt delivery; imo it also wants to be consistent
after your change. This effectively would mean setting only one bit at
a time (or using an enum right away), but then the question is what
order you do the checks in. IOW I think the change to the function is
wrong.

Furthermore it looks to me as if you're making msi_msix_flags_write()
inconsistent with command_write() - you'd now want to also permit
clearing "INTx disable" when MSI or MSI-X are enabled. Which, I think,
would simply mean allowing the domain unconditional control of the bit
(as long as allow_interrupt_control is set of course).

Especially with these further changes I'm afraid at least for now I
view this as moving in the wrong direction. My view might change in
particular if the description made more clear what was wrong with the
original change (476878e4b2be ["xen-pciback: optionally allow interrupt
enable flag writes"]), or perhaps the discussion having led to the form
which was committed in the end.

Jan
