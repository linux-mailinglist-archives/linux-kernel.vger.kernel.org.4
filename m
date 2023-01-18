Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D56715A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjARHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EFF32E57;
        Tue, 17 Jan 2023 23:27:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7scWd0KhReh/KO6RxTgd6bOLsfmUpVOrKFabWM5xr3VyNZBWeJ7yL7Y1KTtiDFJ8KuVqmjiR0fZrX8Y14nR745MyQHLEZ1GE+zPtWQ/1NVJBqkXFZ/Jf16i91v9cY9LmERAZ1Hpn7HvGz/KqBYb/ENUlcLt+5eGzAaEPMTaJQn2484Kzi8TveDLVgAN1vivd0NMGk05aHcn+5HsG4GTx30nH7QJDLpZwyJ2riKTyI1XuqgVkVhypNzZr7nT0anmLAHu9TfSVru5xuoHcUP0iDx/69G6PPyct2TYR1NnuK00wYTAnOBYwLv8Ay8lwH1x1zZB1aZ5R8+k1D2TuhCCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9v+ClTG10mppyHb9Wzah/WWnsN32Dwapb306CpF/kc=;
 b=HKTy5Q4nMnL7QysQPGmbJAhTFeElZiPesHsnzZDpOlPqoXEr87dTMnEuyezUTH538zI6ulqMdYRYh8LeLEDj8O1dC1WNBQCk1glt/SVVV1JsBUqFJbm3ky+wlSi1oYzc1vYnUZZo3DZRjKwVXmDF1S2w63aNCd5w+HGQKQymuZqplNFTtFUV/lvz0hhyGKdRhkq9ROE4rfUcV++8evtvtylQ9Dkc5s1SoLvlCo+ezT5XPhfFpQOTsnaHR8BTWCjfwcGcaWPrk1qHXfbLSRj9U/vY6u04Y3Li07Efdl3A9rNc6QXMfM4aN7o134RBHRHnRZ+iKInXb05os4mjae+XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9v+ClTG10mppyHb9Wzah/WWnsN32Dwapb306CpF/kc=;
 b=xuJCDBsWox8+3KhC0qZbajqCKtIJbDAPlEo1e10zFZINxXsTrXlWg8ZBr8/41QkbsIr2VvmivEgiE4LbRYJ6DvWYLjBopHt11wpbcv8HnCux1yHCj0hhyinW4NPY+XpPmY3ChXmQDrJM/q5Iel1ojUAgsYMmfDgKYeBNdXIepe0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:27:42 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:27:42 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 08/12] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Topic: [PATCH v10 08/12] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Index: AQHZIZZ6lUTTt0Fby0uOvJb5a81PNa6is+gAgAEW2QCAAA55IA==
Date:   Wed, 18 Jan 2023 07:27:42 +0000
Message-ID: <DM4PR12MB5278B92054BDFB689893BC469CC79@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-9-perry.yuan@amd.com> <Y8apIMZ3b+dLrpA7@amd.com>
 <57ce2408-ef8d-c133-4c10-73f226c11c44@amd.com>
In-Reply-To: <57ce2408-ef8d-c133-4c10-73f226c11c44@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T07:27:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ef47858-da50-4f1f-be62-7f36ef94a348;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-18T07:27:40Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 93d60cd2-20fc-44f3-8302-4574809871f1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|BN9PR12MB5338:EE_
x-ms-office365-filtering-correlation-id: bc9de83d-df2b-4943-e1b1-08daf9257c7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PAtH20f6bQZyHKKKaa8JD9Vk9/kob5Gwjsg6bz50/DcO2YUVdU0/Du9VpmjnaaeDnT7Cpuu7cQRcXHvzM/GXt30ftVm5dYgkeHg+7HVZ8OP0YZQ4LE5OiKCbqjRbQdD4gEJOE1Y75BWG7XZDhfkCDfFyREIehmeHVF2688wx/oNufKwkJvzRcMXW64VNIApOhyuSUWOBr9OFCiNltLPLDJd+CTAo6P89bb+vhP+1vTSORc3okVnrkmjiVIiTeyCHnMSt5m6cGWK97mPqffscmh7jEdlblKT45CrPwW26KqBYul2FS3nJ2OsckL64IXc+saoZ0+vVg/qxCxWEBrYRLHAN1PliNAE28iKUS1eTzlfFdSLoN9sasyq1vpEztXHhpk03tO9bx6e2WaDcuMCGl45WVlXns2HGewvTf8x7a+UOmy7Ret2zpCqtcHuoUjj+7YcwHLtNzVCJphhDmrBR+W9G0qY03Op9FzbHpdcO1EfWoWre8Uo4xRj5Ycsrd7uDpzDHZB+X2gICvIiw9UwLKz3RVB12mUWXw75H5fvHPq7qNoLLq48ZVGJY/6rfv3Ri5STc8gNCH5w6WmKeTE1gggmhIqzzKEltRzBj3hzpFG+XeWPuuoKhaEKLgq3VdmAb4rm0I3NvM+uFPbOMb1fFmE9m76g0NgJ21t+OAXQgEDeN8vs7DgitUVZe1L2uwUzzpsF6hjw2AqFxuqq7dHWDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(86362001)(33656002)(26005)(41300700001)(186003)(53546011)(76116006)(64756008)(4326008)(66476007)(66946007)(66446008)(66556008)(8676002)(9686003)(6506007)(55016003)(38100700002)(6636002)(478600001)(110136005)(7696005)(38070700005)(54906003)(316002)(71200400001)(2906002)(122000001)(52536014)(5660300002)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2pISlRoWXlNbExZOTZIM1JkRW8yenp2bzhSWjFCZmRUcTBteStWZGJyeE9u?=
 =?utf-8?B?RlFYVTRHVEhlK1V3MWtvaGhWM0pETEJKMHNnT2I0bkZnalRjZkhMTXdueW5y?=
 =?utf-8?B?SkdmR0ZNV3prdGJubFRkdlBLYWEvVXhKOEFSalVRaG93bWhJVk5JOFEyV2hI?=
 =?utf-8?B?cUpaSGFyK3ZwZStwektsbVY5SlJCU1VzZmF5VjBacmU4b3I1Rm9jeTQxaVBr?=
 =?utf-8?B?SnRuOGRaaDNjNFZJTHdmR3pNT0dEOXovRnp4UjFzaXJreGtHaG40RzYxS3F2?=
 =?utf-8?B?Yy9RN3BCejFBMmFQbkZ0OHlhcWRwNHFoMkpVQVpISTJSQzdnNnNUbUllRFls?=
 =?utf-8?B?RVU3UGJDcnpxRE1UKzN0RzJSdUYyMUdITjBQYWhMaVNobTlvY1JGeUVGamtL?=
 =?utf-8?B?Y0NSMXNnK2E3bEpyWUpubUdnWTJqM0lGQm5STUZ5Rm4zKzUxKzJvVzgxSXZU?=
 =?utf-8?B?ZVhOellYam5rT3Fya0RmaUwxYXZEYVFXK1pTUGthNlNiSENsS1RIbGhDcTBM?=
 =?utf-8?B?WmhJV3hYRjdjSVZpRUcrNjI5WnVOWVJybDRScmI3Z0YxNUJ5c0JyZEdtL3pE?=
 =?utf-8?B?VFVySk1GMXFxL3dKVVd2a1lERXRWNU1INHdML2MyK09FcU1sQkhNZjVtTGM1?=
 =?utf-8?B?cStiY0lpYUxBK2lGcmdRVzZXbkRXTkxUdzQ2WjJ3QUx6M21PZTZxZTdibWdV?=
 =?utf-8?B?R281RlFnSFhPeUhYSVNjQ2E5ZURXMkllWHJxN2Y4QUtYdjJVd1BONUYvSktE?=
 =?utf-8?B?OHNPbjlOQXR4M2RnVWhnQXJ6NGlLVkk2UHdGN2o1cHoyUWg1dGwvTmEySXgr?=
 =?utf-8?B?NTVlVXVGUy8xRXlnR2J4RE1lMzJjMzM5SmVSZ2pjZlhqUTZ6ZTkwOU52TXRQ?=
 =?utf-8?B?VXhZV1UxWGZIWmF6MTFqOHlnaHhBRitGaWpPeVFNRkxzNHJRTVRIWXZkc1Nt?=
 =?utf-8?B?SWRLVnNlU3crVzBnVnQvZUU3WlhoR3VDMmlUNGVHZUxpRyt2WHhmRWgwalYy?=
 =?utf-8?B?anNyM3lFQ1NTRGxmU3N6ek5lSktQUzdUdTU2aHA5VHJkNTRjdVV1QkFOWjdC?=
 =?utf-8?B?ZVVjWFJQY0tLeDl2MCt5TzNSa250bHZFVDhmaHoxQkxSNS9DcExLeHdzbldP?=
 =?utf-8?B?WEM3eks2VEJFaHRoWGdhV3Y4U3ZTRVQxbHh3YkpEVmVhOWVBRjRrZkJwWEMz?=
 =?utf-8?B?SUdkdXcyVUxqT3Iva3FjcW5vREx6WW9MbHJGb2s2UjFBcFdRWXFHbnN0cEgv?=
 =?utf-8?B?K3FRU3htK0dHa1hTUzA5bXFuZW5MVVRDT2FFQTBXUnNNTzUvM21iWmtrM1lv?=
 =?utf-8?B?Zm9peWkvL1ppN0ZjNU5Vd2ZrUDZHSVNFSUVsdEpEVnl5ekRWazBZRHMrVWtm?=
 =?utf-8?B?WWZWUXdreXl3YTBVOEFscXI0Ly9tTEh6R1FCeW9HOFdUQ1BRbFJwNXhlaTZm?=
 =?utf-8?B?eGF5dHRTaWVwMVVJazRyWER3ZFkwOEhEbllVQmxnT1VPRzBneUk3TUF6UU9H?=
 =?utf-8?B?R0h4djc4cHUvZnpaeVJud0VoZkZ6RlFFKzhtdVVoS08rMng4MXIrWmtYbDBp?=
 =?utf-8?B?Y3ZHd2JlaFRjZHdZN3ZqTUFrbWk2OS85SVU1cUE1bkhOMDFicHpOSk90dGRU?=
 =?utf-8?B?M3IwSzg2UkpGOHFJQjMwZEdCNjJMZjQ0N2hZVGplN2dqSk9pdXFobTRHM1pY?=
 =?utf-8?B?T2tqTitnV1pPVEczVEtobTBmMG9ybG5uZzFOTUJhVDNhSW9YTXcxQkM4THJI?=
 =?utf-8?B?SlM4NTFqaVh2by9KV1NMRnZVTVp3b1AzMU5Gci83QUdSTU9wb1Q3ZEdRdjUy?=
 =?utf-8?B?M043WFdOL1ZKUk5hNnNUdjNCN1VsZnd4N0dVNmdNUm5jaVlrMFlta1dKbDhq?=
 =?utf-8?B?dlBjSzhsRUUrZVFHSjdWcHdUSVlpaVRzL2JGNC92a2k3ZWlyaUJRZ1lVcUxV?=
 =?utf-8?B?RHRMeW1HVFVCbGhjRURPbEdWdXVYbldZakt2djlMM2FMYzBFdkx5bkVnMWVT?=
 =?utf-8?B?eFI4NEVGZ1NjMXhTQS92YXRxKzZrODNvUE16TGhpbVdCam1oTm1CVjVQNE9t?=
 =?utf-8?B?bXAyY2ttejRZS1MxR09OMXZFbWFjZ2t4K014NDI2eTRFWExkV211SnIvTkVM?=
 =?utf-8?Q?3QLnkEo2bBRG0IXRM8FQLImlL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9de83d-df2b-4943-e1b1-08daf9257c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 07:27:42.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKuBsmfchzz0l8ZgbR0IAlYrybeqXbK9drTbtyBd4a7UDFcwT0YK8RgtxaqCy6LabVj9slZw6qnS5zP/RTqyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJheSwgV3lzZS4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYXJueSwgV3llcyA8V3llcy5LYXJu
eUBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTgsIDIwMjMgMjozNSBQTQ0K
PiBUbzogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnku
WXVhbkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207IExpbW9uY2ll
bGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHZpcmVzaC5rdW1hckBs
aW5hcm8ub3JnOyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9u
dGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8
U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29t
PjsgTWVuZywgTGkNCj4gKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxMCAwOC8xMl0gY3B1ZnJlcTogYW1kLXBzdGF0ZTogYWRkIGRyaXZlciB3
b3JraW5nIG1vZGUNCj4gc3dpdGNoIHN1cHBvcnQNCj4gDQo+IEhpIFJheSwgUGVycnksDQo+IA0K
PiBPbiAxLzE3LzIwMjMgNzoyNiBQTSwgSHVhbmcgUnVpIHdyb3RlOg0KPiA+IE9uIEZyaSwgSmFu
IDA2LCAyMDIzIGF0IDAyOjE0OjE2UE0gKzA4MDAsIFl1YW4sIFBlcnJ5IHdyb3RlOg0KPiA+PiBG
cm9tOiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4+DQo+ID4+IFdoaWxlIGFt
ZC1wc3RhdGUgZHJpdmVyIHdhcyBsb2FkZWQgd2l0aCBzcGVjaWZpYyBkcml2ZXIgbW9kZSwgaXQg
d2lsbA0KPiA+PiBuZWVkIHRvIGNoZWNrIHdoaWNoIG1vZGUgaXMgZW5hYmxlZCBmb3IgdGhlIHBz
dGF0ZSBkcml2ZXIsYWRkIHRoaXMNCj4gPj4gc3lzZnMgZW50cnkgdG8gc2hvdyB0aGUgY3VycmVu
dCBzdGF0dXMNCj4gPj4NCj4gPj4gJCBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kLXBz
dGF0ZS9zdGF0dXMNCj4gPj4gYWN0aXZlDQo+ID4+DQo+ID4+IE1lYW53aGlsZSwgdXNlciBjYW4g
c3dpdGNoIHRoZSBwc3RhdGUgZHJpdmVyIG1vZGUgd2l0aCB3cml0aW5nIG1vZGUNCj4gPj4gc3Ry
aW5nIHRvIHN5c2ZzIGVudHJ5IGFzIGJlbG93Lg0KPiA+Pg0KPiA+PiBFbmFibGUgcGFzc2l2ZSBt
b2RlOg0KPiA+PiAkIHN1ZG8gYmFzaCAtYyAiZWNobyBwYXNzaXZlID4gIC9zeXMvZGV2aWNlcy9z
eXN0ZW0vY3B1L2FtZC1wc3RhdGUvc3RhdHVzIg0KPiA+Pg0KPiA+PiBFbmFibGUgYWN0aXZlIG1v
ZGUgKEVQUCBkcml2ZXIgbW9kZSk6DQo+ID4+ICQgc3VkbyBiYXNoIC1jICJlY2hvIGFjdGl2ZSA+
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZC1wc3RhdGUvc3RhdHVzIg0KPiA+Pg0KPiA+PiBS
ZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4g
Pg0KPiA+IFBhdGNoIGlzIEFja2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0K
PiA+DQo+ID4gV3llcywgbWF5IHdlIGhhdmUgYSBhY2sgb3IgYW55IGNvbW1lbnQgZnJvbSB5b3Ug
b2YgdGhpcyBwYXRjaCwgYXMgeW91DQo+ID4gYXJlIHdvcmtpbmcgb24gdGhlIG5ldyBndWlkZWQg
YXV0b25vbW91cyBtb2RlPw0KPiANCj4gVGhpcyBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFd5ZXMgS2FybnkgPHd5ZXMua2FybnlAYW1kLmNvbT4NCj4gDQo+ID4NCj4gPiBU
aGFua3MsDQo+ID4gUmF5DQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIGFjayBhbmQgcmV2aWV3IGZs
YWdzLCAgSSAgd2lsbCBwaWNrIHVwIGFsbCB0aGUgbmV3IGZsYWdzIGluIHYxMS4gDQoNClBlcnJ5
LiANCg0KPiA+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8
IDExOA0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDExOCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1w
c3RhdGUuYyBpbmRleCAyYzhiMTI2Y2VjNWEuLmQzZjRjZGQ4MDNmMw0KPiA+PiAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+PiArKysgYi9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4+IEBAIC02Myw2ICs2Myw3IEBAIHN0YXRpYyBzdHJ1
Y3QgY3B1ZnJlcV9kcml2ZXINCj4gPj4gKmN1cnJlbnRfcHN0YXRlX2RyaXZlcjsgIHN0YXRpYyBz
dHJ1Y3QgY3B1ZnJlcV9kcml2ZXINCj4gPj4gYW1kX3BzdGF0ZV9kcml2ZXI7ICBzdGF0aWMgc3Ry
dWN0IGNwdWZyZXFfZHJpdmVyDQo+ID4+IGFtZF9wc3RhdGVfZXBwX2RyaXZlcjsgIHN0YXRpYyBp
bnQgY3BwY19zdGF0ZSA9IEFNRF9QU1RBVEVfRElTQUJMRTsNCj4gPj4gK3N0cnVjdCBrb2JqZWN0
ICphbWRfcHN0YXRlX2tvYmo7DQo+ID4+DQo+ID4+ICBzdGF0aWMgaW5saW5lIGludCBnZXRfbW9k
ZV9pZHhfZnJvbV9zdHIoY29uc3QgY2hhciAqc3RyLCBzaXplX3QNCj4gPj4gc2l6ZSkgIHsgQEAg
LTYzMSw2ICs2MzIsOCBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfY3B1X2luaXQoc3RydWN0DQo+
ID4+IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+ID4+ICAJcG9saWN5LT5kcml2ZXJfZGF0YSA9
IGNwdWRhdGE7DQo+ID4+DQo+ID4+ICAJYW1kX3BzdGF0ZV9ib29zdF9pbml0KGNwdWRhdGEpOw0K
PiA+PiArCWlmICghY3VycmVudF9wc3RhdGVfZHJpdmVyLT5hZGp1c3RfcGVyZikNCj4gPj4gKwkJ
Y3VycmVudF9wc3RhdGVfZHJpdmVyLT5hZGp1c3RfcGVyZiA9IGFtZF9wc3RhdGVfYWRqdXN0X3Bl
cmY7DQo+ID4+DQo+ID4+ICAJcmV0dXJuIDA7DQo+ID4+DQo+ID4+IEBAIC03NzEsMTIgKzc3NCw5
OSBAQCBzdGF0aWMgc3NpemVfdA0KPiBzaG93X2VuZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNl
KA0KPiA+PiAgCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCBlbmVyZ3lfcGVyZl9zdHJp
bmdzW3ByZWZlcmVuY2VdKTsgIH0NCj4gPj4NCj4gPj4gK3N0YXRpYyBzc2l6ZV90IGFtZF9wc3Rh
dGVfc2hvd19zdGF0dXMoY2hhciAqYnVmKSB7DQo+ID4+ICsJaWYgKCFjdXJyZW50X3BzdGF0ZV9k
cml2ZXIpDQo+ID4+ICsJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgImRpc2FibGVcbiIpOw0KPiA+
PiArDQo+ID4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIGFtZF9wc3RhdGVfbW9k
ZV9zdHJpbmdbY3BwY19zdGF0ZV0pOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdm9p
ZCBhbWRfcHN0YXRlX2RyaXZlcl9jbGVhbnVwKHZvaWQpIHsNCj4gPj4gKwljdXJyZW50X3BzdGF0
ZV9kcml2ZXIgPSBOVUxMOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW50IGFtZF9w
c3RhdGVfdXBkYXRlX3N0YXR1cyhjb25zdCBjaGFyICpidWYsIHNpemVfdCBzaXplKSB7DQo+ID4+
ICsJaW50IHJldDsNCj4gPj4gKwlpbnQgbW9kZV9pZHg7DQo+ID4+ICsNCj4gPj4gKwlpZiAoc2l6
ZSA+IDcgfHwgc2l6ZSA8IDYpDQo+ID4+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+PiArCW1vZGVf
aWR4ID0gZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGJ1Ziwgc2l6ZSk7DQo+ID4+ICsNCj4gPj4gKwlz
d2l0Y2gobW9kZV9pZHgpIHsNCj4gPj4gKwljYXNlIEFNRF9QU1RBVEVfRElTQUJMRToNCj4gPj4g
KwkJaWYgKCFjdXJyZW50X3BzdGF0ZV9kcml2ZXIpDQo+ID4+ICsJCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPj4gKwkJaWYgKGNwcGNfc3RhdGUgPT0gQU1EX1BTVEFURV9BQ1RJVkUpDQo+ID4+ICsJCQly
ZXR1cm4gLUVCVVNZOw0KPiA+PiArCQlyZXQgPSBjcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKGN1
cnJlbnRfcHN0YXRlX2RyaXZlcik7DQo+ID4+ICsJCWFtZF9wc3RhdGVfZHJpdmVyX2NsZWFudXAo
KTsNCj4gPj4gKwkJYnJlYWs7DQo+ID4+ICsJY2FzZSBBTURfUFNUQVRFX1BBU1NJVkU6DQo+ID4+
ICsJCWlmIChjdXJyZW50X3BzdGF0ZV9kcml2ZXIpIHsNCj4gPj4gKwkJCWlmIChjdXJyZW50X3Bz
dGF0ZV9kcml2ZXIgPT0gJmFtZF9wc3RhdGVfZHJpdmVyKQ0KPiA+PiArCQkJCXJldHVybiAwOw0K
PiA+PiArCQkJY3B1ZnJlcV91bnJlZ2lzdGVyX2RyaXZlcihjdXJyZW50X3BzdGF0ZV9kcml2ZXIp
Ow0KPiA+PiArCQkJY3BwY19zdGF0ZSA9IEFNRF9QU1RBVEVfUEFTU0lWRTsNCj4gPj4gKwkJCWN1
cnJlbnRfcHN0YXRlX2RyaXZlciA9ICZhbWRfcHN0YXRlX2RyaXZlcjsNCj4gPj4gKwkJfQ0KPiA+
PiArDQo+ID4+ICsJCXJldCA9IGNwdWZyZXFfcmVnaXN0ZXJfZHJpdmVyKGN1cnJlbnRfcHN0YXRl
X2RyaXZlcik7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiArCWNhc2UgQU1EX1BTVEFURV9BQ1RJVkU6
DQo+ID4+ICsJCWlmIChjdXJyZW50X3BzdGF0ZV9kcml2ZXIpIHsNCj4gPj4gKwkJCWlmIChjdXJy
ZW50X3BzdGF0ZV9kcml2ZXIgPT0gJmFtZF9wc3RhdGVfZXBwX2RyaXZlcikNCj4gPj4gKwkJCQly
ZXR1cm4gMDsNCj4gPj4gKwkJCWNwdWZyZXFfdW5yZWdpc3Rlcl9kcml2ZXIoY3VycmVudF9wc3Rh
dGVfZHJpdmVyKTsNCj4gPj4gKwkJCWN1cnJlbnRfcHN0YXRlX2RyaXZlciA9ICZhbWRfcHN0YXRl
X2VwcF9kcml2ZXI7DQo+ID4+ICsJCQljcHBjX3N0YXRlID0gQU1EX1BTVEFURV9BQ1RJVkU7DQo+
ID4+ICsJCX0NCj4gPj4gKw0KPiA+PiArCQlyZXQgPSBjcHVmcmVxX3JlZ2lzdGVyX2RyaXZlcihj
dXJyZW50X3BzdGF0ZV9kcml2ZXIpOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwlkZWZhdWx0Og0K
PiA+PiArCQlyZXQgPSAtRUlOVkFMOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwl9DQo+ID4+ICsN
Cj4gPj4gKwlyZXR1cm4gcmV0Ow0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgc3NpemVf
dCBzaG93X3N0YXR1cyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPj4gKwkJCSAgIHN0cnVjdCBr
b2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+ID4+ICsJc3NpemVfdCByZXQ7DQo+
ID4+ICsNCj4gPj4gKwltdXRleF9sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPj4g
KwlyZXQgPSBhbWRfcHN0YXRlX3Nob3dfc3RhdHVzKGJ1Zik7DQo+ID4+ICsJbXV0ZXhfdW5sb2Nr
KCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPj4gKw0KPiA+PiArCXJldHVybiByZXQ7DQo+
ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBzc2l6ZV90IHN0b3JlX3N0YXR1cyhzdHJ1Y3Qg
a29iamVjdCAqYSwgc3RydWN0IGtvYmpfYXR0cmlidXRlICpiLA0KPiA+PiArCQkJICAgIGNvbnN0
IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KSB7DQo+ID4+ICsJY2hhciAqcCA9IG1lbWNocihidWYs
ICdcbicsIGNvdW50KTsNCj4gPj4gKwlpbnQgcmV0Ow0KPiA+PiArDQo+ID4+ICsJbXV0ZXhfbG9j
aygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+ID4+ICsJcmV0ID0gYW1kX3BzdGF0ZV91cGRh
dGVfc3RhdHVzKGJ1ZiwgcCA/IHAgLSBidWYgOiBjb3VudCk7DQo+ID4+ICsJbXV0ZXhfdW5sb2Nr
KCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPj4gKw0KPiA+PiArCXJldHVybiByZXQgPCAw
ID8gcmV0IDogY291bnQ7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gIGNwdWZyZXFfZnJlcV9hdHRy
X3JvKGFtZF9wc3RhdGVfbWF4X2ZyZXEpOw0KPiA+PiAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8oYW1k
X3BzdGF0ZV9sb3dlc3Rfbm9ubGluZWFyX2ZyZXEpOw0KPiA+Pg0KPiA+PiAgY3B1ZnJlcV9mcmVx
X2F0dHJfcm8oYW1kX3BzdGF0ZV9oaWdoZXN0X3BlcmYpOw0KPiA+PiAgY3B1ZnJlcV9mcmVxX2F0
dHJfcncoZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2UpOw0KPiA+PiAgY3B1ZnJlcV9mcmVx
X2F0dHJfcm8oZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmZXJlbmNlcyk7DQo+ID4+
ICtkZWZpbmVfb25lX2dsb2JhbF9ydyhzdGF0dXMpOw0KPiA+Pg0KPiA+PiAgc3RhdGljIHN0cnVj
dCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVfYXR0cltdID0gew0KPiA+PiAgCSZhbWRfcHN0YXRlX21h
eF9mcmVxLA0KPiA+PiBAQCAtNzk0LDYgKzg4NCwxNSBAQCBzdGF0aWMgc3RydWN0IGZyZXFfYXR0
ciAqYW1kX3BzdGF0ZV9lcHBfYXR0cltdID0gew0KPiA+PiAgCU5VTEwsDQo+ID4+ICB9Ow0KPiA+
Pg0KPiA+PiArc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnBzdGF0ZV9nbG9iYWxfYXR0cmlidXRl
c1tdID0gew0KPiA+PiArCSZzdGF0dXMuYXR0ciwNCj4gPj4gKwlOVUxMDQo+ID4+ICt9Ow0KPiA+
PiArDQo+ID4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBhbWRfcHN0YXRl
X2dsb2JhbF9hdHRyX2dyb3VwID0gew0KPiA+PiArCS5hdHRycyA9IHBzdGF0ZV9nbG9iYWxfYXR0
cmlidXRlcywNCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gIHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9l
cHBfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpICB7DQo+ID4+ICAJaW50
IG1pbl9mcmVxLCBtYXhfZnJlcSwgbm9taW5hbF9mcmVxLCBsb3dlc3Rfbm9ubGluZWFyX2ZyZXEs
IHJldDsNCj4gPj4gQEAgLTExNTMsNiArMTI1MiwyNSBAQCBzdGF0aWMgaW50IF9faW5pdCBhbWRf
cHN0YXRlX2luaXQodm9pZCkNCj4gPj4gIAlpZiAocmV0KQ0KPiA+PiAgCQlwcl9lcnIoImZhaWxl
ZCB0byByZWdpc3RlciB3aXRoIHJldHVybiAlZFxuIiwgcmV0KTsNCj4gPj4NCj4gPj4gKwlhbWRf
cHN0YXRlX2tvYmogPSBrb2JqZWN0X2NyZWF0ZV9hbmRfYWRkKCJhbWRfcHN0YXRlIiwNCj4gJmNw
dV9zdWJzeXMuZGV2X3Jvb3QtPmtvYmopOw0KPiA+PiArCWlmICghYW1kX3BzdGF0ZV9rb2JqKSB7
DQo+ID4+ICsJCXJldCA9IC1FSU5WQUw7DQo+ID4+ICsJCXByX2VycigiZ2xvYmFsIHN5c2ZzIHJl
Z2lzdHJhdGlvbiBmYWlsZWQuXG4iKTsNCj4gPj4gKwkJZ290byBrb2JqZWN0X2ZyZWU7DQo+ID4+
ICsJfQ0KPiA+PiArDQo+ID4+ICsJcmV0ID0gc3lzZnNfY3JlYXRlX2dyb3VwKGFtZF9wc3RhdGVf
a29iaiwNCj4gJmFtZF9wc3RhdGVfZ2xvYmFsX2F0dHJfZ3JvdXApOw0KPiA+PiArCWlmIChyZXQp
IHsNCj4gPj4gKwkJcHJfZXJyKCJzeXNmcyBhdHRyaWJ1dGUgZXhwb3J0IGZhaWxlZCB3aXRoIGVy
cm9yICVkLlxuIiwgcmV0KTsNCj4gPj4gKwkJZ290byBnbG9iYWxfYXR0cl9mcmVlOw0KPiA+PiAr
CX0NCj4gPj4gKw0KPiA+PiArCXJldHVybiByZXQ7DQo+ID4+ICsNCj4gPj4gK2dsb2JhbF9hdHRy
X2ZyZWU6DQo+ID4+ICsJa29iamVjdF9wdXQoYW1kX3BzdGF0ZV9rb2JqKTsNCj4gPj4gK2tvYmpl
Y3RfZnJlZToNCj4gPj4gKwljcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKGN1cnJlbnRfcHN0YXRl
X2RyaXZlcik7DQo+ID4+ICAJcmV0dXJuIHJldDsNCj4gPj4gIH0NCj4gPj4gIGRldmljZV9pbml0
Y2FsbChhbWRfcHN0YXRlX2luaXQpOw0KPiA+PiAtLQ0KPiA+PiAyLjM0LjENCj4gPj4NCj4gDQo+
IC0tDQo+IFRoYW5rcyAmIFJlZ2FyZHMsDQo+IFd5ZXMNCg==
