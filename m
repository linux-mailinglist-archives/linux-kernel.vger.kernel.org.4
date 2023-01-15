Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A166B082
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAOLHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjAOLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:06:59 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3CCA244
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkBeHtaJMX18LM2gZK5Ab2WYDPLXvMHS+q8GD2V5xrK3txal1OkUYzPmCTMk+spYSS3notr0/IWPwzdLAFbcRhGwSKzqgLfJPOf8hdrZMl50/hIFG1KnEC9zyTcP/KhvI5J4qaCEb6VELsyAiW5ibOziP2n9FMFil4BHRwfVychtIRiOhwBEU4l7FdhDce487s5V78/vlks6yeLs7p1kDi+jbOWgnvsMPTN1wBLiR5qmGm0iRKskMtBL/FgSFaugnzifadZo4UCgp3igYz4aQH5yqjZkmrzz72owMXFcI4sQEKvBoZkadRuo5531UD2YKBcW9mqxYKwizUdJujFY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1/1R/bsykjfrMwcWe00jfZImSQA6rGnDzEMVJu1Slw=;
 b=CHINM5ddGtmfHCg1ZgB+07smsfRTEmH4SBAbnXs4wPXHxYqwUMJHER5SXF6zm0AfCkcSyKDe5dfyyT4KXYHxWJUyEnqgUTQJmV/dIT+ZMwGpYOYwSWHrBcQ53mt2SHWFTtwHe3DkmlZ4/o0BRBofemrhua3vdxcP5d5HC6evFvhQY1j4PgRF/f+GjoR8FvDmah2y2irAqolBrFrnMELddJ6m6tRh0w3X+c9r8s2miFzwVkphXbtO5Y4JVnNOxVaQEvqQ7cslds/gtAGepoiBviJp20W1Pp5dpBQHXkvnL7I35m1j88L1RlDMRIPy1cHOw67A9S8DXCiUyGlncXDbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1/1R/bsykjfrMwcWe00jfZImSQA6rGnDzEMVJu1Slw=;
 b=dOCCHwpCnYECvTJWl3kG1tQsjtCXjRxdP8WirIUt7PtOEx+dYybwrgUNUXzJVeECOPwG0tKHQTpTF0jcIUKiLkxitNyWG9jt2fAg2652FYKCzTzN5igjK8EpT7xpsfpySnnpWSOhWn0HgxJX2x47GM/yK5NVb/IdDNyRbnTtijjlltOkK6gQKOlIDB3fqlUM2R2txrhS86erb3whEf884JFWaEnvmlKgEd8qnipNa9Ook0SuhGdRnzFR04NDvbH+IdiwmfKKiFo0nEdoWqUGa9rZmJvHFn6j8DxMJC+Ziyh+OnKV65ITjyVutmTOFojPyuzF5RMMnHTzYU0QxCkc7Q==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Sun, 15 Jan 2023 11:06:56 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Sun, 15 Jan 2023
 11:06:56 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 3/5] virtio-vdpa: support per vq dma device
Thread-Topic: [PATCH 3/5] virtio-vdpa: support per vq dma device
Thread-Index: AQHZJYXuw7jPEXie+kmQgvwxBz5kIa6fV93A
Date:   Sun, 15 Jan 2023 11:06:55 +0000
Message-ID: <DM8PR12MB5400537E96A63AD16F1C118CABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-4-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-4-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH0PR12MB5219:EE_
x-ms-office365-filtering-correlation-id: 76a528f2-3827-435d-af48-08daf6e89d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEzMbMvwnKhyf3SlOYdCBCrzktQ48fShG21Oh/wogcGYtZahEBe8Myg2F+gCxMzVMLTzkqF99Xl/9Y/9RhexkTzvFVT3BOrjIEJjbhLFeSAyES86tbz86DnEhZ6LhJY1/Un3H2okixOk2sMVyd62plFeYKwge9fpN+FstwlRdVUDOwvnM9ynUv/P4SGajUcJ2liCP+rLaRImEXsl3IAnvyeCa921ZnLwnpvnkW4XYBSLko3rPl8W2wIHm4rVrJop4ldsuPAbU/LAN9qhK6ieE8Z6aJwYUuqXjVQXMaisv08FVEe3175IP1EZPCnbAWrN3D0x/EFPVHRvhDpiQ8MMcDqOWmpnDROhvS1lMFwGh9FGxiiNN9U+izH6ebcvLNw9H5Ogbb16IekiVnvTkiLx+LqKiYbwau6P8xs2scn9Tt+7rXWZT0wt3XUkv8pohDFkoVSlM5LrNj8ZbsCGB6BlVYN9fLd4wg78+4Kxn0tlZpB61g8esw5qHcSS2Q/Rl6PM3aY2xQ8erqzkmko4XwdOAvPBjWCSqAVZduU4SrymEy3fDDU5qv/rBNV5MfFG8/DHJ7b8k9Bb7pIlctLFwAEZLTVvP80qt2tlxMVyvXEK1zsPIydf+VpSbgSqh6ukiu3qO9KjG3funN0r9FEbp1MF5MoNGrem1xqZIcrBv/mbCu9ykx27X41zTi+bvzqsfYaZigtXDps2xCkke8jSliUUzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(7696005)(71200400001)(33656002)(478600001)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(41300700001)(110136005)(54906003)(316002)(55016003)(38070700005)(38100700002)(122000001)(6506007)(53546011)(26005)(9686003)(186003)(83380400001)(86362001)(5660300002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlIWE5udW4yOXVBSFJ5N2dHNSszSmpHUTJTakI2WlZFOWtYQm1sQUg1anVm?=
 =?utf-8?B?dDBEZVRWQVZOOVlGRnpQRCtHZSs4STkxc0w0RHAxc0owYWpMR3FHazJaQnQw?=
 =?utf-8?B?eXdIVWVXUmVZZ2h3Z3ZpeGZ2b01NMHBjQWE1aVhHY2NoMjB6Q21HUXdWUjg4?=
 =?utf-8?B?RzZZMFVrWlVCeXlRdVc1Mm5HNUVlc1VQZWNxT2xvZ2lBL3dZUGpCVGZFUlA0?=
 =?utf-8?B?Q3RSbWtTNW9GUFdNWUoxd1VFVGxodmdZZitNTjJIMElGT21QanJQd3cvWTlE?=
 =?utf-8?B?ZTdiK3F3TTd6NXpMZWk2bjlrT1NtTWwxWXU4QzN2NmNvYnRZT2tmMVQ5RTZl?=
 =?utf-8?B?dUFwRVhhRHFhRW9SYXZjcitSSlJ0Z0cxbkhUSDFhWU00V0k2bDZvRWx2eGN3?=
 =?utf-8?B?UklySWZIZDNmdXlPMk1DdGVCdWsvZWFyTmozRU9kNXFUR2poUS9QRFNRaDNw?=
 =?utf-8?B?aFJ3VWM5dFdPUDFIb040WkxUb1hXeUMzYjZJaG9XRnY1eEFuSmZnbXFMYU5i?=
 =?utf-8?B?YVBSYkF3Wkx4VFZSeWVrK2FRNW4xRnBIbUFkWTZNd2MxcnZiQTI3YWtrdTZz?=
 =?utf-8?B?cklHYk9YRkRGdUJsM2pXbG4zVHlOSDYxbnNXd2N5d2dyZWVFbDZlWUFFTTlj?=
 =?utf-8?B?Zk95ai9CZ3psUnVvMjFaTjNMZ2Iya2NFWG9ZMXdObHd3dVhoWURrYkM3dzRS?=
 =?utf-8?B?SWdMVW85aWw3RDlPN05OdXc3RUZ4eEVHb1J6RmNXakY1WGZOQnpiR3J0b3Nn?=
 =?utf-8?B?MUxOMGtJbHZ0R1QySi82K0taYitOQXYyYjB1Rjg5VWdML0ozY2htNC9SVnhx?=
 =?utf-8?B?VmVjaGFEa0pvVjhPbVlvTFVETXlBTWJwVkhWYmJMbGdUWENsT25OSGJmeVF6?=
 =?utf-8?B?dE1pV0ltZEQ2UHBteTVkejVpODhXOFNoT3E3Vzd1K2ppZGJmVEt4RlA5QWhT?=
 =?utf-8?B?N0ZDTjY5Vnl4YzI2d1cxeHR1NFd3N0Y2aWQ4RzVQK1hBRUxtUzdIY3RBUHZ4?=
 =?utf-8?B?bU9idW5sMGs2R0J4RE9MS1VydVlJaHFNUk5VYm9sMUhIcnJWWGlHN1Z0a2Fs?=
 =?utf-8?B?TFJKYnM5S0Fvd3I3dWgvejZ0NUlkZFBma2l5dHZhNlVLbDB4ZmwxZHFlckRJ?=
 =?utf-8?B?WkFhUjJTSmJkMDV3eFY4S2pkWFduejRoQUtqMWdQSTJ6SGUvZ3M0SGNKOEVx?=
 =?utf-8?B?Rjh4bEJnUnR6eWwvYlh0WGhDRDF4em5PQUR1L1VrMng3WU1qYlhvS2kyS0xa?=
 =?utf-8?B?UWh4NGRNR0VId3c4WWdoTkR3TzdtcGFNMHFQMGRWS0kwUzBCeXpWbEZLZDd0?=
 =?utf-8?B?ZWdZdjdEY1hkMXFMak5hVmVMMmYwOVVrMVd1bmxrbnRaQVE1eENYL1hnQXZ5?=
 =?utf-8?B?aGJrWGlEZ1QxYUVhN25ERVFYTzdtNng3NVphRnBoS2pSMnlQUUxHd2VuUC9T?=
 =?utf-8?B?WnJJbzNycHBkNmt4ZkFrWTMzNEVLU01DMTJQN3l3eVlZekVycmpETXczdmNQ?=
 =?utf-8?B?b0hMb3lhNTlZdTF4N2MwbnVzaEt6SFBlcXdaWE1PdXdkd1JTK2hXVmZ6MHNZ?=
 =?utf-8?B?Z0ovVUVnVlBIZjhFejF4NkpQTnp2UUlKSnF5MjgvLzNCRmNUZWhHa01IZk16?=
 =?utf-8?B?WW5PdXNGQ0J4N1Fkb2xLQjVWQjU3TmNGVUIxWW1QRFlVaE1BNVJrWUkyRmF0?=
 =?utf-8?B?S2d6cXZUL0NmckQwLytaemNZN1FsYmh0b09DUEVyRlJGUUNlbmdNYVN6bVZn?=
 =?utf-8?B?NFViMVY2RzZubnVGZWVDc1lsdnkvSWx6NjBCRFFGaFRVcEtoMnJBOEZreUxn?=
 =?utf-8?B?M2hvYlVnM2tWUnlaczRxbEVpbE1xd01lVllaSk95OVVreUZMUzI5RHdtdjZH?=
 =?utf-8?B?WkVkRWtsTGlJMk1IMDlpandpMm83ZHU0MnBBbUhwajN3eERJWEt4YUtlYXdk?=
 =?utf-8?B?OTZ5SU5CZjVUa1ZIaGYwZ2dRNHFFN3d3MnJxUmpIaldOT2xvNWVscHdWSGNK?=
 =?utf-8?B?S0Jqd3FBK0V1YlVBRlFaR0VnckUwN1k3SHFOT2JpaVpqQzZTcXFSQVlDN09K?=
 =?utf-8?B?MmJyL2lEY09UY3psMjYrbUNtVkdLS09ONzBGUGdXaFRUOUVjYVRqNDA5Z2hv?=
 =?utf-8?Q?m5Rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a528f2-3827-435d-af48-08daf6e89d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 11:06:55.9504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzOXW9WPAkuLkG2al6gSmIq6OK4YgNk3jUpuzengufewMHzvUVSwaQOYVz6Uq+wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIDExIEphbnVhcnkgMjAyMyA4OjI4DQo+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdA
cmVkaGF0LmNvbQ0KPiBDYzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+OyBnZGF3YXJAYW1k
LmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHRhbnVqLmthbWRlQGFtZC5jb20NCj4gU3ViamVj
dDogW1BBVENIIDMvNV0gdmlydGlvLXZkcGE6IHN1cHBvcnQgcGVyIHZxIGRtYSBkZXZpY2UNCj4g
DQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc3VwcG9ydCBvZiBwZXIgdnEgZG1hIGRldmljZSBmb3Ig
dmlyaXRvLXZEUEEuIHZEUEENCj4gcGFyZW50cyB0aGVuIGFyZSBhbGxvd2VkIHRvIHVzZSBkaWZm
ZXJlbnQgRE1BIGRldmljZXMuIFRoaXMgaXMgdXNlZnVsDQo+IGZvciB0aGUgcGFyZW50cyB0aGF0
IGhhdmUgc29mdHdhcmUgb3IgZW11bGF0ZWQgdmlydHF1ZXVlcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQpSZXZpZXdlZC1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+DQpUZXN0ZWQtYnk6IDxlbGljQG52aWRpYS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDEzICsrKysrKysrKystLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fdmRwYS5jDQo+IGluZGV4IDk2NzBjYzc5MzcxZC4uZDdmNWFmNjJkZGFhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jDQo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb192ZHBhLmMNCj4gQEAgLTEzNSw2ICsxMzUsNyBAQCB2aXJ0aW9fdmRwYV9z
ZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwNCj4gdW5zaWduZWQgaW50IGluZGV4
LA0KPiAgew0KPiAgCXN0cnVjdCB2aXJ0aW9fdmRwYV9kZXZpY2UgKnZkX2RldiA9IHRvX3ZpcnRp
b192ZHBhX2RldmljZSh2ZGV2KTsNCj4gIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2ZF9n
ZXRfdmRwYSh2ZGV2KTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2Ow0KPiAgCWNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsNCj4gIAlzdHJ1Y3Qgdmly
dGlvX3ZkcGFfdnFfaW5mbyAqaW5mbzsNCj4gIAlzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsNCj4g
QEAgLTE3NSw5ICsxNzYsMTUgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsDQo+IHVuc2lnbmVkIGludCBpbmRleCwNCj4gDQo+ICAJLyogQ3JlYXRlIHRo
ZSB2cmluZyAqLw0KPiAgCWFsaWduID0gb3BzLT5nZXRfdnFfYWxpZ24odmRwYSk7DQo+IC0JdnEg
PSB2cmluZ19jcmVhdGVfdmlydHF1ZXVlKGluZGV4LCBtYXhfbnVtLCBhbGlnbiwgdmRldiwNCj4g
LQkJCQkgICAgdHJ1ZSwgbWF5X3JlZHVjZV9udW0sIGN0eCwNCj4gLQkJCQkgICAgdmlydGlvX3Zk
cGFfbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7DQo+ICsNCj4gKwlpZiAob3BzLT5nZXRfdnFfZG1h
X2RldikNCj4gKwkJZG1hX2RldiA9IG9wcy0+Z2V0X3ZxX2RtYV9kZXYodmRwYSwgaW5kZXgpOw0K
PiArCWVsc2UNCj4gKwkJZG1hX2RldiA9IHZkcGFfZ2V0X2RtYV9kZXYodmRwYSk7DQo+ICsJdnEg
PSB2cmluZ19jcmVhdGVfdmlydHF1ZXVlX2RtYShpbmRleCwgbWF4X251bSwgYWxpZ24sIHZkZXYs
DQo+ICsJCQkJCXRydWUsIG1heV9yZWR1Y2VfbnVtLCBjdHgsDQo+ICsJCQkJCXZpcnRpb192ZHBh
X25vdGlmeSwgY2FsbGJhY2ssDQo+ICsJCQkJCW5hbWUsIGRtYV9kZXYpOw0KPiAgCWlmICghdnEp
IHsNCj4gIAkJZXJyID0gLUVOT01FTTsNCj4gIAkJZ290byBlcnJvcl9uZXdfdmlydHF1ZXVlOw0K
PiAtLQ0KPiAyLjI1LjENCg0K
