Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C65B767D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiIMQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiIMQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:28:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D371AD9AA;
        Tue, 13 Sep 2022 08:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6rXnvQS3NqP8f3wt15CwPPTqV0UsgEbB5pH3pGCX7LaGbUwZcVbGA28BrDgmO8b/raDn3YWwY4h/FgboWE3/+uLGpUmkmgSux0vRV3r9+TwgpSZMvxYX20tbFpy9WAwazhh0ueUYwHPx3x3S6YVX4tEo9dhwg4f4p8tnsioPoeytlzJchQ4p7FmP1VfEJpIfzau4K44TEnIuHZv63CKE4Wx1yTNx7/NKOLH2ctZxiDJgI++wO97d0BjvN0MfRtb3Zg/Ymdu7/eurwFlsmLdGKJZTRsqO/iIrfIbgt+Sbogs6JFnlEsw66U6W5YBDta3Q51P+8hUobwDnDLvEc8sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4KNMBbgdXRGazV+5ddmAZYIqVdbZyhOtmb3DDtVY+0=;
 b=h24G1y5JSW1pZPNoDNhE5PZDz/IPYWyHnOGAE/8Uwccld7mD/M7AhOkEw/kIuxgdwdZ9QQncJD7xhQoR5AnAj12UXDsYaqoaj4f09d9y5+BED7cx22ZssM/2OWMQjXuNqzRhUMvg91yeXX3oalOJY5glDJsUJvP9ilXrTSutVCSWTo2DoeqALyGn5tmhcGkg4ReTukXAMbdC6zZ+UCvdERznnoYBPcQP43ywePdNcWgiTVVTsEhSUMa5QAGB3ZYoduXrpQdJPz5RQHMm27M4fseinjrozSlGcQFYYQ+gzwBX86MVafoF35n5WWo4dISIswhZ3qvBjq3S4gya7C1Nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4KNMBbgdXRGazV+5ddmAZYIqVdbZyhOtmb3DDtVY+0=;
 b=aHZ/gY6ADf+MIIjfDUhoAoct9GcES7Nalf3FgZTEq5uEO8s980x/tmArUgjA7CEJPUwumc8MYNmo8Pu4Iu8nh3dW5z0T3iTQqwmrUBcuw2TIPDkogND4/+lQSH+cZcbvLBfmuk5fg1Bs9DfH4qjZTNEIvSCwRdwdNST2VHUyLR0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:20:23 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:20:23 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Thread-Topic: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Thread-Index: AQHYxGvRM+wjOHeEFkmAjJvH2VLI6K3XcdyAgAYNI2A=
Date:   Tue, 13 Sep 2022 15:20:23 +0000
Message-ID: <DM4PR12MB5278239D8DA75734F511498C9C479@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
 <82b3b47a-c6f6-5d06-d1d5-3a1c132d80da@amd.com>
In-Reply-To: <82b3b47a-c6f6-5d06-d1d5-3a1c132d80da@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-13T15:20:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d7961d8-2de9-46fe-a3c6-23cacc90463e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-13T15:20:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 18150c70-e843-4fd4-8a5f-908f0f706726
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: 6f3bd895-bf20-472b-da98-08da959b7a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeC+vHV1M6F0Nxi8Ks2k8nO27FIVEPQKzI2wWUScB8Oyl405pFDqi8uVde9X47kGGbOSSWmUS0qscaYxWyfHWsjxTavQcDcUSiTy87F7IKFLTTYLcuokFvVL0Yr7IctP1rg5SeLndJCuAz/+Tu8K1ojYU8CTcGKsVW2Cu04horl1a1sujDq6eKUG6So9clRl2G1wAm6MEdr+lQmzPOLRrQ04BIqLFN8UJwUZ7243p/456Sx6E+Ww1CfwrVJh4cAEF5rzsojq/lt6wT4Iby9cYYKOpaD1kYLX6SFImvqbOOOFGIuDd0CZW7f/UGMAdrqTJ+g0f/nvTOb68b0eSs5CbNHRaTsuz9CcDxtsIfdaehCVgkvPJRTJZ4xh2Dkocj+1D+d4PNb1D76wbQbWHCl75jzjsT1ZiQpLUA/N4jKcJmhXPyAdQnnNSo2mxX1a8MNMk1kuK/+02unj0YEqiN4NIlv+JSHRWylijgPo0vs1X0yyNJnGGFswUHXaWzIL8lkjlt9giuGeY163w+BBEKqLmg6MKMqtgILlQ6VTL2ornyMg27dq49zPucN9kEUoqQ9O1Sgr5uavdy+ClwuACSotNR+gfPxlwcBnsqDxbYF1amCkDvUvNkRweozCPi+8mllJZyKoo2bXCy+v9BNZcx8ejXYfAbH+KBlk+4uuwWa3W5Dr/wHAw+jjWyhXpt+tn0BaulyegQD9jHBuM2EhopcYRKtZHquUGzOBdAXWiEoXesChZEmHpUsZAcmh0DwdgueaYeLKu1oOTyyyn3UsJPJGNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66556008)(478600001)(8676002)(64756008)(66946007)(316002)(110136005)(8936002)(66446008)(6506007)(2906002)(55016003)(186003)(53546011)(54906003)(76116006)(52536014)(83380400001)(66476007)(122000001)(7696005)(86362001)(38070700005)(9686003)(41300700001)(26005)(5660300002)(71200400001)(33656002)(4326008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3YrOWxZcWV4cjdzbHgwcWFXcVVOR1htS2pjblRnVHhpbHd3R0xBekk0eHIy?=
 =?utf-8?B?YjZXejJjUmovY1ZGYmEyb1RidXh1bHhZam92UEJJYTNrMElaWE1YcFE0M2hN?=
 =?utf-8?B?cFBFd1ZsMmg2Q1l2cUYxaDU3bWVjN25iVHhlN211SjU3NjBiM2g0SjUyOUp4?=
 =?utf-8?B?emNlcm1TL1RRL3gxQkFwMkc3VUpKZGFCa0xrYlc4Y2JKeEFLdkRFcFhEQVR6?=
 =?utf-8?B?MC9Wc3N6dHRRYXM4UzlBeDFIdTIxUkQ1SEE2L05QMVZVallheGJqeFhKV0k4?=
 =?utf-8?B?eG5CWE0ydlBIbHE3VG9FbGxlVWJSMklaNEN2NVZtZXFmbVFERXpIQ2t2T0k3?=
 =?utf-8?B?aTFIRDR4MlN2dFUySXBITkc2Q2o2V0xGR3RZZ1Vvd1RHOTZhYmc4MVZMZjhP?=
 =?utf-8?B?VVREd1pkV0N3dkhsa1hCTmtXaGZWcmV1anM3STI1OWIweTlQaXJoOEYzNjlL?=
 =?utf-8?B?TjhLKzlBM1lVNDloam9uZngweGMrTHdta2Z2V1hEOUpZNVFJUjFibWZ3V0Ez?=
 =?utf-8?B?OTdrU052SVRqa2xSVTV1Q01pYk1jU0Ezem04QTNoZnRjekRCUDBkQVMwNTRq?=
 =?utf-8?B?YWRHdy9yRFFzbXVrRzF1OEJSSlIvQ0o5WGIxbVMva0hTZVBkTzVlY09VWU9l?=
 =?utf-8?B?a09BUHJteDJUWEdnM2VMa1hHaThRN3plN1FHSDhXSjFDZ1hacVRrU1FoU0JW?=
 =?utf-8?B?NmI3c0tUcmJ4aVFWaGVaY1VldVlPYk1mVTdiMjdtT1Z2dUFrbE8vR0tSYVEr?=
 =?utf-8?B?RFNSM2JXQXU1QkFnalh4RnNjWkJJNnpWNXBOaWluWnp3bHVDWG9SNWZVdmdO?=
 =?utf-8?B?cERSSE1yVkhWY3JJTjVQMmlySGRlUjVFN3VGOHJJd29nb1M5REFrT1FTaXJ2?=
 =?utf-8?B?bERrTU9QODVDb2liM3JXM3BxdEtIU0RkbmhYSCtGcEZSejRSZXVUM2V0Zk8w?=
 =?utf-8?B?OXY1bjVPUzVEalZPbnlSaDI0NGROUXBxTW9iVWoxY205T3JmcnJTU1YzWjRW?=
 =?utf-8?B?Y25BdG51aWVQUllBSmVlN0V1UnJtckxsK0lxZUE5UU9NWS9sY3puWlV1ZXNG?=
 =?utf-8?B?cmZpaFBWUGV6TThDV1JXZVIrR0NyUEJIWm1KVTI2R1BBQVpwNEpRcDh5WjBB?=
 =?utf-8?B?dDZlWlNsbVByWVBsWktJZVJza1FmSnBQV3BjN3I2ZlhtTHBtVWF2cWFZZE1q?=
 =?utf-8?B?THIvVXByaFd6bTJqR2kzVE5KS1BVOVI4MXQybHVhaDR0QllsclF1a3NVNWZm?=
 =?utf-8?B?SFZMNHR4cVV1VGU5WVNvNG5QajlmMlZvUXpFMkJzbDJYeFgxWGlDaTdFYjYz?=
 =?utf-8?B?ZHU5UHhPTkJDT0pPZUV4VWFZTWptSDV3R2pEZ21rcUJMQ3E4Z1A1N3JNbTN0?=
 =?utf-8?B?NTdzOERyUUs4aUpHS2MwSXV6cEMxWG9Mb0FQdm5VSFN1WXJkSEZXSk8xaXla?=
 =?utf-8?B?cXF5enBDR2NsaHlRM2JXUGdueTJ4a1hqZ09hdjVLa1J5ZHdRcXdrMkhQUk5S?=
 =?utf-8?B?aWdONnd6VGJmQU5zOEVkRGV4eTZrYzBzRHR2K3h3RW9vQXBlcHBaK3k0bVRo?=
 =?utf-8?B?SFZiTmNMOHVUK2VVTDNvSWx6SWs0Y2F3S2dDbUU3RjNxU0VyTllNdEVlZzZK?=
 =?utf-8?B?WGw1Y3kycFNzYjROU1hKQnRZMzA3eDUzbkxQcVFrdGRhSGxJdTltOHlKWE4w?=
 =?utf-8?B?U2c1MVJaMGhxT1B1ZXhYbjRkYlB6MGNsd0VlYW1IaWdxVkUvSkdrU2daU2Fx?=
 =?utf-8?B?UitpckFpS2dOZkRpMHZGcVNzczlSMmIvRlYyNlpQU0lKTDFzVzVPOEw5TTlT?=
 =?utf-8?B?UkRaV0kveXZNNDNaMC9nNFVzZXJvRm5MaGtPL0tsd0RJVitIUzJ2OFJFZnBS?=
 =?utf-8?B?YXlxVkh4K1hYR241OVFyaElGa0ZreUhlQmJLRmg4ZjgvckErczB5L01Ea1hN?=
 =?utf-8?B?YnhJWnJNTUVKTEIwRUk1NVpRMmVsZUZHK2V2c2Rzdkh1OEVmeGR2eDI0bExI?=
 =?utf-8?B?a1gydVd1Qk9ROW1VY1h4dmhOT1hsUkg2TTBCdkJHSzhaMUlJQ2czUXZONzJZ?=
 =?utf-8?B?dGNHeTJ1d3BVNDlPY2d1Q0tTUWhxZUNLMG5nRUtaWlo3RlhQVjczdFY0Q1hx?=
 =?utf-8?Q?F9K0luZsImrhXDGjAUhlCLA8+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3bd895-bf20-472b-da98-08da959b7a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 15:20:23.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG2mql7rVvZxd7DfnOfWzJ3Zj0vv1EmNLNFnr+95wkWa5ijim4KBNHOMhfWbILxMdT/31m0mXTBgtMWWwGNCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMTAsIDIw
MjIgMjo1MyBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFl
bC5qLnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47
IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNo
YXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBT
dSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsNCj4gSHVhbmcsIFNoaW1tZXIg
PFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbg0KPiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LQ0KPiBw
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCA0LzddIGNwdWZyZXE6IGFtZF9wc3RhdGU6IGFkZCBBTUQgcHN0YXRlIEVQ
UCBzdXBwb3J0DQo+IGZvciBzaGFyZWQgbWVtb3J5IHR5cGUgcHJvY2Vzc29yDQo+IA0KPiBPbiA5
LzkvMjAyMiAxMTo0NSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBBZGQgRW5lcmd5IFBlcmZvcm1h
bmNlIFByZWZlcmVuY2Ugc3VwcG9ydCBmb3IgQU1EIFNPQ3Mgd2hpY2ggb25seQ0KPiA+IHN1cHBv
cnQgdGhlIHNoYXJlZCBtZW1vcnkgaW50ZXJmYWNlIHRoYXQgaW1wbGVtZW50ZWQgb24gWmVuMiBh
bmQgWmVuMw0KPiA+IHByb2Nlc3NvcnMsIGJlY2F1c2UgdGhpcyB0eXBlIENQVSBoYXMgbm8gTVNS
IHN1cHBvcnRlZCwgaXQgd2lsbCB1c2UNCj4gPiBBQ1BJIFBDQyBjaGFubmVsIHRvIGVuYWJsZSBF
UFAgYW5kIHJlc2V0IGRlc2lyZWQgcGVyZiB0byBiZSB6ZXJvLg0KPiANCj4gVGhpcyByZWFkcyBs
aWtlIGFsbCBaZW4yIGFuZCBaZW4zIHByb2Nlc3NvcnMgZG9uJ3QgaGF2ZSB0aGUgTVNSLCBidXQg
dGhhdCdzDQo+IG5vdCB0cnVlLiBIb3cgYWJvdXQ6DQo+IA0KPiAiQWRkIEVuZXJneSBQZXJmb3Jt
YW5jZSBQcmVmZXJlbmNlIHN1cHBvcnQgZm9yIEFNRCBTT0NzIHdoaWNoIGRvIG5vdA0KPiBjb250
YWluIGEgZGVzaWduYXRlZCBNU1IgZm9yIENQUEMgc3VwcG9ydC4gQSBzaGFyZWQgbWVtb3J5IGlu
dGVyZmFjZSBpcw0KPiB1c2VkIGZvciBDUFBDIG9uIHRoZXNlIFNPQ3MgYW5kIHRoZSBBQ1BJIFBD
QyBjaGFubmVsIGlzIHVzZWQgdG8gZW5hYmxlIEVQUA0KPiBhbmQgcmVzZXQgdGhlIGRlc2lyZWQg
cGVyZm9ybWFuY2UuIg0KPiANCg0KWWVzLCB0aG9zZSBuZXcgaW50ZXJmYWNlcyBhcmUgYWRkZWQg
dG8gc3VwcG9ydCB0aGUgbm9uZSBNU1IgcHJvY2Vzc29ycyBvbiBFUFAgbW9kZS4NCldpbGwgdXBk
YXRlIHRoZSBjb21taXQgaW5mbyBsaWtlIHlvdSBzdWdnZXN0ZWQuDQpUaGFua3MgDQoNClBlcnJ5
LiANCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDEyICsr
KysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDQ1MTI5NTI4NGEyNi4uZmZmMjk4NzQ0YThl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTEzMywxMiArMTMzLDI0IEBA
IHN0YXRpYyBpbmxpbmUgaW50IHBzdGF0ZV9lbmFibGUoYm9vbCBlbmFibGUpDQo+ID4NCj4gPiAg
IHN0YXRpYyBpbnQgY3BwY19lbmFibGUoYm9vbCBlbmFibGUpDQo+ID4gICB7DQo+ID4gKwlzdHJ1
Y3QgY3BwY19wZXJmX2N0cmxzIHBlcmZfY3RybHM7DQo+ID4gICAJaW50IGNwdSwgcmV0ID0gMDsN
Cj4gPg0KPiA+ICAgCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgew0KPiA+ICAgCQlyZXQgPSBj
cHBjX3NldF9lbmFibGUoY3B1LCBlbmFibGUpOw0KPiA+ICAgCQlpZiAocmV0KQ0KPiA+ICAgCQkJ
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkvKiBFbmFibGUgYWN0aXZlIG1vZGUgZm9yIEVQUCAq
Lw0KPiA+ICsJcmV0ID0gY3BwY19zZXRfYXV0b19lcHAoY3B1LCBlbmFibGUpOw0KPiA+ICsJaWYg
KHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCS8qIFNldCB6ZXJvIHRvIGRl
c2lyZWQgcGVyZiB0byBlbmFibGUgRVBQIGNvbnRyb2wqLw0KPiA+ICsJcGVyZl9jdHJscy5kZXNp
cmVkX3BlcmYgPSAwOw0KPiA+ICsJcmV0ID0gY3BwY19zZXRfcGVyZihjcHUsICZwZXJmX2N0cmxz
KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAgIAl9DQo+ID4NCj4g
PiAgIAlyZXR1cm4gcmV0Ow0K
