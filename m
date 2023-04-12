Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6FA6DF0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjDLJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjDLJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:43:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A389000
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg2VDk37OGOhEtBXBY0HW7hwXDTTM3zRkXCI3/W2mbgNO3GRaLD+DsFTiSaBYOz6GklxJZ/5svrRFzxWAhFWbtDBwea4Hj+tBVeQH/QMZkGFzN/0+adZda9vHIxJN3Ah4H2TbfzS5J5b+2ZgoEpSdNyqZ0vxdTUipS5/l5L2UA5tY18KhySY086dUk4HKlgpuLO9lOETGE98Pjs8iP+STmQlvJMTAnvPqnpSPnnt2THhoka34hm/hym60zc1OVyHap9HlkQ0PSYsFXW9HsIZtv4rrPVht70n0Tuh5dgWZGVP9u39bfoBsWDiqUH+6UznnSyLzUVBv1OETW3ew150AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK6m2uUJIW8H3vx6JO8ownVsjeUDVN13jWQcJu24+lM=;
 b=fYrBuRzpBcEfahZsVS25Q0Tyoprzx0l9FM9p5ItPOJVcZw3zAuWriFkVoRMeyh9WrdRgVurSMR0dxh1DfmFTmFRoqvKW03ymlVXlyG7jBjHvVRb5WEYrvI6QwVSCNGcqDnhf6ljdhsXYdFNnvsOtHkOusic0pkRneZOYDgAEMdx5PpVTzc6rAE7iachvPmjRcEEfUJXESBmOVU/wMzmnv/yMpJZQsz6py1fuwmt2zlw/fRrto9shHLjG7XtWGI+sCKV4kICc3rY9GT4AP09z4upz6xBtR5EkyBa9We5PKHpMXXrrbQxNrCdcEQ0F52FV0YMVY8Xm7lH2wQv58vUcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK6m2uUJIW8H3vx6JO8ownVsjeUDVN13jWQcJu24+lM=;
 b=xDZUr2XuyD5Ps1c6okr8tH6ee0h4xo7F9QNruoMl5rcW4Qb9VAWUn/HfVjMr/OkBD++4WGW9IbnRCTEajF3Q/3W6jca788hntMvK79ky9yMOY0ZSuctiIGQI0OKxADxX2Z+fjCQOrGDzDuRstSaz1v/bZEuKQCwZI6i6UN9Z6KQ=
Received: from PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:43:29 +0000
Received: from PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a]) by PH0PR12MB5606.namprd12.prod.outlook.com
 ([fe80::2aa9:44d8:ff48:164a%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 09:43:29 +0000
From:   "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: find_get_page() VS pin_user_pages()
Thread-Topic: find_get_page() VS pin_user_pages()
Thread-Index: AdlsqyEC2Ib370amRP6esQRt2dSqSwAbBFMAAALQUFA=
Date:   Wed, 12 Apr 2023 09:43:26 +0000
Message-ID: <PH0PR12MB5606692D8671BBE82612077BF09B9@PH0PR12MB5606.namprd12.prod.outlook.com>
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
 <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com>
In-Reply-To: <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5606:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: 5f5ffa07-b88a-4f35-6dad-08db3b3a5f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuZxnCciCdxUMCbik6arR7GdmavWep25g4EOWy6kLyDL5HQmgP4C9K2snrYWbAdOrfO66LqReX8gqL55x7vdhzyCk0goD7pRrktQ1uVURXnFjy8/OrvCQ4UGRE3VS2XEcrHdfipBqNRHS736MAEWcv61+zJdI+w3lamzjF03Mgyw4CP6isv+d3u3zl5DIN2+FSQCWldsObeOkd3Y4pR3JXYLri2fUBqxBc+HwrH5fGWvRJWmq7PR7ub7UY6j8rVjRjlcOKT9g5s+5Okr+rbCrnMtrOlj77cT0U8v5SVsD8J/r1jHfdv8rqTuv9ERShKAZ7W1u+tZ6cRQUnxNk7k6w6QrCEw7e9bnu6QXDpKeAoH+nYRUB7LDNPzvawFoD/cNBhsCQzUrccLTMazr0qChg7/eRcBCybYBPpjV0Q/bzBojXLDeYPva5ZSKY0XiC7z5r31wSbG1vpjVWINXf/Am60DSjl/IgOlv67YmkNc3qtc7rGrvLyUptdB1bzBkdgk0v9pAfa47ttlsRlj8EYDKH5SaAPk3t8BOHWwSkfO39EPsn2rE7hWpMnEp61uzG0WWpiPsmRkrirQLU1ivghQ/fXnmrRPwMRqfZonwvf8dr/ZJZXHaY5ZeUUttNsggznX9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(76116006)(966005)(478600001)(71200400001)(7696005)(6666004)(26005)(186003)(6506007)(53546011)(110136005)(9686003)(41300700001)(2906002)(52536014)(7416002)(33656002)(5660300002)(38100700002)(122000001)(921005)(66556008)(66476007)(66446008)(66946007)(64756008)(8936002)(38070700005)(316002)(55016003)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2RKWEFKdmNUVWo3eXBqSzhyWk1pdXdaS2ROeVBXbmRuT0Jra1hsZCtXN1pk?=
 =?utf-8?B?amxrL2k2VFJHd0RBUEx5UjBiUUZseU5KMGtJcEFubkRTcFZDdnl2cnU1SHlh?=
 =?utf-8?B?MEgrYW5pQ2NuWElYMUx0bTJtdmk1SjREckFCNWlRTk00ZHZZT2NsR2VXSXNI?=
 =?utf-8?B?UG40MzY2T25kbThHc1BNRDgvc1pwaDlaQWVOa2NwSDlGbWZyRXBUTlg3c2J3?=
 =?utf-8?B?TUVqdnZxVFZnVXphdWc1S2E3RTJlazZvRFBPbXZaQmc4b1poYkxDSGtOQ0hO?=
 =?utf-8?B?dTUyNlptK0p6SU5keis5T0FybWpyTkh4bS9CclQvZHh0VTFSNjlhYlBjbHlO?=
 =?utf-8?B?cTEvS3g5RmRKWFJ5RUFKeUh3c2tmZDk0UEFkUmplZDRhc1g1bGorczd2aWlR?=
 =?utf-8?B?QkRPYlJ3Vk02WGxKUkZwOHNYZnk3ZThqenR5MkxLMU1ETVUrcDJySmdTY0k1?=
 =?utf-8?B?eU91T3p4T3lBTktPUGNsaDVRUnlnVVppY2dPMUZJTVRIUHZNSXVyZTdhdXkr?=
 =?utf-8?B?Tjl3OWhkMFYrZVVCMmlGaURJN2dTNklKME5JVlZJU2xwN2dIajB3T3VhblBV?=
 =?utf-8?B?OVRPS3o5N3o5NFlyTXFLcDF3NWpLVUJ1QU1vNVdURERTeDlFanZxRFpVT2ZZ?=
 =?utf-8?B?TVM3SU1sNTgzVTM0T1UydlJRTXQ4dTVRTElIRzlpazlydW5hd1kyUFFqUW92?=
 =?utf-8?B?SjFCV083NlZQNWJBNnNoVzEvZlJCWnJnOVBGYVY2c3B1Zk9sazFDNUxJWEE0?=
 =?utf-8?B?Q3hrMFJqSDJ2dVFlTTVHaGo1c3JvczdIK3dUUE4vWHozWDI4djQ3RzNMRnJE?=
 =?utf-8?B?VGVXQy85N2hmVFFVbk9jVWFOU1FtbEt1RkEvRWFURlBqVWErb25Od0dVSWJ3?=
 =?utf-8?B?QU9HNmNMTitMeHExYU0ySkR1d3FLWWxqWHp6TUYzMVhNZWtIZjQrVnNWTVJW?=
 =?utf-8?B?RXJlNmVvODgyNmRPUlNjUVZuMmRTNjlhVDhHNTdVRVdwVjVYZ2hLR1ZPYTJC?=
 =?utf-8?B?WThSTzBQbFpsc1drVTE0TytMV1VUOUQ4aWZad2RxMVczT216bWJjNmM5OHVm?=
 =?utf-8?B?S0V1bURIa290WjVaZjh4SFVwTkt3ZklHMlEwT1k0ME1UUFBGak1ZN25tamYx?=
 =?utf-8?B?SVkrMUg3cGhWVmpSdDhNa3VTTTNqVndEY1lDeTFLaHI3UVlJWWc2bDQ3M09l?=
 =?utf-8?B?WDdMY0ZkajVxUDJ6WEgvU05nNUVjSzhLT2R3WTJJU2s1c1Qyd1QwN0tXTExX?=
 =?utf-8?B?Q1VzaEo5YnpJY1BaWGxYNXJJaDNXbEZVQWc5c0lmVURqaGJQVW1QRUZEOGVZ?=
 =?utf-8?B?WkZnNVNEbDRrWitsMXNnUGZRNVQxRUorSWJtdmdMSm9RalhOQTdELzNacEZB?=
 =?utf-8?B?M0pQYldKUzJaVTZjNjQ5S29sUTJud2NRVnR1MnpKTUQyVXRPQU5CZXF0dFpG?=
 =?utf-8?B?Mkg5REh5MEwyaFdpU3YyOG5MWU9vdmRYSEJvWkNUM0d3blpONlhTZ1NITCtr?=
 =?utf-8?B?MjlvOVFEbTlLYW9MZWdFb3dBdkp0clM5KzhoK3p4cmpialRzaU5rRStySXpT?=
 =?utf-8?B?Qk1XR2RNWkQ2NjloRnZNKzZISWZWUmlwODNrQXBsRzE0WDBCQ2F0QVdlNkc4?=
 =?utf-8?B?cDFLcVZzVXUwNlV3Rk5CMUkrbVV1WEdSelhBVlRjM1Bselc3NVRYcWpmdEtL?=
 =?utf-8?B?aEhJbGVvcGRqKzhCUW92TEJhN1R3UFpFSm9KL1dXT2VOM1RZV3FpYUdqU1pL?=
 =?utf-8?B?TFdoZ2xFQ0pGeUFTYjVNMjNrVjQ3RUxmd0JOZG1xZENVK3ZxYzlnT25FWllo?=
 =?utf-8?B?cityTEZLUE1QaU52TkJuQWgwcXJYVG1DUVNRelVJcHNWSTkxRHVkV3dEck4y?=
 =?utf-8?B?UW02ZzZoK3ZoQ3p0TjVnVlVnUk5maFk0T2pMMjkxUm5HQnE0NVFTMThWeFB0?=
 =?utf-8?B?UU1LUytlL3doajBFWXVReC9yWlBYVEF0Ny9XN2g2ODlrTUQvYU1oNGo0b01Q?=
 =?utf-8?B?N3pQZVp1SU9yN3p1RHpvTlJEY0Ftc1hERHVpeGlidVRPcnhTaWZLNnc0M3V3?=
 =?utf-8?B?ZnljSXJxU0ZvT0xsbE5QcWczQTNnUFd6MncydDd4dHhTQ1JXM3JBWUxOUENn?=
 =?utf-8?Q?ZZhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5ffa07-b88a-4f35-6dad-08db3b3a5f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:43:26.4386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uwWI+E5lm4RToZ6HVdJu2dGufdnLZtCP7z7Jyc6MS2TcsbI63BQjydre0xXf3NCdKRyd0Rl3dF6CnHV73nWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IA0KDQo+IE9uIDExLjA0
LjIzIDIxOjQzLCBUZXRlcmV2a292LCBJdmFuIHdyb3RlOg0KPiA+DQo+ID4gSSBhbSBzdHVkeWlu
ZyB0aGUgcGluX3VzZXJfcGFnZXMqKCkgZmFtaWx5IG9mIGZ1bmN0aW9ucywgYW5kIEkgd29uZGVy
IGlmIHRoZQ0KPiA+IG91dGxpbmVkIHdvcmtmbG93IHJlcXVpcmVzIGl0LiBUaGUgaHVnZXBhZ2Vz
IGRvIG5vdCBwYWdlIG91dCwgYnV0IHRoZXkgY2FuIG1vdmUNCj4gPiBhcyB0aGV5IG1heSBiZSBh
bGxvY2F0ZWQgd2l0aCBHRlBfSElHSFVTRVJfTU9WQUJMRS4gSG93ZXZlciwgZmluZF9nZXRfcGFn
ZSgpDQo+ID4gbXVzdCBpbmNyZW1lbnQgdGhlIHBhZ2UgcmVmZXJlbmNlIGNvdW50ZXIgd2l0aG91
dCBtYXBwaW5nIGFuZCBwcmV2ZW50IGl0IGZyb20NCj4gPiBtb3ZpbmcuIEluIHBhcnRpY3VsYXIs
IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL21tL3BhZ2VfbWlncmF0aW9uLmh0bWw6DQo+IA0KPiBJ
IHN1c3BlY3QgdGhhdCBmaW5kX2dldF9wYWdlKCkgaXMgbm90IHRoZSBraW5kIG9mIGludGVyZmFj
ZSB5b3Ugd2FudCB0bw0KPiB1c2UgZm9yIHRoZSBwdXJwb3NlIHlvdSBkZXNjcmliZS4gZmluZF9n
ZXRfcGFnZSgpIGlzIGEgd3JhcHBlciBhcm91bmQNCj4gcGFnZWNhY2hlX2dldF9wYWdlKCkgYW5k
IHNlZW1zIG1vcmUgbGlrZSBhIGhlbHBlciBmb3IgaW1wbGVtZW50aW5nIGFuIGZzDQo+IChsb29r
aW5nIGF0IHRoZSB1c2VycyBhbmQgdGhlIGZhY3QgdGhhdCBpdCBvbmx5IGNvbnNpZGVycyBwYWdl
cyB0aGF0IGFyZQ0KPiBpbiB0aGUgcGFnZWNhY2hlKS4NCj4gDQo+IEluc3RlYWQsIHlvdSBtaWdo
dCB3YW50IHRvIG1tYXAgdGhlIG1lbWZkIGFuZCBwYXNzIHRoZSB1c2VyIHNwYWNlDQo+IGFkZHJl
c3MgcmFuZ2UgdG8gdGhlIGlvY3RsLiBUaGVyZSwgeW91J2QgY2FsbCBwaW5fdXNlcl9wYWdlc18q
KCkuDQo+IA0KPiBJbiBnZW5lcmFsLCBmb3IgbG9uZy10ZXJtIHBpbm5pbmcgYSBwYWdlIChwb3Nz
aWJseSBrZWVwaW5nIHRoZSBwYWdlDQo+IHBpbm5lZCBmb3JldmVyLCBjb250cm9sbGVkIGJ5IHVz
ZXIgc3BhY2UsIHdoaWNoIHNlZW1zIHRvIGJlIHdoYXQgeW91IGFyZQ0KPiBkb2luZykgeW91IHdh
bnQgc28gdXNlIHBpbl91c2VyX3BhZ2VzKCkgd2l0aCBGT0xMX0xPTkdURVJNLiBUaGF0IHdpbGwN
Cj4gdHJ5IG1pZ3JhdGluZyB0aGUgcGFnZSBvZmYgb2YgZS5nLiwgWk9ORV9NT1ZBQkxFIG9yIE1J
R1JBVEVfQ01BLCB3aGVyZQ0KPiBtb3ZhYmlsaXR5IGhhcyB0byBiZSBndWFyYW50ZWVkLg0KPiAN
Cg0KVGhhbmtzLCBEYXZpZC4gQXMgSSBhbSB0cnlpbmcgdG8gb3V0bGluZSB0byBBbGlzdGFpciBp
biBhbm90aGVyIHRocmVhZCwgb3VyDQphcHBsaWNhdGlvbiBpcyBkZXNpZ25lZCB3aXRoIHRoZSBr
ZXJuZWwgbW9kdWxlIGRyaXZpbmcgbWVtb3J5IGFsbG9jYXRpb24sDQpwcmVmZXJhYmx5IGJhY2tl
ZCBieSBtYXBwYWJsZSBodWdlcGFnZXMuIFRoZSBrZXJuZWwgbW9kdWxlIG1pZ2h0IHRlbGwgRE1B
IGFib3V0DQp0aGUgcGFnZXMgYmVmb3JlIHRoZSBvcmlnaW5hdGluZyB1c2Vyc3BhY2UgYXBwbGlj
YXRpb24gbWFwcyB0aGVtIHNvIHRoYXQgdGhlDQprZXJuZWwgbW9kdWxlIGRvZXMgbm90IGhhdmUg
dGhlIHN0YXJ0IGFkZHJlc3MgZm9yIHBpbl91c2VyX3BhZ2VzKigpIGF0IGhhbmQuDQoNCkkgYmVs
aWV2ZSB0aGF0IGZpbmRfZ2V0X3BhZ2UoKSBoYXBwZW5zIHRvIHdvcmsgZm9yIHRoZSBhcHBsaWNh
dGlvbiBiZWNhdXNlIGl0DQppcyBiYWNrZWQgYnkgYSBmaWxlIGNyZWF0ZWQgYnkgaHVnZXRsYl9m
aWxlX3NldHVwKCkuIEhvd2V2ZXIsIHdlIHNob3VsZA0KY29uc2lkZXIgYWxpZ25pbmcgaXQgd2l0
aCB0aGUgQVBJLCBhcyB5b3UgZXhwbGFpbmVkIGFib3ZlIGFuZCBzdG9wIGFidXNpbmcNCmZpbmRf
Z2V0X3BhZ2UoKS4NCg0KVGhhbmtzLA0KSXZhbg0K
