Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18466B7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjAPHOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjAPHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:13:33 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEDCDC8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAj8cII7i2mTZbfXCs+35K6Rw5fQ1DYijdKRux1qyU2WwH+HOgEcFB0o0eRMvwhBp2ICd39auUqSpmhDK23CQ2JdssmrfRQ+us1iNB6YgtBWNwFpPc+TCp0Gl1UHTaF9UdpT9jsZc09gqcAWeBbd8PJGxNiK7lu7pv27s8FtWPao6pYPf1vh7GLAd8RSSunu7zUIL6yCYqBZJFwOwJ6nNo8hl5/14P1k7oL0TJBpb9cxafQOjjptFqkWHqn7zwjusrWGqByzGQXouU7YN7Ma6NzD8CRiVMgsR+wO2L42tAUHpRJmfBYdM/guPS6+8hnTJRwzWegPV7coFw1OFLgTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15PMmwwr/EF0Dx2vtauzB1kq/gBnJ39O9VRrfpkcPu0=;
 b=hb62yZZ8tFFSfLAFp+jaBlX+B3xKZXQ/HauRSsEr3intfKlLFApi0aa1SErJ4hWn9KVz19FgVa3OeLtPmM1yEm0T5lN1Ot+OHia23h0gB69MOIyJ9e0CRugW9ujBuMim4pGFKnzPdUIIegj7vayH/RaQoXcDtbqy+EH6JvwcIXET3bfV/y2KlznA5ZdPZm2gLZjq+OPp12I/Wnj8Ylj20mPaNwG75AxE8klp7WHdYbVQcbnM2YlwyWoO6zBa2yKhH9O22gO+0V4jlCC2Lm8gvPSalx4gySRHsIjN+HNW37eEHrPGeiTPEOBdExJsJlVkiOKRa7/Pmy8imjU/mjijlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15PMmwwr/EF0Dx2vtauzB1kq/gBnJ39O9VRrfpkcPu0=;
 b=e1JijAQH8yUYTNTWY6/vlB0dkNVLSFD3WL+TKtJ9c/NthPywtUqmjefFbUcE6zekPuJXyzywL6Js7mo4oPB/m6lhie4QFSJb2QQRuVziOCj68SNfGM8zB1HyXDLnHQsKTC3tdJiS3YDaj1YJtSA4s54jIRyZjB0TN6RqVliPGaAyI2WK60wq4PMq1LZ3A3ItDo49r/EpZ4HyCKY6Hf//8/XM8EORRVPQ9TyPv7SlSOxYyXpER6B8LGrrzhbBXF33rfrCUtUkzpf30c0d+qWfStPVsg2xgnXc87HiW0pVM8gbTi8qXqKVgrbh/rp+wy90mMOqxMaO8Q57qYgCDgGeug==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 07:13:22 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:13:22 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
Subject: RE: [RFC 3/3] vdpa/mlx5: take iommu_lock at dup_iotlb
Thread-Topic: [RFC 3/3] vdpa/mlx5: take iommu_lock at dup_iotlb
Thread-Index: AQHZJpFQLEcKvBRzrUao0pXt8Bcpi66gpcbw
Date:   Mon, 16 Jan 2023 07:13:22 +0000
Message-ID: <DM8PR12MB54000ADBE1A0717362433C1FABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
 <20230112142218.725622-4-eperezma@redhat.com>
In-Reply-To: <20230112142218.725622-4-eperezma@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|IA1PR12MB7662:EE_
x-ms-office365-filtering-correlation-id: 1f719de6-0745-4ef1-6aed-08daf791271f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoeSkddAwApNfQi7TEBEwF8hvcMVRPsPepqOEDvKb79AXDOdYlYHRj0zyt3Cx22wy3KIGJOJnN2m+rQqHezvZYIa+w9yht2CUc43PHYHXPvUvzcL7A7gY/KQBLZ9Jfo+IPpPYCI4eNsGLRdUKqKXPPEBx8mzy26E/W6yoamO+y5p6VaPv4SzhvgTwD9An2eDyQ5K7ZMr0hRJbf8wu03uzqZZLds5F900lR1YIInOiGhSpw0oizAj+MXjMFGdyNtMaCp53tz+sS2I3WzwN5hmdTVVf892/OV3NnwTq2AF8nqIcNhQ/pAj0nDA64TaNHBI3eJ0zjR7yg9g44qbuwFkVw2YrqyP2rRr5X5t9OP918HMVONYqxUHulwcOo57deE0AkHpVlWzCV1CMo2+Cj66ZT12GmIMC5JqbPeyWIa9NsQL/Mm3TJCy+U74sxmO+fAKrYD0PJC9r1pvomsg79buxk1DJtB6BgMZNYTeAozXfFrcUB8JkJKsIdBmySJAZV0uVBwWCPEOP0mTUsDuNb4RCFGCw0ifs2eLLQ39ipMUN1cj6c2CASfYqTgCFfm8COGW55Pg/I4beClOHAVQ4vriYk6Zn/DqpYVXFwWZWdoJL3mmoWkpZDMi8Zf8Tf+MzdEtXneryaBEKu/FuWyth5pTihZvlhTWX0jgkZH8ZFsM2/j9qQcrJm0XFHe1OrRd9Ewc01Bhr3aUuds4rMkIwcaUBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(478600001)(41300700001)(38070700005)(66574015)(38100700002)(33656002)(71200400001)(86362001)(316002)(110136005)(54906003)(186003)(66556008)(66476007)(66946007)(55016003)(7696005)(26005)(76116006)(53546011)(5660300002)(6506007)(2906002)(8676002)(9686003)(66446008)(4326008)(64756008)(8936002)(83380400001)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjRRK3l3L2NzYjkwb0lsMDB1VUt0WjhWN21FZERNeGtCWVJsa2o1T3h0aHNs?=
 =?utf-8?B?aG15TEMrUHl3NERiTnB3Y1hHRlRDUjdqTXgxWjVPZERBWm9JcUcraG1ZSHIw?=
 =?utf-8?B?V0hDNEJNYVF4L09VMDloRXBIdSs1WG1EMDFUSVIrMDVzeEZpb2RlaVA1RXQ3?=
 =?utf-8?B?NmhqeG5FbHlCRmxaeC9WN1FJTGVGdDBkSlppd2RVL093blJSbDF6OTdKMS9P?=
 =?utf-8?B?Z1Z4VVNKaUlrSGwwU3pHR0ptdTUrNnI2d1pndDdBWmJtSmF2UEp4MENxQk04?=
 =?utf-8?B?TGtlQU0yMjBySW5sTTZRY01McnBzblBxekxQVkhETHNTTEYrK3Fha0ZjeS82?=
 =?utf-8?B?eGV4TFFMYjBsTmp4ZTdsOFBTTFNDa3pXVER1VFFGMnRraXFEMG93dWZYTnpQ?=
 =?utf-8?B?Wkl4VkRWSEtUMW92M29UTG1KTzZGaENNMkRZeXNYYU5aSUtkRDFRY0xMa0Iy?=
 =?utf-8?B?MjgxR05tQlJON0djMkFyRGMxdzBMZDZUV0JkeTdtVWtMYmVDcldGZlRIYW5O?=
 =?utf-8?B?VkhEK1dPbFhjemNiNnpDZnA0NlY2S2lUaXZjRzJDa0R3UmptUVJyZm8zQ2Zm?=
 =?utf-8?B?OUdubUcxNzNqMTBmNXV3U1VvNEtYcVl1djd2TjlFQzN2T3hNZURPY3dRK09y?=
 =?utf-8?B?Ulk3WHZ3Y1JjOG5NcHd3NVY1OUVYbXNLcUhHcmx4N1ordUVHa3I2ZWxpL2dW?=
 =?utf-8?B?c0RDaGtVVW54S3FNdG9UQ2FmYnAzL2FEQWlxVURsdGlVdVBydFRiMjlQelRs?=
 =?utf-8?B?cVZzUDRpby80a3ltMkRxUmIrNElWaGZyNDJCUU51T3BPTDRDWndnSEh0ZDBY?=
 =?utf-8?B?SW1ZSTZ0SG0yUCtHZFR0bGpSZldVMXJTdmpRZUtTTXV0MDVLYlFrVXp0YXkr?=
 =?utf-8?B?WVgwUUh3T09sOGNyK0pscUw5U3IrK1VhV2xmaFJwNUtJUlY3WTBaelg2elJH?=
 =?utf-8?B?SzdZSEZzMDNmS3g1N3dkU01WaW1uUTNCN1ZDQkc5U2EwNXZud280T0ZSbXhY?=
 =?utf-8?B?UkcwL0NHN1o2d1gzNnJiOXpYWUZTeW5Jb011ZjROMUE4N1RzZklCOTJGaksz?=
 =?utf-8?B?bzdlRHVaMFBiY2x4RkMxeGVpVHBMbnBpQWgzZ3RIbjJsNFVYa2xPdXN2ZFVy?=
 =?utf-8?B?MFRLU1ZpVmN1T1lrY2VXZUZhVlNnVlRhb0dGeDArUzFFaEZReHJNOUc3bklQ?=
 =?utf-8?B?SGRJemg5K1VJbStjY0tOTTc0Y2QvZldKSDBDOExydE9TV1hDMUhwakxFVVg1?=
 =?utf-8?B?U29wOTNYa05lUU84cEVlYWlXOFdtOTlNTnFlb25hREc3WWZveXVCRnp3QVg5?=
 =?utf-8?B?WC9UWTRMOC9kbFpqMEpmQmU1ZWlqVUdJUklYUnZzMlFRdXBJWnFFaTlxYStt?=
 =?utf-8?B?RUM1OUVXR3UwZklOMHN1WnRuR3BPSE5aYVZSUFB5U25ocytPbHBQZG5RVE1o?=
 =?utf-8?B?VU85aWlubS8xdlc1bDJGTDZGckFxZXM0NzlIeW5SeHRNS0ZkNkpwcXAxM2pH?=
 =?utf-8?B?dHFTM0FxaEZ5NThpNFpnT3lWUFBKcU45N3NSUTd4K1A1V1krQUFvWFpwSHhn?=
 =?utf-8?B?NjlmWW1NZVMrWjhJZytWelFGUjhGai9aT3NkWmExTGxPQ3kxQ2hadCtOdnM3?=
 =?utf-8?B?cWU1RXBvMUR5M2lQUHNPMTBkMjAwc2VObWdIMHNJdlFqYlBHS2VrKzlTZ3FH?=
 =?utf-8?B?Y1VhWHRrdTBqcWNrN2RXcE1manpRdWtldjRuYjhkQ0ZZUW1BUCtFMzh2WHdm?=
 =?utf-8?B?RkQybkVpNUJLQWdEVVdscHg4dTBCZkRxUUlHTU1GU09rZENBdnMwWXVEZWg2?=
 =?utf-8?B?MGQzdG5qNEhHL1doTGtiNVNMcWorSmJlNU5JS1V0UE1tU1J6R0tIdHc1eEli?=
 =?utf-8?B?Skp3Nno5SEEwQURleFpacG9qb3FqTlcraW11YTdpeEIzY1pXbzVtT1pOSHhj?=
 =?utf-8?B?eTEvMnVJMEFmU0JtTThwT1dEbGlKM1JPRlJmQkZSd3hZMTZUbzd2bHpIcE5F?=
 =?utf-8?B?NVNTTEp1a2lMRjdDN3NnT3RxdHFmMXVGK3U0NmYvNWhxWXBPRVpiTWFleTlJ?=
 =?utf-8?B?eFNPNmxNUjhsOVBVWE5rT2FraDdCR1dPV1hvb2JrQWFpSmx1QjRPNTRwbEdO?=
 =?utf-8?Q?8xOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f719de6-0745-4ef1-6aed-08daf791271f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:13:22.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jipprm3j0DnJj6CcPkgX9HTL/pI7TtFxdFsIgxB824iXCGZwmF80TfU+4/BoxWAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIDEyIEphbnVhcnkgMjAyMyAxNjoyMg0KPiBUbzogbXN0QHJlZGhhdC5jb207IEVsaSBD
b2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsNCj4gbHVsdUByZWRoYXQuY29tOyBq
YXNvd2FuZ0ByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC0NCj4gZm91bmRh
dGlvbi5vcmc7IHNnYXJ6YXJlQHJlZGhhdC5jb207IHNpLXdlaS5saXVAb3JhY2xlLmNvbQ0KPiBT
dWJqZWN0OiBbUkZDIDMvM10gdmRwYS9tbHg1OiB0YWtlIGlvbW11X2xvY2sgYXQgZHVwX2lvdGxi
DQo+IA0KPiBCb3RoIGlvbW11IGNoYW5nZXMgYW5kIGxvb2t1cCBhcmUgcHJvdGVjdGVkIGJ5IG1s
eDVfdmRwYV9uZXQtPnJlc2xvY2sgYXQNCj4gdGhpcyBtb21lbnQsIGJ1dDoNCj4gKiBUaGVzZSBp
b3RsYiBjaGFuZ2VzIC8gcXVlcmllcyBhcmUgbm90IGluIHRoZSBmYXN0IGRhdGEgcGF0aC4NCj4g
KiByZXNsb2NrIGJlbG9uZ3MgdG8gbmV0ZGV2LCB3aGlsZSBkdXBfaW90bGIgc2VlbXMgZ2VuZXJp
Yy4NCj4gKiBJdCdzIGxvY2F0ZWQgaW4gYSBkaWZmZXJlbnQgZmlsZSB0aGFuIHRoZSBsb2NrIGl0
IG5lZWRzIHRvIGhvbGQNCj4gDQo+IEp1c3RpZmllcyB0aGUgbG9jayBhY3F1aXNpdGlvbi4NCj4g
DQoNCkZvbGxvd2luZyB0aGlzIHJlYXNvbmluZyB3ZSBzaG91bGQgdGFrZSB0aGUgc3BpbmxvY2sg
d2hlcmV2ZXIgd2UgcmVmZXJlbmNlIGFuIGlvdGxiLg0KUXVlc3Rpb24gaWYgaXQgbWFrZSBzZW5z
ZSB0aGF0IHRoZSBpb3RsYiBjb3VsZCBjaGFuZ2Ugd2hpbGUgaXQgaXMgYmVpbmcgcmVmZXJlbmNl
ZC4NCkNhbiB5b3UgaWRlbnRpZnkgYSBzcGVjaWZpYyBjYXNlIGZvciB0aGlzPyANCiANCj4gRml4
ZXM6IDUyNjI5MTJlZjNjZiAoInZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIGNvbnRyb2wgVlEg
YW5kIE1BQw0KPiBzZXR0aW5nIikNCj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
IHwgMTMgKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMNCj4gaW5kZXggODc4ZWU5NGVmYTc4
Li5lOWM4YTdmOGVlMWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
Yw0KPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMNCj4gQEAgLTQ1NCwxMyArNDU0
LDE1IEBAIHN0YXRpYyBpbnQgZHVwX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwN
Cj4gc3RydWN0IHZob3N0X2lvdGxiICpzcmMpDQo+ICB7DQo+ICAJc3RydWN0IHZob3N0X2lvdGxi
X21hcCAqbWFwOw0KPiAgCXU2NCBzdGFydCA9IDAsIGxhc3QgPSBVTExPTkdfTUFYOw0KPiAtCWlu
dCBlcnI7DQo+ICsJaW50IGVyciA9IDA7DQo+ICsNCj4gKwlzcGluX2xvY2soJm12ZGV2LT5jdnEu
aW9tbXVfbG9jayk7DQo+IA0KPiAgCXZob3N0X2lvdGxiX3Jlc2V0KG12ZGV2LT5jdnEuaW90bGIp
Ow0KPiANCj4gIAlpZiAoIXNyYykgew0KPiAgCQllcnIgPSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2Uo
bXZkZXYtPmN2cS5pb3RsYiwgc3RhcnQsIGxhc3QsDQo+IHN0YXJ0LCBWSE9TVF9BQ0NFU1NfUlcp
Ow0KPiAtCQlyZXR1cm4gZXJyOw0KPiArCQlnb3RvIG91dDsNCj4gIAl9DQo+IA0KPiAgCWZvciAo
bWFwID0gdmhvc3RfaW90bGJfaXRyZWVfZmlyc3Qoc3JjLCBzdGFydCwgbGFzdCk7IG1hcDsNCj4g
QEAgLTQ2OCw5ICs0NzAsMTIgQEAgc3RhdGljIGludCBkdXBfaW90bGIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LA0KPiBzdHJ1Y3Qgdmhvc3RfaW90bGIgKnNyYykNCj4gIAkJZXJyID0gdmhv
c3RfaW90bGJfYWRkX3JhbmdlKG12ZGV2LT5jdnEuaW90bGIsIG1hcC0+c3RhcnQsDQo+IG1hcC0+
bGFzdCwNCj4gIAkJCQkJICAgIG1hcC0+YWRkciwgbWFwLT5wZXJtKTsNCj4gIAkJaWYgKGVycikN
Cj4gLQkJCXJldHVybiBlcnI7DQo+ICsJCQlnb3RvIG91dDsNCj4gIAl9DQo+IC0JcmV0dXJuIDA7
DQo+ICsNCj4gK291dDoNCj4gKwlzcGluX3VubG9jaygmbXZkZXYtPmN2cS5pb21tdV9sb2NrKTsN
Cj4gKwlyZXR1cm4gZXJyOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIHBydW5lX2lvdGxiKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikNCj4gLS0NCj4gMi4zMS4xDQoNCg==
