Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AA67EAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjA0Q0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjA0Q0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:26:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC048663A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:25:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erBTSy0ljUfoCHVSeWP8XoeBIssX2gyZK0JcNeujRRsDIIbhoekDyWbCxKN8PKnCQyVmodYPkO4vjOSCrtvaE12Zk+F/eHWrey0ZgHLOTcZ7tgBeI8IgqT3VoGCxBNbShknEzbD0P73/v5w34dpvub2htqOMwPPcLja3+MntuQnKqn1cnJGYwq8iQbeab83vOHoUzgNgWsEP5i0VUhKHzELqNBqWq6rLgqS0IJTsq1+Jh0aN/r8UuLkApb9F5YymdO+iuHp3GHmKR97yJhtKRwAOZ3IGzwL3EZnOMEW4FwWNAWvVOjkoSX8FhU4PIzzhYJHnbrre+AtoBcPCwTQQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVvAlARF1BaQYFNbk9iQr9kla/Dg5yykDvQL8pRidfQ=;
 b=kr2BeK7og2nROHp+KGmjXI9fybxy81wt3OIvdtcOxXb0b0dUk0FLc3HlUD6HLddaqa3EQu+nMBpwgUpnRx7J5Non2cAodu/Sjx54J0LVX+C1YJUsZznHXmFpptC2m4Himn/p4K5h9OPWF4LNsfjOdq1HeE+ejFr/Xbkvk4DNIhMTFrXITEkEScbR8BzprVhecf3tZteKr41OBwY5Fzm1Tc74mdoDapXxe9PfnJ+/vJe+RqW2PiP7f5qkywTU4j4KMeHGKPtmZf39wotNLMzl5ROYj7zHRRQRs/X5vbXFQoa/nzdxmxnkIshZkiRJ94E06zc0Ep/HeXDeiiGoyWLMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVvAlARF1BaQYFNbk9iQr9kla/Dg5yykDvQL8pRidfQ=;
 b=3zbkaHRcdFUNkW4DOTSny2qo8FwR2eDGxN5b282P6jmlkQeLw3H77tViIwvk5VROsB60gnMYGaM957yTl+OE84I/xf2MstvSoXADyqTNR2odKkD+4VFWvr34voDuqBWbK9M0ZVlIicqMcXSYpK6OFZ9yh+EsSLBydqmgtIY0VXg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:25:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 16:25:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 2/6] ASoC: amd: yc: Add a module parameter to influence
 pdm_gain
Thread-Topic: [PATCH 2/6] ASoC: amd: yc: Add a module parameter to influence
 pdm_gain
Thread-Index: AQHZMmi5+tAOEc/Tz0G4/BqTqLH7eq6ycnsAgAAAVTA=
Date:   Fri, 27 Jan 2023 16:25:45 +0000
Message-ID: <MN0PR12MB61014C004C798F7DE8682AAFE2CC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
 <20230127160134.2658-3-mario.limonciello@amd.com>
 <2e9f4301-0211-04f5-5b38-caf2be9f4fd1@perex.cz>
In-Reply-To: <2e9f4301-0211-04f5-5b38-caf2be9f4fd1@perex.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-27T16:25:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=26646a59-9f6e-4089-96b6-cd04e644e238;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-27T16:25:43Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 948d44bb-d9b5-4727-864a-5107af9756ed
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB7281:EE_
x-ms-office365-filtering-correlation-id: 361ca698-63fb-4b2a-58ee-08db00832476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0zuCIJqusuuSiyVFP5Wt/F6cJe9P84UmWwRU3KPJxpuiZl3Jh9ArfodIZ1hF2g1d0iqM95mvcwdlo5FG8ZRj99CXVu64ywxCmoW6tioA9b5b7Pvefn+VFxngsdpvXzxGVXmWl10D+wHQqqU0NJUrDFPKW3Qv76NZ93HDBb2ItJq9R8KF8xU9/XyvQm74m99CBzTAaf6SxKD+Ca2PKBb5I1ev4CLHv8jbEINEBa1fGdy9eMCu412HvORDoNwhLY4f5y9/c94FS6Ib2Cyu49cgmhFSrMwOOf8QB7/SRAVNY/CDLw/iuykwzxu+lVw5KMff4PaH5Z9svi/++pkO8KvVR8uh8vKm+UrkdMCHTbfGC2PpqEf+O+aBTPNSVmVbt2tW5Vh+pZDMfAeGKZ3BIpl4Uxx6CISgGbsLGgNVLJVJzGakpmbD3r6FGUNrvPmaVLWcs9Fjh7/PWIPDXfvn7S4xG6Qc2/6c7bXIL0bBu8gYwDNEzG99U+WfvAH1nQpT4tN7rhhntsE2gc+d5FNV68h1zqBz3yUieZYAQljbHhGfRksGLlj6dSFZYjHIJ937DBXuecyO3z+cwIEloTFVYhkXEyrdWxSQa9CWz0mRo02M7RotmnYOpaIk21bvy5y2aukNAwpFC6FN4NXeJgwjCFNtVrb6daNak7lHHmzE4IkhJgFg2sYjNFFDtqXqx2pTGBC9LKaObirSjJyX7gLnP93zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(41300700001)(66556008)(76116006)(66946007)(64756008)(4326008)(66446008)(122000001)(83380400001)(38100700002)(2906002)(52536014)(8936002)(8676002)(5660300002)(26005)(71200400001)(7696005)(86362001)(9686003)(478600001)(53546011)(6506007)(66476007)(33656002)(186003)(38070700005)(110136005)(54906003)(316002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlZtMUJOZC9GUFRBblNoalpjWUxWZVRXYUFsQVJXQnZIdXpheFZUQmRSUGUy?=
 =?utf-8?B?d09LSUdCS21DT0ppajN0eE16MzJUZ2E5SGVqUi9Mc1dHNWpGcUhucFZoYVpI?=
 =?utf-8?B?bjgrR3FnSHJoSzZEZDVuUmpPNkRVUndvTVl6RHBsa0tRSktPYU5NdlBaOXZu?=
 =?utf-8?B?dVh1R0ZWUXRrb0wwZUhtZ2hqb0h0ait2L0xSZkQ0ZXpQNDc4OUZQM2xxTDFq?=
 =?utf-8?B?OU10WjZuQ2tmWEhiOWlaOWpxS0NBcmI2QUNjNjAweU1jcm1oKzJnQWVia2Zt?=
 =?utf-8?B?NGxJNTVUNWdOVWx6b0hHeUR3OHUzaFZXSlF1czVMYVlIem9YSm92ZDZzUDAv?=
 =?utf-8?B?V1pMbUJHbWlod1ZMVlhVank2S1lLWjUveWdjeXBrSUcvRDFsVmRlR2RydVZi?=
 =?utf-8?B?K29YSlpNbzFjU1dvRWVUa0tHODg5SUtST0NxbWlJYUl6YmU2bnBmTHJFODlM?=
 =?utf-8?B?RGIrWXFkSGhtQ2dKTm9pb0RHYXVRNzBCT0JQWWd6SlpSQklqM2hJK1BRMFNz?=
 =?utf-8?B?Ym9ZUTVxWXdoWkJ5WFZuOVZwMExia3ZybW1ldWNrVDFrYXBKN20xcTZrZ1FS?=
 =?utf-8?B?ci9yc2l1RVVzc0ZNSmZqN01jMC9rQkRIK0d6VGZtdGJiMmdxOW1ZNnVlUlo5?=
 =?utf-8?B?dW9wcHdJVE03MmVQQUpDMW1qeVJvWEw5eGsvUEI5Z004dEZycUsvNFl2S2Nu?=
 =?utf-8?B?akd4NTN3NnhuYTk0UnRFQyt2azdjaGhvVkljRFZpblNlYmswSEdlU0JRQm5u?=
 =?utf-8?B?NnZuZDJqV3JIa2EwbXJRdjY0MDl6K04zd0h0ZlFDYUpNdzFKMzUzRm05M2Ew?=
 =?utf-8?B?ZW83Y3FvSEZ5WkxFaStJajJkN3l2VjFPOVRwS3g0ZGNDSFJlK2tWREdnVmFj?=
 =?utf-8?B?YnFTd1BsUkdLOEkwNHFab1AxSWtZUXZDVG9ERkR0ZER1ODRML1pSYUFGbEJo?=
 =?utf-8?B?VTBDT3dFOHdWVTNvSEk4Vjc5U2c0aWVua0J4MjN2T0pnd1VGOURvbnVMb1J2?=
 =?utf-8?B?NEdKUThnckhPMDgzVWgxQVY0WmRXdktaL0NtSHFXbGJzblRsTkY2blk4eHRQ?=
 =?utf-8?B?KzlPVUtRbVpHVWpSaytyNGhVNkM5aWNoMGVvczZwUkFZUENRZHlEU2RyVDNh?=
 =?utf-8?B?Y1RmbGxybkdOVUZlUUIxQmZ3WHZWckRFYVJmVjlhTDlVQ0VKTHlSZytocFpo?=
 =?utf-8?B?Q3kycDh6SFIrZ1FBaU0xQjRNeDZlYnZwWUJwd2p5bnNMcUtVZXVrZy9MNmVO?=
 =?utf-8?B?S2JtaUUrUVlYbE55QTVsek1FTk5LZkdNM1NybDdmL0I5MTZpR3V4STV2MjY2?=
 =?utf-8?B?UFVtWkx2L2E3NjI4dEpBS0dpUDJHbGl0WXZHdVZ6QUpTRlFUWm4yTmI0ekV1?=
 =?utf-8?B?VllWU2J5OHRjN1dlbDgrd0hFaVJId3crZXFSR0ExY1I2UTdzVy9DUjJvRDB2?=
 =?utf-8?B?RFBWek9kakoySEVwbjAxSkNLYjZnWEFDTXZML09abm1XTHFCYTRSdERodjF3?=
 =?utf-8?B?aUVpa1FBNDRCUFNkZnBpMWMyVVpDZGFUVUdyNVFrVlpiWG41ZHpXQzFDS01M?=
 =?utf-8?B?eURCMndDQ081S1RWVUJKdVBUdXgzK1VKeDV5TFp3OWQzMkV6WFE0S2pucHZl?=
 =?utf-8?B?N082QkpYZGpzK3J3QSt5NlZITHQvc3NTbHFiOXAzbTRWcGEwQUNKa0ZSRXlI?=
 =?utf-8?B?M0hZRjEvWnJuRUYwdWdLaGwxOU5TOUJNRjF4azRMdXp6MHYrSGs5WG03aVZi?=
 =?utf-8?B?UTgvODVJMTRpTGZibC8yTTRwSnp1alRXQlRoUzZBb0NZOWkyNm5CY0UxUjVL?=
 =?utf-8?B?T2FGTGc1UXNOY0lMMllWN2owak1EOXRzdjNsZXRuRTJ5aU5IWVc2VmMvSG0z?=
 =?utf-8?B?bGFHODNZcXFiTXlMb1BqU1NpRGhRRDRIVWpHTzhYV2hhSyt4bXFncDhlNFlk?=
 =?utf-8?B?Nlh1Yng1YUxGdlBlQWQwdDJyc1NCandmK3JtQmpmT0craU5jRWZFRmxxUjEw?=
 =?utf-8?B?TVNFd1hENDhJTnpkRHMweE04NmkvaEFTZ0tEemlkTkNmZk1zOC9zZ1lxSktS?=
 =?utf-8?B?S2VFS1ZnWEtkNU9hazdQcmhPeWtsUXkzK25WSlpLemY4UzRWTElxaDd0THBI?=
 =?utf-8?Q?syB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361ca698-63fb-4b2a-58ee-08db00832476
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 16:25:45.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZxDUFYA/xEzgeA6ABeJdYuBe40BYDR6c9rrsxEgIFRqB5+wyxNsJIfoBisIMVAxf3bFNqXJKOSp8/HhiJTPqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+DQo+
IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyNywgMjAyMyAxMDoyMw0KPiBUbzogTGltb25jaWVsbG8s
IE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgTXVrdW5kYSwgVmlqZW5kYXINCj4g
PFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbT47IFNhYmEgS2FyZWVtLCBTeWVkDQo+IDxTeWVkLlNh
YmFLYXJlZW1AYW1kLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBh
bmFuY2hpa2thbCwgUmVuaml0aCA8UmVuaml0aC5QYW5hbmNoaWtrYWxAYW1kLmNvbT47IE1hcmsg
UGVhcnNvbg0KPiA8bXBlYXJzb25AbGVub3ZvLmNvbT47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29v
ZEBnbWFpbC5jb20+OyBNYXJrDQo+IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBUYWthc2hp
IEl3YWkgPHRpd2FpQHN1c2UuY29tPjsgYWxzYS0NCj4gZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNl0gQVNvQzogYW1kOiB5YzogQWRkIGEgbW9kdWxlIHBh
cmFtZXRlciB0bw0KPiBpbmZsdWVuY2UgcGRtX2dhaW4NCj4gDQo+IE9uIDI3LiAwMS4gMjMgMTc6
MDEsIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IEluIGNhc2Ugb2YgcmVncmVzc2lvbnMg
Zm9yIGFueSB1c2VycyB0aGF0IHRoZSBuZXcgcGRtX2dhaW4gdmFsdWUgaXMNCj4gPiB0b28gaGln
aCBhbmQgZm9yIGFkZGl0aW9uYWwgZGVidWdnaW5nLCBpbnRyb2R1Y2UgYSBtb2R1bGUgcGFyYW1l
dGVyDQo+ID4gdGhhdCB3b3VsZCBsZXQgdGhlbSBjb25maWd1cmUgaXQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIHNvdW5kL3NvYy9hbWQveWMvYWNwNngtcGRtLWRtYS5jIHwgNyArKysr
KystDQo+ID4gICBzb3VuZC9zb2MvYW1kL3ljL2FjcDZ4LmggICAgICAgICB8IDIgKy0NCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
Li4uDQo+IA0KPiA+ICAgCXBkbV9jdHJsID0gYWNwNnhfcmVhZGwoYWNwX2Jhc2UgKyBBQ1BfV09W
X01JU0NfQ1RSTCk7DQo+ID4gLQlwZG1fY3RybCB8PSBBQ1BfV09WX01JU0NfQ1RSTF9NQVNLOw0K
PiA+ICsJcGRtX2N0cmwgfD0gRklFTERfUFJFUChBQ1BfV09WX0dBSU5fQ09OVFJPTCwgcGRtX2dh
aW4pOw0KPiANCj4gVGhlIGJpdHMgc2hvdWxkIGJlIHplcm9lZCAoQU5EIC0gJikgYmVmb3JlIE9S
IHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBjb3JyZWN0DQo+IHZhbHVlIGlzIHdyaXR0ZW4gdG8gdGhl
IHJlZ2lzdGVyLiBNb3JlIHJlbGF0ZWQgcGF0Y2hlcyBhcmUgYWZmZWN0ZWQuDQoNCkkgaGFkIGNv
bnNpZGVyIHRoaXMsIGJ1dCB0aGUgaGFyZHdhcmUgZGVmYXVsdCBhdCByZXNldCBpcyAweDAuICBE
byB5b3UgdGhpbmsgaXQncw0Kc3RpbGwgbmVjZXNzYXJ5IGZvciBwb3N0ZXJpdHk/DQo=
