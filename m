Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6167199FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjFAKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFAKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:39:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA941A6;
        Thu,  1 Jun 2023 03:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx1Zsz0qdzwNMNZBtn6fhntUwdUhsYhG6bbHweProPYnGyMZplvS2OlBFg6yacSfma1JY/mqu5bnRGSaI7kdYOSKEGd83FcVE49tjBOWSWTO6ZPYM0QjN/zDM12YjbeqPKi1rDIeibdsoSgKoFNcmuK9hU7CP/u+97KLlqzZn3MdMuF8fujb+uw8M810/PG+zmNZ6Xb6B7mSnWQVFewbB5AwM4zEwUwinSw6jFdx1n21h6Nz5Sxl9kpkeQNdgWptcZmUUtECo7Z+Hf9BInXKA3Q7Z/X3/QsdOKmX+vswmi8AF5B8CxtuDxZH2it5cJlTesyM+htwtD6EqPqeg1ajKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj0a0C1NzD7LwdevArh4wvDdD75K26wzDGVbIs/h4ng=;
 b=nvD50S4ri2gsdBcEOe7YZ/mEsgDB96mP04Rr7ZE3P59yeuCge0CktjlgLsykgNDl44KaE1difAFJvk+aThANwl9KVN+u4inSmnNMr/TWC3fP/N8JMimdD/I9h2+igpbbZjrfIA5Z7Wi0qoNMDwxAbnWT+JCL8qBgUFWgm5+twvHeC0fQMUGSrD3p89bLSoLoo/0VcpF75nB0DtSV3zAsWzLKNBwmABt6sF1GykQQoiqeCNdNXh95sdulYI6l29azgrpHe965tBsB7M4TCjovelNK97ECXQKLhlxilceu6TaqikIUMFTXrI9FUbF65ehCsidEQFmMYYdDM7onPHoCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj0a0C1NzD7LwdevArh4wvDdD75K26wzDGVbIs/h4ng=;
 b=a/flOQm4OCbDsLTv6pD/Ncpu6GcZLYnEqmH/Mx9ip99AS/H3paqL5iy9AcAgkKkX/BS11z4wQ7WVitq7rxpRZ1u+HZAlyckLCf1HKjmKe8KRS/TtMNb7RORf1BrwRLLwtbfmbVVfbSoyetz3EVgeVU4nJIvSGNoUTN6MeWiBt9EgFa5Nv2U2xTcI/v6VTBQ5yLEwmejerda934+17+pJC2hMdROg73h8j91oMOcAWElhQK3WwiHcE9EQtPJ/fEtg9IpzdJcsxqgEJY+OzRIdJSr/wRydygnwIdMi47tA/yUhrhhHiR2s0bunayqH9wf7kEe4C0Lttr9PjgMjCks9Bg==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CY8PR10MB6513.namprd10.prod.outlook.com (2603:10b6:930:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.25; Thu, 1 Jun
 2023 10:39:15 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:39:15 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "perex@perex.cz" <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Logitech P710e: Add quirk to fix setting
 sample rate.
Thread-Topic: [PATCH] ALSA: usb-audio: Logitech P710e: Add quirk to fix
 setting sample rate.
Thread-Index: AQHZk76tOTrERb/qZ064LfUyAGXe4691wx+A
Date:   Thu, 1 Jun 2023 10:39:14 +0000
Message-ID: <bef94a3bbcb933e0c9128b602a973b7996ba337e.camel@infinera.com>
References: <20230531125148.892100-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20230531125148.892100-1-joakim.tjernlund@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CY8PR10MB6513:EE_
x-ms-office365-filtering-correlation-id: 28d7d213-5fa4-4d01-ed70-08db628c71f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +D4ihxha3oknkiknCz/2LCt2eiT/8ANERGBPxsmFZXi/qvfU0nEftaw9T98BR66BlUQcpuar1cLftZVs8OB1CqYesoYuRyXVEVuzcfgLRMrVZEGuLNVYrrNtoTDoo7EznYD2Rg5Foc8OaHcklkeTHd8kfSfQa1TMmoVN3ABh3ywR+eQPPTzZkAfA944PS/sfSfAZA7WZ7evYi8WgqfocuLCJBZUi+lIzyGEYBKN67Wpu7TuDJ98v33QUoSifKugXfOR+b/CkxoaD1BsJhLdi5jJOTqW74w/8zpI/I3hTFo3IN4wG3j0oegpsVkDBTaeukMKwmb5mddRiCFE7fQQCu8uZatj+faRB0H/4kwMN4ROqMyXc3HxnwbslR7A+f8j5/0a27bYfUOFbo3Djl4m8y+RtHE60+o6QnxadeCwf0HLHVEaW2/4SJToxvq57cO0ZueDgBU40fY9uk0H0acLGMJqHxKExyp1DxF/fKLEPFU7pWZCf79jeaJKp/9SW8QAS6Oh+QugbyAb6DRC6Lk2PNKLKWiNrVGdsMC4KYf38trDs9Cra2HvJTaxhEtccjgwUSF29UIAhZMaSScLQfoObAXVoLhevk655ibT2NeN3lipr8STR/OknAX2CAogl3Jud
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(5660300002)(36756003)(6486002)(6512007)(6506007)(316002)(41300700001)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(122000001)(76116006)(8936002)(8676002)(91956017)(71200400001)(2616005)(86362001)(478600001)(110136005)(83380400001)(186003)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUpVVE5Bc0t1SUhBMktlOEtha1BHWGhlQmZ4RlNUMzBQQ1hYZytpYTR6bFpC?=
 =?utf-8?B?cXU5NWt1RHJVbGw4ZkN5NUVjMUtPVzJIREkveHc4eTA4Q2ZXam9Wbnl4OGdn?=
 =?utf-8?B?Z2pIN3FQbXNsVVNvdUlwWGFLQTd6RWUzNDQrK0RKN1p0U0lqOWhuYnIweHBR?=
 =?utf-8?B?SmR6OVgvNDVjZ2UxVHRlY3dDV2o2aDNRcm4wL0F1M2RMOEcwaWUxd1AreHdY?=
 =?utf-8?B?Ymg4VkZzMlpPRXdKdEZqMWhyNU9HYkREU25uanhUV1ZUcWdSeFdGMjBKTFQ5?=
 =?utf-8?B?Mm14VXBnZU9rTllXRE5vd0g2dUJOUTBmT3h4bXdkVFRDT09lVnV2NHM0TWpt?=
 =?utf-8?B?enVxMVI1bDcvd0xQbkJ5NXNERlBZNXNadTNvVURRSWhGeU5Sb2x4TU9nbXI5?=
 =?utf-8?B?a1FaNUlxWEVadzB2dSswS3hWblJZZ1E1dzI5R21HclhhUUV6eFkrUXE1NmRC?=
 =?utf-8?B?VmZvRVFYMzVTaDFUeGZid1VPc3BjdU84QnErRVhqN0tRditrclI2d1VEZEtL?=
 =?utf-8?B?UnNMcktPbDI0U2dhRHBwWHBMU05UN1dyVHlVQmdBdlhOajF0U1JoT3RGdTcw?=
 =?utf-8?B?VjhmWk51d1o4d1U4SDFmTmYzSEF6VmZWUFRpU2Nsbm13b1pSZmozS05QTjQ4?=
 =?utf-8?B?VzhqSHR2KzNnR2gzV3ovM3BhZlczbjV2dExjeVVSeGZQb2xKV20xMFhWREN2?=
 =?utf-8?B?ZStUTks4aGsxRVh1TVk4RjQvbGZ1NHp4cXhtZGg1ZTJ0TmtOTnJvc1lreW5a?=
 =?utf-8?B?WW96TXZnZ2pVTm9qUjZGL0lFUUE0cldlV3NBVjl4cU5kL2lwNHVrVkdxSGht?=
 =?utf-8?B?eThxQktmRDF1Z2xLSHJOdkJPZ1Vrd01yWEdIMnppNm80QjBEU1hnTEpNS0x5?=
 =?utf-8?B?aUhQT2ZpcVRUVTRIRXlsaU9qcVZFd0VhdWlwL0UwUWZOSnZuWjYzU09TV3ZW?=
 =?utf-8?B?UHlWdXJ5ZTNOVHJteGdpSkdlQUhQZmVreHgySWhQSzhKRlhhMmZlTkZ5N2Jr?=
 =?utf-8?B?aUZuS01JWk1RVGR6WDZQRmsxOXlqSkJTeS9zZHJGS3paNUZRazVRa09BUE5q?=
 =?utf-8?B?UEZEbnlvUUQ0Wmk4R1RNQXNFRGh1YXp0bkt1bVdaSENwU25adVBWYkFvUUtS?=
 =?utf-8?B?SVdYaU5KSTA4bmRBeTlXMmJHSGdvSzk5ajk4Smt2VjhKTDhOMDVERTI4bXlS?=
 =?utf-8?B?aURpWkJFME1XZC9DREthWWczdDNoSi8wS1pZVHhCVTdOQ0ZldHB3QXl6dGhx?=
 =?utf-8?B?WFNvLzJUOFVGdVRpK1hkQWN2aUZQQVp4OTVEOEhmTzN1dllKWk1OWnJIWGhB?=
 =?utf-8?B?S3V4aHN6bmprSStHd3A0Q3JZNVRYbUU1YWRoRlFibjlnZ2VkNUNJSzBDQ0U3?=
 =?utf-8?B?SkNEN1JQTDdwam1mVkpKblVvY1J0dERQY1JxcXlnV1pkL0hTb082ZnpmSFh6?=
 =?utf-8?B?U250eGEwRlRsN3N3dFZMT3hKOWJCQ3Qrdm1ZNktYU0hmOE5BMnFkNUpnNWxG?=
 =?utf-8?B?eHZ6NDNQV3R4K0hqdGhjSlFxSTFmeFhObGVLYW1XTWdxVkE0dm5NeWxxVEtn?=
 =?utf-8?B?bXhoOG5oRy9MUkZFLzhmM0RoOE01L0c3YnJFNUZES1VvTnRRK1Nadmg1TnMz?=
 =?utf-8?B?Q3drdTFicDVFTkN2OUs3eGJnSkw4eDlOeXRZTlF2VEJJeGZpRHM1SVZucEt4?=
 =?utf-8?B?Y293c205TlNKUlE2WDlMRERIaW5MZlJoWFlvUmFaSzRTdGxxdUZENnk4ZjUw?=
 =?utf-8?B?WHo1WDJYNUVUblh1dzRpZjNuS3Z0SmtXQ0dzMmFqaTNNOGVlcGxTalBJdUMv?=
 =?utf-8?B?U0d1VUFSVUxKWDk0REpGSFN3bmtCUG1uZ0ErU1VEUnNSdk5ZcHdBc1VGREpv?=
 =?utf-8?B?cnZZZ0Z2bUVmck9OcC90bjFnSzBEKzd2MVZ1SVV4MTZkS25BR21YdWloMW52?=
 =?utf-8?B?Z2M4NjJxVWI5OWVkd21ka0c3azhRdjA3cmJ1cDkrc2piZGJucXcwUWl5M1p4?=
 =?utf-8?B?K2JJWHdDL0lrM1QzWk9wSXNNSUxrNUEwRyt4bDRXRzdoaHcrZyt5RFN1cHAr?=
 =?utf-8?B?NWxqZnRVelVpVjNwWlE5bGFDOHRoQXVFS2Z3K3VsR252TXJUTDN0dW92aXZr?=
 =?utf-8?B?amNZM2gyd2dxbTRIWnB6SlRsbXhIZlJScWp6emJjN1h5Z2tJWVRyVDRFdHgx?=
 =?utf-8?Q?i2KvcqnxeeDF8edKyQq4U6ZyFZwv96hWCsWD1KP7eh1K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C9FEFC9CC58D0448CC4A7296B1BFD71@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d7d213-5fa4-4d01-ed70-08db628c71f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 10:39:14.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42yrA3IE76jXgBQXvHFhuxZWm6mauHKIbnlKveSdT5bcde9+BEMKRyUsgBlqkYxgCTj/Rgp36IvP8DDvk1G9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDE0OjUxICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBQNzEwZSwgd2lsbCB0aHJvdyBhbiAiY2Fubm90IHNldCBmcmVxIDQ4MDAwIHRvIGVwIDB4
MyIgZXJyb3IsIG5vDQo+IG1hdHRlciBhZGRpbmcgbWRlbGF5cyBhcm91bmQgc2V0dGluZyBzYW1w
bGUgcmF0ZS4NCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCB0aGUgImNhbm5vdCBzZXQgZnJl
cSA0ODAwMCB0byBlcCAweDMiIG9ubHkgaGFwcGVucyB3aGVuDQprZXJuZWwoNi4xLjMxKSBpbml0
aWFsbHkgcHJvYmVzIHRoZSBkZXZpY2U6DQoNClsgIDU1NS4yMDAxNjZdIHVzYiAzLTE6IFVTQiBk
aXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDE0DQpbICA1NjAuOTA2NTUzXSB1c2IgMy0xOiBuZXcg
ZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAxNSB1c2luZyB4aGNpX2hjZA0KWyAgNTYxLjEw
NDM0MF0gdXNiIDMtMTogMjoxOiBjYW5ub3Qgc2V0IGZyZXEgNDgwMDAgdG8gZXAgMHgzDQpbICA1
NjYuMzQyNDIwXSB1c2IgMy0xOiAyOjE6IGNhbm5vdCBnZXQgZnJlcSBhdCBlcCAweDMNClsgIDU2
Ni40OTcwNTZdIGlucHV0OiBMb2dpdGVjaCBTcGVha2VycGhvbmUgUDcxMGUgQ29uc3VtZXIgQ29u
dHJvbCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTQuMC91c2IzLzMtMS8zLTE6MS4z
LzAwMDM6MDQ2RDowQTRFLjAwMDgvaW5wdXQvaW5wdXQyOQ0KWyAgNTY2LjU0ODgyOF0gaW5wdXQ6
IExvZ2l0ZWNoIFNwZWFrZXJwaG9uZSBQNzEwZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6
MDA6MTQuMC91c2IzLzMtMS8zLTE6MS4zLzAwMDM6MDQ2RDowQTRFLjAwMDgvaW5wdXQvaW5wdXQz
MA0KWyAgNTY2LjU0OTA4Nl0gaGlkLWdlbmVyaWMgMDAwMzowNDZEOjBBNEUuMDAwODogaW5wdXQs
aGlkZGV2OTcsaGlkcmF3NTogVVNCIEhJRCB2MS4xMSBEZXZpY2UgW0xvZ2l0ZWNoIFNwZWFrZXJw
aG9uZSBQNzEwZV0gb24gdXNiLTAwMDA6MDA6MTQuMC0xL2lucHV0Mw0KDQpJIGhhdmUgYSBKYWJy
YSBTUEVBSyA1MTAgd2hpY2ggYmVoYXZlcyB0aGUgc2FtZS4NCk9uY2UgYXR0YWNoZWQgc2V0dGlu
ZyBzYW1wbGUgcmF0ZSB3b3Jrcy4NCiANClNlZW1zIGxpa2UgdGhlIGRldmljZXMgYXJlIG5vdCBy
ZWFkeSB0byBoYW5kbGUgc2FtcGxlIHJhdGUNCnRoaXMgZWFybHkgd2hlbiBkZXZpY2UgaXMgYmVl
aW5nIGF0dGFjaGVkLiBEb2VzIHRoZSBrZXJuZWwgbmVlZCB0byBtYW5hZ2UNCnNhbXBsZSByYXRl
IGJlZm9yZSBkZXZpY2UgaXMgZnVsbHkgYXR0YWNoZWQ/DQoNCiBKb2NrZQ0KPiANCj4gT25seSB3
YXkgdG8gYXZvaWQgaXQgSSBjYW4gZmluZCBpcyB0byBhdm9pZCBzZXR0aW5nIGl0IGF0IGFsbC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRA
aW5maW5lcmEuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gDQo+
ICBJIGFsc28gdHJpZWQgUVVJUktfRkxBR19GSVhFRF9SQVRFIHF1aXJrIGJ1dCB0aGF0IGRpZG50
IGhhdmUgYW55IGVmZmVjdC4NCj4gIHNvdW5kL3VzYi9xdWlya3MuYyB8IDMgKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvc291bmQvdXNiL3F1aXJrcy5jIGIvc291bmQvdXNiL3F1aXJrcy5jDQo+IGluZGV4IDNl
Y2QxYmE3ZmQ0Yi4uODI3N2JmZDNkZWVjIDEwMDY0NA0KPiAtLS0gYS9zb3VuZC91c2IvcXVpcmtz
LmMNCj4gKysrIGIvc291bmQvdXNiL3F1aXJrcy5jDQo+IEBAIC0xOTUyLDcgKzE5NTIsOCBAQCB2
b2lkIHNuZF91c2JfYXVkaW9mb3JtYXRfYXR0cmlidXRlc19xdWlyayhzdHJ1Y3Qgc25kX3VzYl9h
dWRpbyAqY2hpcCwNCj4gIHsNCj4gIAlzd2l0Y2ggKGNoaXAtPnVzYl9pZCkgew0KPiAgCWNhc2Ug
VVNCX0lEKDB4MGE5MiwgMHgwMDUzKTogLyogQXVkaW9UcmFrIE9wdG9wbGF5ICovDQo+IC0JCS8q
IE9wdG9wbGF5IHNldHMgdGhlIHNhbXBsZSByYXRlIGF0dHJpYnV0ZSBhbHRob3VnaA0KPiArCWNh
c2UgVVNCX0lEKDB4MDQ2ZCwgMHgwYTRlKTogLyogTG9naXRlY2ggUDcxMGUgKi8NCj4gKwkJLyog
T3B0b3BsYXkvUDcxMGUgc2V0cyB0aGUgc2FtcGxlIHJhdGUgYXR0cmlidXRlIGFsdGhvdWdoDQo+
ICAJCSAqIGl0IHNlZW1zIG5vdCBzdXBwb3J0aW5nIGl0IGluIGZhY3QuDQo+ICAJCSAqLw0KPiAg
CQlmcC0+YXR0cmlidXRlcyAmPSB+VUFDX0VQX0NTX0FUVFJfU0FNUExFX1JBVEU7DQoNCg==
