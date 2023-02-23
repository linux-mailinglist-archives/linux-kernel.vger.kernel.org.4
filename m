Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A36A108B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjBWT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBWT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:26:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CE1C339;
        Thu, 23 Feb 2023 11:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cby/2XQYqmT+DmhhMtd3j6CEo/n811/Jol3Qfu+9PbuKF86p3lrxrLqkfDeh9EVskKwAdCCLdXt1oGJqX2EqYcrvJoJl5lSy9PR1rU3PrzVlqDgbvp2VUNs5nWTg2ZiE1Db5kBB+ORYuMmeBElBBqNofW3gtpPvTE3ny84rezj4+3nbJgHWbdFZ1DrsA9dykyTKm5LgZ/p5rQ3m1wAGALCD96epn2EAwqYk+XTbvFtfHS1OpRAcsSIecGrWI7+BU3LBiaQYFLCwZKmxjq4z0T5Bg7jI9nyiQeD1DRA+0y3ELsplDb6bamkSg99tL+MOjliFUoKWXbLKEVGGUHCX4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PE/50Qj4vJv8XZflsQQa8+JE2tr6TFqjjaElao0G9Y=;
 b=KXvGMmIoWyyf+JZKsKqSWWXChEK7ts6UKQwM9VcbI0vyMjOa92cMfNicKO27Cmrl/Tcm6FBBYmDuu5qMLQNqStzj1yOBQF0ofBwCagUkAEq1tcI/Z1Nsh1yKxdtUYY+LQZmRvQhE8OAkYGv9QpsElo04F0pQ6aei1Z1DTiH1SCwhxHsm5rjZu9GSfd77XnCx2Y1J3rASh34kGjED5726arWSXjMFwuASQBZHgflEi9fbqdbiVAe4Qz4YMldvO8flHt7eWJjenLF+6P+8SI+hFkkwLpull/IcZyOP9t4tk1bDvLhZl/Md2RKKTLTUPM1lxY4+BNz2k43UPQbcuD1VPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PE/50Qj4vJv8XZflsQQa8+JE2tr6TFqjjaElao0G9Y=;
 b=ILpGUQ0Yo7SXGR22pUXRcDkNgzvSARO8YTdVPruRFACXy/L/E3r7SDAP0/RExaCiTb5KJqd6n8p086nRnX8l6nk6ey2rWvVYwDdvRV5He5cpaptKlNTPAgU7sAGuYCMAXFbydpPyGq3hHSmwHRhWNshz9e+2yufyiZmigLsnjhQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 19:26:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:26:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is disabled
Thread-Topic: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Thread-Index: AQHZRyaJWBW+f1tCHEOacts33tMoja7b+aSAgAAd/wCAANNcwA==
Date:   Thu, 23 Feb 2023 19:26:30 +0000
Message-ID: <MN0PR12MB6101524A5A51758A5CAF4A17E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
 <07827f74-0c63-259c-37ff-86905c496b71@amd.com>
 <CAAd53p52AkTLcuytA=hPCeQze_NRU0amLjc7eZq3+-0YahwGJw@mail.gmail.com>
In-Reply-To: <CAAd53p52AkTLcuytA=hPCeQze_NRU0amLjc7eZq3+-0YahwGJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-23T19:26:28Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=29131e49-6c63-4515-90e0-1f31675356f0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-23T19:26:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 126a42c8-8e02-45df-8746-d0573020b9c0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CO6PR12MB5393:EE_
x-ms-office365-filtering-correlation-id: 583b2b98-179a-4b05-e067-08db15d3dd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdJDZXXkoxgVTkUG0gLexIF1j/7WARq4Csfn+0IHluMqKnI5boKDo2aYFctazNacHyCqa8P34oTW0SxxHa49t9cVNsLfP2C3BhQbLrp/ZDuxnJtRznQu90vHgG8NxYTSE5mbwGTDuqNizjRlDkVREi1vOfmq/FmtvnKqXPshFLEZtwavjkTAemJw2e402VrzSH/d5BtSfpBUGM6I+P8iE2MEFkuv6l4SB9JiLY/Z7YHLl3GKkuefcUykiH0tq+XU2w7Uoyj3O8HAqhJKFV/K4TS7ewviYrSDZZWOYK2xRyzQ2L1my+vZ9H0FZhmsy1N2goNJygUSP3PgUfQzR/3WrjtRe8qd1LUDFklLs2UNcFjbU0W0Y86HWUpi/9rFuN6vEhGUunezlJBe1hbRN0p4Ll8YUMTi4MzS/h/IeeMhYaS71sBsAS5znOVldb9j3XiVhNiXgpbAnZm4u9yp/0qkPRE0X/3o9eDpCoiov8FGc68fgVb1WPfk/E0+AX7sMXk9xTU2UfwrHGDNS6v+y9F2ynOVNecxRD+IlhzPMQECkmU/hALMYwQzwnMKi4n91FyRFWFV3xIwxUVLbwZsKKguH/9d6+cw1D5ib0yuWVAgs179Kl4GVvpunB7fJlD1e+vwaLbGiAUnPavW2acTltMiRB7nxNFhxX/aYaMLvlrch3L2qD9AWN0ehkiDdiTPq0z7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(2906002)(66556008)(66446008)(64756008)(66476007)(966005)(33656002)(316002)(71200400001)(122000001)(66899018)(7696005)(41300700001)(53546011)(55016003)(6506007)(66946007)(76116006)(5660300002)(9686003)(478600001)(83380400001)(54906003)(8676002)(6916009)(38070700005)(4326008)(26005)(8936002)(186003)(52536014)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDcxTDViYlIyeFdoUldPTkZpSGg4Mm9SUWpEeDVBb21Senh4WEViOEt5QUU2?=
 =?utf-8?B?VVJwZWlMMW94bURLbEFDWW1PUm0xYW1yRXNWdWozZllmQjQ5U3pONjBwWUlu?=
 =?utf-8?B?NVlFMW1mQUgyOEZKNmJwWm93Yk01ZjRlMmQrdzVGZXVYengrdE5jOC9ROXIx?=
 =?utf-8?B?Mjc4bWtlWE9SMVE3Uzd6UEovTk1iVTJsUmlqaEpkNnprakJsMDBTYnBESHpp?=
 =?utf-8?B?NXI3MzRIdmVMNjY4QlVYSWNMdVNuMktzeXd2ZUlTQndldkRCZzlMUE5pd0Fs?=
 =?utf-8?B?NU9NU09rTFhSdFlJTTdvYm9zZjE2RERiMkhwMDYwaU1QeHZiN0k1M0FYS2JF?=
 =?utf-8?B?NFhUMXRGUWtOWVVMNGoxZUdNSGpwZExrNXJrbG5aend6Y0Vvd1BKNzdhQmNH?=
 =?utf-8?B?MERVbWhtWGd5TU1VR2QzRmV2dW9DWjE1S3N3b2o2SSszeFY1OEpzU0t2S3hT?=
 =?utf-8?B?SFpPQVlIcC8xVlJLbVpTbjRLdkhBb21LL1VHclFvWjVYWjFLYWozN1Bma1Rl?=
 =?utf-8?B?eXZVUDRoTkk0bUdvMDd5b1J5bFRWc29mYVBWWE9kQ3RuOStaNmpNRVMrS2VT?=
 =?utf-8?B?SzJDU1NOUGFncFNKVytHVThsb0g5TkdRckEyWjZzenFYRE5hVFlxNWlnSUp1?=
 =?utf-8?B?ZVpWWVNhNm41dFdhWWpzNmUxaG5nR1RwTlFDYzBwUTQyN0wvTnh1TzI4OC9y?=
 =?utf-8?B?M1h5c3NTdlFIUzAvZmZJUFg2cHBwOEE5ekR4ajBpNm9kalVCSUVxQzNNZFc0?=
 =?utf-8?B?TG1oQy90ODZBb3hJTDBaVVJWSlhoak81c1lrTGZBK2M4b1lLU2xheEhudHY4?=
 =?utf-8?B?V0RCUDBPRWRhcVQ5TjMrMnArbFFadmxEbjA2cmpXODlQR1kybWhjajNoRWxC?=
 =?utf-8?B?anFVMTlMWXpQT2lmNmo2RXViM25GOEl1NTJIRzRyOTNGS1pmWXF1cUZRRnhl?=
 =?utf-8?B?ZGxvZWVWenpiTXRqQWNFZHJyeWh1aGNhWlkwY2RQK1VvZisvY2o2SEdLNVBF?=
 =?utf-8?B?M0V4aGdnRVU5TVVoZWJZcVRqd3hHWHBZOC9xSkVyeGJlUmhXVjdDcktjVklZ?=
 =?utf-8?B?emtIak9RVk5xdC95UUd0S0lEd3NMRXJSdjZGN0RxZklQc0I5Qmoyc3BtWFBU?=
 =?utf-8?B?VUJ4OVIvblROQW12SnhGdEU1a0Z0U0hLOEJYaXBGb3hzWmxxS1BFem1nK2Ew?=
 =?utf-8?B?VjUxTzhWVDJBQk0yNGNKM0pGb1pITHVqY1o5TG0rK3dKbk9qdkxRdFdYZ2FF?=
 =?utf-8?B?Z2djTHFOWnZjRTZ3OVRONmVxS3JTd0crOGRudFJoNlJ6REI4OGkvaUFod1I3?=
 =?utf-8?B?ZEdwWFczOG1SNkJvNUdFTjg1SnJqc3V2TFZyRXdTMnhBUUlIMXc4OXI1SVYz?=
 =?utf-8?B?OW5IcWhJc2ZLYTlQTjIwbFhGaWZ5VU1uMkl4MGNlcjFOdkdoUG16cEhJZVBW?=
 =?utf-8?B?S3E1M25tM0UxOHdKczB4SWQwcCtEaDIwR1JXNm9LTUJyTk41UnF1Tlo0ZkVv?=
 =?utf-8?B?em9uUUVVcTE3d085WGFRVUpHdVF4Z25iWkpWYUhhblhSRm15c2JneVhxNzhw?=
 =?utf-8?B?TkFBL0hnaEhjb1hCR1ArNVRzYlgwaTR3RWh5Yi9LUVptRGx1RGlMRUtzNUY2?=
 =?utf-8?B?Q3pkM3BuWFVmMERuSERsc2xmTjgrUkcvZGs0M1NFRmZZQUp2ZFgwVDlXT0Z6?=
 =?utf-8?B?L3ZXNGVuRHVwa3o2RytKQThJQXlMRGxqS0FyYnRvaEtXOTdrYkpna1dlWEp1?=
 =?utf-8?B?WjUvZEVKd1dDMXJvYWpUUnhVMHN1NHlDbGtMU252Ujl4M0JhRlVHMjZJbmtS?=
 =?utf-8?B?MmZzV0VjRFVMekpuQUFXUmt2T2hGWk4vWmlic2VzL3pRMmNEUjFjekoybVNl?=
 =?utf-8?B?dTE0Y21wamUyMXhNbVBHSXBEdUJ6VGJBNjlwYUtVeVBLYkdFT2cvT0k3eHRP?=
 =?utf-8?B?U29mK0xKWkVQeEw0QTlMQmZRenNSV1E5S0UyZThQZ0s0U01IaWh5TVhiSXI1?=
 =?utf-8?B?dWZJbkl1VnFBZUpSbWZleDJhUjFpQmlndWxhalZXbDlOaWpEMVYvcUVNRW1z?=
 =?utf-8?B?UHZXclgyZkRCUEdMd0ZhazJvSXpXMndXM1RCdmRuNzRLZnNGYVhTVCtHS3FL?=
 =?utf-8?Q?oDs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583b2b98-179a-4b05-e067-08db15d3dd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:26:30.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7EHgoPIOq6OE49+tYJSCgKuwx9yID17KPcdKwukGEz9Xvu8dQLKYqmoIG3r24Sb3bMiVSJqjf4KE0149DFFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2Fp
LUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgRmVicnVhcnkgMjMsIDIwMjMgMDA6NDkNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQu
Y29tPjsgUmFmYWVsIEouIFd5c29ja2kNCj4gPHJhZmFlbEBrZXJuZWwub3JnPjsgVmlyZXNoIEt1
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
Y3B1ZnJlcTogYW1kLXBzdGF0ZTogTGV0IHVzZXIga25vdyBhbWQtcHN0YXRlIGlzDQo+IGRpc2Fi
bGVkDQo+IA0KPiBPbiBUaHUsIEZlYiAyMywgMjAyMyBhdCAxOjAyIFBNIE1hcmlvIExpbW9uY2ll
bGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDIv
MjIvMjMgMTk6MzAsIEthaS1IZW5nIEZlbmcgd3JvdGU6DQo+ID4gPiBDb21taXQgMjAyZTY4M2Rm
MzdjICgiY3B1ZnJlcTogYW1kLXBzdGF0ZTogYWRkIGFtZC1wc3RhdGUgZHJpdmVyDQo+ID4NCj4g
PiBzL0NvbW1pdC9jb21taXQvDQo+IA0KPiBJIHRoaW5rIHRoZSBmaXJzdCBjaGFyYWN0ZXIgb2Yg
dGhlIHNlbnRlbmNlIHN0aWxsIG5lZWRzIHRvIGJlIGNhcGl0YWxpemVkPw0KDQpJIGhhZCB0aG91
Z2h0IGNoZWNrcGF0Y2ggd2FzIHBlZGFudGljIGFib3V0IA0KY29tbWl0IGZvbyAoInJlYXNvbiIp
DQoNCk5vdCBhIGJpZyBkZWFsIHRob3VnaC4NCg0KPiANCj4gPg0KPiA+ID4gcGFyYW1ldGVyIGZv
ciBtb2RlIHNlbGVjdGlvbiIpIGNoYW5nZWQgdGhlIGRyaXZlciB0byBiZSBkaXNhYmxlZCBieQ0K
PiA+ID4gZGVmYXVsdCwgYW5kIHRoaXMgY2FuIHN1cHJpc2UgdXNlcnMuDQo+ID4NCj4gPiBzL3N1
cHJpc2Uvc3VycHJpc2UvDQo+IA0KPiBXaWxsIGNoYW5nZS4NCj4gDQo+ID4NCj4gPiA+DQo+ID4g
PiBMZXQgdXNlcnMga25vdyB3aGF0IGhhcHBlbmVkIHNvIHRoZXkgY2FuIGRlY2lkZSB3aGF0IHRv
IGRvIG5leHQuDQo+ID4gPg0KPiA+ID4gQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5u
ZXQvYnVncy8yMDA2OTQyDQo+ID4NCj4gPiBzL0J1Z0xpbmsvTGluay8NCj4gPg0KPiA+IEJ1Z0xp
bmsgaXNuJ3QgYW4gb2ZmaWNpYWwgdGFnLCB5b3Ugc2hvdWxkIHVzZSAiTGluayIuDQo+IA0KPiBX
aWxsIGNoYW5nZS4NCj4gDQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEthaS1IZW5nIEZlbmcg
PGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgMiArLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMN
Cj4gPiA+IGluZGV4IDQ1Yzg4ODk0ZmQ4ZS4uMzA1ZjczZjY1N2VkIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9jcHVm
cmVxL2FtZC1wc3RhdGUuYw0KPiA+ID4gQEAgLTEyNjMsNyArMTI2Myw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ID4gICAgICAgICogd2l0aCBhbWRfcHN0
YXRlPXBhc3NpdmUgb3Igb3RoZXIgbW9kZXMgaW4ga2VybmVsIGNvbW1hbmQgbGluZQ0KPiA+ID4g
ICAgICAgICovDQo+ID4gPiAgICAgICBpZiAoY3BwY19zdGF0ZSA9PSBBTURfUFNUQVRFX0RJU0FC
TEUpIHsNCj4gPiA+IC0gICAgICAgICAgICAgcHJfZGVidWcoImRyaXZlciBsb2FkIGlzIGRpc2Fi
bGVkLCBib290IHdpdGggc3BlY2lmaWMgbW9kZSB0bw0KPiBlbmFibGUgdGhpc1xuIik7DQo+ID4g
PiArICAgICAgICAgICAgIHByX2luZm8oImFtZF9wc3RhdGUgaXMgZGlzYWJsZWQsIGJvb3Qgd2l0
aCBzcGVjaWZpYyBtb2RlIHRvDQo+IGVuYWJsZSB0aGlzXG4iKTsNCj4gPg0KPiA+IFRoZSBmaWxl
IHVzZXMgYHByX2ZtdGAgc28gdGhpcyB3aWxsIHNob3cgdXAgYXMgYGFtZF9wc3RhdGU6IGFtZF9z
dGF0ZSBpcw0KPiA+IGRpc2FibGVkYC4gIFRoYXQncyBhIGJpdCByZWR1bmRhbnQgbm8/DQo+IA0K
PiBXaWxsIGNoYW5nZS4NCj4gDQo+IEthaS1IZW5nDQo+IA0KPiA+DQo+ID4gPiAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPiA+ID4gICAgICAgfQ0KPiA+ID4NCj4gPg0K
