Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84DD65E5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjAEG5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAEG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:57:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD552767;
        Wed,  4 Jan 2023 22:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWtFOgrf6HyGMQFN9AhA9WM79LLBFvTwFh1YYVs7hBk6zBkr3ytibq78OHezlaIYPgyqPqv84LKgWV8zYtFuWaDewuX4X6UwbpLnaDRJC9jWGh+6ivv33BHEFfktKBxKShgFJUpMrwgT+oB13gNhztsBo0AogksUcYc5Zs42As8a9gf3E6F1gkQq4QiU5lDYYJx0nsIhp7tOStRaCDzLLEyzIcRml17ctEQGwqVEjRLW2UL45vBOjGPYLP4Ev1ITfm20MEpVhEwRO0ZRxDBaBU5L6GHGEtdXNKlTNNNjtY5T/ZEGLf0eNEzbQ3aEKy7XNsNxQ6F7jLMOE949WHAPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCCr1A7P8Bz8RCXgH8zUXDA/zOn9ayEINj8Plz4J4G8=;
 b=ffkSDqzURYrSdj41vx7FxUbGuDzblKP0PfObLehwNt++ltjoU97z/tjunrrGtrjUw3qCKhVTVB7NEI8REombIk937lJrYfqASXar6A2sJfsjBDOTo5BR+41lFRwmxfY3V1FXi8RrD724zPjhmSjfAIa9OtqvcR8QiGesio/cIuk2tqr14Fu3CMPTbAHzKXA8HqVfE+u9GknVLhnP4By8fTOfTc+9wtut+DIviY5ann3H6lTZWe5O3lzJRSmnGesgHE+2cpQIYjNZ5EtNOA/TpwEMC+UoTOfnSV7q3u2U1fhd9u/dB4Gw0ANtS5u4Pr4Wrw5sWL6BkLshDHNHwbzmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCCr1A7P8Bz8RCXgH8zUXDA/zOn9ayEINj8Plz4J4G8=;
 b=SwFaNtFO3EwNXcQ0K8yWQe/sQp3asIjDxwEgVB0fna/El/DYIV6YuF0OChulU5J8nD9/0xSz/xepQlHWZpEHkmxgAwePtXuGq2DyrgolhlWRE01gXzYKNfKOURv8uIARaIViC0aO8q01q0sbyclhMYuR3cRqDFJsiqUBfyF21Oc=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:57:14 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:57:14 +0000
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
Subject: RE: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Topic: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Index: AQHZGH8M3+HiCNL7ukyC70Df9L9r3K6PZXqAgAAFcuA=
Date:   Thu, 5 Jan 2023 06:57:14 +0000
Message-ID: <DM4PR12MB52784BDE059CF447DB9E2BA49CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-10-perry.yuan@amd.com>
 <6bf69386-3e8d-d820-de38-38a1bbe987fc@amd.com>
In-Reply-To: <6bf69386-3e8d-d820-de38-38a1bbe987fc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T06:57:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=365173bb-43a5-4328-a6c6-e7119dec4b37;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T06:57:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 28c705ec-7ac9-47db-9f53-0a5bb0b1cf97
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SJ2PR12MB7894:EE_
x-ms-office365-filtering-correlation-id: af7f9f82-a88a-4611-bfac-08daeeea13ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5HFgNObeBMDglUprYr8vU3zocqt+QhzV7TNIdCZD2ckpGowiAB7hOJ4mODT5hAO+pKwwbhuhElb3zrTfi9GjzT/MbUl6d18rlDPOMB0L01riqDbL2tLd19plR5XBoEcIyjMv3yJGRicML+3fifAJlCW8VyxM5pGyaJHyGdJNWH2XxIgBIRLcx2BkNH6jjHqIgkQKO6R613kwUIwgVdKM/IC/+h1cuuQmFfYFQ7QgpJGn/kXH13AI/c4jyfylDhTfzQEsxgIfbA7qUTgR2OylUy6ID4J6xaXLoamF85AuPzS4fws33jq25SMU11IFdFuvm48IcqfbN7v37HPSXgSxje8Xmyd6X1BJFtOPX1AJigAffD+W/EoL+/YvXEbsS+D9Fw5aRb1NJPX981jpJ+b9JsJ4fCTt6at+x3AwXd6q+DIIaTzUyUDfzI1Vbph1IP6Uc91JLfdk3hIWDsH8D5EeATieUhGbxexpQXhQGKEyRFQPy5yhErxd8vY3dokQj8N0CWVoXpWA31q+efzZxb0zM5wHQq1C/8eo8bm7iIr3/XE13e95zWsdAbkjnBmrYGWVPxHEyYaKFRw8AXNvuPM/2zY+qW7a1TvjKEEUQggvsozLA0sMnMMbHDyfiWXMSEH+PH2551kYO+QE3bOxwI07VbyORWZ7eT3BOBXSQ+PllZPK/mvjYhOVtLCzgcyoerCHOLXds6Z/ESTIAEXNVQpLmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(8676002)(4326008)(5660300002)(66556008)(76116006)(66446008)(66946007)(64756008)(316002)(41300700001)(52536014)(8936002)(6506007)(71200400001)(54906003)(110136005)(33656002)(2906002)(478600001)(66476007)(7696005)(38070700005)(9686003)(38100700002)(186003)(55016003)(53546011)(26005)(122000001)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpjTlhUS0ZwNHB6emt6VHJVY2VhSTF1dzBMT3NLYlkwMWdMc3dyNTVrYkdR?=
 =?utf-8?B?a2ptY3Y5dlB4cHR5UFlQTzYzeDFmNWp6dFBVMG44SXlpQmVGelkrNlROWEI1?=
 =?utf-8?B?cW9PZVMrcGF1MVVtZGdBSzFHTXpQN1EwdnlGQjVCRkM1WWQyYTcwRTFMNnFT?=
 =?utf-8?B?czgxOURKZ1p4VHZKNjgyaXVwdmpDOG44ckt6YW8zNXczNVVsUkpmeDIwcUU3?=
 =?utf-8?B?QmxjUUszNkdabmtuYkszNGZqTkJiTi9ML05HVjJkdzU2MXE0anQxWVJ3Nktz?=
 =?utf-8?B?RFV5cUVzVy9NUnNSalJsVldxS21kK2pFL3YrMXJYdFhZSnFBZHVqaVFpWHhB?=
 =?utf-8?B?R2IvQ2ZpajA4dWwzMldiUTh0TDR5c2o0YVFjSTNCMDcxRWp1V1k4V2p6VTJ1?=
 =?utf-8?B?azhWV0xHVWphbTdqTkc3ZmphdDFrSGxvM3NrYTc5dWtzNWhxQ2Q5aERYSy9s?=
 =?utf-8?B?VzgyMFFwMmNQcGZDbDFITUUrU0xCa0R1WE5jNktIRmJLVkoxeTdxQXFhQUhD?=
 =?utf-8?B?N00yanVYZU5qRnMwNTRML2JycGdVMWlGMTJQR29Nb3FCbWpCbnBCcHRFWERu?=
 =?utf-8?B?bitUZUtzR2RpYnYxNGJaMkJHMnV5a2RhZGFUbld3eks3bkRaUUN6WFN3bDNq?=
 =?utf-8?B?aHpKM1pXWVBqaFVwVzFLdExSVk1WRUNHS2hOSVVyNUVIM082Rm05Qy9FRy8x?=
 =?utf-8?B?VmxVbjRFeGFabGpKVkJFUmRpK2s1eXV4aU9KdVhFWGdhK0VGcFZ0bk5UTkQ4?=
 =?utf-8?B?VEcwT3ZKVFZtZ0J6UUR2OFE4YldCQUVLbXFlNW9oWG5FRXY2eSt4NHp3anA5?=
 =?utf-8?B?dlIydzMvYS90M21tZEFNb01FbStKS0luRnh1aWVyRWI1NEU4UlZyS3FBWUp3?=
 =?utf-8?B?K09RR0k4ZSt5QnVuZDBTTGJuRXBEaXFQVkdWSnVSS1B1TzE5WnpwaFU4Y2Z1?=
 =?utf-8?B?VzlkQnNvcGtKNmlXWUdlYmZwR3VSUW4zTGZsU0ZTK2hOL3dNblVHWnpIVlMv?=
 =?utf-8?B?L1B0ODkzMlQvZlU1TGRCRktRYmFSSVFIODhybWNwd0ZkblVCZlJia0hvVVhZ?=
 =?utf-8?B?cnNUQUtpeDJobEZObFFzWTZhOXZsa2RSVGhvNU02Qk5mU1grMXBvMmJKYk1Y?=
 =?utf-8?B?TW9zbk4zc3l5UVJteEw5RVRMaHhuRXNBMWo5ZG1KNW8zSUlCeEVOZEZCYVJo?=
 =?utf-8?B?a1ZHYlZLQk0reFFJZXc5ditPeTZQOHh0U0JmS3h0NWZESjNnNzJZeEhuRElp?=
 =?utf-8?B?S1JvTXNLb25hSDQ0TVFOYUFVNXlGTXJIZk9kSTA3cGpXb2RVTkVPS1lJWHJa?=
 =?utf-8?B?d0toUDE3YW53RE9XbnREaGQ0aGQrbmtpNzBrblVwVCsrRjNhTkkvekYzWGVB?=
 =?utf-8?B?R2J6RHVMaXdwWVJnRElKUTRNa1lXOWYyME9pRXN2SDMwOGhLT3pOdjFvWi9B?=
 =?utf-8?B?Q2tneVNZOHN3bVByajFLODJpTmpKN0dPdVcydjU0NlArOTVUd0tRczZmUTJR?=
 =?utf-8?B?WWwxRXhRZTNSOEZTSEdRbnJyUlJjNkF6L0s3dmxHUDd5bEVqdEMyb0JTd2lD?=
 =?utf-8?B?TXA3a1U1MDFPcWc0VDE3YzJKZG4vSHJtK3ZiS21lT2h6a0Y5RGFHdXVCMnFC?=
 =?utf-8?B?bElnZXpoeStFVkx0UkRwV1pZeGlhb01NRjRVbk9RU1pDZTZBYWFNYXJoeksz?=
 =?utf-8?B?UStmcTJIb3hza3dSYVpjSUpjZ1VRTWRHTEIvZDhJaFhiVytKOXI3eGgvOWhY?=
 =?utf-8?B?STNqMURKeVhsOUhXc0F6V3hKVGU3N0oxekdPL08xcVZXQUYvaHVpUnpwMW50?=
 =?utf-8?B?VFh1T29GeUQxNkZGQTAvQ2x3SExvdSthS1FEeVlEbE9TNlZ2eTJueGZHdm11?=
 =?utf-8?B?YnJQaGZudGZVT0M4aXpsNW1QUHFrWHJncnNnbFdwbHNwQS8vcHg4eW9LemZm?=
 =?utf-8?B?U0pVT0tGOEQ2TFNOYTRPeG9pV2UzTTlTbERBMlJMTE5nMWhEK3pub0x1RmRU?=
 =?utf-8?B?VHpPTDJUejkwdm5OK01IQ1pZN1NRUitkazRBYi9XTld5SFlSVklMamtEeFdn?=
 =?utf-8?B?azRrMWdBNnFuaVZYZTRMR1NsVUVYS2FaTkpPcUI2OUFkU3NzSU94MDE4TGRL?=
 =?utf-8?Q?g/DSal+ADsRUSU9FNP4iR8oFC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f9f82-a88a-4611-bfac-08daeeea13ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:57:14.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAeVgLZMg8H9uznyf8rSWZ66LqmZ5lK3pVgWScyfCqcLoofe/fUcoO8uvKXTtZePJiZYE7K/CYeSuiTC0IxnGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMgMjowMiBQTQ0KPiBUbzogWXVhbiwgUGVy
cnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOw0KPiBM
aW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBIdWFuZywgUmF5
DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBT
aGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0K
PiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkg
KEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5
IDA5LzEzXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBhZGQgZHJpdmVyIHdvcmtpbmcgbW9kZQ0KPiBz
d2l0Y2ggc3VwcG9ydA0KPiANCj4gSGkgUGVycnksDQo+IA0KPiBPbiAxMi8yNS8yMDIyIDEwOjA0
IFBNLCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEZyb206IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5A
YW1kLmNvbT4NCj4gPg0KPiA+IFdoaWxlIGFtZC1wc3RhdGUgZHJpdmVyIHdhcyBsb2FkZWQgd2l0
aCBzcGVjaWZpYyBkcml2ZXIgbW9kZSwgaXQgd2lsbA0KPiA+IG5lZWQgdG8gY2hlY2sgd2hpY2gg
bW9kZSBpcyBlbmFibGVkIGZvciB0aGUgcHN0YXRlIGRyaXZlcixhZGQgdGhpcw0KPiA+IHN5c2Zz
IGVudHJ5IHRvIHNob3cgdGhlIGN1cnJlbnQgc3RhdHVzDQo+ID4NCj4gPiAkIGNhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9hbWQtcHN0YXRlL3N0YXR1cw0KPiA+IGFjdGl2ZQ0KPiA+DQo+ID4g
TWVhbndoaWxlLCB1c2VyIGNhbiBzd2l0Y2ggdGhlIHBzdGF0ZSBkcml2ZXIgbW9kZSB3aXRoIHdy
aXRpbmcgbW9kZQ0KPiA+IHN0cmluZyB0byBzeXNmcyBlbnRyeSBhcyBiZWxvdy4NCj4gPg0KPiA+
IEVuYWJsZSBwYXNzaXZlIG1vZGU6DQo+ID4gJCBzdWRvIGJhc2ggLWMgImVjaG8gcGFzc2l2ZSA+
ICAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9hbWQtDQo+IHBzdGF0ZS9zdGF0dXMiDQo+ID4NCj4g
PiBFbmFibGUgYWN0aXZlIG1vZGUgKEVQUCBkcml2ZXIgbW9kZSk6DQo+ID4gJCBzdWRvIGJhc2gg
LWMgImVjaG8gYWN0aXZlID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kLXBzdGF0ZS9zdGF0
dXMiDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAxMTgNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTE4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4
IGUzNjc2ZDFhODVjNy4uOGNlY2E0NTI0ZmMxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5j
DQo+ID4gQEAgLTYzLDYgKzYzLDcgQEAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciAqZGVm
YXVsdF9wc3RhdGVfZHJpdmVyOw0KPiA+IHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1k
X3BzdGF0ZV9kcml2ZXI7ICBzdGF0aWMgc3RydWN0DQo+ID4gY3B1ZnJlcV9kcml2ZXIgYW1kX3Bz
dGF0ZV9lcHBfZHJpdmVyOyAgc3RhdGljIGludCBjcHBjX3N0YXRlID0NCj4gPiBBTURfUFNUQVRF
X0RJU0FCTEU7DQo+ID4gK3N0cnVjdCBrb2JqZWN0ICphbWRfcHN0YXRlX2tvYmo7DQo+ID4NCj4g
PiAgc3RhdGljIGlubGluZSBpbnQgZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGNvbnN0IGNoYXIgKnN0
ciwgc2l6ZV90IHNpemUpDQo+ID4geyBAQCAtNjMyLDYgKzYzMyw4IEBAIHN0YXRpYyBpbnQgYW1k
X3BzdGF0ZV9jcHVfaW5pdChzdHJ1Y3QNCj4gPiBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPiA+
ICAJcG9saWN5LT5kcml2ZXJfZGF0YSA9IGNwdWRhdGE7DQo+ID4NCj4gPiAgCWFtZF9wc3RhdGVf
Ym9vc3RfaW5pdChjcHVkYXRhKTsNCj4gPiArCWlmICghZGVmYXVsdF9wc3RhdGVfZHJpdmVyLT5h
ZGp1c3RfcGVyZikNCj4gPiArCQlkZWZhdWx0X3BzdGF0ZV9kcml2ZXItPmFkanVzdF9wZXJmID0N
Cj4gYW1kX3BzdGF0ZV9hZGp1c3RfcGVyZjsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4g
PiBAQCAtNzcyLDEyICs3NzUsOTkgQEAgc3RhdGljIHNzaXplX3QNCj4gc2hvd19lbmVyZ3lfcGVy
Zm9ybWFuY2VfcHJlZmVyZW5jZSgNCj4gPiAgCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4i
LCBlbmVyZ3lfcGVyZl9zdHJpbmdzW3ByZWZlcmVuY2VdKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMg
c3NpemVfdCBhbWRfcHN0YXRlX3Nob3dfc3RhdHVzKGNoYXIgKmJ1Zikgew0KPiA+ICsJaWYgKCFk
ZWZhdWx0X3BzdGF0ZV9kcml2ZXIpDQo+ID4gKwkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAib2Zm
XG4iKTsNCj4gDQo+IElNTyAnZGlzYWJsZScgaXMgbW9yZSBjb25zaXN0ZW50IHRvIGNwcGNfc3Rh
dGUuDQoNCldpbGwgY2hhbmdlIHRoZSBzdHJpbmcgdG8gYmUgImRpc2FibGUiIGluIHYxMC4gDQoN
Cj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsDQo+IGFtZF9w
c3RhdGVfbW9kZV9zdHJpbmdbY3BwY19zdGF0ZV0pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgdm9pZCBhbWRfcHN0YXRlX2RyaXZlcl9jbGVhbnVwKHZvaWQpIHsNCj4gPiArCWRlZmF1bHRf
cHN0YXRlX2RyaXZlciA9IE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYW1k
X3BzdGF0ZV91cGRhdGVfc3RhdHVzKGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpIHsNCj4g
PiArCWludCByZXQ7DQo+ID4gKwlpbnQgbW9kZV9pZHg7DQo+ID4gKw0KPiA+ICsJaWYgKHNpemUg
PiA3IHx8IHNpemUgPCAzKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJbW9kZV9pZHgg
PSBnZXRfbW9kZV9pZHhfZnJvbV9zdHIoYnVmLCBzaXplKTsNCj4gPiArDQo+ID4gKwlzd2l0Y2go
bW9kZV9pZHgpIHsNCj4gPiArCWNhc2UgQU1EX1BTVEFURV9ESVNBQkxFOg0KPiA+ICsJCWlmICgh
ZGVmYXVsdF9wc3RhdGVfZHJpdmVyKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQlp
ZiAoY3BwY19zdGF0ZSA9PSBBTURfUFNUQVRFX0FDVElWRSkNCj4gPiArCQkJcmV0dXJuIC1FQlVT
WTsNCj4gPiArCQlyZXQgPSBjcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKGRlZmF1bHRfcHN0YXRl
X2RyaXZlcik7DQo+ID4gKwkJYW1kX3BzdGF0ZV9kcml2ZXJfY2xlYW51cCgpOw0KPiA+ICsJCWJy
ZWFrOw0KPiA+ICsJY2FzZSBBTURfUFNUQVRFX1BBU1NJVkU6DQo+ID4gKwkJaWYgKGRlZmF1bHRf
cHN0YXRlX2RyaXZlcikgew0KPiA+ICsJCQlpZiAoZGVmYXVsdF9wc3RhdGVfZHJpdmVyID09ICZh
bWRfcHN0YXRlX2RyaXZlcikNCj4gPiArCQkJCXJldHVybiAwOw0KPiA+ICsJCQljcHVmcmVxX3Vu
cmVnaXN0ZXJfZHJpdmVyKGRlZmF1bHRfcHN0YXRlX2RyaXZlcik7DQo+ID4gKwkJCWNwcGNfc3Rh
dGUgPSBBTURfUFNUQVRFX1BBU1NJVkU7DQo+ID4gKwkJCWRlZmF1bHRfcHN0YXRlX2RyaXZlciA9
ICZhbWRfcHN0YXRlX2RyaXZlcjsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldCA9IGNwdWZy
ZXFfcmVnaXN0ZXJfZHJpdmVyKGRlZmF1bHRfcHN0YXRlX2RyaXZlcik7DQo+ID4gKwkJYnJlYWs7
DQo+ID4gKwljYXNlIEFNRF9QU1RBVEVfQUNUSVZFOg0KPiA+ICsJCWlmIChkZWZhdWx0X3BzdGF0
ZV9kcml2ZXIpIHsNCj4gPiArCQkJaWYgKGRlZmF1bHRfcHN0YXRlX2RyaXZlciA9PQ0KPiAmYW1k
X3BzdGF0ZV9lcHBfZHJpdmVyKQ0KPiA+ICsJCQkJcmV0dXJuIDA7DQo+ID4gKwkJCWNwdWZyZXFf
dW5yZWdpc3Rlcl9kcml2ZXIoZGVmYXVsdF9wc3RhdGVfZHJpdmVyKTsNCj4gPiArCQkJZGVmYXVs
dF9wc3RhdGVfZHJpdmVyID0gJmFtZF9wc3RhdGVfZXBwX2RyaXZlcjsNCj4gPiArCQkJY3BwY19z
dGF0ZSA9IEFNRF9QU1RBVEVfQUNUSVZFOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJcmV0ID0g
Y3B1ZnJlcV9yZWdpc3Rlcl9kcml2ZXIoZGVmYXVsdF9wc3RhdGVfZHJpdmVyKTsNCj4gPiArCQli
cmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwkJcmV0ID0gLUVJTlZB
TDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBUaGUg
aW1wbGVtZW50YXRpb24gb2YgYW1kX3BzdGF0ZV91cGRhdGVfc3RhdHVzIGZ1bmN0aW9uIGlzIGdv
b2QgYXMgbG9uZw0KPiBhcyB0aGUgcG9zc2libGUgc3RhdGVzIGFyZSBsZXNzLg0KPiBDdXJyZW50
bHkgcHJldl9zdGF0ZSBhbmQgbmV4dF9zdGF0ZSBoYXMgOSBjb21iaW5hdGlvbnMuIEJ1dCB3aXRo
IGd1aWRlZA0KPiBtb2RlIHRoaXMgYmVjb21lcyAxNiBjb21iaW5hdGlvbnMuDQo+IERvIHlvdSBo
YXZlIGFueSBjb25jZXJucyBpZiBJIG9wdGltaXplIHRoaXMgZnVuY3Rpb24gYnkgY3JlYXRpbmcg
YSBzdGF0ZQ0KPiB0cmFuc2l0aW9uIHRhYmxlIGluIGd1aWRlZCBwYXRjaCBzZXJpZXM/DQoNCk5v
IGNvbmNlcm4gLCBwbGVhc2UgZ28gYWhlYWQgIGluIHlvdXIgc2VyaWVzLg0KDQo+IA0KPiA+ICsN
Cj4gPiArc3RhdGljIHNzaXplX3Qgc2hvd19zdGF0dXMoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+
ID4gKwkJCSAgIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+ID4g
Kwlzc2l6ZV90IHJldDsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZhbWRfcHN0YXRlX2RyaXZl
cl9sb2NrKTsNCj4gPiArCXJldCA9IGFtZF9wc3RhdGVfc2hvd19zdGF0dXMoYnVmKTsNCj4gPiAr
CW11dGV4X3VubG9jaygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+ID4gKw0KPiA+ICsJcmV0
dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3Qgc3RvcmVfc3RhdHVz
KHN0cnVjdCBrb2JqZWN0ICphLCBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmIsDQo+ID4gKwkJCSAg
ICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkgew0KPiA+ICsJY2hhciAqcCA9IG1lbWNo
cihidWYsICdcbicsIGNvdW50KTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJbXV0ZXhf
bG9jaygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+ID4gKwlyZXQgPSBhbWRfcHN0YXRlX3Vw
ZGF0ZV9zdGF0dXMoYnVmLCBwID8gcCAtIGJ1ZiA6IGNvdW50KTsNCj4gPiArCW11dGV4X3VubG9j
aygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldCA8IDAg
PyByZXQgOiBjb3VudDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8o
YW1kX3BzdGF0ZV9tYXhfZnJlcSk7DQo+ID4gIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFtZF9wc3Rh
dGVfbG93ZXN0X25vbmxpbmVhcl9mcmVxKTsNCj4gPg0KPiA+ICBjcHVmcmVxX2ZyZXFfYXR0cl9y
byhhbWRfcHN0YXRlX2hpZ2hlc3RfcGVyZik7DQo+ID4gIGNwdWZyZXFfZnJlcV9hdHRyX3J3KGVu
ZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlKTsNCj4gPiAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8o
ZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmZXJlbmNlcyk7DQo+ID4gK2RlZmluZV9v
bmVfZ2xvYmFsX3J3KHN0YXR1cyk7DQo+ID4NCj4gPiAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIg
KmFtZF9wc3RhdGVfYXR0cltdID0gew0KPiA+ICAJJmFtZF9wc3RhdGVfbWF4X2ZyZXEsDQo+ID4g
QEAgLTc5NSw2ICs4ODUsMTUgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVf
ZXBwX2F0dHJbXSA9IHsNCj4gPiAgCU5VTEwsDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIHN0
cnVjdCBhdHRyaWJ1dGUgKnBzdGF0ZV9nbG9iYWxfYXR0cmlidXRlc1tdID0gew0KPiA+ICsJJnN0
YXR1cy5hdHRyLA0KPiA+ICsJTlVMTA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgYW1kX3BzdGF0ZV9nbG9iYWxfYXR0cl9ncm91cCA9IHsN
Cj4gPiArCS5hdHRycyA9IHBzdGF0ZV9nbG9iYWxfYXR0cmlidXRlcywNCj4gPiArfTsNCj4gPiAr
DQo+ID4gIHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9lcHBfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFf
cG9saWN5ICpwb2xpY3kpICB7DQo+ID4gIAlpbnQgbWluX2ZyZXEsIG1heF9mcmVxLCBub21pbmFs
X2ZyZXEsIGxvd2VzdF9ub25saW5lYXJfZnJlcSwgcmV0Ow0KPiBAQA0KPiA+IC0xMTU0LDYgKzEy
NTMsMjUgQEAgc3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gIAlp
ZiAocmV0KQ0KPiA+ICAJCXByX2VycigiZmFpbGVkIHRvIHJlZ2lzdGVyIHdpdGggcmV0dXJuICVk
XG4iLCByZXQpOw0KPiA+DQo+ID4gKwlhbWRfcHN0YXRlX2tvYmogPSBrb2JqZWN0X2NyZWF0ZV9h
bmRfYWRkKCJhbWQtcHN0YXRlIiwNCj4gJmNwdV9zdWJzeXMuZGV2X3Jvb3QtPmtvYmopOw0KPiA+
ICsJaWYgKCFhbWRfcHN0YXRlX2tvYmopIHsNCj4gPiArCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJ
CXByX2VycigiZ2xvYmFsIHN5c2ZzIHJlZ2lzdHJhdGlvbiBmYWlsZWQuXG4iKTsNCj4gPiArCQln
b3RvIGtvYmplY3RfZnJlZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBzeXNmc19jcmVh
dGVfZ3JvdXAoYW1kX3BzdGF0ZV9rb2JqLA0KPiAmYW1kX3BzdGF0ZV9nbG9iYWxfYXR0cl9ncm91
cCk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJcHJfZXJyKCJzeXNmcyBhdHRyaWJ1dGUgZXhw
b3J0IGZhaWxlZCB3aXRoIGVycm9yICVkLlxuIiwgcmV0KTsNCj4gPiArCQlnb3RvIGdsb2JhbF9h
dHRyX2ZyZWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
K2dsb2JhbF9hdHRyX2ZyZWU6DQo+ID4gKwlrb2JqZWN0X3B1dChhbWRfcHN0YXRlX2tvYmopOw0K
PiA+ICtrb2JqZWN0X2ZyZWU6DQo+ID4gKwljcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKGRlZmF1
bHRfcHN0YXRlX2RyaXZlcik7DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIGRldmlj
ZV9pbml0Y2FsbChhbWRfcHN0YXRlX2luaXQpOw0KPiANCj4gLS0NCj4gVGhhbmtzICYgUmVnYXJk
cywNCj4gV3llcw0K
