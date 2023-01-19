Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E56673286
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjASHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjASHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:33:18 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B41676C1;
        Wed, 18 Jan 2023 23:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EezQxkOJeF+Vx9V5bhnBDTFhkQh6D1L2jPXJLV7mLtoPMVyamRRAKAlNPyTji/zbYSXLYWtXr5/HM4uy9r0Ngo5l4oMFLYxgYtXm9uBcrApzRP8FnLFVMToKPtoMewK9usROBpGF0EKfJPsmQey1XPDqMn9NF+I+IE9WyNEVJHWdCXwtpOlxQDu0p8oOzAvE+f2QtBJBWTkIgMsglq/r/xfXaILTd05usv25oA8DEX2RsSIiVc2uBZsB0d6k3S8SwoeuZvxXIxvcMPRjgW6aPNhasBfAg6aSzIbsqSq4motV/vzdtlauDSMjdeBXQIf96WAnz0aJzGHpum5dhel7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcXcFAV+cn0RAm2cCl0nrGodqnCBh+P1k1RbeI6yk2s=;
 b=hhsOxqUPfiQ1z7QvPxxvdKuzE5KmPpj12VBlC0wGAqKF25qvKP+U89DNfQ8Xf/39wj7yjzr5d10Ili18vOnQtInV4ANW1YciohLolxtHjVbBoKo2uXDRcB6TH+D5imq1bbl8EFANhru0hxe2kk6VojwFZq8bDerSR70e540NKy3b4910kUKdgT6sp/e+uC/6MkFPSH1VX6subtBpEusHHaMVsm2Jp7B64rcTNMrclZdAE74IwBjsje60OfB4aiZgwZrCgwB+7QDaQJvqbLUTL+DgJQdwUOwKZ35MkZdvYQEZKmkX25V6JXFWJr6eVS1GNXU11XI14vzoCUpShqqdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcXcFAV+cn0RAm2cCl0nrGodqnCBh+P1k1RbeI6yk2s=;
 b=TXaW+N7DajF0kgGlzNg8C4jK3/QnywUg7houAsUqTLossnkXox54Ds+Mt8DjBJ8QuZDPY9Q8Kne+UCFPmVEa3Qgls8Rgr3xb6vMQ5LxcHX144ESgFLFYVTO4pMFG4OUDT/uWOEn9/PqxiRTWiAOaE/yPx/EA1P9iUx1G/nzkfHs=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 07:33:09 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 07:33:09 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 03/19] dt-bindings: bus: add CDX bus controller device
 tree bindings
Thread-Topic: [PATCH 03/19] dt-bindings: bus: add CDX bus controller device
 tree bindings
Thread-Index: AQHZKnmKvFQEkQFz/ECMo62YIPjOMa6i5IIAgADRRhCAAGowgIABOoiQ
Date:   Thu, 19 Jan 2023 07:33:09 +0000
Message-ID: <DM6PR12MB3082314793821CFB91C5A4FAE8C49@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-4-nipun.gupta@amd.com>
 <5ebee797-aa87-8db4-228c-dfe236ad32f8@linaro.org>
 <DM6PR12MB3082BE8616F773B990146866E8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
 <12358dd7-d600-0b2c-96ab-518ee2e65404@linaro.org>
In-Reply-To: <12358dd7-d600-0b2c-96ab-518ee2e65404@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-01-19T07:29:22Z;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP 2.0;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=07e3f28c-1e07-45cd-9b83-5cbf6a350d0f;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|DM4PR12MB5987:EE_
x-ms-office365-filtering-correlation-id: e1edafcc-fb49-4331-1c4f-08daf9ef69e2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcvppGfKxIRT6K8Y5QnV/lALATO+gwFcFDvqJ6S2uiDDjI2+UCws/ILSNk5e+kB+8+U1RfJrXYJjkf/Yl/2mL/xypiTUqjbkVWvPD43wjDh3O29Z69d1ujpMh7F3VaMhwBgjRkv2R0Zt+A5MhjMnP0ghbDJE/OOv5uJqXv8M0EPABh6it57foiUXCjiHjOgPBq/YtVx9KuD51hBMuZzFYP7stH3GvVnpSrbe/2pWBOW05bLbulC0Z3RcgHzMARVTHqObp1wVEBX+cI8oS1OYHkOV9wIQZzoo1HsCDrXNty2ykZhqfDzPap0VqCCB5bP1XoZQCId/sxhRfYj/Dz9/OkH0YQO67rZ+lpuzkS+MZ3Ynrj4kk0wvui3cs34pPswdJp05Wo1ujAy4oDzxW5suFhWVXDXzviYunExwpmrLziY03qHVrF6STNHsdhysLyP0kr0c5zS4QYCOYSxunvtGs4CRTxTrn5m8d5fpub0+ZzQ6HGVQGzpn5/fp8kxwBxoeDuPOcjS8zabNlDAkqXD7SF25jm1VcJyqt2xg3fsNmM/J+XwdInoeHhqaVGaL2v3fgLVE539RXcaKE9ky1HeyWCE71bu1Wzr9aokOdpnJYNgQPPd7czekM7B4CJJSCWG0YI2fAmNxL2aRh8LM6ceSl/vepaBupnVY266seZNv5aBuZ+nt6WpQsR4hQG4sb3nXUpDY3YzQTJ74xdpdiSNwjKUUoED8pnTybj6ur4gb7B8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(55016003)(33656002)(52536014)(4326008)(8676002)(41300700001)(66946007)(66556008)(66476007)(26005)(76116006)(7406005)(64756008)(5660300002)(66446008)(83380400001)(53546011)(8936002)(478600001)(9686003)(186003)(7416002)(6506007)(55236004)(7696005)(54906003)(316002)(71200400001)(38070700005)(110136005)(86362001)(921005)(2906002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFpoMjFCcVVQZy9WN0ZBbzBDYWVDM0FSRk14WGU4S0VOelJsejR6MEVSQXV3?=
 =?utf-8?B?TUpCWTF4UWZYellYclFXSUlFT0lvaFJ6VXRJQlJDWHRrcml3SVZrVi9nbk1G?=
 =?utf-8?B?N3AwZlVUdmpVRTR0QjhTMWc0a1AxeUZ3cFJFbmFoTzNtTVV5YlkwRzNnTXdU?=
 =?utf-8?B?QmxhSllGQ2JBSXpGN3FjdXFld2xTUkdET3ZEcE0xQ0c4Z3VvNjViME11eW1m?=
 =?utf-8?B?SDQ4ZGRNWTNZZ0JPbHZXc1kvb21ScC9DWHNRZmdHR1hTS0IwZGZVa2dGVWlq?=
 =?utf-8?B?bTBzcEtOTlAxZVluRUVTeFRubitFZEd2SGpmMDBlcG03NXFhUFA3L2tnZVlH?=
 =?utf-8?B?M0ZYY2pHRTRMY04xaGdVMXRsU1hPcCtQeVl5TzR4U2IrL0pwRnBiTnNVNHNH?=
 =?utf-8?B?ZkUrd0NPTGJLR01xcGlma25MMGdwbmdCZFREYnlzVElyVlBjRktUS1o4MVUy?=
 =?utf-8?B?eW1zcFJHdWRvRDhjVHV5VVlFbmtoL2ltbmlVaXBTV2FQZld4UjBhSEkxYzVZ?=
 =?utf-8?B?cmtuWFUrU2lDOFNMUFNqcmV2RjNBL3pyZi9ld0N1UGNYcEVZMFdJNTZLbUhB?=
 =?utf-8?B?c0dVemlhbG9ReitOQmp0Z0hmRFdXN3NFeExidm1IbHJoMGRqbUpNQkVVeXhV?=
 =?utf-8?B?Z2NVMFhFVmxzUjJxeDV0MXpnaUJUSXdHdHFacmdtbS8xZkpGYzV6R3pKcFBo?=
 =?utf-8?B?YXp0dmVNNUorM3lCc3BxZ3ZYWWExQjQzTEt1VUVTdlR5ZjBGWkdFUWh4L0hu?=
 =?utf-8?B?a29jUUhQaGEyQTN6MWFZU2R0SEJySE93WXpkRzJPN3gzSmZCTSt2SVduT1c0?=
 =?utf-8?B?c2xsWXJYVjV2cytKNDM0ZUdUTFFjTC94cTZTT2RSSzdkZW5XZ0ZNbUlxRzRp?=
 =?utf-8?B?VzJUUnFGMHVRektiZk1EdU1ZWnVmU09CU1VtSmRxdlZrYmhIMW5oZlpjcXNC?=
 =?utf-8?B?UW93S2ZGLzZhTnZFQkxjQnE4ejVaN0xERmJudXM3ekRoL01pTmQ1a2QwTnlz?=
 =?utf-8?B?S05tcTJiVkVOamJLL1hPMXIydi9FdG9FQzNNMS84N1ZMK1BISzg5Q1dzdDhx?=
 =?utf-8?B?SFRTOGFVUzdTdExjcENJOEt2YkRvUlo1QzlNZnl3T2xXTUZOa1VqWEdhMytJ?=
 =?utf-8?B?aE1CTkdrNktSdXpJbFBFNE5hLzdrTFVvM2dxb0NSOG5IVFhIWUcxTXdPL2RQ?=
 =?utf-8?B?d0xma3NrZGk5OTNvaDlnRnJkRy8vdTJwdjBwQzBhTWVvckZoY3pRRkZ1WUVo?=
 =?utf-8?B?VUlhMkVuWWFGME52VEJ3bFpTalVEMWNxYlpkWmFKdWVVY2dnNVBhMzVjaGJ6?=
 =?utf-8?B?NndGczBMQlh4eEpCT2VIVTE3UGJDMW96MnpWdlBNWCtVaStlR1JSaU1rT3hn?=
 =?utf-8?B?SHlLMjBJM1IvNEo5M29DRnAzWklqVWU5MllVL1dyOEc2SllKbHNIWFRNcTJk?=
 =?utf-8?B?RWRhOU1MUHpsbC9Pa2pUSjRlYkRMSHEzc3I5WVhqT2J1cE5nQmhTaWV2S0lK?=
 =?utf-8?B?YzMzRGp4YVUvdVdzVG5YbTdGdlkwa1o2ZkV3bVlIS2VYNFJaZEFoc3VaMCtS?=
 =?utf-8?B?Wnh2TjI2cm43d3UxV0lua0h0cmxqZDFFaDAvdTVDbGx5aXpYdmRQNDgwdHNq?=
 =?utf-8?B?NVB4MHBqbG41OXBzNDUxK3dWa3ZMamhPelR1S2hISERJSmptSUV0ai83MTlU?=
 =?utf-8?B?WE5TS1FKVkxFais5MDgrY0wva2JUVENIcnJaUnUrUEVJTk9xT25VTFdvOGtr?=
 =?utf-8?B?bDgxa3JTazJMUVJPMmV5ZXVsVW8za0ZZc0xkRzFKNG9rNjJSSGdURkZUQkJ6?=
 =?utf-8?B?VSsycUpsZjRHRTNGZDQ5YXlpK0o2VjR5MUhTZVd3Z0phV0xud3RqWGtEb0hN?=
 =?utf-8?B?ODQ2RVVqeFVKSjJxdUdqdlVCcjJ0SzVYN29FZGJmZzZqK0FlWXBVQ2g3OFVt?=
 =?utf-8?B?cjhib21FNm1jVG5JUDIvdUNiWEZveW1BMzVtZ2lhbkxlYXZxSXRtR0t4cVJw?=
 =?utf-8?B?VlA1cWI5RlFPeTJJRDdsNHhTTW92ZXBaNmJwWXg3b041UHU3ZFU0L2VabmEx?=
 =?utf-8?B?d1llSE8rbVU4TkpXQ24xaGJXNXhsR0J4THAyYlNYOVNmSkd4TTJzSzMwM0hO?=
 =?utf-8?Q?pVys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1edafcc-fb49-4331-1c4f-08daf9ef69e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 07:33:09.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maRrI3TmEKb4XrqPmvqZ2PLypOHYGPWCywa5kewMkmaGUwvnHMu+f5lbeilzpy22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTgsIDIwMjMgNjoxMyBQTQ0KPiBUbzogR3VwdGEsIE5pcHVuIDxOaXB1bi5HdXB0
YUBhbWQuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByYWZhZWxAa2VybmVs
Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsN
Cj4gY29odWNrQHJlZGhhdC5jb207IHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tOw0KPiBtY2hl
aGFiK2h1YXdlaUBrZXJuZWwub3JnOyBtYXpAa2VybmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5j
b207DQo+IGplZmZyZXkubC5odWdvQGdtYWlsLmNvbTsgc2FyYXZhbmFrQGdvb2dsZS5jb207IE1p
Y2hhZWwuU3JiYUBzZXpuYW0uY3o7DQo+IG1hbmlAa2VybmVsLm9yZzsgeWlzaGFpaEBudmlkaWEu
Y29tOyBqZ2dAemllcGUuY2E7IGpnZ0BudmlkaWEuY29tOw0KPiByb2Jpbi5tdXJwaHlAYXJtLmNv
bTsgd2lsbEBrZXJuZWwub3JnOyBqb3JvQDhieXRlcy5vcmc7DQo+IG1hc2FoaXJveUBrZXJuZWwu
b3JnOyBuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2J1aWxkQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBv
a2F5YUBrZXJuZWwub3JnOyBBbmFuZCwgSGFycHJlZXQgPGhhcnByZWV0LmFuYW5kQGFtZC5jb20+
OyBBZ2Fyd2FsLA0KPiBOaWtoaWwgPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBTaW1laywgTWlj
aGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzE5XSBkdC1iaW5kaW5nczogYnVzOiBhZGQg
Q0RYIGJ1cyBjb250cm9sbGVyIGRldmljZSB0cmVlDQo+IGJpbmRpbmdzDQoNCiguLi4pDQoNCj4g
Pj4+ICtwcm9wZXJ0aWVzOg0KPiA+Pj4gKyAgY29tcGF0aWJsZToNCj4gPj4+ICsgICAgY29uc3Q6
IHhsbngsY2R4YnVzLWNvbnRyb2xsZXINCj4gPj4NCj4gPj4gVGhpcyBtaXNzZXMgU29DIHNwZWNp
ZmljIGNvbXBhdGlibGUuIERyb3AgImJ1cyIgLSByZWR1bmRhbnQuIEkgd291bGQNCj4gPj4gYWxz
byBzYXkgLSBkcm9wIGNvbnRyb2xsZXIgLSBkbyB5b3Ugc2VlIGFueSBvdGhlciBkZXZpY2VzIHdp
dGggc3VjaA0KPiA+PiBjb21wYXRpYmxlIG5hbWluZz8gVXNlIG5hbWluZyBjb25zaXN0ZW50IHdp
dGggb3RoZXIgZGV2aWNlcyBpbiB0aGUNCj4gPj4ga2VybmVsLiBKdXN0IG9wZW4gc29tZSBjb250
cm9sbGVycyAtIFNQSSwgSTJDIGV0Yy4gYW5kIGxvb2sgdGhlcmUuDQo+ID4NCj4gPiBNYWtlcyBz
ZW5zZS4gV2lsbCB1c2UgInhsbngsY2R4IiBpbiBjb21wYXRpYmxlLg0KPiANCj4gTm8sIHRoaXMg
c3RpbGwgbWlzc2VzIGRldmljZSBzcGVjaWZpYyBjb21wYXRpYmxlLiBZb3UgZGlkIGlnbm9yZWQg
aGFsZg0KPiBvZiBteSBjb21tZW50IG5vdy4NCg0KU29ycnkgSSBtaXNzZWQgdGhhdCBwYXJ0LiBX
aWxsIHJlbmFtZSB0aGlzIHRvICJ4bG54LHZlcnNhbC1jZHgiLg0KDQpUaGFua3MsDQpOaXB1bg0K
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
