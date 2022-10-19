Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8DA603947
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJSFgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJSFgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:36:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CC4D242
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBSYVqNg9EAmakgrPW5wv1FaXk5VRrLZq0DEnDQX55RqMdvQITczAkaSVmztvnlriu2CpYnBVu/ATjoDpTKvoRioKQ3E9u7TfOaQcUBmOFADwT6+92aXdzDfqq9YJDJypiSWTZj3Jcp8LRUtqjudCFXye8jO+0yZsW60PnnflIMk9H1fDeMYzYA6f2N1JuIea414jGlB/cTyzmWsNRn0krAwCzehRDaZ0sjHXcigQMe6BfJ/j7VgX1t0PUADI9UlvizVd2ZdxpYPJy4+iMoUM+sjm9HNz9SRVyGmNu0hS/GUh05SVei2OOB+KDuYvF6NYrNr9aVFJnH2xcMY95m1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD6a/8ox/8uSTtcwRjXdnqx7CF7zmXiLCEkWzgZKIMc=;
 b=EKCgQ4Qsz8cEtI036QA3TGwJbPK8E+Vg1G3JFgcxlXA50ENm0jjIJxjqnX2G7kM8vnQ8kXJuvkIQPj1UBPe2i13zF7QSOlJxQNcPXCcg4N8QSmZWdmMJ8jfYqssiJonPoS4gdLX4giqETecB9znHmceGYJMv4jn+ocF/6XXgdt6Uf1BJRHV4G6EUqKcUpfBFf5Nkfjhj6oNeebtVhxY1gNHiTkHbYCaLJU2lDNJN1aOOLVjptLjh7kPRXRd+0zl706JNot6SD4FPMlnKlwDVv/mJW8joVBq+ngrxusZxhngXy5ksI5aS08RLm3+ay62Ku5yR+KvGVUWhxpSafOuLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD6a/8ox/8uSTtcwRjXdnqx7CF7zmXiLCEkWzgZKIMc=;
 b=h5NMIt1uMa2EC7BjmJKzFtZE3LEyH8psQoeHBWRwtdGcEj2PU4+YOonEkwp1fcRXL68G7Z5xbZABxdPkH8OOPKzlOTRFyeJglPK/RrfrwUBjYARYRi/le9e5tARwKLuzaU7aX+RR27SlPa1HC2E1UmPoyXG62Rpdcymrk07WUSSlr3uD9KT/zPvnzjaFtli+kJrbBT8IAyltQycuOybMOKQxpHeB+TjKbDPu10YZhVfccGrmuU05DYPXOuMD6/T9st7I6smJ6VynDXv2Bxd+VmA6CmJk1BwfAaQf9USlzAEseVQDclchiqjZzY9SG0r9r2sr/OuY/U4kQxqto+dtXQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Wed, 19 Oct 2022 05:36:17 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 05:36:17 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Topic: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Index: AQHY4uKSTm3vnq7kQEqG6a62xIRmzK4Uh6MAgACpquCAAAHUAIAAAB8w
Date:   Wed, 19 Oct 2022 05:36:17 +0000
Message-ID: <DM8PR12MB5400D576AB4F9EE03205A919AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
 <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20221019013402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221019013402-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DM6PR12MB4483:EE_
x-ms-office365-filtering-correlation-id: e3318ab9-6f44-49a8-f4a8-08dab193d84c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqpA8sHwokKOaMwlXOK5775KotJ2GYP7sSkbWNriRDo+YnFignDxeQTou9u0cD9R5EkxUGPfONogfgeGQlYPv9WAAZIb2GXUVRZbswcR0I2QKNjO5SvCuKfSkt4FjO4qH/UiDEb5Wik33f9/5h20ljxuwHqIC8Dxik0I9p/quR3/4GxilI/UczjW3kMnUXQTBMI8GLFQs3MTvSF8SUI5QBT0aXlJyvDXH00Qh08es0GzZk84cSagHYOcp4Ns8mm+UTGDJnP6paDqQ0ZgGj4vqPwy81Vo7BTSsFq9rOQV80qdxzmk3/uQO151r9CTvjzirnA3LzJiAYwqywitzZU9OfskO+MYEoU8L3POo2hGWowD18kG4KPcxr95asEtJd6CP7RtD6X5wKnfh+Jc7GLZxwkQQLxPnG9DB4KsPcDAbiYshLpdvnWZFdko4KPGY+bAcNd/L/VeUaVWq605CMISYP+BzZio4i/tZ4tUmiCnO2cpUhKd1ZcfTSypQ0dnw38yYxR9BLvWdSwp1TJKBHnLTWsNEC8RNN11tCVaSYegDp3688LNBtH0MZhLlkSxy983kMfpfkJgHqJVKUeP5ubTQvNTeItRVPpJYsg+ObHkUHQed3dfpJ0HHIq178rR8cRRlLMJML6+Gq2/mdz3FjcWKYqyGd4qr7FGaH6t3YWtbTOjXeQM/OvtnXP9cCjmwfhe7lFXMMcHmcN9bbgFSN9Z77IYAU+FwPHc1fDn4ToDCQhgbgTfXtzGF7+3/Z6hPuGB9Yd2DB4vHk+F1nyTK1R/8QUO6c/vbAQxy0/ZxOz5C4dl6z3HvefbpxzvzvkYsL69hc5+qf/jVE4GtXVRtDHO3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(6916009)(83380400001)(186003)(38070700005)(2906002)(5660300002)(52536014)(86362001)(122000001)(38100700002)(478600001)(41300700001)(4326008)(55016003)(64756008)(8936002)(26005)(8676002)(966005)(6506007)(7696005)(316002)(66446008)(66476007)(66946007)(53546011)(76116006)(66556008)(71200400001)(9686003)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjMrNDdZUCs3SlkvNW1IQkVpR2lzYXhCcmZCR3M1UDlaNjB5MUFmcHBxQ2ZE?=
 =?utf-8?B?aGVaYzR6WEJndUdNWmdYYW16Q1Z0ZmY5dnBwanNmcjlPRGNuQjJFbTIrTTZS?=
 =?utf-8?B?cjJTWStRZ2Z3WktHeFJRemdxTVByb3ZMWlFuL0pRSHdqSS9MaEdKYkVKS0R0?=
 =?utf-8?B?L1poWEwwT3FlNzJOY055eW8vSjRPTHFuSjlUb3BXL0VYRnhZL2tZTGlQZ20x?=
 =?utf-8?B?aVVnSENyQXhoS1RiYU1vdS9qQmhMby9KZkFJNDNVVkNKMWxVZE5qY1BMR0tC?=
 =?utf-8?B?QW1KekNHeHB4ZDhJT05sdEtvZHQ2VHJQdGZna09lc0RGUnJXbFpJQ0FvRW5S?=
 =?utf-8?B?d1BHS1RxbFVpR29pb3FUMFg0VW96c1MvVWlBekNuYW43Sk5uL2x1SGRtQ3Nh?=
 =?utf-8?B?aG9pOC9kcFpBM2drRE9qRm1OOUVENThheDRSTGlUN0pXblpTOWxZajVrQ1B5?=
 =?utf-8?B?WU9PUzdyYTZzbE54Zm40UC9zTXR0RktTVElISUdYNjVydXlocjJRYkpmMVEx?=
 =?utf-8?B?Wnc0dDh3am5kS1BTa08yT1hJdS9TZnh2L0FPT0YyR2pmMGlURkxZRVFpcjZH?=
 =?utf-8?B?eDNZTmtNem82OHVSQUFUczFNdlJzYTlSK0RCOXJWVWtaU3l5Tm03eDJjVHho?=
 =?utf-8?B?WmlhdzM1UTB4Nk1GWGx5OTM4c0VhMndkRFp3NVhLcnJaK1pUQ3lMaWNGZXJD?=
 =?utf-8?B?NXdKRVdjUUNDT2FoMFRxWEFWSGJKQUFvaFRDMFZyRW0rMUNzQjNFTCthaWRT?=
 =?utf-8?B?Z0pOQ2tVcXJFVlNkeDc5WXZkcmd6R0pMTWdjaXhEaW43Njc4bjFxYXFOVGc5?=
 =?utf-8?B?Sm1UTDNZQTNTZ0lOMUdvUGltS2laNTIwYjd3dlB2VWxZZ3ZoZzI1NWpCN3F6?=
 =?utf-8?B?YnYyT0RZVlorc0FqY1JHdVYrUkdtUmVkR0d0RDBVVHEzZWNCTzIzbm1pMmFp?=
 =?utf-8?B?TUZrSTVML3FtbEVMOGRVMWRyOUNMaWFyWWJBeHFzdzlTdnZONmkvNDkvUzlQ?=
 =?utf-8?B?UXJ2OU5NL1pqdlczK2pDa05NWUVQanBQWFo0L2I1Wmpla2ZibXVaSEM5eXZp?=
 =?utf-8?B?VHF1WFRNLzJtUEVpOENBcFFHQXBwREI1ZWpsaWd4dFBLK25LRE1Ba3VueGJY?=
 =?utf-8?B?Y1BPSmxGb05RQzhKV3ZPZXJFSUNBdTRGa2xROHA4eFRQeElpWml0cE1JYzUz?=
 =?utf-8?B?bGNDQm5NdnAzL3dPd0tFcStBVkV6ai9BOUd6VjJIN3BoR0ZMNlQwZzR3UzI5?=
 =?utf-8?B?MjFHRTZtZndxdjl2T2RDd2UzZ0lrZ2FwQUQ1UmMwYVhobm51ckF2TUxZajVX?=
 =?utf-8?B?akhNbVRlV0tVSmhHWm1TREdJM3ZaeEZZOGczb1BsbndVVm0rdm5XRjJ2eTNm?=
 =?utf-8?B?RXoycmF1L216emdwZ3Zway8wNndzQjFGMno3UnJDRUpYRnNSMm1acVA2Q1V0?=
 =?utf-8?B?d2ZGTVR6L21UMkczSU5tck5CRWhhakJKMEZhVnVYaFlwcWVwUkJwOEhwR3dL?=
 =?utf-8?B?UkIxMTQ1SFhjdHl5NW1mZ1VMa203ajBuVWE1Nmw0ck5EQU4wazJvL1BXTlpl?=
 =?utf-8?B?d1M0d21DU3FZY3dKWFZtb25OS0paeVVtdmxLMXFOc050elhKQ2JTZTRxV0Ft?=
 =?utf-8?B?a0FUUlRCZGZjcTBoeVNhN1lFWitnbEtHeGlJN0phT3RTSHdRVk81K0lhWGww?=
 =?utf-8?B?NHB5MHNiTVdtL2p3YjVIN05scGtBSzQ4VjFXOTFsaFBnRGVrVGhiTWV0TURq?=
 =?utf-8?B?RU0rRS85MUlGVjBob0R3bDNhR1J0cm5QRzRLcEQ5OFArQ05jSmh3MXpmdTlq?=
 =?utf-8?B?SFNiMGxjTHN2QWp3OU5MeVFzcGRpT2hvRGJIdXFjUTh4M3BjakhGdWFtK21E?=
 =?utf-8?B?ZU50eWlCeWk3RXAxTElFamRVaElDbzU2Q0JzN2thQzl2eXI3Sm5uOGhxZlF4?=
 =?utf-8?B?Z0xZdFlpUng4ckRvbjBOMWh5Ukh0NURsNVFVVVNtdkk5dzhDQzdIOGlHbURE?=
 =?utf-8?B?MHNJRFpyNnNtUE56SFJHamhhQnlLYzU0L3dnQWhVRTU4bE9MTUNXcnlyTkRL?=
 =?utf-8?B?akg4dFdZM3ZNY1lPdjZQRnRCWDVDd1Y4U1Y4ZU5iZGt1Z1RWRkFSaVR2LzNx?=
 =?utf-8?Q?W1EA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3318ab9-6f44-49a8-f4a8-08dab193d84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 05:36:17.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXR8xNwBiJ4qrr/nEUNsPALM9zbimSq4SV2eqs+mLXct9PzGgtLKFqi0gXjRh/C9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIDE5IE9jdG9iZXIgMjAyMiA4OjM0DQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4NCj4gQ2M6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT47IGphc293YW5n
QHJlZGhhdC5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gZXBlcmV6bWFAcmVkaGF0LmNvbTsg
bHVsdUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSB2ZHBhL21seDU6IEZp
eCBydWxlIGZvcndhcmRpbmcgVkxBTiB0byBUSVINCj4gDQo+IE9uIFdlZCwgT2N0IDE5LCAyMDIy
IGF0IDA1OjMxOjQ4QU0gKzAwMDAsIEVsaSBDb2hlbiB3cm90ZToNCj4gPiA+IEZyb206IFNpLVdl
aSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIDE4IE9j
dG9iZXIgMjAyMiAyMjoyMQ0KPiA+ID4gVG86IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPjsg
bXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207DQo+ID4gPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiA+ID4gQ2M6IGVwZXJlem1hQHJlZGhhdC5jb207IGx1bHVAcmVkaGF0LmNvbQ0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIHZkcGEvbWx4NTogRml4IHJ1bGUgZm9yd2FyZGluZyBW
TEFOIHRvIFRJUg0KPiA+ID4NCj4gPiA+IEhpIEVsaSwNCj4gPiA+DQo+ID4gPiBJdCdzIG5vdCBm
b3IgdGhpcyBwYXRjaCBidXQgc29tZXRoaW5nIHJlbGF0ZWQsIHNvIGp1c3QgYSBmcmllbmRseQ0K
PiA+ID4gaGVhZHMtdXAuIEkgaGF2ZW4ndCB2YWxpZGF0ZWQgdGhlIFZMQU4gdGFnZ2luZyBiZWhh
dmlvciB5ZXQgZm9yIG1seDUNCj4gPiA+IHZkcGEsIGJ1dCBmcm9tIG15IHF1aWNrIHJlYWQgb2Yg
dGhlIGNvZGUgaXQgZG9lc24ndCBzZWVtIGl0DQo+ID4gPiBkaWZmZXJlbnRpYXRlcyB0aGUgY2Fz
ZSB3aXRoIGFuZCB3aXRob3V0IFZJUlRJT19ORVRfRl9DVFJMX1ZMQU4sIHRvIGJlDQo+ID4gPiBj
b21wYXRpYmxlL2NvbXBsaWFudCB3aXRoIHdoYXQncyBiZWVuIGltcGxlbWVudGVkIGluIFFFTVUg
c29mdHdhcmUgKGENCj4gPiA+IHNwZWMgYWRkZW5kdW0gd2FzIGZpbGVkIGFzIHJlcXVlc3RlZCBi
eSBNaWNoYWVsKToNCj4gPiA+DQo+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3Zp
cnRpby1zcGVjL2lzc3Vlcy8xNDcNCj4gPiA+DQo+ID4gPiAtIHdoZW4gVklSVElPX05FVF9GX0NU
UkxfVkxBTiBpcyBuZWdvdGlhdGVkLCB0aGUgZGV2aWNlIHN0YXJ0cyB3aXRoDQo+ID4gPiBhbGwg
VkxBTnMgZmlsdGVyZWQgKG1lYW5pbmcgb25seSB1bnRhZ2dlZCB0cmFmZmljIGNhbiBiZSByZWNl
aXZlZCwNCj4gPiA+IGFuZCB0cmFmZmljIHdpdGggVkxBTiB0YWcgd2lsbCBiZSBkcm9wcGVkKS4N
Cj4gPiA+DQo+ID4gPiAtIHdoZW4gVklSVElPX05FVF9GX0NUUkxfVkxBTiBpcyBub3QgbmVnb3Rp
YXRlZCwgYWxsIHRyYWZmaWMgaW5jbHVkaW5nDQo+ID4gPiB1bnRhZ2dlZCBhbmQgdGFnZ2VkIGNh
biBiZSByZWNlaXZlZC4NCj4gPiA+DQo+ID4gPiBDYW4geW91IHBsZWFzZSBoZWxwIGNoZWNrIGlm
IHdlIG5lZWQgZnVydGhlciBmaXggaW4gdGVybXMgb2YgVkxBTiB0YWdnaW5nPw0KPiA+ID4NCj4g
Pg0KPiA+IFN1cmUuIEl0J3MgYnJva2VuIHRvZGF5LiBJIHdpbGwgZml4IHRoaXMgdG8gY29uZm9y
bSB0byB0aGUgYWJvdmUgcmVxdWlyZW1lbnRzDQo+IGFuZCBzZW5kIFYxLg0KPiANCj4gRGlkIHlv
dSBtZWFuIHYyPw0KPiANCg0KSSBjb3VudCBmcm9tIDAgYW5kIGhhdmUgYmVlbiBmb2xsb3dpbmcg
dGhpcyBzY2hlbWUgYnV0IEkgY2FuIG1ha2UgaXQgdjIgaWYgdGhhdCdzIHRoZSBub3JtLg0KDQo+
ID4gPiBUaGFua3MsDQo+ID4gPiAtU2l3ZWkNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMTAvMTgv
MjAyMiA0OjEyIEFNLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiA+IFNldCB0aGUgVkxBTiBpZCB0
byB0aGUgaGVhZGVyIHZhbHVlcyBmaWVsZCBpbnN0ZWFkIG9mIG92ZXJ3cml0aW5nIHRoZQ0KPiA+
ID4gPiBoZWFkZXJzIGNyaXRlcmlhIGZpZWxkLg0KPiA+ID4gPg0KPiA+ID4gPiBCZWZvcmUgdGhp
cyBmaXgsIFZMQU4gZmlsdGVyaW5nIHdvdWxkIG5vdCByZWFsbHkgd29yayBhbmQgdGFnZ2VkIHBh
Y2tldHMNCj4gPiA+ID4gd291bGQgYmUgZm9yd2FyZGVkIHVuZmlsdGVyZWQgdG8gdGhlIFRJUi4N
Cj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6IGJhZjJhZDNmNmE5OCAoInZkcGEvbWx4NTogQWRkIFJY
IE1BQyBWTEFOIGZpbHRlciBzdXBwb3J0IikNCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMiArLQ0KPiA+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4g
PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ID4gPiBpbmRleCA5MDkx
MzM2NWRlZjQuLmRkMjlmZGZjMjRlZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYw0KPiA+ID4gPiBAQCAtMTQ3Miw3ICsxNDcyLDcgQEAgc3RhdGljIGludA0K
PiBtbHg1X3ZkcGFfYWRkX21hY192bGFuX3J1bGVzKHN0cnVjdA0KPiA+ID4gbWx4NV92ZHBhX25l
dCAqbmRldiwgdTggKm1hYywNCj4gPiA+ID4gICAJaWYgKHRhZ2dlZCkgew0KPiA+ID4gPiAgIAkJ
TUxYNV9TRVQoZnRlX21hdGNoX3NldF9seXJfMl80LCBoZWFkZXJzX3YsIGN2bGFuX3RhZywgMSk7
DQo+ID4gPiA+ICAgCQlNTFg1X1NFVF9UT19PTkVTKGZ0ZV9tYXRjaF9zZXRfbHlyXzJfNCwgaGVh
ZGVyc19jLA0KPiA+ID4gZmlyc3RfdmlkKTsNCj4gPiA+ID4gLQkJTUxYNV9TRVQoZnRlX21hdGNo
X3NldF9seXJfMl80LCBoZWFkZXJzX2MsIGZpcnN0X3ZpZCwgdmlkKTsNCj4gPiA+ID4gKwkJTUxY
NV9TRVQoZnRlX21hdGNoX3NldF9seXJfMl80LCBoZWFkZXJzX3YsIGZpcnN0X3ZpZCwgdmlkKTsN
Cj4gPiA+ID4gICAJfQ0KPiA+ID4gPiAgIAlmbG93X2FjdC5hY3Rpb24gPSBNTFg1X0ZMT1dfQ09O
VEVYVF9BQ1RJT05fRldEX0RFU1Q7DQo+ID4gPiA+ICAgCWRlc3QudHlwZSA9IE1MWDVfRkxPV19E
RVNUSU5BVElPTl9UWVBFX1RJUjsNCj4gPg0KDQo=
