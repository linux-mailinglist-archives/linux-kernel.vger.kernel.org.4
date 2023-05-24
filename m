Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55170F7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjEXNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEXNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:36:55 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A342E7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684935406;
  x=1716471406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cs3emPG+Yg5AMQMg559PfmI0Bjzn66YG/6uHiH4QWiY=;
  b=Lrr1rr7sdN7+Oti7UFhHMrjbXTmMUNgt/+BNYkKgskLBKuy4Yjx11hFo
   DJaRPI7Z3LklYklnzemjbAqZ8GUFqdSZLz3eNhvFFn/hKwWLN4IO/GBwG
   tO4+4pZx+ZKpziHR3PUmyHt60MLMRCA2AFCdFcJ02/Vvn8dc3s+xlH1Wu
   VCbJrm5+6q7vTpHGQcA+UJnpYtnIWDxh0eWQ+G+bCaaKkn4GxKB9Aa6VL
   ZpvPGZAiJNuR3+EkMiJpLmC/XgLO9ZE1lV9q0uNx8gOZnLSspcm6q5Eeu
   iCDGhEn0j+eDcinSduyFJmdPQvI/w3Z6slLbI3opAnw4JsUy7xKITOZnI
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8fni44w06Tj719AlxarjtTFMgkAtUCF+JBNtEQL66oQLHQaXTv2xFRpC2PkqRzKp6xYL/tXJquEdqO4qQFvhRei3RukvX3MRLBxMq5QhgTpfUXj00SgGpZvMe1yZUi3gUWv+h+nezABjp46UYu17+UVv5tyGzuJk1CWyM6fDvEUJPNd+/QB+OqDed1QTjJWIMBd/BiMW9moIsxVogjNu2o2hT7NsSWGC5mnGuDaC1m0w3x+f+JLbAp5GXzdS2rxJ8gQrLWCrZm0PiyxTNqp/HZp+6W9sz9tQzaOYG8INgFjeZgI9sRF/H5KihoJqXuZ5fxvJzoHxotpMfiw6n8OVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs3emPG+Yg5AMQMg559PfmI0Bjzn66YG/6uHiH4QWiY=;
 b=NhdgbGMbtrzp+0wggCc2FozJPjOtJmS/pLc+UEiFwJ4Ui5tqWKatcCUHqbJkBkbbAYTqe8xJky//f5iKAopxl7ezRAKovprESmdmHIwO096XDLTmLWZCLSiA3zlOtqEzF208TNx+UZXTWzHb4EjOfOWI4jfaT/tak7GiDqm8L0hEjALcDwxnnqResl57286aTHLg3UBcBCcieOgqQ3SKQ8FKJ+vaCezpecV+OLTYSD9fDzjRLdes/jsxBcS8sGTRpF/chSN3maMCYii7eBpsFYAlpgx7/pPdqHhiO6S7cEWTWdusJ4x2oURUhtIUDYsUNqBgpzA39aUREBA+eL0OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs3emPG+Yg5AMQMg559PfmI0Bjzn66YG/6uHiH4QWiY=;
 b=tVc7YbJQL+CRMfulOF2qfwGoZdZACLvruTg0ItadoQHAB9Yym1+UGZtPDmHW0uaPwqLXkRH+t3oh5ED6rk5PVTMWyaSQGuyXEm/mXxcTk2sqlcAWkc6yd41ufK4uTAXgLRsYRG+8l39/JEA9O58y5fA29m9Y6VbTLXhNxeWWsUA=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     kernel <kernel@axis.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] ubi: block: Fix deadlock on remove
Thread-Topic: [PATCH 2/2] ubi: block: Fix deadlock on remove
Thread-Index: AQHZjXg3+vjJPDC7yk2iD6NuhjsXV69o8DYAgAB+YQA=
Date:   Wed, 24 May 2023 13:36:39 +0000
Message-ID: <fa2a06491cf2d90eb35c95042f888cd49df119fe.camel@axis.com>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
         <20230523-ubiblock-remove-v1-2-240bed75849b@axis.com>
         <ZG2o4rrfqWGbYziq@infradead.org>
In-Reply-To: <ZG2o4rrfqWGbYziq@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|GV2PR02MB8920:EE_
x-ms-office365-filtering-correlation-id: b4b0de22-3803-4ceb-e246-08db5c5be757
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYX+BAACHT1axJMezdEdNanYS0oEbrjmT39mC3s2GGVeLmnCXzsrNydZB7rAgvbQq/ASrzJ3MCitcLp3XeF//4wVEVqFKhp9CrAoyuVp3uAZG4jCdU8gUwL8+b4j6FaMo1KXS8Y7EvlOKpeD7IpeBN7NLWkWWNMzoZbh/gEefxSvgnCkNdSfv6/ZwKUi/GwFU6jtNX8AylLYFpbkZ5/TdBqi1/nFoIO94Bw9K3OFhEM6e0sbxLMg8JuozwN0tcPHrg3T+RKdyXLR2+upfq4/PXDTu3U7QpGvWq+sX1z+IkTzRVNpwHn1QX9C8gDiG0tnyGJ5DKvZB2JOoptdc86dFFuODWM/kqs2BvXeDqaYELDj3MNx2zUT0lbArZbnhz7pdCCpd+DQe8Vc2zx9rvoNrnk5ONk5Du1UrKWyIwmbxtpbqvFVPrgRP43gNpRS1p6vIlgxy/dUnIF8fPICxxgKBn7jINRlEzcFFiBD+1nayuLwXPUbbkjPAturqJdZWr0Gfx9bcrA0jzfPqT/GiKkVeIAzL5LWnDOpHrgnPWw/K0kPKjZF7zlfp9ZNA/4vfIWF4hFrEEYtbuDAYa38cqRNEJDGGlDdCrCaCwYKZT2oXnviOdhWDXk/d+kNVMn0kT8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(6512007)(122000001)(26005)(186003)(6506007)(38100700002)(4744005)(2616005)(36756003)(83380400001)(2906002)(6486002)(71200400001)(316002)(54906003)(110136005)(41300700001)(478600001)(66556008)(66446008)(66946007)(66476007)(76116006)(64756008)(91956017)(4326008)(38070700005)(86362001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhWVVl1Tld6bXo3STloelNYVjFrWEdSWHVZbGowSVlMbmJSbGhoT214U011?=
 =?utf-8?B?U0NZMWFSY2RCMmxBeDc1eEdlZzZNcWZnWTQxaEc3SERNUmdGUnNwTGpsc3lS?=
 =?utf-8?B?Nit3NHdvWGx1aG44VG85Y2hURjNxSm04MnZoTjlsaHdvOHBwdmc2eXIvR3lV?=
 =?utf-8?B?bmlsMXhuUThSQWpWek54K3ZETHI5aFZKazFOSmJGUlhaZGsrby90VFBKSFR5?=
 =?utf-8?B?NG1rKzFWMUwxbHhud3g5d2ZEUllDZ3I2eEdxTmI5dlpQeU8vSmtSeER4K1Zv?=
 =?utf-8?B?R00rdGpZRllDaDV4NFRaclJrVzgvMjZpdERFL0FhNmc3UjBHZitBVGlHcTd5?=
 =?utf-8?B?WDZPcmFaUGh5L1hUVkRYbkhobWYwNW5ZV1phcWRsSTQxZ0hkS1FnUGUrS2dF?=
 =?utf-8?B?UVZSWm9zVzNVaXoyUzRqbkl0MWVwSFVXdDZydUhUUU84Vi9Cdkx6Tlp0MzRk?=
 =?utf-8?B?UHoxK1dFYmlNWVhKbXJMZ200VDRjOXNpWENPSEhzeFhnNlIweXljdzZndjd0?=
 =?utf-8?B?UkR3SWhoT2Vycm5FRzJ6OGtmNlIzekk5aUllVk5RdVFYZVc3YmMxSHcvMGti?=
 =?utf-8?B?UXpnNW5jdE9tTmh0eWE5c2hDUTcrNVhKdEFZbTkzNHVOSTdUM0ZhSDNEQmJC?=
 =?utf-8?B?UGJCWjFrNmVVbnAvZDlsU2Q1Ky9nb1o0NHYwZmJ5WGdUbzdrTlZNTHlZK01o?=
 =?utf-8?B?R0hLWVFpQmRGYnNhRHFGVW9DZWNFeUQraFV2cmowV05uM3pSMFpvOFFwVEY4?=
 =?utf-8?B?cDhMVlN4MC9paUhIejN2cXRNVzZzN1NBdFMvejlFZndWS29UU0djcFk2bndP?=
 =?utf-8?B?dk9YcW0rc1ZSeStFWFdWUHJCSkJoK2c1QzNTYmEvV1pudUYvVGlua3ZZRUFK?=
 =?utf-8?B?dEkxaS8wclJVcno1QnZKeUlBaGRRMnJVQ1pobmVSd29Tdmp0UVR0U2Z2ZC8x?=
 =?utf-8?B?TTR0R2lKUE9wRDJlWjFiaTVoY294SENiRE5rZExITHJJSDB6RkgzZHZsOFEw?=
 =?utf-8?B?TjFwN2E3RDZiY1BtS2FqS0ZQck1kdVd4QmxhR1dOczZ6d3J6bDkyV2szeFR2?=
 =?utf-8?B?RTRXeGN6dTFTVGluUnV2dXdpWnpSbjhtajREN0ZvRnZCcU9IRG1nb3pCMzBZ?=
 =?utf-8?B?L2pYQTNSTkFrMndmOGlQeGh3bm02VnpncjVGaURZZmRVQTNJeGhUMUUydFJR?=
 =?utf-8?B?WVBTdzFRSTZnTjhXM2ZXM0J0RW5ma3BxbVNaRjdwWEZIL01FUWtHeEk2b3dP?=
 =?utf-8?B?akFkbjFxN3BjRXRrTGRLbElzOUVhYlgyQ3dwWnJQTEFEdGlUMGRKUzBnb2xW?=
 =?utf-8?B?ZHkwaDdXNExMTGM5czBOUWUyVlBCbEEwR0Q1NDEzV2F5RDg5dG05cTdLSWJu?=
 =?utf-8?B?S291TVRhZ0tvQWxSTDEzb1A0cFNFZXNkdmsvbk95elBSdEFuNzdFcVpoT2Na?=
 =?utf-8?B?UGU0bGp6ZGkxTGNZc1g5d21zMFhDdWdhTEFTVHVmMncvOVlCNndYM3Vpc05O?=
 =?utf-8?B?MXdhZE9BbzRPY0hjZ3VKZXNpci9JN09DWUhLaG5FZHhJdnpWUmpRREZjWDI3?=
 =?utf-8?B?QlFMMUZoTmFrajNoMFRtemowM2s0c2FUTHhmRTM3M2N5RXVpelJKc0ZUUHhx?=
 =?utf-8?B?cTl3M2xMS0k1QU1zNXN3azhnYlZ0QTYrT3pxTzV1WEp2Rm9OQTV6U2R1bFov?=
 =?utf-8?B?RWg3SS9JcjRLRUZVejBacVFWM25iMmg0cVNzQU1BWGRvV0hFMk8xWVBMZGxy?=
 =?utf-8?B?NUtIY1JQQ3Y1YnUwNlU0SFlhY3VJK1hWbUhsbVEyYmJUUTVTRm8rcUN1bkFm?=
 =?utf-8?B?TGNLOHQvRTdBYUtRd0lqaGIyZ0NMUE1SSUJBU2N3REJ2QWtFV2FMbTNoVm5C?=
 =?utf-8?B?dE01SzdEMy9ncXd1SnJGRTNzcXR6ck45T2hkRGV2NXppS3VXYzRHS2R1REox?=
 =?utf-8?B?Ym0vc0I3UXd5MzZlbTM3NmIydjNMZTV5VU9UVEQxempYK0p4bzJKL2g4U0FU?=
 =?utf-8?B?R0NWMHpYWVF4ZnNuWG5pYU1GK0paRGx2YzZqWjBQOFZ2d003MWYxditNMVR5?=
 =?utf-8?B?UWJnN0lMM3JaL0llZ21tOXBIOTNlKytISGc0ckdPeUpSZXV0MTRKN2Q0YVQz?=
 =?utf-8?Q?/TsrObpCX9QMBhLXFXfDVANKl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65D392C26286184E8FE0EC6ABAE20FF5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0de22-3803-4ceb-e246-08db5c5be757
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 13:36:39.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxtpdo+nMibZpRTWFjm9kHgyDTKIhIJwYNx0hAtJujmGJ3Q6/6e8nyQ7MNh3AFHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8920
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDIzOjA0IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSWYgeW91IGltbGVtZW50IC0+ZnJlZV9kaXNrLCB0aGUgbGlzdF9kZWwgYW5kIGtmcmVl
IGNhbiBtb3ZlIGludG8NCj4gdGhhdCwgYW5kIHdlIGRvbid0IHJlYWxseSBjYXJlIGlmIGEgbmV3
IG9wZW5lciByYWNlZCB3aXRoIHRoZSBkZWxldGUuDQoNCk1vdmluZyB0aGUga2ZyZWUoKSB0byAt
PmZyZWVfZGlzaygpIHdvcmtzLCBidXQgdGhlIGxpc3RfZGVsKCkgc3RpbGwNCm5lZWRzIHRvIGJl
IGluIHViaWJsb2NrX3JlbW92ZSgpIHNpbmNlIG90aGVyd2lzZSB1YmlibG9ja19yZW1vdmUoKSBj
b3VsZA0KYXR0ZW1wdCB0byByZW1vdmUgdGhlIHNhbWUgZGV2aWNlIHR3aWNlLg0KDQpJIGFzc3Vt
ZWQgdGhlIGN1cnJlbnQgY29kZSByZWFsbHkgd2FudGVkIHRvIHByZXZlbnQgbmV3IG9wZW5lcnMg
cmFjaW5nDQp3aXRoIGRlbGV0ZSwgYnV0IGlmIHRoYXQgaXMgbm90IG5lZWRlZCwgeWVzLCB3ZSBk
b24ndCBuZWVkIHRvIGFkZCBhDQotPnJlbW92aW5nIGZsYWcgaWYgd2UgbW92ZSB0aGUga2ZyZWUo
KSB0byAtPmZyZWVfZGlzaygpLiAgSSdsbCByZS1zcGluDQp0aGlzIGJhc2VkIG9uIHlvdXIgc3Vn
Z2VzdGlvbnMuICBUaGFua3MuDQoNCg==
