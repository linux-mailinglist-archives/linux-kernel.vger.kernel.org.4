Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6715F68BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiJFOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJFOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:02:01 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120044.outbound.protection.outlook.com [40.107.12.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262AA6C1A;
        Thu,  6 Oct 2022 07:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6CJ5s6ngkUJhhxzKYdWkcM8K1AhTKi5CvNffRb0mOXsgw2aWAbKFOvMKVu3JMi6bzOQ0LZRraiXs2kQCCSI89FwcNn40JjpArks4YgAcghdHsKJeLmRzP/c8RQTwBX1j53L53hJjEOrx+g95RrnCpYBaTv1zRy/dEZAtt4t/HLQ/iHDMOcd3n2QM1lyyJx1W7AxQQUH/YLAfR5WAYAlZvBbavFCmhIdZpEcDhnYDyLs1Mu2iupw5Jv9xDooQBQFz/kOV514X/WRwu8sg2eSdkrjHzj+O6Ixwbc76fgVrNYmDWPTO/RB5+kL9XwgsG5H7CdYuTioycnroKVJujfvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0+YkUA9k0avRRt13lOBc/M5dw46xwP1TGB6iTbU9xk=;
 b=aDYjvfO6wyBRZ21brGXkcHBUzANq3/aGokyCSROFf54993k1s5GunBUArB3x7tgNQ413CxMGP1eRvWQzWg/fa+WG1BFj6tspyFVPKDAR33uEnDsQkZL19Sw61JRcdB2MG9uDJCoAhfcmVhuRmpAOcSUpbfZ8FFnMBAfNNyw9xawuhiTCz6jCdNlcX4WEk0v1F/7v1EHlVqPQ5e49bxQUv4Ce7xKOZr+1/j6zzp+Pqy6fudOU+svXCIyFcFGXmpVMa61SMa7AOlrljq1ssh+7heIVBLpcogEZbsijWv5A5Zzjn+CDzvhEcjxkzYdbQNC7sTGmWaCt66oRMM218JYeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+YkUA9k0avRRt13lOBc/M5dw46xwP1TGB6iTbU9xk=;
 b=h/GkeBtA2kTizu1qbrS4OR2LmLDH0UzYUWoAhYK+SpHLGgteAujSoqkB6aH8qJwTig/C/wjlntmLXlvxBLum+gjpgPDScJp3GdfD1fQNY4oexJiJDmOefpyNgwp+1MrnUKlFeReKZ2rHDzci00mb7fgZuugmI8grvAaS4LCXXvnCfeBRbqvARpkQBrHh1N+1oXdNr7xyZVEgO6yeYgElqS4Ch1RVOHOvLJISuBeEyF4lM2M7x6o3VHGWkP56KM52etkOVngouy3wk7+oeUTxzk45IEzzfIH35fdZTXyYnUvl1IqFa8Nx866Qw4R3r5+lqIqR99X/I4+G4nQO9ajdEg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3310.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 14:01:57 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 14:01:57 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Replace NO_IRQ by 0
Thread-Topic: [PATCH] usb: Replace NO_IRQ by 0
Thread-Index: AQHY2UK+PJcRly8Gk0ii4TX51MgeQa4BYqiAgAADNQA=
Date:   Thu, 6 Oct 2022 14:01:57 +0000
Message-ID: <0d2056d8-ed12-88d3-b9c1-d6c1e772dcf3@csgroup.eu>
References: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
 <Yz7dI5iTaguhn73K@rowland.harvard.edu>
In-Reply-To: <Yz7dI5iTaguhn73K@rowland.harvard.edu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3310:EE_
x-ms-office365-filtering-correlation-id: 0d8ac2f6-2a2a-47b6-d447-08daa7a354d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjPJFBTkybi1s0F4x+uSD3AQPQPj9PO9vmMxuK55cUN60tfHxfwXT/IGMzoKOZW53p3ymE6g3n3LoVmZoN6E7Qk2vf99xQOPBGc13qQP7ERM3esoMZjZXwNWXK9hpm6eP0induhe4FkE7S7BaPWP3Eo5cKiLNiGUl2bj4osW3Cc/geiGxvAfpOg8UYVoNPxPiRVcaaQGaptg9nsqce/WLOCCAQN24G29LdwXcCJD6FgYG2ffCs4Z9gUl7QK34ZLKBTdO0UKc2mzAXN9IHqR/VzMNdqppVoQjLCY11BdiyNMld2EgkJy94/J9FA+RZbipoWNtQQCxHN35wI+5BTDF38z0ULV/4rGIfVYg/X0AaLRaRR2dJBkPyVShnJ8ykLZiARZeER63h4+m7kLnJsYVEepZ+zhHrtMQm0kEpPMSktSet2hNnRPbbB6xiqDSmDKSY3Un2QUbq/FuNk4YiQMh9yU2HR1cFdmF3PRozEiat5Htqy84r3RsECuPSiKTQ/z7jGSfmXdCLpbOYlifvFnMvxb2iZNE+JxDNd7d9qg+iLRxOB27YAMZTj7AXKEU/1lSqHwnZ+6Ca9zf+mMRqglc4ZVnMOTOy3Cj9aql4wmrftHvLNRN30K5dsxmPX6jv/FhN6WSU8IJSOlFafijjb/utYEp86Z/GVRFNRK14nyxJlcWTU21CuWpcx3fVEXI/HwqAoIejUCTCPND8/kHm8dF/sSMUf/cGQRX2yGazc4yzDGCdzwX+6Z3zJS66gD8ePf5VQzie7VADnT8M8QmQbSOjjzNBANTKTSGhH1N+55bJLUnDZUKC4J1YEiRnyVl1LkJeBYlysCJ5BFE1pFeFVxcv8m8VEvkszn9Kqu4r7ua1iA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(2906002)(66556008)(2616005)(186003)(38100700002)(83380400001)(38070700005)(122000001)(86362001)(36756003)(76116006)(66476007)(8676002)(478600001)(31696002)(66946007)(66446008)(64756008)(4326008)(31686004)(91956017)(966005)(316002)(6916009)(6512007)(8936002)(5660300002)(71200400001)(54906003)(6506007)(44832011)(41300700001)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU5qTWlpZHJhd3FKL255Wlh0R3hqc3pLcWJYeUw5RnVFTTRtUGl4ekI2N3po?=
 =?utf-8?B?ZGd5QldYeEF0UW1VQkdPTVBFQ2pSbldzUnJpanJPYWhwSlVaK1hqd2NHYW56?=
 =?utf-8?B?WHBUR2pNblZNMFhGK3Jma0lNVFhYS3dieWp4Rm1UdDhNQlloUEFJZ1hna0hv?=
 =?utf-8?B?K0tIOTZSRVZ0VE41ZUxTK1pZTXI5QUIzTVZ1b3VpL0pYUy8vV05NY2MvSDhZ?=
 =?utf-8?B?cTIrdmZTQlhwbFQrSTQ3Rk9VYThLS1Vmb2ZFUmN0d1RRUlZSNnJraU9XclNr?=
 =?utf-8?B?NkROOWdFaXI4bHRvZlUwQmVGZlJJVUFxSk02K3hNbjk1UjE1L25Qd1czby9Z?=
 =?utf-8?B?Tm1LTjBqTlBocjlRNTVEcmZEZXBGVnRBY2xmSnNGL2lBTXV3ODNxN09qUmwv?=
 =?utf-8?B?MUVna2RPYW1kOFhCU29WdEJzWi9yZzFIZ04wRWRQcDBLSjFVcFJya29RNFo1?=
 =?utf-8?B?RmEwSnZObWdJTkdCSDM5Q2hiVzFQSUJxRkkyMzRKaWRjbDllZlZqa2dsL2Ns?=
 =?utf-8?B?UVVvdXhKUUczeWZWRkpKR00xUmwvV3NWaWdESWxIbGdVUWtXNUY5S3B0akJo?=
 =?utf-8?B?eCtOZ1hHWDF6bFdBWjNackVjUzVxTmdJOEtDWng1WEhXa09LTUw0Mi9pQlFX?=
 =?utf-8?B?TmNPOVpZbVh6M2J1RUZZU3BiMTlIYXhqc29kRUd3Y0dxYjJzYnZQaXBvTWlx?=
 =?utf-8?B?WWVBOGxFdHp1cllic09pK1VRb0dIRlg4N01JZmN2VFBKRlZsamhNOURsVVow?=
 =?utf-8?B?ZDVIcWV5STFsMmNudWo1SXdJYU83aGptWHlZaUNzK05Pb2g4eHJORGxrWGZT?=
 =?utf-8?B?Ri9EL05QcGFsNE1CY1N1bXBwU1B3dlhrZlcyRy9NK1VNNGlZRFF2T1ZLV1hX?=
 =?utf-8?B?Y1BFQ29KVUJpTVJjLzQ0WDA5V0t4UGZVMndOaTJPN1RtNW5BQ2FpU2UrVVQ3?=
 =?utf-8?B?VkFKU0dBUHNWNWlIRFRKUmQyUnBhWUtMMDVEN3V0SjJ4OC9XRXhBWmpqTUZZ?=
 =?utf-8?B?OWFRNmpnMkRrSU9VVzNRL3FvbGRoTHNzaDR0ak0ySFFRZ1NtZ1hodUpiU0lX?=
 =?utf-8?B?bnVnSWE0d0VrZlJnbVljSkM1OTZ1bXYrNEt5eTR4cm1mOUpacVdtV3RMSUxx?=
 =?utf-8?B?blh0WnZVQU5Wa0tCRFVDSWFEbllqbE52eERwbEViNHRTWHhOWHBITHhmK1pH?=
 =?utf-8?B?RDZZeDlVY29IUURndCtzUE9GWTkxSFRxQmlsZFBUdlpUKzArS3l2YUgxQmdz?=
 =?utf-8?B?NXcxb3pFTW1FM1NUOTIyYVV6RkZtaXJTbld2U04xMXg4cUx3YVpZVTAweXpr?=
 =?utf-8?B?QU56dTNycVpRYjMrc2YzdldWSXZ4MU5iOEc2SkpIbGpTMWcwekpiWmgyZUFC?=
 =?utf-8?B?TjBuemFuSzVTcXZJSExMWnoybjhhN1NmWUpmQmpSTlBkaHNFZ3FrUEkwa3FG?=
 =?utf-8?B?NkJRcy95djVGT1A4QmtlaTJuaHNPYytkV0FxeVpkdGd6aE55dWJGNzhuK0xl?=
 =?utf-8?B?blFqaS9TM0ZoYlEydUs1ZmloeFpoczRGZVp5OExRd0lOMytLMm5VL0NiTUp6?=
 =?utf-8?B?KzB6dENzMFVidmJNT0pXa0p0YnNSMWpPS1NaclpmdEI4ZUJRTmFuVG4wT3VD?=
 =?utf-8?B?MEQwTjgzQ3drbzZpa3U2dlhnRzE4SHBIYXVQVERrL3NkaEhxc2c0R3IySUNx?=
 =?utf-8?B?UDc4RHErN3ZNNzNsdVRaaU1hSStLS2taMTBmMVVRSlo5TzkrU2g4eUV0eG1w?=
 =?utf-8?B?d2hLSU0zQW9YNktzYk5EWHdabVZXS1JFN0hvdVVPV2ZmQnBGVXFJMUw1TGx6?=
 =?utf-8?B?MHVqc1d4UWlseEI3SzNXdWF6SWVqc2ttZ0JsSUlLNmwwQUpFandnTzF0MkNG?=
 =?utf-8?B?QWdFU1YySUR4SlFjVjRGZ2FMcXhzRVNkeTJicnN4WmU3VUVEY3ZKK2VoS2ZV?=
 =?utf-8?B?c0JsOXJoekNBTGdjaUpUejNmWFQ0WjdpdklmUXF0Y2Y5aDJEVW5Rc3Z2Vmhu?=
 =?utf-8?B?cnZYcDVXMVZLMENDS3AzRGdWTXI1Y2hPOXI0RkRodE5FcUtWaGZ3b1ZtNTNt?=
 =?utf-8?B?SnVaS0pCbVk5dE9CQldHbW1VUUpRZ3NZclRIMHVFWVVSQTdRRytDNnhmRUxW?=
 =?utf-8?B?QUc4bWtZZjNOeWpQWGwwaWh3OE5vK09RN0prRkxEeHRxWS9TVW44Wkl2cnRK?=
 =?utf-8?Q?++uyK8QAo/vDIZr4rXFLAC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C46840C7633D484B83AFA2C8B6FD36DE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8ac2f6-2a2a-47b6-d447-08daa7a354d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 14:01:57.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kLIRfrvPHx342PvjNfcsBQLl81QA+PaMyNQ1ZEgOwIZO5VtIZFX/OmojCXleH1b/yhX89CvjncHeScEJqEXYXXhmhKyhLflOFXmI/6ThgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3310
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTU6NTAsIEFsYW4gU3Rlcm4gYSDDqWNyaXTCoDoNCj4gT24g
VGh1LCBPY3QgMDYsIDIwMjIgYXQgMDc6MTU6NDRBTSArMDIwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IE5PX0lSUSBpcyB1c2VkIHRvIGNoZWNrIHRoZSByZXR1cm4gb2YgaXJxX29mX3Bh
cnNlX2FuZF9tYXAoKS4NCj4+DQo+PiBPbiBzb21lIGFyY2hpdGVjdHVyZSBOT19JUlEgaXMgMCwg
b24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBpdCBpcyAtMS4NCj4+DQo+PiBpcnFfb2ZfcGFyc2VfYW5k
X21hcCgpIHJldHVybnMgMCBvbiBlcnJvciwgaW5kZXBlbmRlbnQgb2YgTk9fSVJRLg0KPiANCj4g
VGhpcyBpc24ndCBjbGVhci4gIERvZXMgYWJzZW5jZSBvZiBhbiBpcnEgY291bnQgYXMgYW4gZXJy
b3I/ICBJbiBvdGhlcg0KPiB3b3Jkcywgd2lsbCBpcnFfb2ZfcGFyc2VfYW5kX21hcCgpIHNvbWV0
aW1lcyByZXR1cm4gMCBhbmQgb3RoZXIgdGltZXMNCj4gcmV0dXJuIE5PX0lSUT8gIFdoYXQgYWJv
dXQgYXJjaGl0ZWN0dXJlcyBvbiB3aGljaCAwIGlzIGEgdmFsaWQgaXJxDQo+IG51bWJlcj8NCg0K
Tk9fSVJRIGRvZXNuJ3QgZXhpc3QgYW55d2hlcmUgaW4gY29yZSBmdW5jdGlvbnMuIE9ubHkgc29t
ZSBkcml2ZXJzIGFuZCANCnNvbWUgYXJjaGl0ZWN0dXJlcyBoYXZlIHJlbGljcyBvZiBpdC4NCg0K
aXJxX29mX3BhcnNlX2FuZF9tYXAoKSB3aWxsIGFsd2F5cyByZXR1cm4gMCBvbiBlcnJvci4NCg0K
MCBjYW4ndCBiZSBhIHZhbGlkIGxvZ2ljYWwgSVJRIG51bWJlci4gSXQgbWF5IG9ubHkgYmUgYSB2
YWxpZCBod2lycSANCm51bWJlciBidXQgaXQgd2lsbCBhbHdheXMgYmUgdHJhbnNsYXRlZCB0byBh
IG5vbi16ZXJvIGxvZ2ljYWwgaXJxIG51bWJlci4NCg0KSSdtIHRyeWluZyB0byBnZXQgcmlkIG9m
IE5PX0lSUSBjb21wbGV0ZWx5IGluIHBvd2VycGMgY29kZSwgdGhlcmVmb3JlIA0KdHJ5aW5nIHRv
IGNsZWFuLXVwIGFsbCBkcml2ZXJzIHVzZWQgYnkgcG93ZXJwYyBhcmNoaXRlY3R1cmUuDQoNCkxv
bmcgdGltZSBhZ28gTGludXMgYWR2b2NhdGVkIGZvciBub3QgdXNpbmcgTk9fSVJRLCBzZWUgDQpo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAwNS8xMS8yMS8yMjENCg0KVGhhbmtzDQpDaHJpc3RvcGhl
DQoNCj4gDQo+PiBTbyB1c2UgMCBpbnN0ZWFkIG9mIHVzaW5nIE5PX0lSUS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvaG9zdC9laGNpLWdybGliLmMgIHwgMiArLQ0KPj4g
ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktcHBjLW9mLmMgfCAyICstDQo+PiAgIGRyaXZlcnMvdXNi
L2hvc3QvZmhjaS1oY2QuYyAgICB8IDIgKy0NCj4+ICAgZHJpdmVycy91c2IvaG9zdC9vaGNpLXBw
Yy1vZi5jIHwgMiArLQ0KPj4gICBkcml2ZXJzL3VzYi9ob3N0L3VoY2ktZ3JsaWIuYyAgfCAyICst
DQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZ3JsaWIuYyBiL2RyaXZl
cnMvdXNiL2hvc3QvZWhjaS1ncmxpYi5jDQo+PiBpbmRleCBhMmMzYjRlYzhhOGIuLjA3MTdmMmNj
ZjQ5ZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1ncmxpYi5jDQo+PiAr
KysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZ3JsaWIuYw0KPj4gQEAgLTk5LDcgKzk5LDcgQEAg
c3RhdGljIGludCBlaGNpX2hjZF9ncmxpYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpv
cCkNCj4+ICAgCWhjZC0+cnNyY19sZW4gPSByZXNvdXJjZV9zaXplKCZyZXMpOw0KPj4gICANCj4+
ICAgCWlycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKGRuLCAwKTsNCj4+IC0JaWYgKGlycSA9PSBO
T19JUlEpIHsNCj4+ICsJaWYgKCFpcnEpIHsNCj4+ICAgCQlkZXZfZXJyKCZvcC0+ZGV2LCAiJXM6
IGlycV9vZl9wYXJzZV9hbmRfbWFwIGZhaWxlZFxuIiwNCj4+ICAgCQkJX19GSUxFX18pOw0KPj4g
ICAJCXJ2ID0gLUVCVVNZOw0KPiANCj4gU2luY2UgTk9fSVJRIGlzIHNvbWV0aW1lcyBzZXQgdG8g
LTEsIHNob3VsZG4ndCB0aGlzIHRlc3QgKGFuZCBhbGwgdGhlDQo+IG90aGVyIG9uZXMgeW91IGNo
YW5nZWQpIHJlYWxseSBiZSBkb2luZzoNCj4gDQo+IAlpZiAoIWlycSB8fCBpcnEgPT0gTk9fSVJR
KSB7IC4uLg0KPiANCj4gPw0KPiANCj4gQWxhbiBTdGVybg==
