Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2066E728723
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjFHSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFHSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:25:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6E1FDC;
        Thu,  8 Jun 2023 11:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GREZMWydfsdnxpGI8g8GIQz7X56stDteW6xS0vw66g7CbSQ39RgKcUC43M9GquwiyRuJ3ummkEfnsoMHetQmXus9bx1otO1JwuNk21RzHxJkDbcbEmvP/sp8VOOyUpJq18gAPBN88iUeDs7aIhJe78XCM6MrDhHxrF5I7PhPLaKGe9lP/ztpAyHbDnE+8xh40tSHfLH3clD0NZC7WWN8vnyt78aYJ6E5tfXAhJjkYl88V1rJ0jx6mKasJTdIjhnrXeLhWqAbSbi2FmIvAcRcb4PhIjt+eeJiiBIUVvtDkKHwWCuuRyPG4R7r2vCqe/l12+NvAbkFjZGnFM9HLMej9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EAz/JO8o0z8BrG23wag7EtYnjnZyjgOanHdVaTNSBQ=;
 b=A90i0VpPDKM72wbwZ8gS+ERq7ZyvZpY+pMnH5NlKPRNyFG1iS7Rxxn8qbltyDwYyEwoMOBHVqsm9Sxqhyz7m8TtUY1rxPR0lPdsZb4DmaMLkZHpw0hg8NtjGCzCPd/fvvHQR6vR1TO7a9zHyjdyh4H18QQJ7RgMJt9uoVqUhDbxhfDOCk/o5MxY8FEwyo/REo8Z65uVjqr2wQGOJBpvj3WodQELgj8G2IYPgSjJYt27kpMnKeg6pHGEqaiUQFBXC4VyWhmd3nmUTmgvGPr8/uDUqKGJSFgkJDPGQ5qup9g9LCevZ2F4LJPrJnt9UntvGhqUkVf/mX/CulSt0RSNXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EAz/JO8o0z8BrG23wag7EtYnjnZyjgOanHdVaTNSBQ=;
 b=NRnZoTnSqyUmDBoKu8c+jNSWVmRwSc2gNBTP1HsO3rMC1STKE5xzmzTV3hBaIbA+qAaNsUNLCe/JJZcnkUB0zr38HvWwX6/PppEDVEoFy+xVLVra1F7va+AkrQ/Alt3ru9IF9bX4EoAA057bJQUgjnP6yOfyOYuWnFdD6KpLv4A=
Received: from CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 18:25:36 +0000
Received: from CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::1747:b643:24a6:1030]) by CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::1747:b643:24a6:1030%7]) with mapi id 15.20.6455.039; Thu, 8 Jun 2023
 18:25:36 +0000
From:   "Kannan, Baski" <Baski.Kannan@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Moger, Babu" <Babu.Moger@amd.com>,
        "clemens@ladisch.de" <clemens@ladisch.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ramayanam, Pavan" <Pavan.Ramayanam@amd.com>
Subject: RE: [PATCH] hwmon: (k10temp) Report negative temperatures
Thread-Topic: [PATCH] hwmon: (k10temp) Report negative temperatures
Thread-Index: AQHZjbgeStd3Ox1FN0ak11gIaKMq1q9oZLCAgBigoICAABOSYIAAMquAgAAFeUA=
Date:   Thu, 8 Jun 2023 18:25:36 +0000
Message-ID: <CY5PR12MB6432845EE4F8019062837FB88450A@CY5PR12MB6432.namprd12.prod.outlook.com>
References: <20230523204932.2679-1-Baski.Kannan@amd.com>
 <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
 <64e6164a-c874-403e-b899-45f741db2130@roeck-us.net>
 <CY5PR12MB64326FB8A8E84A2698FEBB4D8450A@CY5PR12MB6432.namprd12.prod.outlook.com>
 <866a6d6b-c75e-26d7-a323-f8840c1228c3@roeck-us.net>
In-Reply-To: <866a6d6b-c75e-26d7-a323-f8840c1228c3@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fb604a50-6de1-4b67-a950-e3933a2c0701;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-08T18:22:50Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6432:EE_|PH7PR12MB7140:EE_
x-ms-office365-filtering-correlation-id: e7ef54a4-f9d7-4f10-eac6-08db684dc13e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gsnkx1W2OftO03wAcDpS+rNl86VzeTumSpwvm0IrO0+bII5BmlX6v18LUEjEiK07jU+YV/US5XICW9tNjcWe2Dzi7Dq4pJugjiBH79YR0l/PFvUACuf+C0gWkuAmHE9XnHKuSk+6dRnAElDcP6pfmGovVvFDcllGBhNmOuckhnkyF2eAZ/pDcaUPsHX21TBv8dEAf/2cA5mRi4y4U4NcpruHsFycjrk2THy+3NsUgdb6fEyQVONHiT0P1x99sWy1eDF1J30jW9yzd4qqN36seK9uFnNwIFosdzBuXPnfOYbC9M9AFNjWacJACEk6xlru/v9R5gcJUDIXEWio+aNAF72Lx8I1RzjXLdECxVCbLkf3rZMG3HnVudsrnjTeY0z5pfSRDUGqfGJv/idGkRuNWfV0sHkO8hsWDW+F8qg42+05es371Zo4elMBtRFJoHnuFtBzj7R0iDRNuAhyHC02BTlm0stS2F0VdW3PJiKUm+6nqsnKnoLD6qWU5cbMU+oh53K4IuWhVwrUmJ3FFB3yZaOsK8LzZkrIlMapzq2EJw/ZE9ZEFtBEJrdgt5lulgTOfzJwNsCVkNni7XLwvwJqFZCpTmSPWdy+uKkkjXMqxrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(83380400001)(478600001)(33656002)(55016003)(8676002)(41300700001)(8936002)(66476007)(66946007)(64756008)(66556008)(76116006)(316002)(86362001)(6916009)(38070700005)(122000001)(4326008)(38100700002)(5660300002)(52536014)(66446008)(71200400001)(54906003)(2906002)(7696005)(26005)(966005)(186003)(9686003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzAxRVhEeXI3OXBjcC9CRnozdk13ZWxKYW40d0UzMHk0cDMwdHE4U1oyYzdv?=
 =?utf-8?B?b2FzWHdXTkJMWW5XRVc3VFNpSnUyNmRuMmNtU2drTFh4YytmYy9kRFlRQVpW?=
 =?utf-8?B?Vnd3TmVZb1pYWTdzZGZZMDdab3VMbGRPcy9KQk56S0hKbFhBRHZWaWJOVWtG?=
 =?utf-8?B?TE95UU50bFBpN0hqQkR1NWI5bHZ1Vk5QdlNtOHgwSVZpTm9UL1h1TTZHK0Ez?=
 =?utf-8?B?Q2tROUptbURZb2x6eUpoZG9LUlBnZDVBYS95QWRHVVlDVXVJMTVWVUtmZ3hz?=
 =?utf-8?B?R3hTb0crSkxlNEFoN2dSaTU0UVJCaWI4c0xmRDN6R1RpdnBObHo3YlZrTmE3?=
 =?utf-8?B?SlBlbTNESVdHdnJpa283L3pCMnBKOXF5UXFBNW1GZzQzQUQ5RVVKT2dRTFlk?=
 =?utf-8?B?R2RLdmZORzdUTXV1dk1CN3NDNm1KU25pZU01UmJNdmp1NlBXMGIxL0RsSUlw?=
 =?utf-8?B?Vk4wQUhLcElBMU13SXZXdDFkVkI2L0cvVjFCYitsckJ0NFhuSGF4RndzdTBN?=
 =?utf-8?B?RjJzZTcxb3V2dUhXV3pMNlk3MjkyaEhsZFA5bFAxTG5Dd1djWi9FQVFXZ2tF?=
 =?utf-8?B?bEcwNkw5N0Mxb1dOL2twSTQ3a2RFc01RZzQvL2VvR2hTMmlwL2NGY2NZaG1T?=
 =?utf-8?B?dFkwcjBJZDlVQStHQzdxUkJjVW12YUlQbHg1QVVvU005V05qaC90cXQ5L0lp?=
 =?utf-8?B?cnVBOWo5cUxWUkZTbm0zT0d5clFBYnVLcmp1eEdNVFI5dG1TbFhhNHZLSHpr?=
 =?utf-8?B?NFdGcWFFa1E0YnJ2dkdtQVRNd2lnMFVjVWtpcUdKVzZ1aTJOQnVyTGNFbHNH?=
 =?utf-8?B?TGVNOFdyMXZVZ3pIS1ExWDJSMm1hMGdtaHhuQkx4K1EyaGpodzBpU0VvZW9C?=
 =?utf-8?B?UWcxclZHclc0Z0I0U1U0QWhzbW01Q2hPTEpNWnpVOXVVeVN3dzRhL25rTjJR?=
 =?utf-8?B?b1Mvakh3VHNzZUloNEFnd3AxYkxGVzZ6NlRiMkpJM1kvYThaZnNlTzRRdndG?=
 =?utf-8?B?L0FTVy9ZZERjdlg5NmhhWGNob2c3c3JwT09uWnNRUzZ0QkRzS1Y3NURLNVYz?=
 =?utf-8?B?NWZlcndPNmN1bURCK2cydGNheTd3NlZqcUZxdWY5Tk5FZXJLdHJNc0xKclBl?=
 =?utf-8?B?MXphTFdqaG80amdrOUlCdXFyM1oyanFNZGlhS1JZNjRsVUZlVGw5dHdQTWZD?=
 =?utf-8?B?RXJuTVhyMjhUdHk2VnpsaTJTZDg4Q1NpSUZqVFF3T1NKTDRyeXVaOGl0WTVE?=
 =?utf-8?B?TUdCL2QvTjhIaW9qZWU4REp2N1FvOENneUVMdktkdHo4R0M2b0NSWmFhYTE0?=
 =?utf-8?B?c0xGSllXMUVoaldMUXMveENxRVVpTlhvRlZKaVA0OWRsYUFlcGlxMWZVcnZL?=
 =?utf-8?B?KzFuSHgwcE16aVppeEExK09UQ2c1Ym5LdGFCYWw0YTVoZk93SGFMeHE0MW9O?=
 =?utf-8?B?UjcyL0lLWnVZVHI5d2ZmREFFSU02VDZUVnRZNGJ2VUd0T2gzRVZtejc4OHlV?=
 =?utf-8?B?VUFSNHU2dmRLeUE2UE5BQ2lscFcwL21OZ1NKbVRhWUhoN0U3WmNpbUlTd095?=
 =?utf-8?B?MjF1MWRQWVFhQWpSaG5oWndGa1dSM2VvdEFUWnM1TTBSSm1kdy9tRk5vSStx?=
 =?utf-8?B?a3I3M0NJQW1pd1NVdk81SkZsU0FPUEpicWR6bHkxQ0Z1ZmUyQmMxKzIzaFp3?=
 =?utf-8?B?ZW1VSWJXL3ZiQUx4dmNLNnhmYWJWQ2RyV0svd0F2b0N6VGpTRit6RkNvSFBD?=
 =?utf-8?B?dWMrVG5pZllpeWZkUStrQlhSR2xuTFVIL2YwbWFlN3FJL0hTZHg5ZXNLQ0JZ?=
 =?utf-8?B?OWQrTzk0TUIyeVFQMlZYL0NDcU1lRnZkcHNGbW02VkV5ZVRkYUVUTXl5eDUw?=
 =?utf-8?B?bk56ekdvMnJOQnFrYU1rU1FtTWJFZnV4MytMVFVETDMzRnBHQWVYaU1EeXRm?=
 =?utf-8?B?M3JtcHhNVEVLOHFNN1Y1Zm5mUGhqRGVQMEdEaWlzNFoyRlhUZFJ6WC9iTDNC?=
 =?utf-8?B?aVBVdENXQkZDR0lDd1B4eEJFWUx5bTRtYTBqRjFFK1F1VkFNRnIxcS8rY2F4?=
 =?utf-8?B?eEx3c3JVUU9ZY0hHRm1EcG1ZWThOVzRFbjUrSmNRdXM4dEhySDZ6M1Fncndp?=
 =?utf-8?Q?vpL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef54a4-f9d7-4f10-eac6-08db684dc13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 18:25:36.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8BjQk/azFJ9Q5w05Uvos5+N7W2fWPt/XrzICTyIrhRm0mPvutLgq0N2c33G/Bnb7Mt3mSqD+HHqu5M4VNZZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRvIG5vdCBzcGF3biBhbnkgbmV3
IHByb2JsZW1zLCB3ZSBjYW4gZ28gYWhlYWQgd2l0aCBvcHRpb24gMi4gIGkuZS4sICJkbyBub3Qg
YXBwbHkgaXQgdG8gcHJvY2Vzc29ycyB3aGljaCBhcmUga25vd24gdG8gX25vdF8gYmUgYWZmZWN0
ZWQgYnkgdGhlIHByb2JsZW0uIg0KDQpUaGFua3MNCi0gQmFza2kNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwuY29tPiBPbiBC
ZWhhbGYgT2YgR3VlbnRlciBSb2Vjaw0KU2VudDogVGh1cnNkYXksIEp1bmUgOCwgMjAyMyAxOjAz
IFBNDQpUbzogS2FubmFuLCBCYXNraSA8QmFza2kuS2FubmFuQGFtZC5jb20+DQpDYzogTW9nZXIs
IEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT47IGNsZW1lbnNAbGFkaXNjaC5kZTsgamRlbHZhcmVA
c3VzZS5jb207IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgUmFtYXlhbmFtLCBQYXZhbiA8UGF2YW4uUmFtYXlhbmFtQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBod21vbjogKGsxMHRlbXApIFJlcG9ydCBuZWdhdGl2ZSB0ZW1w
ZXJhdHVyZXMNCg0KQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRl
cm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMs
IGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KDQoNCk9uIDYvOC8yMyAxMDowOSwgS2Fu
bmFuLCBCYXNraSB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+
DQo+IFRoZSBwYXRjaCB5b3UgaGF2ZSBtZW50aW9uZWQsIGFlZjE3Y2ExMjcxOSwgc291bmRzIGxp
a2UgYSB3b3JrLWFyb3VuZCBmb3IgYSBwcm9ibGVtIGZvdW5kIGluIHNvbWUgUnl6ZW4gVGhyZWFk
cmlwcGVyIHByb2Nlc3NvcnMuDQo+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoaXMgd29y
ay1hcm91bmQgKGFlZjE3Y2ExMjcxOSkgaGFzIGJlZW4gcHJvdmlkZWQgYXMgYSBibGFua2V0IGZp
eCBmb3IgYWxsIHRoZSBwcm9jZXNzb3JzLg0KPg0KDQpEdWUgdG8gbGFjayBvZiBiZXR0ZXIga25v
d2xlZGdlIGFuZCB1bmRlcnN0YW5kaW5nLCB5ZXMuIFNlZSBodHRwczovL2dpdGh1Yi5jb20vbG0t
c2Vuc29ycy9sbS1zZW5zb3JzL2lzc3Vlcy83MC4gVGhhdCBkb2Vzbid0IG1lYW4gdGhhdCBhIGJs
YW5rZXQgcmV2ZXJ0IHdvdWxkIGJlIGFwcHJvcHJpYXRlLg0KDQo+IFRoZSBJbmR1c3RyaWFsIFBy
b2Nlc3NvciBpbiBxdWVzdGlvbiBpcyB0aGUgRXB5YzNrIGkzMjU1Lg0KPiBBTUQgRmFtaWx5IDE3
aCAoYm9vdF9jcHVfZGF0YS54ODYpDQo+IEFNRCBtb2RlbCAwMGggLSAwZmggKGJvb3RfY3B1X2Rh
dGEueDg2X21vZGVsKSBNb2RlbCBOYW1lIC0gY29udGFpbnMNCj4gc3RyaW5nICIzMjU1Ig0KPg0K
PiBJdCBzdXBwb3J0cyB0ZW1wZXJhdHVyZSByYW5naW5nIGZyb20gLTQwIGRlZ3JlZSBDZWxzaXVz
IHRvIDEwNSBkZWcgQ2Vsc2l1cy4NCj4gV2UgaGF2ZSBjdXN0b21lcnMnIG1hY2hpbmVzIHJ1bm5p
bmcgYXQgLTIwIGRlZyBDZWxzaXVzLiBUaGV5IHJlcXVpcmUgdGhhdCB0aGUgY29ycmVjdCB0ZW1w
ZXJhdHVyZSBiZSBwYXNzZWQgdG8gdGhlaXIgdG9vbHMuDQo+DQoNCldlIGhhdmUgdHdvIG9wdGlv
bnM6IEVpdGhlciBsaW1pdCB0aGUgd29ya2Fyb3VuZCB0byB0aGUgbGlzdCBvZiBwcm9jZXNzb3Jz
IHdoaWNoIG1heSBiZSBhZmZlY3RlZCBieSB0aGUgb3JpZ2luYWwgcHJvYmxlbSwgb3IgZG8gbm90
IGFwcGx5IGl0IHRvIHByb2Nlc3NvcnMgd2hpY2ggYXJlIGtub3duIHRvIF9ub3RfIGJlIGFmZmVj
dGVkIGJ5IHRoZSBwcm9ibGVtLiBFaXRoZXIgY2FuIGVhc2lseSBiZSBpbXBsZW1lbnRlZCBieSBh
ZGRpbmcgYSBmbGFnIHRvIHN0cnVjdCBrMTB0ZW1wX2RhdGEgYW5kIHNldHRpbmcgaXQgaW4gdGhl
IHByb2JlIGZ1bmN0aW9uLg0KDQpObyBvbmUgb3V0c2lkZSBBTUQga25vd3Mgd2hpY2ggcHJvY2Vz
c29ycyBtYXkgb3IgbWF5IG5vdCBiZSBhZmZlY3RlZCBieSB0aGUgb3JpZ2luYWwgcHJvYmxlbS4g
SXQgd2FzIHJlcG9ydGVkIG9uIDE5NTBYIGF0IHRoZSB0aW1lLCBidXQgaXQgbWF5IGV4aXN0IG9u
IGFsbCBwcm9jZXNzb3JzIHdpdGggdGhlIGFiaWxpdHkgdG8gc2V0IFNlbnNlIE1JIFNrZXcgKGFu
ZCBwb3NzaWJseSBTZW5zZSBNSSBPZmZzZXQpLCB3aGF0ZXZlciB0aGF0IGlzLiBXaXRoIHRoYXQg
aW4gbWluZCwgdGhlIGZpeCB3aWxsIGhhdmUgdG8gYmUgcHJvdmlkZWQgYnkgQU1ELg0KDQpHdWVu
dGVyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2Vj
ayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6
IFRodXJzZGF5LCBKdW5lIDgsIDIwMjMgODo1MiBBTQ0KPiBUbzogS2FubmFuLCBCYXNraSA8QmFz
a2kuS2FubmFuQGFtZC5jb20+DQo+IENjOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29t
PjsgY2xlbWVuc0BsYWRpc2NoLmRlOw0KPiBqZGVsdmFyZUBzdXNlLmNvbTsgbGludXgtaHdtb25A
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGh3bW9uOiAoazEwdGVtcCkgUmVwb3J0IG5lZ2F0aXZlIHRlbXBlcmF0
dXJlcw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVy
bmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFR1ZSwgTWF5IDIzLCAy
MDIzIGF0IDAyOjQ2OjQ2UE0gLTA3MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+PiBPbiBUdWUs
IE1heSAyMywgMjAyMyBhdCAwMzo0OTozMlBNIC0wNTAwLCBCYXNrYXJhbiBLYW5uYW4gd3JvdGU6
DQo+Pj4gQ3VycmVudGx5LCB0aGUgdGN0bCBhbmQgZGllIHRlbXBlcmF0dXJlcyBhcmUgcm91bmRl
ZCBvZmYgdG8gemVybyBpZg0KPj4+IHRoZXkgYXJlIGxlc3MgdGhhbiAwLiBUaGVyZSBhcmUgaW5k
dXN0cmlhbCBwcm9jZXNzb3JzIHdoaWNoIHdvcmsNCj4+PiBiZWxvdyB6ZXJvLg0KPj4NCj4+IFRo
aXMgd2FzIGludHJvZHVjZWQgd2l0aCBjb21taXQgYWVmMTdjYTEyNzE5ICgiaHdtb246IChrMTB0
ZW1wKSBPbmx5DQo+PiBhcHBseSB0ZW1wZXJhdHVyZSBvZmZzZXQgaWYgcmVzdWx0IGlzIHBvc2l0
aXZlIikuIFRoaXMgcGF0Y2ggd291bGQNCj4+IGVmZmVjaXZlbHkgcmV2ZXJ0IHRoYXQgY2hhbmdl
LiBHaXZlbiB0aGUgcmVhc29uIGZvciBpbnRyb2R1Y2luZyBpdCBJDQo+PiBhbSBub3QgY29udmlu
Y2VkIHRoYXQgaXQgaXMgYSBnb29kIGlkZWEgdG8gdW5jb25kaXRpb25hbGx5IHJldmVydCBpdC4N
Cj4+DQo+DQo+IEFueSBjb21tZW50cyA/IEkgYW0gbm90IGluY2xpbmVkIHRvIGFjY2VwdCB0aGlz
IHBhdGNoIGFzLWlzLiBXaGF0IGFyZSB0aGUgaW5kdXN0cmlhbCBwcm9jZXNzb3JzID8gSXMgdGhl
cmUgYSBtZWFucyB0byBkZXRlY3QgdGhlbSA/DQo+DQo+IEd1ZW50ZXINCj4NCj4+IEd1ZW50ZXIN
Cj4+DQo+Pj4NCj4+PiBUbyBkaXNwbGF5IHRoZSBjb3JyZWN0IHRlbXBlcmF0dXJlIHJlbW92ZSB0
aGUgcm91bmRpbmcgb2ZmLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQmFza2FyYW4gS2FubmFu
IDxCYXNraS5LYW5uYW5AYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvaHdtb24vazEw
dGVtcC5jIHwgNCAtLS0tDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL2sxMHRlbXAuYyBiL2RyaXZlcnMvaHdt
b24vazEwdGVtcC5jIGluZGV4DQo+Pj4gN2IxNzdiOWZiYjA5Li40ODlhZDBiMWJjNzQgMTAwNjQ0
DQo+Pj4gLS0tIGEvZHJpdmVycy9od21vbi9rMTB0ZW1wLmMNCj4+PiArKysgYi9kcml2ZXJzL2h3
bW9uL2sxMHRlbXAuYw0KPj4+IEBAIC0yMDQsMTMgKzIwNCw5IEBAIHN0YXRpYyBpbnQgazEwdGVt
cF9yZWFkX3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCB1MzIgYXR0ciwgaW50IGNoYW5uZWwsDQo+
Pj4gICAgICAgICAgICAgIHN3aXRjaCAoY2hhbm5lbCkgew0KPj4+ICAgICAgICAgICAgICBjYXNl
IDA6ICAgICAgICAgLyogVGN0bCAqLw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSBn
ZXRfcmF3X3RlbXAoZGF0YSk7DQo+Pj4gLSAgICAgICAgICAgICAgICAgICBpZiAoKnZhbCA8IDAp
DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSAwOw0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICAgICAgICAgICAgICBjYXNlIDE6ICAgICAgICAgLyog
VGRpZSAqLw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSBnZXRfcmF3X3RlbXAoZGF0
YSkgLSBkYXRhLT50ZW1wX29mZnNldDsNCj4+PiAtICAgICAgICAgICAgICAgICAgIGlmICgqdmFs
IDwgMCkNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgKnZhbCA9IDA7DQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICAgICAgICAgIGNhc2UgMiAuLi4gMTM6
ICAgICAgICAgIC8qIFRjY2R7MS0xMn0gKi8NCj4+Pg0KPj4+IGFtZF9zbW5fcmVhZChhbWRfcGNp
X2Rldl90b19ub2RlX2lkKGRhdGEtPnBkZXYpLA0KPj4+IC0tDQo+Pj4gMi4yNS4xDQo+Pj4NCg0K
