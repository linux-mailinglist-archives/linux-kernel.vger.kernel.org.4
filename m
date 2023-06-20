Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81079737533
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFTTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:41:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E430E72;
        Tue, 20 Jun 2023 12:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrTlHRY1eqBcjNW6FJLZceeoaAln8QtU4FuC7NwdawYjYz0QdrSmN2wG3YyoLE+Bw3Fx8pjiWVcSuEs9mhFdi4/12c5EcoWCKZAad8tKJp/0kEvvb9V5PeGBq63ovp4an4ePBPDCRNCPlTcUMtFLEA12Qf6jE7EEsY1C/2f8ZlZkXWBqD46EiyttaemFv3OcnEJ6AzadNyOXdNZpKw5ZwT5Fn1IYiAZsgwfIsk5MHOayemLOet5MFkZ8CuuNBKFjP9IJl8LAjjHxZUH/lYCZ/x36gy3P4BFqfcZcOXs/kS099TaVN66lw3YyHsZq4IXJOuG7vdB/7QhLBou//TwpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z57AXJ7y0XzIz10jpKRmI87uM7dVb1XO0yHWR0Zc9eg=;
 b=WnfBQOSyHpSbRqFpkCZpLSFlELz9zRnAH8lBy9dNRoN0Kw5CfVbLIZmfGJ9RMzeQUXLEN95Ze4X6403I2oIlvNiTUkJAhzuhJrkPTIYLQr+D8z+uGmoUl1SZMkVuteUeOlJNoC8aqUtFHNutrzzNu2vGvPeMxWahsuQNC07OEIR6B4aCHMtxwqr2zJ+OH2tVQ547cmC+6w9QF5lRQmLYfaynlUAjqO0PzmOUlzxnqYjJJT0C0tXXcJowfGm8lV5uz6KlGoi9Xn9kLmrHz+ydo946ZRiOGH0hN96HP+EHm4nxerR2+e7hfjyUftkEfAnhltmCzQ4W2/CP89xu2wUwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z57AXJ7y0XzIz10jpKRmI87uM7dVb1XO0yHWR0Zc9eg=;
 b=AWmCIsUWUvrU1KDuUM3udgOCGxggTHYdhTaFWrvp6+m6h2YospEV8hErdnyvGaSAUNdgtCyJAvjGoj+vsjdnROS6UuSqG967liq+AeJ8+7R9L7HDP1GcentSDguxIekGy8h9Lfjgnv5Py5+nupFSNXv+aHEkig4HRMRgHJnMwGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5809.namprd13.prod.outlook.com (2603:10b6:806:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 20 Jun
 2023 19:41:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:41:42 +0000
Date:   Tue, 20 Jun 2023 21:41:35 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
Message-ID: <ZJIA7y/x7GV1/hfu@corigine.com>
References: <20230620144855.288443-1-ivecera@redhat.com>
 <CACKFLi=1EV01f=47eDP08mp8OiaBdUHcigrJak-PKx1z8KHUUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=1EV01f=47eDP08mp8OiaBdUHcigrJak-PKx1z8KHUUg@mail.gmail.com>
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: fd48d108-c48c-4560-24bf-08db71c65f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwFslHq19zNU3QY9St9vrzIPc6cDeBsF9ioARfCrZiQlq0PCC5W93l3PQAXwElJprODlSKGQKy9UwiEhYox/s7oa7RNOQ2CKSB36q6G3zLTBE2sgDPZrDO1pdzBig7u1L8K1d/8JMfcim2YLYnbjkamDjvSk2T+U4m4j35Owk8IBnIPITn7446nXF7J2d6JWVoOGaPzhxN06koz5alR9dwpJzkHYXAcaSPynrsPLvxwrxKDioMBafGLRFi6Q3weLGhgh6j6noB+h0wk5NBxEN3XCtrNT0tpjAlu4v3J4SSFymRy3cb2PsBSXk7Yx7SBKjsmxkZOS8fSMen/owj4tBMvQTDdDKnHmdnFm4p+/7DryGpb9bSYzztp9gepRAkR+v5CxbKIRtqFrm/EAzkU2Cpvpi1DKXaEAqFl866ohH8AkJHJa85LI0SefrnMxcBurisEzQtxGuBlbE2aDnR0v7S5c4xQ8cM3EcdGMLsq/0SiJ0j0AWKjslZp+wEUlg+TvuSnPNcWkDeqsa4TkV8DyRCEfznP3Dyjo2LK+50dJQXy1UYM8y/9yM/XTIOKCUUys
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(451199021)(86362001)(4326008)(8676002)(66476007)(4744005)(2906002)(54906003)(41300700001)(38100700002)(36756003)(6916009)(44832011)(66946007)(316002)(66556008)(5660300002)(6486002)(6666004)(478600001)(186003)(8936002)(2616005)(6512007)(6506007)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9nb2VjaW5zbTZxSjhMYzZpeGsrZU9aM2dDNnpBVEh1RWNYM1hOb0ZBYWRB?=
 =?utf-8?B?cUNxcWhXT3RTRC9jOUZualIySnhJa2kwaHNSVVhTMXUzV2dpcTFoU0JyMTRN?=
 =?utf-8?B?N0tKQ0FtYkpkb2M4b2VtNjhZakRCQ3djemVsamxxbVp3Tng3dURmalhzZ1JN?=
 =?utf-8?B?b1c0ZXRCek9YWVhWZzU1TVFxbFRyRXNXK3RwT3pVWWtYamFVU0xmZEJZN0Na?=
 =?utf-8?B?MzdFK2w5d01hU2p2YmdhbUNGVWdMWGQwcjI3MzQvVms0dDVQSGdVTWNiT2RM?=
 =?utf-8?B?Q1duMkw3djZrWDZyZ2VaZ3VYZWVaUlZxUmZidGhlSmhWOUVkdmk0NHdpd3Mw?=
 =?utf-8?B?Z2xHWHpFNnVwNllDaU4ySnVBTnNJdXFnS2l0NkZLalZEbThnaW9Mb2QwYjh2?=
 =?utf-8?B?dEIxYUlINXR2Z1QwSDdILzdtdmdaZm5CTjltSlowUXE3N082MlpRWEU5OFhK?=
 =?utf-8?B?cW1KV3JiL2F4anhJbWE0ZXdRUjlJeEErMFBZWElxRDloTlN2MkxIenBXN01X?=
 =?utf-8?B?akxBVHBzUUViVFo1MVNkRFhKeTJsVGpISjU1NlplVUNBaHF6T25FWUtkWGxX?=
 =?utf-8?B?TUpuYmI2cDQvS2I4Z3g5MnFmRE9JdzJ5bVEwYWRyQmczWXh5SHRkZFNGNUxW?=
 =?utf-8?B?Wi9pVEhCdll3amZ3ZTlxU09LcW0wVStKbkoyRUh1K2FiMDlZbmVWeVc1M2Zt?=
 =?utf-8?B?aHRuZ2Q2SE5naWpGQ3ozWWVhbnZSWjZkUUpOODlpRlFvOEJFTnFWcmRBaTVU?=
 =?utf-8?B?SkRINndkLy9qWEhpZ3dzT04rM1BaOCtTQThDMkhEOWtMSy9RL2pWbkl6TG9u?=
 =?utf-8?B?Z1lDRVFidmtnRWZvOWltM1RvWk5EcW5wK2pPOU4va1JaYi8zM2hkS1BLdGxN?=
 =?utf-8?B?NzdUaWpFUXkvTnRrNWN5c0lZY3BKaUxmL3NjQVpEbVpJTWN6MlMxTmhSeko2?=
 =?utf-8?B?K2hFUk44N3ljT3BjV2djTFNXWVhUMzY2OFcwbG5oYXlYMnRjNktFWklZdUtF?=
 =?utf-8?B?T1hVaEFEcjVDT29NUGdEWXpTUFZmVlVLcUZnYUxLY0RqTThIV0ExQ0hmV1FX?=
 =?utf-8?B?Q1FGMmd1bytaZzcyMTJ5WlBMUWFreUt1NDNrQXFrc0hJZXc3ZEdmaEM1ZUZX?=
 =?utf-8?B?Q1hiaHZZWFFUU0RWaDE0YWY3QnBVamNHbWFUa01uZDR0QVZmTnI5L21mUUdz?=
 =?utf-8?B?Wm90cDNTTG5KbTFOMGFsSDlobjBBZ0dpN3VCaXlZNTJGSzRUWkJNWmk0VVZw?=
 =?utf-8?B?YjBMbDA2MDhBcnR4eGVXVnBVekdubGp5RU52Z3BzQjJQYXBoM29YeG12MVZx?=
 =?utf-8?B?aU02RDJpY1VjUmdtMlRsUFRNWTkwRVFJZWUzanJNcHliTVhuQUt3d2dmTytC?=
 =?utf-8?B?d1MvRmhrQ2NPQ2orbnE4OWc5U0dsSVBHZEg5RVZiMzlRYzNLTkZvbEU1Rjd2?=
 =?utf-8?B?RGdkUE80ZFlpZEpMQWxJU1V6bDB1QWZXQkVoMENqRks5a3ZWbGQwNTg2cTNR?=
 =?utf-8?B?QUpOdExESnk0Z0EzVlNlNlRkMmc4NXdTS1NvbGdoTU5GWk5LSkxCSVk3QmJJ?=
 =?utf-8?B?bnFZWUd6MVhyd1EzQnkyRUNZWFIvOTdiOGdMZkdxSlZzZVQwSG5Ia0RKb0x2?=
 =?utf-8?B?Ni81NkIwM1VhZHAzd2dUcjZRMXNGT25jTVBoYWVsa2szZlpQU2RPd2lVRnhk?=
 =?utf-8?B?T1IrcmJTeTd4aEV3NmY1U3RMaEN0MnNNcnplVUhxVW5oRWZmZ2ZYQjZYRTNs?=
 =?utf-8?B?eFArSVVSa1QvZFNMdU80ZWZTck1TRTR4N0JtU3RkYit2ZVRLRGF4ejdhbGln?=
 =?utf-8?B?TnhjNzBRYXpkV256ckNNVzFYdG01d01vc2NSQVN4RWtrVUUxbStnd3Vtamwy?=
 =?utf-8?B?VlRmYThlMVNxRXBUcVcxVHRyTGMyazREWVk3SjVuRWtNRld2UndXUGpNMVV6?=
 =?utf-8?B?ZVAzWmxFQzB1aElOOUFVRlBMc3psRkhVQ0pySFUva2d0NFNGZExiNmxVcHZk?=
 =?utf-8?B?SHRDazczWjNjbFAwVDA1ZmN6a0UzamFnWEY3cVlZaE5CcWZZdlcvcXJ4VWo2?=
 =?utf-8?B?RkZDQnNhbVJNU3hHTU4wVXF3MFEvb3JTbm1PTFEyZHZaM0cvREtqdXBBd2ZE?=
 =?utf-8?B?RWtnR050eitlcFdla0lURXVmNjhkYytvSEtwYm0rUTBDSHd6TkNpTFl1eXN0?=
 =?utf-8?B?TUpEdEFGT0ZhVXd5Q1FaWU83a3ltK2hDWGF6ZnNHSjBWSndGNlFOc2NPYVVt?=
 =?utf-8?B?cGdkZXI5Mm0xeVA3OFVwSmNWUFdRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd48d108-c48c-4560-24bf-08db71c65f44
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:41:42.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJdXbeYOnYNlPBzPo5m+H2JEAGIKkZljfrSSiolQ9nl+GfgkYoGIQqt8JAg34/ENiQGvphdSRQ73DrPOCQb5Nr/pLROcqJrvixpE87/wzYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5809
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:26:21AM -0700, Michael Chan wrote:
> On Tue, Jun 20, 2023 at 7:52 AM Ivan Vecera <ivecera@redhat.com> wrote:
> >
> > Link VF representors to parent PCI device to benefit from
> > systemd defined naming scheme.
> >
> > Without this change the representor is visible as ethN.
> >
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Thanks.
> 
> Reviewed-by: Michael Chan <michael.chan@broadcon.com>

nit:) broadcon -> broadcom


