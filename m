Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16565F9B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAFCw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAFCww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:52:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6081B1CE;
        Thu,  5 Jan 2023 18:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StkBAfC+ERIaJTry09tYCwGgap6YMdXgLnG4SNu5o+Nw2tCvoIGp8M/gkYEb1+XeYbhe7+bfyRWgWykOtgNbvUOHx4bAd9legpMS6AN8H1nPCn8Y3IJjHmed5vDjyl2QZKhAv8qkAY4+5bMGx4nldXEcwPDTJCg0VTnPaSnNr0xztCbKV9AK0dERJk32NzQ86YbTMaELKOVqjotnqRrrl20rHToo2gJ1bl2CLhuB/hq7G006/E/wZnQUfo3CGrZoCab5nWuU8reQSRw6csp2Yz4HZlCQmKub2Rh7WinK8vppzArXrW+JFw1oYY9Ac+YkD9NbPW656UuXkO2RP2AzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+1t9o1PQOR+13bTjWLSOCKhQ1FUEP6WBhZ8Fgp5oaY=;
 b=gDqHlIRGvqdfN5/7vhEllWnSiqhzWz9NrBRPlvaoUaHoyFPxoXSF1lZ13sc+EerB0efFQdnr3yaKXKCG4ArCtHn/hR5wef+pCt0zqOImPYaV7nURYTfqzKsmjC6fKUK7EaXqMevsy/01vUY/AeKnDBcqbe5c5WLMgJbhYzsRqonV9TvXl56RXxKM9CIIH3L9CJo3q7tOQAfW2LYcyBbPivIz/QEFWJSeaIMjd6vQGl5rz1g/nv+uspwo0ixWwbYtWx2NZXB5UwqyITAMFUK7fOzXl5nXjKrDZW/rm+ix8+pkvDXE8BeFYEe3uhDDdTHkG4h3FpUBg1srndNzHpsv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+1t9o1PQOR+13bTjWLSOCKhQ1FUEP6WBhZ8Fgp5oaY=;
 b=cLNBwckG4r8lu+bYw8V51VDx9zJltoU1+fNhqedw5PQJjre+9Q56KlyiDqzy9ytBjBOe9WLNNJ3IfNQSK38QGbhobfcov4uSuCh9dYv4J0t2me++VDR1xSwWwrfe/UB+tx4mTTXtDYRzE4uudwiPJRQtJXvTmREp3I84IKnIfTY=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:52:48 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:52:48 +0000
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
Thread-Index: AQHZGH8M3+HiCNL7ukyC70Df9L9r3K6QDYMAgAC06lA=
Date:   Fri, 6 Jan 2023 02:52:48 +0000
Message-ID: <DM4PR12MB52784DC840E4AB591E07BF8A9CFB9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-10-perry.yuan@amd.com>
 <9afd6384-fb1a-933f-7873-eaeec38cc65c@amd.com>
In-Reply-To: <9afd6384-fb1a-933f-7873-eaeec38cc65c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-06T02:52:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a53673f-e90d-453a-8e74-d0c1b1068b3b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-06T02:52:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 916cd0d1-fe3f-4e95-9888-367c93f5f59a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH7PR12MB5926:EE_
x-ms-office365-filtering-correlation-id: 214ec0e6-7d22-4ec8-a050-08daef91186a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zi4IEXwIwqyBAagDP3NTW2NIN0/b6nnobV3JIHlXkq3cfzA757+CkvHMsa10EtzXRNaX8T4JTPiY1XSBT0ynI0Ibior9WluXQAhqymzEiqbdpD+EAEFwg3Y3H3C37LILSLnvhUkJ8XtIItQ9n3jykDhp3jQdyZoF9T2PUTepCzgz2lI6WPqyFTxBMtnF/mdHlI6wjwlGlu1lFHB8YTBOUbp2DMulDi56Kmud8/nl9F3w5yISOl+kk3HItZ7C10lVZf7EnEeWMbo37DNTIYgIZinYQQvuNtIvTGU1zlRSUscQ8KGYtL2f+lR0NtOTEwu6V9rFqur1YNSzvRwpYw/Fcu4EpIjE0RN52CvOcfi7oOeBybAN1RguhrzlhiRcOoImQzZOb0Zvka/SR0ya4dKhUZPIb3+uc6VEzLEhVhQ81ITVSjQ+OurnnlITrouxPCNJ/h7ndWBEa1qy5uxjMHDqdR1OuUIvUCm0jlldlPZ9+tpfqRCOXyIy1Or56O+0lLh7dbQ9usuyMTVwW6QtZ410uWjRX8LIMILCQOPDMBTC+wNiXEIi6OuQPsN4n9kYfT0pLdLfoEGV1XV1JL7a/pJEvR62UaDy6pSruqI6Dq+goevyRcLIA6qeNgnaQasDG7DjJO8zxx4jnadvwykHoJ9gx1cCrqtE3P+kLShp4yPNh1u7nLjdYLGqkZpaLvjauK9X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(38100700002)(38070700005)(122000001)(55016003)(33656002)(316002)(86362001)(54906003)(71200400001)(53546011)(6506007)(110136005)(7696005)(478600001)(26005)(186003)(9686003)(5660300002)(83380400001)(2906002)(66446008)(66556008)(8676002)(4326008)(66946007)(66476007)(52536014)(76116006)(64756008)(41300700001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmM3aHdkWkI5QVluL3lYWnA4WFJHWldTN2RUaE9Yd1dRYURmTDBPRzNGajQ4?=
 =?utf-8?B?QzNXVlk3S1BpVUttVDRFaFJOamE2NTBVQVlTaW9ncUVEK1diSS9Na0hEbGNz?=
 =?utf-8?B?V29JUXVIYXFvZXZscjJKRFRwMU03ZnI0RE5haVlZZnhRTHZZRkU4ZFFaaW03?=
 =?utf-8?B?Z09XSUgzdUQ3S3lNYjFKc2QwKzh4R3NhSzBLekg4Z01yZlF6Y1VvTEhGdGx4?=
 =?utf-8?B?dUZTU1Q4QVZhaUl5SEJKM3Jvd3RYL25wNkMzUEJQRUNJOWZiTW55YjR2aG1r?=
 =?utf-8?B?aHBqMlovWHIxcVhnd2c4cjZMb21CNnZhdVBuVWFxTVpVRStJRnhydURvVWNG?=
 =?utf-8?B?VEdlbmNKRHJuU1lINTQ4aVdjRzhmcW9GdldWUVdZeklvRlEwZyttNE9ma0p4?=
 =?utf-8?B?ejkwOEwyM1VGbkFOQ2UzOXo2TmZnVHBCZ2kvb2w5V0JSY0lGUlg4a1ZKUng5?=
 =?utf-8?B?RFhQdThraVllMGV4WDF2QTJyUzNVeWRJN3VZb01MN0Q3VnhCTm1vc1V1MG9D?=
 =?utf-8?B?ZFJIL0t4TmxMeHgyTjVHbmxPNUgyMXo3elJsVE90TVpFbWQzaFlZcGNPZGR3?=
 =?utf-8?B?NDBBeVZlQUhQQ2FZT0pFZENBTGY3d2hmSjRxRTUwckdGRzc4cVhsRUxLSjJG?=
 =?utf-8?B?cUtDejNXYi9BTW1henI4QzRmVTZJU1pwZVhwSjRlb1pmemFLRU9keTIxVldS?=
 =?utf-8?B?MUpIdXBVN0JibEExN1FLV0J0MSt6SThjQWZ3MCtkU0VaMUh5cWpGOE51cXRM?=
 =?utf-8?B?WE9xaEpmMUJTSUtvWVl4Qm5uVWRKSE9NYlkvNXZjTDdmSnRSZFh6ZXNKUDJx?=
 =?utf-8?B?a1FRdG85WWNVWmxIUzdwNWRvK2hIYjhJQVcyTytsdURnWE9XWUZlUklFSGhW?=
 =?utf-8?B?azRiM1BRUW80TUlDUFo3MC9oNGx3a3cweE52bzY1YnNGUW5MbGlXNkhpdi9n?=
 =?utf-8?B?MjNvVGl0YkJ5N2ZYVGxXM0d6bTR5UGVqVHJRbmtnaElZbG9BWm4yak1FYlFp?=
 =?utf-8?B?dDBNYTMycFFzK2prUW9PQjV6dFViN2Jrbmp4NDRacHZXaWkva0ZLeFlxcHdn?=
 =?utf-8?B?U0dnUXJkK1NURSs1bThWRitJaTFzdTlzaXBIVjZvSDZOTXhtZ0hmTWNES05o?=
 =?utf-8?B?UHZvKzFFMGY3ekFWT3dBQzd0RzdsRlRpeDgwdU5ISHZGYThyZ1FDcGh0dXFU?=
 =?utf-8?B?UE9hZFU3dmwyS1NtakVoQ1dkZGN3WDdlRExYeDZCYmI5bkVmRVJkSDRFOUl1?=
 =?utf-8?B?OHlvSGNvZHVUbmxMVmpFRFJjRTdvbE9QNmhLNkFzYWhjZ3p2SEtHYTlBQUN2?=
 =?utf-8?B?NmVFWHd5TzZ5bkV1WVFLWllsMjVQdWMwR01jVWZjRkhqcmRVb3Q2U0VpbmZS?=
 =?utf-8?B?LzlDTVJhbzFnTHN0QXVmLy8vL21NZmJoQWNhTm5haEdUTGxJS3JrbHZPSW4w?=
 =?utf-8?B?YXZlWG8yZ3o1RC9SbFNrc29NRzN6QUR4YzU3RTZrcUR0QXZWUENtbEhaNjZx?=
 =?utf-8?B?MDBaTVcweXpZQjZVQldaUVpCNWdQMzNJMW1va3puQkp5UnhnUXBhRU5xUzU0?=
 =?utf-8?B?U2VNMzhXVjdtY3NNZnpaNDEzYjVuOE50U29QOFZvUzU1aXVFTVFJZWIzbEhH?=
 =?utf-8?B?dGN1K3ViK3lLMzN4Y3Mxa3dvQlJWWmw0R2FYL0dRSmR6THFtOFpva2p2bUh0?=
 =?utf-8?B?c0xlOWhkU2d5enFGZEZMZTRqS2tvd3A5OUErYmZhL01nK0FNY1FqWmU1cWlm?=
 =?utf-8?B?YUJMaitNTllMRGFtWW03WkkwbWxpUG1SWUZ6cWdKYi9LOFVTak9kem5jUDF2?=
 =?utf-8?B?Z3pjd0lRNzdiVFVhSmVQVFN0aUJtNjZvaDJXY3ZKNyt5OFcrdUROMXplTmgy?=
 =?utf-8?B?d25uZERVTjJtU0JiR2R5WUt6RzZEbWZYUGtVQjFGL0FVQmh2eGlaNndOcHRG?=
 =?utf-8?B?NHFBOEVsc2czWTFmMWcrTVdSRm5yd3dLL0FxR3pxNXlxR21Fa2YzQkRCc01O?=
 =?utf-8?B?cHZOQk1WcFIwUXErN1pxeklpL2g4R1NjR0pDdDdRTU9peWFKR000R213TitG?=
 =?utf-8?B?ZEZPaEVLdUFJZkM5KzhQQVpBeHEyV0ljWHNRMkUzVTQ4M0oyano5T1dtZjlM?=
 =?utf-8?Q?fWzJCSHHINf3315jshifG9/MI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214ec0e6-7d22-4ec8-a050-08daef91186a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 02:52:48.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liPp0jo3SO05SW1NgIWSYN2CvzCDJE2x5RP4Amrd8Byo5YKZLxoktFlTYu1bCVycwUzYGcVR8dUrjXxmjWTA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFd5ZXMuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FybnksIFd5ZXMgPFd5ZXMuS2FybnlAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDYsIDIwMjMgMTI6MDQgQU0NCj4gVG86IFl1
YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tpQGludGVsLmNv
bTsNCj4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgSHVh
bmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZw0K
PiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IEZvbnRlbm90LCBO
YXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIu
SHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IE1lbmcs
DQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAwOS8xM10gY3B1ZnJlcTogYW1kLXBzdGF0ZTogYWRkIGRyaXZlciB3b3JraW5nIG1v
ZGUNCj4gc3dpdGNoIHN1cHBvcnQNCj4gDQo+IEhpIFBlcnJ5LA0KPiANCj4gT24gMTIvMjUvMjAy
MiAxMDowNCBQTSwgUGVycnkgWXVhbiB3cm90ZToNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IGFtZF9wc3RhdGVfdXBkYXRlX3N0YXR1cyhjb25zdCBjaGFyICpidWYsIHNpemVf
dCBzaXplKSB7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJaW50IG1vZGVfaWR4Ow0KPiA+ICsNCj4g
PiArCWlmIChzaXplID4gNyB8fCBzaXplIDwgMykNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiArCW1vZGVfaWR4ID0gZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGJ1Ziwgc2l6ZSk7DQo+IA0KPiBp
ZiAoc2l6ZSA+IDcgfHwgc2l6ZSA8IDYpIHJpZ2h0Pw0KPiBiZWNhdXNlIHBvc3NpYmxlIHN0cmlu
Z3MgYXJlOiAiZGlzYWJsZSIsICJwYXNzaXZlIiBhbmQgImFjdGl2ZSIuDQo+IA0KDQpTaW5jZSBJ
IHJlbW92ZSB0aGUgIm9mZiIgc3RyaW5nIGZvciB0aGUgdjEwIHNlcmllcywgU28gWWVzLCBJdCB3
aWxsIGJlIGdvb2QgdG8gdXBkYXRlIHRoZSBzaXplIGNoZWNraW5nLg0KDQpQZXJyeS4gDQoNCj4g
LS0NCj4gVGhhbmtzICYgUmVnYXJkcywNCj4gV3llcw0K
