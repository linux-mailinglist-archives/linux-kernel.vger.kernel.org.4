Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE663702CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbjEOMcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjEOMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:32:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691719B5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684153918;
  x=1715689918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q3j/vgaucZFux9IKrVNv4CGUuQljbpT/9XfdgYNxpIg=;
  b=Y26Ys/HBP0PUpcy/eth+6vnWt2hIO1K2YnMA0oufV4/BopqWB2CN9A6z
   k/I17f57tsU1NyUf86zp9RlYGWPQOlxDsZR/rUkwZrZNxoARbYK4PVVOp
   q91NlaP8zi0gcqCopidFVWm7AlosM6FYY/L/QHp4NsRy2YgPT+Qz1i1to
   2+oZhu7XLsh/2CJ0m3YjdSieavVwjJRpFDl7HKm8jDxUu6xZe5I7fugT6
   /hg9sEMwjoBLU7LEadkB9ELc8JAH6h/JSux2fm4XARKxRZB4jNr88Ojgf
   B/8PzW1+SsfqlpQ0WwRS/roGfo4jiaeSoaTQpiRWn9Z6HSCexMG/e4q/d
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO65inD617J+mVwUT2mXA1UkwlJcmpjiqTqoGauDOW/t6N2fojjQSJZRMOug6UowuBrzh6vEhTJ230GLH0cG/YFM710hX2UOyk4YrLztjtD4i28AcvyFTWAuBQQNdxHzbQQAUSlWV7UCZd65TJ9rwhrp7kiglD03c/U/bqoMxYgsx3Nj+Z3efLoWicuZBYvgmIE42dIi42AotN8ggLeK+qqrnCw0XdReyRZ2vBxlk2Ignv31aFtLC8A/OXmsiLz2lifa0rOhjC+NjjlORC0ziI0tE3iuZDt1PQGj0ifRsEV9l5ZzTIwGfcU4aYLuRp+4x/CkG6mq5ixEQhTatNKBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3j/vgaucZFux9IKrVNv4CGUuQljbpT/9XfdgYNxpIg=;
 b=FuHLY9KdwqfIkGE6sorb16daHg0dOHjphqbq0DgRJ2v+OqifODAcMHvlU1auadIMYlLdzcJFYnFkq4LbmvufNTJihS7jqT/Hi05Ix+nMk5F3n1zaH50/VTtCk/CJYu3pT0oukKb8LVfBfnIlXlr5yg+j7dfMY6cpqOUdtl173LidVJ1/BLFWx7V5d2hl8iQkuZX+kxSq7Qwa1cG028BLVjr0kix125pTP3V2fyjOiCDQWzioCnwuITAhTzBq1E2h7GSiHUpgfeqK+Q4oblw9Mv4Xr7cQBGtyid7Ixph70ZQjogISbbJZxWCBXCMun5QoqDNWFHz54mQ54dCwUrjZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3j/vgaucZFux9IKrVNv4CGUuQljbpT/9XfdgYNxpIg=;
 b=a2PKx9J+gTEogdsQXYSLlRpzBDxz8Zj1e5mUw9SjpXUhhe9fggJVbzPsRFtrnRYUHdgr8CIJDKc1yRizQh7rGGpgsgfCPxMXtKZpDYRr9UP/89OndiZkU/n+GqxjzBHiaIrba8zxksqHUlcQIbwOjIDbrA8XfMkJX61yB4TVndc=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     kernel <kernel@axis.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "pliard@google.com" <pliard@google.com>,
        "phillip@squashfs.org.uk" <phillip@squashfs.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] squashfs: cache partial compressed blocks
Thread-Topic: [PATCH v2] squashfs: cache partial compressed blocks
Thread-Index: AQHZhNRGfYgM+JB/2kmkByB5R8GoYq9bH3EAgAApVQA=
Date:   Mon, 15 May 2023 12:31:49 +0000
Message-ID: <031c4d99c2cd9870ca5ed0d7fef809d3f7c31381.camel@axis.com>
References: <20230510-squashfs-cache-v2-1-42a501a17569@axis.com>
         <20230515100352.GA24402@lst.de>
In-Reply-To: <20230515100352.GA24402@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|PAVPR02MB9306:EE_
x-ms-office365-filtering-correlation-id: f931fbd7-0aae-4394-eed8-08db55405ac6
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K57n6TbZdqGQb/fgltnBlIg+7Eg+FFhgRW8B5Dfb3FqzdlvhpAsYnnsl5rbhtFB6M5siWYA7EmxaSYi0hZbrvJnBB50SCMI3+F7QudSu4bBoAojnjCQfiV39Y3fjqDdvfd4+0mUIOhADCpLSbJjqBEb7TY+Zj7HmlChWv/RkFnQyH5S9eddnNY0aqYY9sG1VDGUcavkP49Va7zu9Z/MXJLPAXELDYLyf3WgbDXvX2PMbDPjLBlC7+H3/kTaNdG0Ub5latxPwHSZt9MCZEpu7PmRhnS36Yd/PGfCNavhA7s+KsJ5T/9kgXPCp/tYsdYcLfgvhFVzeKRDDEpEGaq2waQpyPRxq0CBPCFkcPvwbqyERfRShukkMrakr8JxPLby6UKURTauwn0O/oApc4FmQ3ePUNteZuioN9cB5pGy7FnjpWnxlD8+fEN8I/zL5i3t1qyfpZIdowV1kmv21eg5ES7F++M/NcQgnBK3zLSknyw6Av/rmFoZfqBhPRl2ODY2+XeHi69zwHTEKYxsEBavu5EDhcRSYPA5tK/+nAPxtoTdL8Byp8yuJ65FPqEmZjvx9W6SaZp4ztHz0wiE6RsGYD8GzJOH5vhh1RM0lVnkmSZahbBOa8Fnk5uO9cH4dEdJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(38070700005)(86362001)(122000001)(38100700002)(36756003)(6916009)(41300700001)(4326008)(316002)(5660300002)(71200400001)(8936002)(8676002)(54906003)(6512007)(26005)(186003)(6506007)(4744005)(2616005)(2906002)(6486002)(66556008)(66446008)(64756008)(66946007)(66476007)(76116006)(478600001)(91956017)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFpendUSnhyZVpNL1RuUFhMNHplWHVxMXk4NGk1UW9IQ3ZsUTNPbS9UbXhU?=
 =?utf-8?B?Y0l3aXdzdDlpSWkvMkJTZDFHRWZzbEEvbkhTRUhQR2locFpIeStERzcwN1Bq?=
 =?utf-8?B?dk5FTXBQRGVHRDdNV1hpYmkyRTBXOVVWaWE4VUNSVFF4TWoyRVJxdUlTYzVE?=
 =?utf-8?B?S05PQUZmUzJlbit4QlZtM2ZlM1V3NW1TWVZtOC80bnN4dmlUdDRKcmRGdW00?=
 =?utf-8?B?bFdpUmRTb25nQnZENnlCOFdybFplZjlWZWRhQjZsWm5PQ2FsRnRmR3kvNTBv?=
 =?utf-8?B?N1NrT0RBQzlWSTNvcWlnTnpVVGU3cXVMWW1xQitubEV5Zk9TSFRnZmpzOU1P?=
 =?utf-8?B?SDJoZEEyRWVDVlBBM1R4c1dNVmlQZjNnYnc5K25SdER4SHZ6UEdmUHNVaEV1?=
 =?utf-8?B?MzFtcldnSjR4cGR5MFZCc1A5eDJnTkVha0taTXcxa1dFYkNqcWYyVzE2UGU3?=
 =?utf-8?B?RGtOakZsUVBRNjNjRXRiSHRXRXBWTnlWNkF1K1Q0L1hmSFZJL0NnTEYrZ25s?=
 =?utf-8?B?VVZ1aVBSMFhyWWp0bXBOUEFMTVV2M2hEVkJWV0djdzBUQjlZRkkvWEJyNVpj?=
 =?utf-8?B?L08xamQ1S2tEbnhwbEFvMFNBNEx2VFdHTDdQWW0xNDJTUHZNcjQxYy9wdUg3?=
 =?utf-8?B?aEhYRkVFZ29IOXJsZC9pRno2OTRSekc1R3RqRy9ZYkhyZ3VYY09pVUttL3J4?=
 =?utf-8?B?ekxUOWk3QUovU3I4R2ZLbXpwOUdjdHg3NWVibFRCeUVxa2pUd3JtR3VndHJj?=
 =?utf-8?B?MXBrNmMwMjhjYjdSZXNmNmszTW94L1htdVZ1bVdvMUtvcWFUOGt1bEdiV2RM?=
 =?utf-8?B?ampIaGZ2OHJPLzBVdW5iTEhzNzEyRlNFNkFucFMvbHRET1MvK3E2MkVmWWVo?=
 =?utf-8?B?TlJRU1RIR3ExMjJsb0o1eVhsVU9sNzhxS01UdHE5STNHU1JvQXVBOWg3Wjgv?=
 =?utf-8?B?RVpta0V0V21lN3BLdFA0TzBnV2dDVnZrT3F4c1k1QzZtTXh2NEV2MDRCOW00?=
 =?utf-8?B?ZXhpYmJmTHF2VWljWHBUeGtZb3ZBV2x6ZHRSUldaWnNrc2pLZUk1Y3o2VXdm?=
 =?utf-8?B?OTNEU2ZZOU5jWDh1QVNMYU55NlVqUksyNmdhYStScVAvcEcyOVhHbmIrUHR1?=
 =?utf-8?B?UHYwY3kxcHJIakRsY2FnSHQxSjVlM0VGTWpQbjFTMFIrZkRSUU5QQnVFOVJF?=
 =?utf-8?B?UGpLU3pKTlZ1bktqQzhpMUpLdkdYekpZQTJHM0MxL0NXSUFQaTdMZmFhRkdE?=
 =?utf-8?B?a04zNUtkREFiS1lBRjRnS3BZcmVCOGk0dnpGN2xIcDIwWkMzeVVvbEY1bmtS?=
 =?utf-8?B?RDBVNlRkcUlsdDJ5TWhUOG5rU1JQOTArOHlKaVpqQTVmSEVoQUJ3OEhPRXQr?=
 =?utf-8?B?cGdGRnZYVnFrYmV6NitmbkY3RkRCQUxWa3dlUkZnNGVSNGU2RmpXWGlUTmFv?=
 =?utf-8?B?WnZkOEgvU2tsc0tXbVI0QmZJTGNxZkhXL1lwR2tkNGdCWDlLb2RSc3h5Q0JI?=
 =?utf-8?B?REJMemRxODJKZ201WVJLQzVMZ0pyNlgvWVQ0elk3UUFIUTY1K1VOSWZDNG82?=
 =?utf-8?B?TGUxeUhpZ2V3UTBPRDZCMEtDUnB6UlFqaDgzQzlXd3NsdG1IenlTcEZOUnZy?=
 =?utf-8?B?c1J0MjdjWTRXUnJzMVEvdll5MitNeTFtTTg4V3ZtMHhVcUE5dUpCSXZmVWZq?=
 =?utf-8?B?OGhrY3o5SFZLUm54cERaa3k5ajdiRC9GZmFZZEkvU280SzEzZ0VIdzk1bkhR?=
 =?utf-8?B?djAyTmtLUDhBcm5hcGpGVldnMXAzM1NLYUV1bVNLNVVVNWJVMUZMU2xOaisz?=
 =?utf-8?B?SnAzakRsRjdWQWFrY3YrTEk1eHVjZTdiUFdmeFFuM1VaYTNvZTNJRTdJTkdn?=
 =?utf-8?B?UHkvWDdiSnpqaFNnL0ZIS2l2dUxWMmQ0R2ViMFZ1YmdEejZJRE1adFJOMldE?=
 =?utf-8?B?UWxhUFU2dXdxVTQ5cDhMZE9WRW1YQlk4ZlcxZUpwdHFneUJReWVwRWRnbVd6?=
 =?utf-8?B?Mzd1OGpON3d2T1YrdU9pRy93M0JDVTgzSUNuT3ArTFRiRzFVVzlmRTlVSlhV?=
 =?utf-8?B?bUV5Wkc2R0dQWVcrZWo2aGluMVJ6ekxvdjdMWVpZQkx3Z3haUGdoWk1jb0JM?=
 =?utf-8?Q?TFmiZg1yTkRLhJK5CHA1Gy3p1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <863517A60DA9274093C082E62F598291@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f931fbd7-0aae-4394-eed8-08db55405ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 12:31:49.2304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nM7+tBS02r7WB/T/9C1eIWdhel+1e1Nr6ipQshjFSDPK2V2T12K9y5KCACObZ/96
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9306
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDEyOjAzICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBNYXkgMTIsIDIwMjMgYXQgMDM6MTg6MDVQTSArMDIwMCwgVmluY2VudCBX
aGl0Y2h1cmNoIHdyb3RlOg0KPiA+IMKgc3RhdGljIGludCBzcXVhc2hmc19iaW9fcmVhZChzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1NjQgaW5kZXgsIGludCBsZW5ndGgsDQo+ID4gwqAJCQkgICAg
IHN0cnVjdCBiaW8gKipiaW9wLCBpbnQgKmJsb2NrX29mZnNldCkNCj4gPiDCoHsNCj4gPiDCoAlz
dHJ1Y3Qgc3F1YXNoZnNfc2JfaW5mbyAqbXNibGsgPSBzYi0+c19mc19pbmZvOw0KPiA+ICsJc3Ry
dWN0IGlub2RlICpjYWNoZV9pbm9kZSA9IG1zYmxrLT5jYWNoZV9pbm9kZTsNCj4gPiArCXN0cnVj
dCBhZGRyZXNzX3NwYWNlICpjYWNoZV9tYXBwaW5nID0gY2FjaGVfaW5vZGUgPyBjYWNoZV9pbm9k
ZS0+aV9tYXBwaW5nIDogTlVMTDsNCj4gDQo+IFVubGVzcyBJJ20gYmFkbHkgbWlzcmVhZGluZyB0
aGUgc3F1YXNoZnNfZmlsbF9zdXBlciBjaGFuZ2VzLA0KPiBjYWNoZV9pbm9kZSBjYW4ndCBldmVy
IGJlIE5VTEwgaGVyZSBvciBhbnl3aGVyZSBlbHNlIGluIHRoZSBJL08NCj4gY29kZS4NCg0KSG1t
LCBpbiB0aGlzIHBhdGNoLCBjYWNoZV9pbm9kZSBpcyBvbmx5IGNyZWF0ZWQgaWYgZGV2Ymxrc2l6
ZSBpcw0KUEFHRV9TSVpFLCBzbyBpdCBjb3VsZCBiZSBOVUxMIGlmIENPTkZJR19TUVVBU0hGU180
S19ERVZCTEtfU0laRSBpcyBub3QNCnNldCAob3IgaWYgUEFHRV9TSVpFIGlzIGdyZWF0ZXIgdGhh
biA0IEtpQiksIHJpZ2h0Pw0KDQpJJ2xsIGZpeCB0aGUgcmVzdCBvZiB5b3VyIGNvbW1lbnRzIGlu
IGFuIHVwY29taW5nIHYzLiAgVGhhbmsgeW91IGZvciB0aGUNCnJldmlldy4NCg0K
