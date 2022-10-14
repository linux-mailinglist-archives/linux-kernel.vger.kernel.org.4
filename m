Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBF5FEBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJNJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJNJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:41:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F044733CA;
        Fri, 14 Oct 2022 02:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h00L1aaGjImnBsvk9thncHqFUahZW3Wq5nW7COMl8Rb/9oJpxdMKeJuoM+Q8d92FyXgPdMi0A9QgCuubQRg0vUDYNwbuxk3KD6az4iQB6OKyK6mQs3KXz5FWnDh63+P+a/3wKuD5XO5ryF7T5yB66cms+Zg3CInSfAOsOiiMt5tcTkoKcXlk52kZCG8YCdrmj17Qxe6abUfVX7zqjyDFSqFNfVF+ODvd9zL4gqaR39D9fO9Y6gjM92nrxaXCMjIlStp52PIfIAdKl6QhmkcMmTPx0YqOysv1s1e12JF6onLQjIi9CtN5s9eRCDzsvjlXxvJBCU+Q8pjiJBHFn8VeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufp9jRtEhQvyxwrWAc+CaoKldEerh2Olbx2k3muOkEg=;
 b=KEcnh6TvW/bn64B9G/92+7j4FtG3qTBgAUSgjKYk1pFL6K/yGEolN7Zpi0cLKCme9zQRpE+pXc/LPVjE+hUh6roUMNgOqsHAepkm84mUmgzF3R4d+j9W/tD9CVqrXjCHjCnwkYm7jQTB0HAUFk155LaVDKkiXjzcmGprrk+bdjnYe5cF/GcGgBAn8qw3DUFVwxBjBiITVGFTQ9xTPBuX0elHac13uQH4Uqkl4tlcOrFxGSjFA+o2UOAPyA8P/K0wdyliLXt4c0H7XfSCViA7uA7QvMLvVzbsJhclFoleNgl7BC+KSwWuSfFR61pblI+LE+QfwtcNO6YZemszYQAIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufp9jRtEhQvyxwrWAc+CaoKldEerh2Olbx2k3muOkEg=;
 b=h3nWtv8PbaZv5DbmUfnX8Cp0W8npDgj+6HheDOrCcTWVaNc3Kqv0qM0EMJd64pblNAZNUXopdVby/r2k+eCbKVieOpvycqhUELVMjAB7vDT4yj9s6XHdKe/7UQsHCeYDjejVyKbb0mXIDhs4W1WZ1pn+xBNTVUTOgTgPl5LyAaLy9lHPH/6Lnj+mWMYAz7/8piIkpsCBUoE404f/RZXMaz9MgLsH+4K8Jp/RJAxynhvJemRi6NHo3ULfl5EpDYwtQcADxiRgfN+m5cDGxAttjijNQUtv9bKyIO4OFYLf6Do1EloW/rz6S59Vk8CATLYs5v/x+RwJvjM8OVdfIUfKAQ==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:41:00 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3%7]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 09:41:00 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Topic: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Index: AQHY3iTzGqk+LW8EIUGun7Nw/Ps9r64KnHmAgAAG3wCAAwJ9gA==
Date:   Fri, 14 Oct 2022 09:41:00 +0000
Message-ID: <024da76e187a1043fcbe47a1ddc32283ab22c0d2.camel@nvidia.com>
References: <20221012102511.3093-1-jilin@nvidia.com>
         <Y0aikRq2Yi5kYW9j@kroah.com>
         <d219eb55-ebea-091e-d9b0-3881bd4525bf@nvidia.com>
In-Reply-To: <d219eb55-ebea-091e-d9b0-3881bd4525bf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: 3f8b8324-be41-46c3-7edd-08daadc83426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /tUVXsVR5PxLgVtL9ay76ZD8jNmmxmcLoX/hR/Dg/2Bc6efHSm7Ahp+/K2JsRLRqxXpCI/rLX/PDpfq3mXc2R/ggsS3tSnJXByOg5CtAYabGKGKqjC8+tuNg2pQYzNCxv6mV9VOrdLUCLAj8OVs4cwWt2Va1wzYq+RDZK99xXG4ILOHgNCV57wy49jnhts5NgASdVjPz+bCd/S65bU1syGv7OLnfFMh9uA3rhreqGi2AXRj67vTsWtbkvCRSyuFVDDs3tqHRRip3WkTv7C8lPHuXBZkEyWHFASkfW8aXZGcLrRPJJZPpXNYI1ELrUHKMopezncnTgCv2mPlacehyLCk0m0Q6nuL84Av1N48ULA+50SPF99K+IeAwtjiKtW/1+BrYwKHV9/f99YlXMf0cecEgzKSGEEhcwwQpGz/db32Z3GuGGR/qEnr11KwbuCHO9YHMJO/EJaAn5GIFdWQOnzyAe4h/ihLZqlPNPUGf2FVFJ3Ah4iUMdSWnq3rgZ/+MTS5CwMYubn5FgAgxF9nacXdBDAmdSyltubWUltJzwh03vvrISA9CZdwIV6uhWbdamA8iJxO5+Qb0jn7vQmnTC0eyDs6UVauwgSq3AXoJsa1xJisFGVACR08mMOyLqLZ9dWzaRPHvbfUncPc+qH0gqFxTq6THxL1dobahDsi4juVX9BQZHUkPUhCu/4fPlE5moOFDGWN/eHvVpDSGWc1ET1iclnXNthjv/4MzaEe4b6OtUxWTT7xHMik6aX9maQFNn8TJlKivzaaefh+imC7CU4RNfsrqyV9CWQa5CxLMxFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(2616005)(6512007)(26005)(4744005)(186003)(4001150100001)(2906002)(5660300002)(53546011)(6486002)(6506007)(110136005)(316002)(54906003)(71200400001)(76116006)(91956017)(66446008)(66476007)(8936002)(8676002)(4326008)(41300700001)(478600001)(66946007)(64756008)(66556008)(36756003)(86362001)(38070700005)(38100700002)(122000001)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmNrOTR1VWxiZmRsRGtjTmEyQUFzWlp1OWUrTDZRSFJpMlBscmRFb2s0KzlE?=
 =?utf-8?B?dmVQNHVWa2JYcnBua1lYajBBVzVDTldOMmZJK2o2RXF6ckIrNHRtdWc5TTh4?=
 =?utf-8?B?OUpkQVZ1ZEpQMFFKT0NzQ1Z5c2FJc0dqRWIyMVFiOW01RVBGM3Q4djVYNW91?=
 =?utf-8?B?OU9lR1VQeDExZWpXQ1pxcjFqWXphQVR6NERUSGtpM1FBWTU1UWZRcFgzODNn?=
 =?utf-8?B?Y2lvZ3AzSGpBdDdWSmx2TmRHUW5XL0xpYXhpUkFXcVQ2TFN6V0FNMEI5ZHpO?=
 =?utf-8?B?aHBmSmxkV3AwZGZxR0J6OGNrVUJNK2hHZEE4U05LWWZteTY2cURFeHB4N1BD?=
 =?utf-8?B?RWM1a1dmc0IzeWp6Sk9Qd2lMWGlsK1U4am0yNmxQcXFkWWdESUFWNlZwaWYr?=
 =?utf-8?B?YkVBN01pQjBxTUlpQjJ3RTlHUVBRRlhlR0h3MklsTUxQQmpoL1M1UGkvb3dF?=
 =?utf-8?B?Q1ZxTW1JaEdtOXhHUnF6K3hFenhGSjJ3MHlZZGVXL0EvZk1leGRsOVIvY2tk?=
 =?utf-8?B?U21LV0o0VDhpSU50ZlVWTFFaRVpkMkVLZ2lZQ0RtL3RsVzBpK1Y3RTNIRTRC?=
 =?utf-8?B?c1MyQjJ6QnNLcEJMaTU0UjlsNldna0ZzczFWaGV0bHI1WmFBTVZXK1Q4c2ZE?=
 =?utf-8?B?MGhSbnNiSHdRSGhpLzNrQzh2NEVHY0kvYStrQmVnWEduYUhzS3ZxaW0yaEZ0?=
 =?utf-8?B?a1ZEMDJqbkwyU0hGRW9xVkQ5dWdVcFVRdUIzMlFVYVFuRWxLQ3QzWTZmZk9p?=
 =?utf-8?B?OXdyUFg4RDAxTnJuNkdrSG14TUpBNWhSbXducC9Ock1GS3M1a0oyUzV2dlNU?=
 =?utf-8?B?VFVjaW1HOHRuYW50L25hcGpOSk5LMExVZlJ4dDhUa1duSU1NOFlxZXhZZG45?=
 =?utf-8?B?Q1d4ams0L1N3M2gvUDlsbnBHQXBjRjNzLzN6cCtpeU1OT2xpVUVzYXlyTTJx?=
 =?utf-8?B?YW9TcElYRFpsQTB3dXFoZlFtSFpyblZRRGJMaG1HSlVDcDlPQnErclZKQ3dt?=
 =?utf-8?B?bCt3RG5OVFJmZVQrbGNVbFU2TFQzKzZFTjc0K1I4cHJTK2cyTC9yMjYvZUdP?=
 =?utf-8?B?czFCbG9wMWtIa3ZuSGViek9FM29zS3ZvaEFBWURNZHQ4b1dKVGFHblMraEdu?=
 =?utf-8?B?L3lNQ2lvRWlPNzFGbVFicWdIWW9rb211RmpsYng3YlZjUnBkWDZ6dlVlYVUy?=
 =?utf-8?B?bnpRWm01MmJkbVlnN21zbXRQQ1hnL200OWp2MlJaZm5oZUkyenpSTTFMV3h6?=
 =?utf-8?B?OGVUWTJSRUtvRUFGM1h5SFlSd0JSbzJJRUlieWZGMFJFVlI5TWZjRWNkVmNP?=
 =?utf-8?B?V2F2L0pWcXcrR2QvRW5nUlVqbGt0SjgwZlpYaldmODhQTDMxYlMzNXg3NXE3?=
 =?utf-8?B?SjRkODJsZXRMNmdHVm9nY0FqRHdJYkFRV0V2L0wvVHQ5Qi83QWFEK0hHWUJl?=
 =?utf-8?B?bjA5S01zWkZzV0wydDlwQVRkVFFPRkFHZjQxU2NPZFJOODB6eVREd0lYSi9C?=
 =?utf-8?B?TFBpT1Fzbmd0RzJ1Z0RMWnRpUDQ0KzVERkZidjFiZ3ErY0tRTjRTRUNYc2pR?=
 =?utf-8?B?M25qVTM0ZFZSV25BeWU0MkpJOWVhcGFIU0NHSWlSMC9CYUNGWUlib2doZTVQ?=
 =?utf-8?B?UmhLdXRpY1lubnNtdUM1UVJrN3NXNldKbmxSa1ZXdk85TXZ4aGtxR2JZTWIx?=
 =?utf-8?B?em11dVRpc0Y4bDZwTUJaNWJTeHp0UEQ0WW55d3FsZGpEY2c5Z1JSM3JnV3Zv?=
 =?utf-8?B?MUw0WnE5TGw0MWsvNmpyTlVqZ2FIcUxwbUc5V0MxVGQ4Q3pBbzcwWWc5VC8w?=
 =?utf-8?B?T0RQbFBCTlhrYytEKytONDh2b2dkaEJEeHBzcnZiZDVhQmJIRmQvWTUrWG1Q?=
 =?utf-8?B?cWh3TEFxcWpzQzF1QzF5b1FPelZSYUFuVnFma3NKZkFEOFNOUE4xM3lya2tU?=
 =?utf-8?B?VFhTemlzT1dtbS8zNU4zYTNaRGNDMnZuR0RoWWE0Y29hRS9Ic0FYayt6SkN4?=
 =?utf-8?B?VjAxcmFVTHM5OU5UVlZqSWxSVmE2L3NJV09FdngwVC90dzlZditiekRRQ1lZ?=
 =?utf-8?B?bUhkWXAzUnhCaWswb2p3bzBUQzBWWXhPRTdSenVLWU5jTVQwWkNNZVFHaXh1?=
 =?utf-8?Q?xXF5xR3e+kqZzWxsqmRfyIKiA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16EA3FE6639CAF478646174442649DCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8b8324-be41-46c3-7edd-08daadc83426
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 09:41:00.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8fNa11p2YAlUog5XsBRGG1ulxC78lCaca2oaxVuVFIRuMFl/hBDpUifCTjlsg2FwCCycOGKHVfNArek5hGwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDEyOjQzICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAxMi8xMC8yMDIyIDEyOjE4LCBHcmVnIEtIIHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDEyLCAy
MDIyIGF0IDA2OjI1OjExUE0gKzA4MDAsIEppbSBMaW4gd3JvdGU6DQo+ID4gPiArc3RhdGljIGlu
bGluZSBzdHJ1Y3QgdGVncmFfeHVzYiAqaGNkX3RvX3RlZ3JhX3h1c2Ioc3RydWN0DQo+ID4gPiB1
c2JfaGNkICpoY2QpDQo+ID4gPiArew0KPiA+ID4gKwlyZXR1cm4gKHN0cnVjdCB0ZWdyYV94dXNi
ICopIGRldl9nZXRfZHJ2ZGF0YShoY2QtDQo+ID4gPiA+c2VsZi5jb250cm9sbGVyKTsNCj4gPiAN
Cj4gPiBObyBuZWVkIGZvciB0aGUgY2FzdCAoYW5kIGlmIHRoZXJlIHdhcywgbm8gbmVlZCBmb3Ig
dGhlIGV4dHJhDQo+ID4gc3BhY2UpLg0KPiANCj4gTWF5IGJlIGJlc3QgdG8gZHJvcCB0aGlzIGlu
bGluZSBmdW5jdGlvbiBjb21wbGV0ZWx5IGFuZCBjYWxsIA0KPiBkZXZfZ2V0X2RydmRhdGEoKSBk
aXJlY3RseS4gSSBvbmx5IHNlZSBpdCB1c2VkIGluIG9uZSBwbGFjZS4NCj4gDQo+IEpvbg0KPiAN
ClRoYW5rcywgd2lsbCBkby4NCg0KLS1udnB1YmxpYw0K
