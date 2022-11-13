Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9287627075
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiKMQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:23:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928552BCD;
        Sun, 13 Nov 2022 08:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZu75vhNBsjy3MHMuswh5CvcG3Q5I4YUzYopYbrEnvRNYBhQA3rjijHlHkQayQtGnrk7HN+WbUzUQJe/0QoOnmYkOr9WWBEJbeHCd4o2DkJmHKoPeQ+yAD/oe6lawhRfMMPdCW62sM0LZd/Iyb6H8vz5hEmWBDj+uyaMj1a3NjjON82d++cAgd4fRSMOPDa8688fuN80G1QkBnCGAtZouZEYdgqayKg60XbwqFyZAXD1JrV3XMaLyAdE4xx9fSyDZhJRfIRYBAZ9vht7tLlZbjvMMN0JjPp+NmM1gYUi2jLAPTYyInB9veR1MHAqnJpa80PyTbR+ftNoMRlNFcqCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VuoEApFI5KgmrSVA80ubOH0VaG8ASWqYt0LMFkiqEk=;
 b=c13cXvvtKUto69FzQ5FLIEOTEpaJ/A19JGJawyK8oVeN59giN1EAIDLRZ1dUOCpul9oBYbJuxmMAX3u7XN7jYQ8Cuj56+7sqdSWNIdqWEBJPXsK3tnW954xBul5z4TY3g81dGFPBw8br+uWADrK7ZS5ztq+9OflrLeuEpzkGr5tQmfiSIZeWP5Jb2ZJcFPlkjRw26Y0rXyALZS2fiGqrrXvUlVqv7uT1ixBnmUdA1LDfRSzlv8IDmjl+PvfigvAMRqoFGRtNFvj0h40veQxrjpbl3cYOzPZfJTWeyi8AM6Jq/4UqPc6HphnHy+PvL6KXQbNnxHVrkcSIrBtvR6AggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VuoEApFI5KgmrSVA80ubOH0VaG8ASWqYt0LMFkiqEk=;
 b=nsK8SPAcZvbV45DkK7RDFM2H31nTK/jcLBU+i9l64Q0zX5+ei6BGuIqG89MVFmKgdMf1HW3zrlvEihM+E/Xcofea27ahPuOW0kbNuSlc5wFykCRfIeJHdjJXHvO8W7ZFoNIT+Nj+qe2M59dFQSHK+K4i/83/fyLo6OL3ZDL732s=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:23:37 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:23:37 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Topic: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Index: AQHY8tJ7SjPRFZXrqECSdAHvOgmzOa4zyVAAgAlJEWA=
Date:   Sun, 13 Nov 2022 16:23:37 +0000
Message-ID: <DM4PR12MB5278FF3295D216707E6C4AA99C029@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-3-Perry.Yuan@amd.com>
 <8ca9feaa-90c9-93fc-38e0-3c41d51dc845@amd.com>
In-Reply-To: <8ca9feaa-90c9-93fc-38e0-3c41d51dc845@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-13T16:23:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a54804ac-63f6-409c-8d6d-ed72ccad91be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-13T16:23:34Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 579541ba-e519-4fa7-ab57-ded28ae90de2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|MN0PR12MB6125:EE_
x-ms-office365-filtering-correlation-id: 7cdd093f-fb12-4627-068e-08dac5936b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uIjmoCbLfKAcw4GfeIQhkbeoChYo/6iT5fhY8k69Gs/Ul0xLL2S7/XgYT7TBlLikA/2FE8NIPBsg5rB888l2PtJm3SPFTHaFTXWpFZDR6SPGNKEg9/1TnqKQ6r2K5QDAg6A7pLK3jzUmMeKP/DLu0iDaYq+0ZD4fJe8+0FqyPbsVu0B+/XP4kFOKpk0y4W/u1F5oWlmG06JXDz7DhMZ87udbmHvZel3mvz5mni8ePotcu7ysVWAci5A7QuqIan0QZizJ8yeq1Y3nYefjW33hYxwCYRHiFqwF/Gi6dIVWmiv72Y+LuVuklVozUlyiUPYA1ryYegfUQjKa0EZ860y1/4Nwn8lGEIutgyq80GjvVnrqGNxWAvuG89pUnmz0WNmk5zOGFi1oFoFVSYzSdMZAHCRlFUz+AQsHOO8QN8M2JB5fGpYMt65CLtnHpwDPrjiGdbtsH54iPKrNE/UoCKSZX5qoZxHAANLhnZpNxrAl9x1AX0s36pilxrhld1O2MrSmFnOZwLq1cAuF3C7sxSiupLW65MiH8GBhv3sUjmzxQ1bSLHJhdIW5owSUeGSyPlbh7qzOfxHfmMq50Ue5ivHO85JbdghnRaZNCX11mcqbNEYM9IpXYN+koTgl8cbxIKM5N4vb6sVHATuslxv+tAes0bXtv7Z07Ij+2pEjBamOZX992RoeTUq1mB/AT584sROBuQ7AdH+puwIG8rN4mVFuJRwIc8C6zGEt9e28Gv9tbTFrtSH/jiiVrjQ0gwUDF2ksI1/gLbT1/84BaJxeLwjwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(478600001)(38070700005)(33656002)(54906003)(71200400001)(110136005)(7696005)(6506007)(316002)(53546011)(66946007)(66476007)(4326008)(8676002)(76116006)(64756008)(186003)(5660300002)(9686003)(26005)(66446008)(41300700001)(52536014)(8936002)(66556008)(83380400001)(2906002)(55016003)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGFqTEdmWHBIc29ZWjJEbFFIOHYzOUZiWmRyaElwbUtyMkNoblRUNjM2Y2do?=
 =?utf-8?B?eTBCUUNyOWsvYVoxMUk4QnViMDhRWnRKL3pjUGFxaTZ2cmV6R0VDYmpqelNk?=
 =?utf-8?B?ZGc3MXJaakUyNVozU1kxaElDcFVTQlJXa05xRkc3Unl3S09iL2ZIdm9Ic0o0?=
 =?utf-8?B?cGZFemJkMGZNamhIeEJ4YUZ0dUt0bDJqc3h1Q1ZjcUR6d0V4TFZ2Smd4WHZF?=
 =?utf-8?B?Rk92c0FVZDJWWUpiYklVTXZXU3liSktiV1hmQU9MbmhJMGg3OWlmdkFRZG1q?=
 =?utf-8?B?YTNlcVdjYUU2NCtSVU53N3VLK3dFd1hBYnd3cS81MnowTlFmYjM0ckduQUha?=
 =?utf-8?B?R1VBU3dCTkd6SlcrSmIzclpnS3AwYU0rVE9ka3FaRjlFb2NnMGt0NVdDRE5U?=
 =?utf-8?B?ZTBTTnRqcGNXalpVUUplOUtDaVNBaGVMVmE0dFg3WUZJYjVaUmNhcC9ueDBl?=
 =?utf-8?B?ZzZCdUdsVGN6VEI2RzJtREJHT0dld2Z1ajEybU5MRWc1N1VORWY2SDBTZzNC?=
 =?utf-8?B?TlhlVU9ONld2bmtlZXVPMUkzWE1UdlQvYU5YQ3pFalEzNmNERnBLam9md0xi?=
 =?utf-8?B?dy9ZejJvQ3NmZWUvWWxBc3RYRUw2NTJybVRBMkt6Wjh1Q0piZytqYzlOSldr?=
 =?utf-8?B?RktRMlc3R20vVitCZ1R6a21CYVRVNVo4YUxvRXRDS0dFNDRWTy85U2l1cnZa?=
 =?utf-8?B?QmtFTmh5WUNLU2tER1hOL1FMTmVVaTgrdVBoM0NqUGJiTzdPODQyZWdnVXVE?=
 =?utf-8?B?bnp1dlVKSmJUVWJlVDl6WlZDaDhuTm9FaGJHQ00wUDJrUU8zVGQxaUczekN2?=
 =?utf-8?B?QWRyYVpzU3U4cmdqWGY0Z3BRb0txdkQ2TWg4YUIvSEVsNDdNclE3MWlVbVdy?=
 =?utf-8?B?eWJGR0NTdThFL3VKbEFIOXhUM0kybytKY0RndEVSOVVFcXBRZTNYaTgwMTdH?=
 =?utf-8?B?dnNtSkFtQ0thcms5anFIN2M2aWNhMUlBVmlvNlo5eHlrY21xUXVCU3pwSFFy?=
 =?utf-8?B?d1ZGTkh0SEFlNC9ib243QXA5RmRFd2N5VTN5SkRIWnFwaWQvS25kYWo4cHVJ?=
 =?utf-8?B?WGtYYk1lenlmZ1pBY3NhR0hWVDcrKzBveWxDN21Uem45emhYMmhIOHJvVkJK?=
 =?utf-8?B?UDlyOGVMK0FPbWVXWlZDeWIxcm1XUFNONWVFVmgvamgrVHlFbG9pMklwYlNK?=
 =?utf-8?B?QUVBTTIxUTZjWVBiczN3ZXpEcVRrcHVMcjFDUmdlL1E1VncvcFFGaUJFUHVT?=
 =?utf-8?B?UTd6Z2hMQk83dVpheVdNVUNPbzFXVGxhSFc1WlJ5WkM2eFRUVk53eTBjODBH?=
 =?utf-8?B?TVBUL1lPdHJnb0dhQ296a2FydTI2VlFSVDlkNkNWY1JmZDZiY3hodGpodnR1?=
 =?utf-8?B?L2M2LzFvSHhzeFhrWFdubzE5TksxaS9ZRmRWdDFYdk9iUjVXSHc1L2JxaVVj?=
 =?utf-8?B?MC9HR0VHWUM3VDRjd3FVQ0FSREd5VVRQMXZPVEI5b3ErdEk4K0U3RVRUYW9S?=
 =?utf-8?B?UDJNdEg1TFBvZ2t5Q01QU2tZeWVBUDdyemR6NkIyZ2NaNzBjTmZralhBL2R1?=
 =?utf-8?B?cmV0cVNLd3UyWDJRVDV2d2xFQ3RZbERCRkRwbHZaV0hDMXVtSHBXa2RZWGRF?=
 =?utf-8?B?NkNPUXV6cGI0NkowTGJuazZsMUhvdXJMSyttd0EwTmZBb3RQc3FVU0ZMQjU5?=
 =?utf-8?B?bUZEVENUNDZHZWxhRy96OFMwQXFQUU5KVjZRMlF6SU9CdnAxWmkrcCtTU0g4?=
 =?utf-8?B?T2NxN0xrRVVoRnVzTlkrUURoRXZJdU9FNnM1Tm0wSndoNTZmYVNkdUNvaGFO?=
 =?utf-8?B?SGJ1UVdYamlPTVBpeUhZWGdJZnlvTVJRRlR6QlJYU2pWMkprWm1MUnRwY0Y0?=
 =?utf-8?B?Qm44eW40cEtheDRTaUJOaUs0NlBvSnFiS3c3TnJiQkJzVTUrcDQxSkpvWTdI?=
 =?utf-8?B?cXR2WTkxTEVLaDR6K3I2dEQ1T3BMZUlRUk1EbVJMbXZtY3RON2hlUEE1eElv?=
 =?utf-8?B?WmRaNkdzM1ZMcm9xVlBSMzV2RXBhc3dQODZBd3U0U2Z6VW5jSDRKVGNFN1Ju?=
 =?utf-8?B?UDQrS2lPVnlHNm53MElxYkM2Zzc3NTJKMm90dUR5TFhsVmhVRnMvVWRJQTAw?=
 =?utf-8?Q?KzjhsZHvq/0FdrEhSW15Jwlxh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdd093f-fb12-4627-068e-08dac5936b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:23:37.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2rLgoSIn0zohLiOEeRO2BJXK32/fgv4zLZ63dM9HHGgFsvRmqeoeGcpO6joseO6xDEg+EqcVR5kK5Ycd38ngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA4LCAyMDIyIDI6
MzQgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2aXJl
c2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFA
YW1kLmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcs
IFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2pp
YW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzhdIERvY3VtZW50YXRpb246IGFtZC1wc3Rh
dGU6IGFkZCBFUFAgcHJvZmlsZXMNCj4gaW50cm9kdWN0aW9uDQo+IA0KPiBPbiAxMS83LzIwMjIg
MTE6NTYsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gVGhlIHBhdGNoIGFkZCBBTUQgcHN0YXRlIEVQ
UCBmZWF0dXJlIGludHJvZHVjdGlvbiBhbmQgd2hhdCBFUFANCj4gPiBwcmVmZXJlbmNlIHN1cHBv
cnRlZCBmb3IgQU1EIHByb2Nlc3NvcnMuDQo+ID4NCj4gPiBVc2VyIGNhbiBnZXQgc3VwcG9ydGVk
IGxpc3QgZnJvbQ0KPiA+IGVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXMg
YXR0cmlidXRlIGZpbGUsIG9yIHVwZGF0ZQ0KPiA+IGN1cnJlbnQgcHJvZmlsZSB0byBlbmVyZ3lf
cGVyZm9ybWFuY2VfcHJlZmVyZW5jZSBmaWxlDQo+ID4NCj4gPiAxKSBTZWUgYWxsIEVQUCBwcm9m
aWxlcw0KPiA+ICQgc3VkbyBjYXQNCj4gPg0KPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUw
L2NwdWZyZXEvZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmDQo+ID4gZXJlbmNlcyBk
ZWZhdWx0IHBlcmZvcm1hbmNlIGJhbGFuY2VfcGVyZm9ybWFuY2UgYmFsYW5jZV9wb3dlciBwb3dl
cg0KPiA+DQo+ID4gMikgQ2hlY2sgY3VycmVudCBFUFAgcHJvZmlsZQ0KPiA+ICQgc3VkbyBjYXQN
Cj4gPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWZyZXEvZW5lcmd5X3BlcmZvcm1h
bmNlX3ByZWZlcmVuY2UNCj4gPiBwZXJmb3JtYW5jZQ0KPiA+DQo+ID4gMykgU2V0IG5ldyBFUFAg
cHJvZmlsZQ0KPiA+ICQgc3VkbyBiYXNoIC1jICJlY2hvIHBvd2VyID4NCj4gL3N5cy9kZXZpY2Vz
L3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL2VuZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlIg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJz
dCB8IDE5DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9wbS9hbWQtcHN0YXRlLnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9w
bS9hbWQtcHN0YXRlLnJzdA0KPiA+IGluZGV4IDhmM2QzMGM1YTBkOC4uNzhjNjUyNWQ1YTQ5IDEw
MDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5y
c3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUucnN0
DQo+ID4gQEAgLTI2Miw2ICsyNjIsMjUgQEAgbG93ZXN0IG5vbi1saW5lYXIgcGVyZm9ybWFuY2Ug
aW4gYEFNRCBDUFBDDQo+IFBlcmZvcm1hbmNlIENhcGFiaWxpdHkNCj4gPiAgIDxwZXJmX2NhcF8+
YF8uKQ0KPiA+ICAgVGhpcyBhdHRyaWJ1dGUgaXMgcmVhZC1vbmx5Lg0KPiA+ICAgPiArYGBlbmVy
Z3lfcGVyZm9ybWFuY2VfYXZhaWxhYmxlX3ByZWZlcmVuY2VzYGANCj4gPiArDQo+ID4gK0FsbCB0
aGUgc3VwcG9ydGVkIEVQUCBwcmVmZXJlbmNlIGNvdWxkIGJlIHNlbGVjdGVkLCBMaXN0IG9mIHRo
ZQ0KPiA+ICtzdHJpbmdzIHRoYXQgY2FuIGJlIHNldCB0byB0aGUgYGBlbmVyZ3lfcGVyZm9ybWFu
Y2VfcHJlZmVyZW5jZWBgDQo+ID4gK2F0dHJpYnV0ZSB0aG9zZSBkaWZmZXJlbnQgcHJvZmlsZXMg
cmVwcmVzZW50IGRpZmZlcmVudCBlbmVyZ3kgdnMNCj4gPiArZWZmaWNpZW5jeSBoaW50cyBwcm92
aWRlZCB0byBsb3ctbGV2ZWwgZmlybXdhcmUgaG93ZXZlciwgdGhlDQo+ID4gK2BgZGVmYXVsdGBg
IHJlcHJlc2VudHMgdGhlIGVwcCB2YWx1ZSBpcyBzZXQgYnkgcGxhdGZvcm0gZmlybXdhcmUgVGhp
cw0KPiA+ICthdHRyaWJ1dGUgaXMgcmVhZC1vbmx5Lg0KPiANCj4gTXkgcHJvcG9zYWwgYXQgcmV3
b3JkaW5nIGl0Lg0KPiANCj4gQSBsaXN0IG9mIGFsbCB0aGUgc3VwcG9ydGVkIEVQUCBwcmVmZXJl
bmNlcyB0aGF0IGNvdWxkIGJlIHVzZWQgZm9yDQo+IGBgZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZl
cmVuY2VgIG9uIHRoaXMgc3lzdGVtLg0KPiBUaGVzZSBwcm9maWxlcyByZXByZXNlbnQgZGlmZmVy
ZW50IGhpbnRzIHRoYXQgYXJlIHByb3ZpZGVkIHRvIHRoZSBsb3ctbGV2ZWwNCj4gZmlybXdhcmUg
YWJvdXQgdGhlIHVzZXIncyBkZXNpcmVkIGVuZXJneSB2cyBlZmZpY2llbmN5IHRyYWRlb2ZmLiAg
YGBkZWZhdWx0YGANCj4gcmVwcmVzZW50cyB0aGUgZXBwIHZhbHVlIGlzIHNldCBieSBwbGF0Zm9y
bSBmaXJtd2FyZS4gVGhpcyBhdHRyaWJ1dGUgaXMgcmVhZC0NCj4gb25seS4NCg0KTWFrZSBzZW5z
ZS4NCkZpeGVkIGluIFY0IGFzIHlvdSBzdWdnZXN0ZWQuDQoNCj4gDQo+IA0KPiA+ICsNCj4gPiAr
YGBlbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZWBgDQo+ID4gKw0KPiA+ICtUaGUgY3VycmVu
dCBlbmVyZ3kgcGVyZm9ybWFuY2UgcHJlZmVyZW5jZSBjYW4gYmUgcmVhZCBmcm9tIHRoaXMNCj4g
YXR0cmlidXRlLg0KPiA+ICthbmQgdXNlciBjYW4gY2hhbmdlIGN1cnJlbnQgcHJlZmVyZW5jZSBh
Y2NvcmRpbmcgdG8gZW5lcmd5IG9yDQo+ID4gK3BlcmZvcm1hbmNlIG5lZWRzIFBsZWFzZSBnZXQg
YWxsIHN1cHBvcnQgcHJvZmlsZXMgbGlzdCBmcm9tDQo+ID4gK2BgZW5lcmd5X3BlcmZvcm1hbmNl
X2F2YWlsYWJsZV9wcmVmZXJlbmNlc2BgIGF0dHJpYnV0ZSwgYWxsIHRoZQ0KPiA+ICtwcm9maWxl
cyBhcmUgaW50ZWdlciB2YWx1ZXMgZGVmaW5lZCBiZXR3ZWVuIDAgdG8gMjU1IHdoZW4gRVBQIGZl
YXR1cmUNCj4gPiAraXMgZW5hYmxlZCBieSBwbGF0Zm9ybSBmaXJtd2FyZSwgaWYgRVBQIGZlYXR1
cmUgaXMgZGlzYWJsZWQsIGRyaXZlcg0KPiA+ICt3aWxsIGlnbm9yZSB0aGUgd3JpdHRlbiB2YWx1
ZSBUaGlzIGF0dHJpYnV0ZSBpcyByZWFkLXdyaXRlLg0KPiA+ICsNCj4gPiAgIE90aGVyIHBlcmZv
cm1hbmNlIGFuZCBmcmVxdWVuY3kgdmFsdWVzIGNhbiBiZSByZWFkIGJhY2sgZnJvbQ0KPiA+ICAg
YGAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVYL2FjcGlfY3BwYy9gYCwgc2VlIDpyZWY6YGNw
cGNfc3lzZnNgLg0KPiA+DQo=
