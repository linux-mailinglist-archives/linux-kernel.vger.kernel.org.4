Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5565FB23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAFF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAFF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:58:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3C61478;
        Thu,  5 Jan 2023 21:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7n9FX3xiiPu7C2Idem5n0+EeWAfWddGabj/81cujDs7fw6ceONgs0n+NFcyjJ/O8x2PZ262nWIPyQdOLOwrVUuYB0/0OpllI/JvoRPzGbucAn5aIu58x0qyCPysdU0Ga4uoCY4d882Sa13YvMgCEnbhFzKB2MevDpcmoazzlDjHS6wCWx3G6Zr4GFYpmK/jqERQHuVKp8QJ88BsuigMM2Ntj+FxvxU5a2ZdYvFQMHJTYZkKca0WHwP5B9wIfVBYX6q0uMrLJ0k847EUfetaiQwIuz+fsIMUoXWZZeWrx0dyzeI98R0KDGrlZmhUDLM6GBWEgrHLQdrhnmlYxZWIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eBoghNUwE1y4uqYMb2h40pF0okrcrOUYUW0aoJdL0E=;
 b=g3ydWALO1TnF4bBTXjjvRjcvRth2P0cAza990CDOGcuJdGvZaOi4cM3K6++X47vc0Gy+0Uxg9JHOnnWTRqWmJfNDm1Clbf4cXM8gsTDx/pArJKPBvMbtG3Xx4BkBEy88VQd/gSEJOf71f8VWBl8QlslA1yMUYRkfDcakDY4Mufp6JkHTy7cDWxW38LahozVXv/QrJJJxGc8rX9tZMMeIgTip4xmoNjmisnG8vc2ROKHqCuvouv26iya4DQK5G1cIfPWqMfY7ZRlA1vKqKvzM1zk6AaA0ahQuQu6Kz3rkns6FKkihz0z5gEMqrEyJTxGXeEekyM7SJjbErN1G9NIF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eBoghNUwE1y4uqYMb2h40pF0okrcrOUYUW0aoJdL0E=;
 b=kvlaoEuuBNB+ZEYhzoTq5UX0DiHHIKp6j3rZADxN6ibNoaQAK2+8Md8tzcMuEb3K7ePtRLK7pRQlPp3b1NdtlBH9PPfdQNEjKQLh2PpkZFCFkNb893zu5sBzfzBpQw1X41DBFooHtxQTGxNY/c511wJbTN+vnFnwc1/WYn7Cqzs=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 05:58:40 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 05:58:40 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
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
Subject: RE: [PATCH v9 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Topic: [PATCH v9 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Index: AQHZGH7/m5zLGzzK3EG3ptMdQMNA+a6Q7KsAgAAJP2A=
Date:   Fri, 6 Jan 2023 05:58:40 +0000
Message-ID: <DM4PR12MB5278D7464FA0CEE9A5DB330E9CFB9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-7-perry.yuan@amd.com>
 <c8e15651-d4d3-bdb1-f9d3-b5efb93fcd5b@amd.com>
In-Reply-To: <c8e15651-d4d3-bdb1-f9d3-b5efb93fcd5b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-06T05:58:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d62015f-c77d-482a-b4b3-46414bd34f4f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-06T05:58:36Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d7c24be2-ff91-47b5-a7be-a6fdd2c28f16
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH0PR12MB5482:EE_
x-ms-office365-filtering-correlation-id: e4bde912-bfa7-47aa-d4c1-08daefab0f5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0vDNdxkPEXIiIoLTj9YUWZAGA2YkChOKkuXuLysdNRLmlDg5xWHiTcPO5wjcFUeS86PHzj8b1wN+bdUzCh3Dzfmwdkzgl3JbSJX2DDy9ICzP94NFiRg8jlDVf3pHiVmb5youUgSiojHtivDk4tNnBtc0FMRAwETOpUlg7+6z7nliX8JOqF9I5iG2kzBRbss2EXSLTdjT4GhWuMymzGp8IWpyoARfV1R68uT5YlrpoR5MAlPDk8n1/5L1vvFxwPkLHkdkIXKcAhyUuzETcgva39t5WmGS7YpeVgz23QDKZ6fOGzTfF5wbk4/4lmCvvfRSahCl6zFbLfXezsT4rg/jZvjHdb0ui7GS47iKjSNwg6Kdn6xtO7JsJfJ9yycSH8MWcUgxXSWT8lziw5LuKGwLupj7OQj22XIN5+ljnaDxlcmheUdvllMnRVnaAVJU1k6bPac30zlR4NvEheIYal4N/Ve+YJY4Y1+iZicY/phs+vrprXaHmsIXBJcT11wfabnxb9ou1kQvCEpTJ+c1oav3oav3lM/oNCg8CnaG/9vjv93hV57bfeCGd1B5DEXKGpcWCHaVCz4A7dQeYvC8UCpQv4fjgl71JeTpowj5EtRd75JQit3e2kzoQ396Bd7G4KbxMERRYKUZS1GwgUhSEz36PndufQjyvAkYmDuIMOpNXsVDXEDaQNKAL5t8slVdcrKtNDv+uezxfHcPx1SPV3Wyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(110136005)(6506007)(7696005)(478600001)(53546011)(86362001)(55016003)(122000001)(38070700005)(38100700002)(9686003)(33656002)(186003)(26005)(83380400001)(71200400001)(64756008)(66946007)(8676002)(8936002)(5660300002)(66556008)(76116006)(4326008)(66446008)(66476007)(52536014)(316002)(2906002)(54906003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0J1UjJuZWk3WCsxeE9LM3daUm41amxrSEY4SjU3em1PYzBrOStyZGpVMG9w?=
 =?utf-8?B?Q0xZeHF3Q1oyS05zRTFHME9kOTBpQStjWFU2UEw5NWQ2OGNVQW1GTnUwWEp5?=
 =?utf-8?B?R2NFUmV0WHVyaTgxbENIbUVKY3ZiRW93bnh0MThOQnl3VHVleU1QTGJqOTI1?=
 =?utf-8?B?TVpmNjk4ZWdUbXEvTE1NdDJPV2RZbXpMVGNwYVhScmdSVFlsem1lZlBlRFFP?=
 =?utf-8?B?MVlvRFVlQ01aZk9JMXJINHdXNVQxbjdJWnBGV01NOGhtNU5aOUJET2dYdkh6?=
 =?utf-8?B?QnhSYU1tZDUwaTlxeng4U21acGMvU2puVHBXQytVV0V2aG4rdUxLVUErWmYr?=
 =?utf-8?B?dmt3UWFZbFBQc0l0U2dVQzRNaUkrSWpZa0xqczlIMjF6dnNzRXp5YXUxYkxH?=
 =?utf-8?B?OVpDUGhXc1AxOWNTc2NaK2VzYWVHbGlYaU5IOE03OVVDL3A2bFlaZ1ZRclgy?=
 =?utf-8?B?ZUZmVHVWblRmakZFZVFKanVBeFc2bjFoRnVOZFFyYmdBT3hqVFBtNXczTXZB?=
 =?utf-8?B?QjFNdERhWWtHVnFETkpIOHpsSmk0YU51bW01cUcxS3BFZzd4MGc3US92anpw?=
 =?utf-8?B?a2hyZ0VWWWpPV0dPTWlzMGtnRmpjQWt0OVJRNGJvU0JjTkRpYlhKcTN2WVNn?=
 =?utf-8?B?MW5ZbHVRZ1UrQ2EwWDFWdkFyZjBEVGxLeXFRS0FGOVBOMkhpNkphQktDNzgr?=
 =?utf-8?B?VUtJeG9uQU9oNy9MZDVPaS9jQ0NoKzVpQm5LSmlaQ1BpcTdkeGlRZHBqelZF?=
 =?utf-8?B?ZjBReWxheU9GVXpseEJReEtoMSs0WE56a0FMdmVCUi9OVXBsNnlvNldGVSsx?=
 =?utf-8?B?RFl2eUFQT3dTYlpzcWR1NjMvTk5NSFRaM0Fqc0Jma1RZY3BPcjNBa2RWcElv?=
 =?utf-8?B?UGY5UDJmWEJuTFBjVVFNdHovODVhbzU0MnhNZ3Q0MzdxYmxwekdlODdMVlB6?=
 =?utf-8?B?L3pVRXdpeDFaMG9WMW8yVDVld2dqeDI4bHpqbnRjMWhSdjlKbXBndWRqT3lE?=
 =?utf-8?B?WGEwcW8wcS9tSVRocTJ1d3dxMm1IazNQMW1IK1NaSTVacTh4aUJNTDZYOGl1?=
 =?utf-8?B?RUU2TTV2RDVRTlV6MXhaZW8ydkI0bElZM2VKeWtvMmROOUZNVU9SZHNjWGc2?=
 =?utf-8?B?eFVUbDZZMG5nY0o3Nmhocy9qOU1zRGZYM2lpdEhRUmZ1VjUvS3ZqMWdpQ0xO?=
 =?utf-8?B?RlZsb1ozdk1MK2gvOW9BcG5yUGovdzY5cWtDWWhiSncxQXQ5cmhGV1grZlVC?=
 =?utf-8?B?LzhwMGd5QTYrcnMzMVNOdUo0UUY0ajNxbFJjYUM5YTZyL2tROHVBQkJOMWpr?=
 =?utf-8?B?cG9lOWx5NnBYY2hiTCsvanhQSzZBdWpMcjBId3dXMmpnSzM0ZkVhZEhUR2F4?=
 =?utf-8?B?ZHlGelNrRGVOSDB4K2JXd1gways3ZG14QmZzVk84Zzd0ZWE0TU5FdCtVdkdD?=
 =?utf-8?B?by9FQlRTQ29Id1hFdUJPZUszeSt5SS9leTh6bGtWeVNESGc3QStQL3BMRlM1?=
 =?utf-8?B?bitTM202YzFWaHp3eXE2dUxnUmNZMkxPZU5SSm0zdmZGK2J3V2RzVUgvbWNU?=
 =?utf-8?B?SHR1bER1TDVCajZ4VUVvV1dOTUVleERzUlF5a2paYjdsVnV5VUU5SHcwM08r?=
 =?utf-8?B?YkhYRWJpUWIrSmRIcGVLTGsxazYvUzEyVXVabHNyekdZTCtuVnZCUXJqdWZ2?=
 =?utf-8?B?OStmVEZDS0pTVW5OZ3Y0MmRNZGF2VERnMENleFFkTlFaL1RuZCtYWTZBSXV1?=
 =?utf-8?B?d3prTmkrdzk4dVdVdHlWV1dlZlBnUjdVRlVldGU5RDZ2VXVhc0dRb25ha3lw?=
 =?utf-8?B?UGlsaE1qSXRMYmxaRDg0ZmFPWnhaYkV0SUpKWkVCUXQ1TGp0SU92b1FCd3M0?=
 =?utf-8?B?T3lJUTZTQk9Da09zUlN2SkxxTXhtdkV1Z2Jsa3ZVZjRvUTMvdE1VYUhLUXZ4?=
 =?utf-8?B?ZUdmeHdHbnI3b3FZWlJ4WXFIUm1VMnhkVkdqMFFRSnZFY2lybU8xVmQ3QW5W?=
 =?utf-8?B?eHdOVEUyVU40dzZ4RlRIMlptRG9NSkRTS0JsVVpIM0dnR21yZ0hvNkRRUm1u?=
 =?utf-8?B?L05sRDFpSFBPdURETE9HYVNVVzNqSmxCMVdILzNlTTdBVVBuaFFHQlFnZGNi?=
 =?utf-8?Q?ySYWiKq0edsnw4EJMTdUHBkwJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bde912-bfa7-47aa-d4c1-08daefab0f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 05:58:40.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b90Dgxbmf17c0HcVb1KQsBMhFzBZFk2NXvBrcHs3w88h9WzupCLeDQMcd5B2DSo7dHah3frkfe9b1lYT4WZOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFd5ZXMuIA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFt
ZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSA2LCAyMDIzIDE6MjIgUE0NCj4gVG86IFl1
YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tpQGludGVsLmNv
bTsNCj4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgSHVh
bmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZw0K
PiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IEZvbnRlbm90LCBO
YXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIu
SHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IE1lbmcs
DQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAwNi8xM10gY3B1ZnJlcTogYW1kLXBzdGF0ZTogaW1wbGVtZW50IFBzdGF0ZSBFUFAN
Cj4gc3VwcG9ydCBmb3IgdGhlIEFNRCBwcm9jZXNzb3JzDQo+IA0KPiBIaSBQZXJyeSwNCj4gDQo+
IE9uIDEyLzI1LzIwMjIgMTA6MDQgUE0sIFBlcnJ5IFl1YW4gd3JvdGU6DQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1kX3BzdGF0ZV9lcHBfZHJpdmVy
ID0gew0KPiA+ICsJLmZsYWdzCQk9IENQVUZSRVFfQ09OU1RfTE9PUFMsDQo+ID4gKwkudmVyaWZ5
CQk9IGFtZF9wc3RhdGVfZXBwX3ZlcmlmeV9wb2xpY3ksDQo+ID4gKwkuc2V0cG9saWN5CT0gYW1k
X3BzdGF0ZV9lcHBfc2V0X3BvbGljeSwNCj4gPiArCS5pbml0CQk9IGFtZF9wc3RhdGVfZXBwX2Nw
dV9pbml0LA0KPiA+ICsJLmV4aXQJCT0gYW1kX3BzdGF0ZV9lcHBfY3B1X2V4aXQsDQo+ID4gKwku
bmFtZQkJPSAiYW1kX3BzdGF0ZV9lcHAiLA0KPiANCj4gU21hbGwgbml0LCBhbWRfcHN0YXRlX2Ry
aXZlciBuYW1lIGlzICJhbWQtcHN0YXRlIiwgd2hlcmVhcyBoZXJlIGZvcg0KPiBhbWRfcHN0YXRl
X2VwcF9kcml2ZXIgbmFtZSAiYW1kX3BzdGF0ZV9lcHAiIGlzIHVzZWQuDQo+IFNob3VsZCBhbWRf
cHN0YXRlX2RyaXZlciByZW5hbWVkICJhbWRfcHN0YXRlIj8NCg0KRm9yIHRoZSBub24tZXBwIGFu
ZCBlcHAgZHJpdmVyIG5hbWUsIEkgc3VnZ2VzdCB0byBrZWVwIHRoZSBzYW1lIHJ1bGUgZm9yIHRo
ZSBuYW1lLiBidXQgaXQgZGVwZW5kcyBvbiBSYXkgd291bGQgbGlrZSB0byBjaGFuZ2UgaXQgb3Ig
bm90IGZvciBub24tZXBwIGRyaXZlciBuYW1lLg0KDQoNCj4gDQo+ID4gKwkuYXR0cgkJPSBhbWRf
cHN0YXRlX2VwcF9hdHRyLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBfX2luaXQg
YW1kX3BzdGF0ZV9pbml0KHZvaWQpICB7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC02NTYsNyAr
MTAxMiw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ICAJ
LyogY2FwYWJpbGl0eSBjaGVjayAqLw0KPiA+ICAJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVS
RV9DUFBDKSkgew0KPiA+ICAJCXByX2RlYnVnKCJBTUQgQ1BQQyBNU1IgYmFzZWQgZnVuY3Rpb25h
bGl0eSBpcw0KPiBzdXBwb3J0ZWRcbiIpOw0KPiA+IC0JCWFtZF9wc3RhdGVfZHJpdmVyLmFkanVz
dF9wZXJmID0gYW1kX3BzdGF0ZV9hZGp1c3RfcGVyZjsNCj4gPiArCQlpZiAoY3BwY19zdGF0ZSA9
PSBBTURfUFNUQVRFX1BBU1NJVkUpDQo+ID4gKwkJCWRlZmF1bHRfcHN0YXRlX2RyaXZlci0+YWRq
dXN0X3BlcmYgPQ0KPiBhbWRfcHN0YXRlX2FkanVzdF9wZXJmOw0KPiA+ICAJfSBlbHNlIHsNCj4g
PiAgCQlwcl9kZWJ1ZygiQU1EIENQUEMgc2hhcmVkIG1lbW9yeSBiYXNlZCBmdW5jdGlvbmFsaXR5
IGlzDQo+IHN1cHBvcnRlZFxuIik7DQo+ID4gIAkJc3RhdGljX2NhbGxfdXBkYXRlKGFtZF9wc3Rh
dGVfZW5hYmxlLCBjcHBjX2VuYWJsZSk7IEBAIC0NCj4gNjY3LDE0DQo+ID4gKzEwMjQsMTMgQEAg
c3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gIAkvKiBlbmFibGUg
YW1kIHBzdGF0ZSBmZWF0dXJlICovDQo+ID4gIAlyZXQgPSBhbWRfcHN0YXRlX2VuYWJsZSh0cnVl
KTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAtCQlwcl9lcnIoImZhaWxlZCB0byBlbmFibGUgYW1k
LXBzdGF0ZSB3aXRoIHJldHVybiAlZFxuIiwgcmV0KTsNCj4gPiArCQlwcl9lcnIoImZhaWxlZCB0
byBlbmFibGUgd2l0aCByZXR1cm4gJWRcbiIsIHJldCk7DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4g
PiAgCX0NCj4gPg0KPiA+IC0JcmV0ID0gY3B1ZnJlcV9yZWdpc3Rlcl9kcml2ZXIoJmFtZF9wc3Rh
dGVfZHJpdmVyKTsNCj4gPiArCXJldCA9IGNwdWZyZXFfcmVnaXN0ZXJfZHJpdmVyKGRlZmF1bHRf
cHN0YXRlX2RyaXZlcik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0JCXByX2VycigiZmFpbGVkIHRv
IHJlZ2lzdGVyIGFtZF9wc3RhdGVfZHJpdmVyIHdpdGgNCj4gcmV0dXJuICVkXG4iLA0KPiA+IC0J
CSAgICAgICByZXQpOw0KPiA+ICsJCXByX2VycigiZmFpbGVkIHRvIHJlZ2lzdGVyIHdpdGggcmV0
dXJuICVkXG4iLCByZXQpOw0KPiA+DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gQEAg
LTY5Niw2ICsxMDUyLDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfcGFyYW0oY2hh
ciAqc3RyKQ0KPiA+ICAJCWlmIChjcHBjX3N0YXRlID09IEFNRF9QU1RBVEVfRElTQUJMRSkNCj4g
PiAgCQkJcHJfaW5mbygiZHJpdmVyIGlzIGV4cGxpY2l0bHkgZGlzYWJsZWRcbiIpOw0KPiA+DQo+
ID4gKwkJaWYgKGNwcGNfc3RhdGUgPT0gQU1EX1BTVEFURV9BQ1RJVkUpDQo+ID4gKwkJCWRlZmF1
bHRfcHN0YXRlX2RyaXZlciA9ICZhbWRfcHN0YXRlX2VwcF9kcml2ZXI7DQo+ID4gKw0KPiA+ICsJ
CWlmIChjcHBjX3N0YXRlID09IEFNRF9QU1RBVEVfUEFTU0lWRSkNCj4gPiArCQkJZGVmYXVsdF9w
c3RhdGVfZHJpdmVyID0gJmFtZF9wc3RhdGVfZHJpdmVyOw0KPiA+ICsNCj4gPiAgCQlyZXR1cm4g
MDsNCj4gPiAgCX0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3Rh
dGUuaCBiL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gaW5kZXggZGFlMmNlMGY2NzM1
Li44MzQxYTJhMjk0OGEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRl
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+IEBAIC00Nyw2ICs0
NywxMCBAQCBzdHJ1Y3QgYW1kX2FwZXJmX21wZXJmIHsNCj4gPiAgICogQHByZXY6IExhc3QgQXBl
cmYvTXBlcmYvdHNjIGNvdW50IHZhbHVlIHJlYWQgZnJvbSByZWdpc3Rlcg0KPiA+ICAgKiBAZnJl
cTogY3VycmVudCBjcHUgZnJlcXVlbmN5IHZhbHVlDQo+ID4gICAqIEBib29zdF9zdXBwb3J0ZWQ6
IGNoZWNrIHdoZXRoZXIgdGhlIFByb2Nlc3NvciBvciBTQklPUyBzdXBwb3J0cw0KPiA+IGJvb3N0
IG1vZGUNCj4gPiArICogQGVwcF9wb2xpY3k6IExhc3Qgc2F2ZWQgcG9saWN5IHVzZWQgdG8gc2V0
IGVuZXJneS1wZXJmb3JtYW5jZQ0KPiA+ICsgcHJlZmVyZW5jZQ0KPiA+ICsgKiBAZXBwX2NhY2hl
ZDogQ2FjaGVkIENQUEMgZW5lcmd5LXBlcmZvcm1hbmNlIHByZWZlcmVuY2UgdmFsdWUNCj4gPiAr
ICogQHBvbGljeTogQ3B1ZnJlcSBwb2xpY3kgdmFsdWUNCj4gPiArICogQGNwcGNfY2FwMV9jYWNo
ZWQgQ2FjaGVkIE1TUl9BTURfQ1BQQ19DQVAxIHJlZ2lzdGVyIHZhbHVlDQo+ID4gICAqDQo+ID4g
ICAqIFRoZSBhbWRfY3B1ZGF0YSBpcyBrZXkgcHJpdmF0ZSBkYXRhIGZvciBlYWNoIENQVSB0aHJl
YWQgaW4gQU1EIFAtDQo+IFN0YXRlLCBhbmQNCj4gPiAgICogcmVwcmVzZW50cyBhbGwgdGhlIGF0
dHJpYnV0ZXMgYW5kIGdvYWxzIHRoYXQgQU1EIFAtU3RhdGUgcmVxdWVzdHMgYXQNCj4gcnVudGlt
ZS4NCj4gPiBAQCAtNzIsNiArNzYsMTIgQEAgc3RydWN0IGFtZF9jcHVkYXRhIHsNCj4gPg0KPiA+
ICAJdTY0CWZyZXE7DQo+ID4gIAlib29sCWJvb3N0X3N1cHBvcnRlZDsNCj4gPiArDQo+ID4gKwkv
KiBFUFAgZmVhdHVyZSByZWxhdGVkIGF0dHJpYnV0ZXMqLw0KPiA+ICsJczE2CWVwcF9wb2xpY3k7
DQo+ID4gKwlzMTYJZXBwX2NhY2hlZDsNCj4gPiArCXUzMglwb2xpY3k7DQo+ID4gKwl1NjQJY3Bw
Y19jYXAxX2NhY2hlZDsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKg0KPiANCj4gLS0NCj4gVGhhbmtz
ICYgUmVnYXJkcywNCj4gV3llcw0K
