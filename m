Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934365E572
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAEGOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAEGOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:14:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4412451325;
        Wed,  4 Jan 2023 22:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsxA+oKW5P5CgvlOypNEZRnTkjDvSICCvOGfVjcVsjZiHX/3J7W0GOJT4XX4FGo+d7t/MLlbKu2qtaXpzQ/xd5khI6Us30k94D3UiwstKlbUDfi/ndksaIkwDVAK38CxYl4rIcWj8i208SnE5IFF3cPlmASED+nz0FR68BL2neete/kIAjG/sVjZXC/6qpwFLwHSzEX1hjoZ1kr6jKbYXnObqjduILMHmG/1C9j5SnlCb4dboNFnTg4dXoMeTOGqPDGWK+IdgziKlX6jlVXN9XlGevF7e9eD5FfO2IhJqS7wWmsBshIRS6E3N4/ee1DnN65+odhsSucuml2ghbOGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vPH9hXkm2ILsmGhlSS6Ozxlq2bacGaW9jlu48zWAbw=;
 b=g7ya5dBGlnw3AWwbFYjvKwH420RXOj/9rfKHUkn1DCtQlIOsZfDjj37O0D6U1m1/kJyQVN9wYSaCh2csFH/5P0ywuQAdP0H/Fm7Xnm+2G+zmuytxPFkYNLTwZtdXA6LLUIh2dqhmeEa0fXzEUyb4zbyRFVd04XGY0a2oflvqjdCWTjUSTqm6hGqqkVwGoAQsUeF9T5ZqMiia3owZVfe64gjNsrN/EyuR6JlTjJtJ0KVGbcwwUcsVxDPj7HdFfU1XtyfFUqFBhXLFT3Ge/cVZjMR7onKuMiWMt9QTs+dRmBg/sSC6NEiTV3FFb3i7C8j4Q7DL6H7tcO+BCiaEW3TMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vPH9hXkm2ILsmGhlSS6Ozxlq2bacGaW9jlu48zWAbw=;
 b=J1n0OOIr+v+qA7zTRur0p0Sz/ffmilzjebk+7bSGNw2aZqyiirqGWqkelgM8icd5CQCzawr02NkkvWqbMfI1f6TQzQzAsRxP3wXZfiZM7/MvpAjReW53Mf8zUsMz8kRdUNrAHSuf8PPQ2E00H34vccZx2OtnuS+li1N5NU3gnag=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:14:33 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:14:31 +0000
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
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZGH7vDlYW86zG/kOXbWfPNoGdH66NdsQAgAHCISCAACruAIAAAeaQ
Date:   Thu, 5 Jan 2023 06:14:31 +0000
Message-ID: <DM4PR12MB527815452A4BD57C19462C6A9CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-4-perry.yuan@amd.com>
 <700d3351-1a52-5362-d22d-9326ad1220e5@amd.com>
 <DM4PR12MB5278F31C41AA3DFD5569FEB89CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <60ba1e38-d196-6b38-7c34-cd94daf50f81@amd.com>
In-Reply-To: <60ba1e38-d196-6b38-7c34-cd94daf50f81@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T06:14:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e049fcd7-6aa5-47e3-9b2f-803c3e7ce6b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T06:14:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8442fe5f-a7ea-4550-811f-651659865075
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB8500:EE_
x-ms-office365-filtering-correlation-id: bede6568-628c-40f9-4d65-08daeee41c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W1ogkKqlXb9C1SH6UVPQe7h+MmTq/QWT9nFDYiVINpeDRhGyhtHLYHL1p+64Rwyts5fQGh+qpf/BgYy7JX5bP0OQf7FSzRkJOWOq5WLG0eRIKCOIc/sJ4v+OaqK3G3dzSqBKgai5kuR49cyz56Q4bGuPscNdSkbxZaGRKo4NP4ZLvXRSspTRyEdMgLv3CNPa13viEv+a8EapKC+Gr2NkC5tarY94f9cosYxO0JxyuqSSjoqz8gEX91fPQUcmWCPEGCtg7x4fW/e1G/cZYyOHOBnlKCsjTnPMTMEKVMVryJnmxa1qMbAqqkls7Jpw56tuRE9A5dKmZs/abVzRWPnn6rA/e/NYHFUFVt0UQaBHJiYvAuTk7HVBI0O6Nb6faViObtoCbjb+VEoFwGPA4DcuKiUjJf6dbcdFgseJyZ2K2lYdl312XOHvjqjj8k+BdAu7BYiuk/JBhh3RPQN0m5f6gHPv4dUIKuwGR4vpUVdi6d+mlH5CwiF4fxj6GYUy/EWgoOXs9mFP+LSxE/XG6PPaC8q6mCB24PB0iBgvf9uwkq+rgP/aawi9Aw5zRAC9TardwO7DVHGeB4soapmYVGwg795u7HIIcnnKC8j+IelloPkUeydz+E/i/eaKZsjuLlCXzuOeBIZl6eDq6S8KVKIKVbZK4s9t3bHFsm5iQlpUT9Ktr1RKzVErDiivzsRn7yxlkWskE92xA6ueW0oZNiGaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(64756008)(8676002)(8936002)(4326008)(66556008)(66446008)(52536014)(66476007)(66946007)(2906002)(54906003)(5660300002)(316002)(110136005)(76116006)(6506007)(7696005)(478600001)(71200400001)(41300700001)(9686003)(53546011)(186003)(26005)(83380400001)(33656002)(38100700002)(122000001)(38070700005)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjV4SzFDbExPZG83SHZab0R0S05ZZEhLZ2piQW1oRlVSMHhRTlBGWXZKUjQw?=
 =?utf-8?B?bTgrY3UzN3BEcVR6cWxuK1ZFM2JGY05VZHREVjFleGFUdjNYdjFpVGJ1RzZN?=
 =?utf-8?B?UUtZWXpnb1UxMHYrV1BQMURnUlZ5ZnFrMWxTVkxBUnc0azNUSmZkZDNLN1No?=
 =?utf-8?B?b0k1NDRnUEswTXp3a3dnOEd2SW1wajh1d0MwYXNySmI0OE9NTmMvbzZCQ1o1?=
 =?utf-8?B?MWFNdk1LRTFERzV1SGQvVVY1K1ExU0NFUzZGanBwN2tpdyt4SXE4MlNSYjRh?=
 =?utf-8?B?NGhqZ0tid0FqNjdpN09vK1FHanIrUm01Y0NZL0RIQTEwdjBERStQZ09mb0hV?=
 =?utf-8?B?eGNMZ2h0aDNqWGZLM2UwMmF0SVdjdHp3K25yRXM0TWorSEI2cXVIcVhHZ05T?=
 =?utf-8?B?YmkwSnpJZTJESTh1bDJFWGNuUE0rV3lyNlJCOW1qWG05MXBBSXdSdnM5ZTZW?=
 =?utf-8?B?ZmtMMXMyK1lXNE9pRVpyRlpVU1VnUXE5b2o4aStDY2ZpNjVuc2FwMUZRV0RF?=
 =?utf-8?B?T3VHdC9Dc0srM3BHbncvWGlLM01rdTVzNGZnMm9GU2FITUJ5NXFuV01OcVBH?=
 =?utf-8?B?bnRpbWN2ZE8weUNqL2Q1UmhoeFdOblErWENaZjhKQVJKUU0yK1BabUs0TElS?=
 =?utf-8?B?VVpkSVYrYkdYTDhuZVByeWt5ZkVkSExxL3NHTVlIRXBMVk9YcmdnVUQ4dWRv?=
 =?utf-8?B?VjA0dElxeHF2QXgzR0dyVXdzMEVDS1RNOU45Y0RScnN5aWs2TGFZbEtqaEcr?=
 =?utf-8?B?ZnJqUzRTZkZVY1lvenJ0a3F3WlVCWElPQ253WEQ2SFZuNWFRUjZzL3JuMksx?=
 =?utf-8?B?YzZNTWtNZ1UxNEtrZFdja2JHMG1zaTFLOC9BWFNwYmNMRmhza1EyVjBtT3hI?=
 =?utf-8?B?MXBZOUZvU1ZvZ3V4WHk3Q3ZNSTFTVWNZcEx6a21UQmNNM010M01HY2xOd0hz?=
 =?utf-8?B?cExFSzNMcXVYeEJLVWtSUE5OWFdBQ2E0WnlwZmxBQldQV2g5SXU0T3dFREtQ?=
 =?utf-8?B?SFJobjB4MGgrR0NHeVVVRDRJSWFBMmE5WmJUNWxqaXdoaU82T2VpbzljVi82?=
 =?utf-8?B?V0N1MzNUWUlGWmZHTFJBRWt1WlgzQVhDM29PV1RLbURCWW0yaVZkMUtmbm9E?=
 =?utf-8?B?ZTRSWHF6TlpQbjBid1Bxd0g5ZXMxbFMzVXljTG96d2NlWDBJQ1lqSWJmeXlX?=
 =?utf-8?B?aGZyNHV3OWxGVk5GWndOQkN0cEtMeVhROVRyMTA4MVlQVDlBa0dERUUrQzNO?=
 =?utf-8?B?Y3ZTemtyNU5IQTV5RExPaDBKY1gzdE55SklRODluQldvWkFMMDdmSXVBNHlR?=
 =?utf-8?B?NVVGUDRYRi93b0wxWUx0c1VwR20wNkx1VkRNd2QreWVBZnFtWllSMFgxdUxP?=
 =?utf-8?B?aDlQcGxoN0hJVytyamVtd0NlU0tob21SejBNUVZkc21BaXZxVjhWamxiRG9N?=
 =?utf-8?B?WHlTaFc5WGwxNXZkRDluNHUxQXJZbmNQZWtzckxRdWZrT3I0UC80MHphRDVX?=
 =?utf-8?B?bGlSdG95YXl4c0J4cm42VFlKZi95Ly9YcHkyRXNETjBTNzdtTWFWWWRqN0xN?=
 =?utf-8?B?UWZ1UHJObjRCbTZxbmgrdmExRjl0eEpjcHJES3g0NTVFa1YybU8zYkpUdVI0?=
 =?utf-8?B?WUFvN0RvUnVwVnFmU3RPY3VEdmFkTStnd1RlWEZZRC94RjQvV2xDYUdhQjNv?=
 =?utf-8?B?U3AwakdiZlUrMHBaczZYNG1UME8xOG5lRjRHUlBTWVdFcmFpaW1MeGRqUysw?=
 =?utf-8?B?S0tHZ0Z3TUlBd2pUbTlvS1BTNENla1dZdHh5amwvMlM1cmh4SFJKZ1BlTndy?=
 =?utf-8?B?Y2pIaitpUmVBZW95UzcwR3hINUdMTm8yYm1DdEVyb1hVM24xTlNvaVRsWWdr?=
 =?utf-8?B?NGNKRTlocitRK0I1d25aLzJHWjZMaVpSSnNGN0hERUdyK3I1cldwTjFMSEdn?=
 =?utf-8?B?bVc3N1BtRHdHUUtSOUc0Wk9uT3diWSttcEtITDhlT29iV05WWVVqb2g0dGox?=
 =?utf-8?B?RW03dWdWTWxZSHdhWFZVeWZEY1FFM2RXQ2tpWCtVZHk2MDFjMVoyYVFRYnNB?=
 =?utf-8?B?U1U4eXRmbmZIRitrRG4wcTBVcGtPU21FS3lCb21JTlByZVNyemMxWVpJb0hK?=
 =?utf-8?Q?LF59x3leCJ9l46UtWVD8RMOW0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bede6568-628c-40f9-4d65-08daeee41c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:14:31.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZjjjQ+vIHjeV3+9dAVjbOgBpvqfniTYR1dWihNERiREQqs09tUfAUOCIHQkHusFMg3P7NRN6weuwXkNpodX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMg
MTo1NiBQTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJt
YUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFu
ZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFv
amlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29t
PjsgS2FybnksIFd5ZXMgPFd5ZXMuS2FybnlAYW1kLmNvbT47DQo+IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY5IDAzLzEzXSBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IHVzZSBjb21tb24gbWFjcm8NCj4g
ZGVmaW5pdGlvbiBmb3IgRW5lcmd5IFByZWZlcmVuY2UgUGVyZm9ybWFuY2UoRVBQKQ0KPiANCj4g
T24gMS80LzIzIDIzOjQ5LCBZdWFuLCBQZXJyeSB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gR2VuZXJhbF0NCj4gPg0KPiA+IEhpIE1hcmlvDQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNCwgMjAy
MyA4OjMxIEFNDQo+ID4+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFm
YWVsLmoud3lzb2NraUBpbnRlbC5jb207DQo+ID4+IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQu
Y29tPjsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gPj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxE
ZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+ID4+IDxOYXRoYW4uRm9u
dGVub3RAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+PiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+Ow0K
PiA+PiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21p
bmUpDQo+ID4+IDxMaS5NZW5nQGFtZC5jb20+OyBLYXJueSwgV3llcyA8V3llcy5LYXJueUBhbWQu
Y29tPjsNCj4gPj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDMvMTNdIGNwdWZyZXE6IGlu
dGVsX3BzdGF0ZTogdXNlIGNvbW1vbiBtYWNybw0KPiA+PiBkZWZpbml0aW9uIGZvciBFbmVyZ3kg
UHJlZmVyZW5jZSBQZXJmb3JtYW5jZShFUFApDQo+ID4+DQo+ID4+IE9uIDEyLzI1LzIwMjIgMTA6
MzQsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4+PiBtYWtlIHRoZSBlbmVyZ3kgcHJlZmVyZW5jZSBw
ZXJmb3JtYW5jZSBzdHJpbmdzIGFuZCBwcm9maWxlcyB1c2luZw0KPiA+Pj4gb25lIGNvbW1vbiBo
ZWFkZXIgZm9yIGludGVsX3BzdGF0ZSBkcml2ZXIsIHRoZW4gdGhlIGFtZF9wc3RhdGUgZXBwDQo+
ID4+PiBkcml2ZXIgY2FuIHVzZSB0aGUgY29tbW9uIGhlYWRlciBhcyB3ZWxsLiBUaGlzIHdpbGwg
c2ltcGlmeSB0aGUNCj4gPj4+IGludGVsX3BzdGF0ZSBhbmQgYW1kX3BzdGF0ZSBkcml2ZXIuDQo+
ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy54ODYgICAgfCAg
MiArLQ0KPiA+Pj4gICAgZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jIHwgMTMgKysrLS0t
LS0tLS0tLQ0KPiA+Pj4gICAgaW5jbHVkZS9saW51eC9jcHVmcmVxLmggICAgICAgIHwgMTAgKysr
KysrKysrKw0KPiA+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL0tj
b25maWcueDg2DQo+ID4+PiBiL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4NiBpbmRleCAwMDQ3
NmU5NGRiOTAuLmY2NGFlZjFlMDkzZA0KPiA+Pj4gMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJz
L2NwdWZyZXEvS2NvbmZpZy54ODYNCj4gPj4+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmln
Lng4Ng0KPiA+Pj4gQEAgLTM2LDcgKzM2LDcgQEAgY29uZmlnIFg4Nl9QQ0NfQ1BVRlJFUQ0KPiA+
Pj4NCj4gPj4+ICAgIGNvbmZpZyBYODZfQU1EX1BTVEFURQ0KPiA+Pj4gICAgCWJvb2wgIkFNRCBQ
cm9jZXNzb3IgUC1TdGF0ZSBkcml2ZXIiDQo+ID4+PiAtCWRlcGVuZHMgb24gWDg2ICYmIEFDUEkN
Cj4gPj4+ICsJZGVwZW5kcyBvbiBYODYgJiYgQUNQSSAmJiBYODZfSU5URUxfUFNUQVRFDQo+ID4+
DQo+ID4+IFRoaXMgZG9lc24ndCBzZWVtIHJpZ2h0IHRvIG1lLiAgV2hhdCBpZiBzb21lb25lIGRp
ZG4ndCBjb21waWxlIGluDQo+ID4+IEludGVsDQo+ID4+IHg4NiBzdXBwb3J0IGZvciB0aGVpciBr
ZXJuZWw/ICBUaGV5IHdvdWxkbid0IGJlIGFibGUgdG8gcGljaw0KPiA+PiBYODZfQU1EX1BTVEFU
RS4NCj4gPg0KPiA+IEhvdyBhYm91dCBjaGFuZ2VkIGxpa2UgdGhpcyA/IHdoZW4gYW1kIHBzdGF0
ZSBlbmFibGVkLCBpdCB3aWxsIGJ1aWxkIGludGVsLQ0KPiBwc3RhdGUuYyBhcyB3ZWxsLg0KPiA+
DQo+ID4gICAgIGRlcGVuZHMgb24gWDg2ICYmIEFDUEkNCj4gPiArIHNlbGVjdCBYODZfSU5URUxf
UFNUQVRFDQo+IA0KPiBJIHN0aWxsIGRvbid0IHRoaW5rIHRoYXQncyB0aGUgcmlnaHQgd2F5IHRv
IGRvIHRoaXMuICBXaHkgbm90IG1vdmUgdGhlIHZhcmlhYmxlcw0KPiB0byB0aGUgY3BwYyBsaWJy
YXJ5IGZpbGU/ICBCb3RoIGludGVsIGFuZCBhbWQgcHN0YXRlIGRyaXZlcnMgc2VsZWN0IGl0LCBz
byBpdCBjYW4NCj4gYmUgYSBjb21tb24gcGxhY2UgYm90aCB3aWwgdXNlLg0KPiANClRoYXQgd2ls
bCBiZSBnb29kIHRoZW4uIA0KUmF5IHN1Z2dlc3RlZCB0byBwdXQgdGhlIGNvZGUgdG8gY3B1ZnJl
cS5oICwgSSB3aWxsIG1vdmUgdGhlIGNvZGUgdG8gY3BwYyBsaWJyYXJ5IGluIHYxMCBpZiBoZSBo
YXMgbm8gb2JqZWN0aW9uLiANCg0KUGVycnkuDQoNCj4gDQo+ID4NCj4gPg0KPiA+DQo+ID4+DQo+
ID4+PiAgICAJc2VsZWN0IEFDUElfUFJPQ0VTU09SDQo+ID4+PiAgICAJc2VsZWN0IEFDUElfQ1BQ
Q19MSUIgaWYgWDg2XzY0DQo+ID4+PiAgICAJc2VsZWN0IENQVV9GUkVRX0dPVl9TQ0hFRFVUSUwg
aWYgU01QIGRpZmYgLS1naXQNCj4gPj4+IGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5j
IGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+ID4+PiBpbmRleCBhZDliZTMxNzUz
YjYuLjkzYTYwZmRhYzBmYyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRl
bF9wc3RhdGUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+
ID4+PiBAQCAtNjQwLDE1ICs2NDAsNyBAQCBzdGF0aWMgaW50IGludGVsX3BzdGF0ZV9zZXRfZXBi
KGludCBjcHUsIHMxNiBwcmVmKQ0KPiA+Pj4gICAgICoJNAkJcG93ZXINCj4gPj4+ICAgICAqLw0K
PiA+Pj4NCj4gPj4+IC1lbnVtIGVuZXJneV9wZXJmX3ZhbHVlX2luZGV4IHsNCj4gPj4+IC0JRVBQ
X0lOREVYX0RFRkFVTFQgPSAwLA0KPiA+Pj4gLQlFUFBfSU5ERVhfUEVSRk9STUFOQ0UsDQo+ID4+
PiAtCUVQUF9JTkRFWF9CQUxBTkNFX1BFUkZPUk1BTkNFLA0KPiA+Pj4gLQlFUFBfSU5ERVhfQkFM
QU5DRV9QT1dFUlNBVkUsDQo+ID4+PiAtCUVQUF9JTkRFWF9QT1dFUlNBVkUsDQo+ID4+PiAtfTsN
Cj4gPj4+IC0NCj4gPj4+IC1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGVuZXJneV9wZXJmX3N0
cmluZ3NbXSA9IHsNCj4gPj4+ICtjb25zdCBjaGFyICogY29uc3QgZW5lcmd5X3BlcmZfc3RyaW5n
c1tdID0gew0KPiA+Pj4gICAgCVtFUFBfSU5ERVhfREVGQVVMVF0gPSAiZGVmYXVsdCIsDQo+ID4+
PiAgICAJW0VQUF9JTkRFWF9QRVJGT1JNQU5DRV0gPSAicGVyZm9ybWFuY2UiLA0KPiA+Pj4gICAg
CVtFUFBfSU5ERVhfQkFMQU5DRV9QRVJGT1JNQU5DRV0gPSAiYmFsYW5jZV9wZXJmb3JtYW5jZSIs
DQo+ID4+IEBAIC02NTYsNw0KPiA+Pj4gKzY0OCw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29u
c3QgZW5lcmd5X3BlcmZfc3RyaW5nc1tdID0gew0KPiA+Pj4gICAgCVtFUFBfSU5ERVhfUE9XRVJT
QVZFXSA9ICJwb3dlciIsDQo+ID4+PiAgICAJTlVMTA0KPiA+Pj4gICAgfTsNCj4gPj4+IC1zdGF0
aWMgdW5zaWduZWQgaW50IGVwcF92YWx1ZXNbXSA9IHsNCj4gPj4+ICsNCj4gPj4+ICt1bnNpZ25l
ZCBpbnQgZXBwX3ZhbHVlc1tdID0gew0KPiA+Pj4gICAgCVtFUFBfSU5ERVhfREVGQVVMVF0gPSAw
LCAvKiBVbnVzZWQgaW5kZXggKi8NCj4gPj4+ICAgIAlbRVBQX0lOREVYX1BFUkZPUk1BTkNFXSA9
IEhXUF9FUFBfUEVSRk9STUFOQ0UsDQo+ID4+PiAgICAJW0VQUF9JTkRFWF9CQUxBTkNFX1BFUkZP
Uk1BTkNFXSA9DQo+ID4+IEhXUF9FUFBfQkFMQU5DRV9QRVJGT1JNQU5DRSwgZGlmZg0KPiA+Pj4g
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCBiL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5o
IGluZGV4DQo+ID4+PiBkNTU5NWQ1N2Y0ZTUuLjA2OTMyNjlmYjc3NSAxMDA2NDQNCj4gPj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oDQo+ID4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2Nw
dWZyZXEuaA0KPiA+Pj4gQEAgLTE4NSw2ICsxODUsMTYgQEAgc3RydWN0IGNwdWZyZXFfZnJlcXMg
ew0KPiA+Pj4gICAgCXU4IGZsYWdzOwkJLyogZmxhZ3Mgb2YgY3B1ZnJlcV9kcml2ZXIsIHNlZSBi
ZWxvdy4gKi8NCj4gPj4+ICAgIH07DQo+ID4+Pg0KPiA+Pj4gK2VudW0gZW5lcmd5X3BlcmZfdmFs
dWVfaW5kZXggew0KPiA+Pj4gKwlFUFBfSU5ERVhfREVGQVVMVCA9IDAsDQo+ID4+PiArCUVQUF9J
TkRFWF9QRVJGT1JNQU5DRSwNCj4gPj4+ICsJRVBQX0lOREVYX0JBTEFOQ0VfUEVSRk9STUFOQ0Us
DQo+ID4+PiArCUVQUF9JTkRFWF9CQUxBTkNFX1BPV0VSU0FWRSwNCj4gPj4+ICsJRVBQX0lOREVY
X1BPV0VSU0FWRSwNCj4gPj4+ICt9Ow0KPiA+Pj4gK2V4dGVybiBjb25zdCBjaGFyICogY29uc3Qg
ZW5lcmd5X3BlcmZfc3RyaW5nc1tdOyBleHRlcm4gdW5zaWduZWQNCj4gPj4+ICtpbnQgZXBwX3Zh
bHVlc1tdOw0KPiA+Pj4gKw0KPiA+Pj4gICAgLyogT25seSBmb3IgQUNQSSAqLw0KPiA+Pj4gICAg
I2RlZmluZSBDUFVGUkVRX1NIQVJFRF9UWVBFX05PTkUgKDApIC8qIE5vbmUgKi8NCj4gPj4+ICAg
ICNkZWZpbmUgQ1BVRlJFUV9TSEFSRURfVFlQRV9IVwkgKDEpIC8qIEhXIGRvZXMgbmVlZGVkDQo+
ID4+IGNvb3JkaW5hdGlvbiAqLw0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSByaWdodCBwbGFjZSBm
b3IgdGhlc2UgdmFyaWFibGVzIGFuZCBzdHJpbmdzIGlzIGluIHRoZQ0KPiA+PiBjcHBjIGxpYnJh
cnkgc291cmNlIGZpbGUgdGhhdCBpcyBjb21tb24gYWNyb3NzIENQUEMgaW1wbGVtZW50YXRpb25z
Lg0K
