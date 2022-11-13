Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA4627000
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiKMOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:01:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2586325C7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 06:01:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoOWVBrlzU1s0dfie/OzZw163eqsHqrwrFXVWlIYEwNla1ysYfUOeSEhnRGXCKpxPkj3WAv2vJ36qnLeYuk/oPvR7CvRVQ9tKXDudJJY8uxLnHVAOYFeaKoGhfxtrAFQnYOYXdVP6NbzhrMTtlpNPFMzz3cINWd3IteIbI1LGtcXyuKmNKobAesjXagUcB2LgX93iWhdkfVPjJvMeax9NiauVPBrRqj1P96DeOQRrWbwNAXcvGsKn9hUgHVtjPrR62BQ3DhxJ/wYMOUweRs7RG2l26i2RjSPVpBRuPfHNRhM5WcuxVYMAcxXAY9m0fEf3N/M+D8k8ETMTMYw+hiloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KY6ci5x3uye+lWbPdTOjxHCMssh2ppe3xv1YsS2lAM=;
 b=YC8G8bjHI91PzssPblqQliyCE/W4SKpMbBT3ZkvsVgJfVd1VyFYGO6ZgqSymH5ZK4DHKru15P6/z0FZcz3Sgn6TXv1gwSx+GG//7SBwI2GGPQdPCfs5u8L2hGZa9oT8yoOAoke7lNKvjDyHQ7OUqYyy21qWQcvQ/G/GO+2QUc48ELdPX4e/ynfXQihwd0CgsARSYrCC62hBx3OACvIMbWfRbHgYHaAg7COzH6Sx3ofbb5gxWOBZPgu+if9zOmhuYs2mh6oYKzuAE6H+vR54xOy4V04f/BkSmB2829PJZf3HvBUYCKI8QlOkuH6f9kDUYiW01fYZpDSjnrAHcwgnvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KY6ci5x3uye+lWbPdTOjxHCMssh2ppe3xv1YsS2lAM=;
 b=br6d1toCyHA/9MTp0Ht9Eh8eNBWjMcqOA81H22Vt6AXZNkOaDBLjLbUa6Sa1a9wVefP1l+gWv8ywEKEt1zNVXcmiqytfJs5ZXDX/aPySLSujb2k7Om0bZKXu+QxKZMjQf43HAA/RcLIkiGt1jRiH7BdDUmK4JJji7C2BATD99nyrqB/ZIhJDbjSULmiThKyotOVRKuKKNqbDT5Nm2yvgJQQxWyab9xjgi6+vA/KbbMIlIKEHeYFaityPaJKVVoAk39Ls2kmbmxLkTUuz2BSpSNXpKi9l6AzXKMZhFvO804B4amA2zv0vtUpzjN0YRGEd7z2qkCoVYgfqRH2HoDrWuw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.14; Sun, 13 Nov 2022 14:01:32 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6%6]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 14:01:31 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Thread-Topic: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Thread-Index: AQHY92YiBGQm0FF/E0yws0bWCLVtPq4830QAgAAAYTCAAAFggIAAAC/A
Date:   Sun, 13 Nov 2022 14:01:31 +0000
Message-ID: <DM8PR12MB5400D6C50554C873B7484FB7AB029@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113085044-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400DB70B0AA6831E6ABF7AAAB029@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20221113085723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221113085723-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CO6PR12MB5442:EE_
x-ms-office365-filtering-correlation-id: fcdb2daa-edb2-4d33-22ff-08dac57f917e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfy+dd/Hx2ESekIYJ3EZxeMzQbg9UShTTQjAIevMxO0G2b3EpjptVDIDkiwY1KW99fO8GOvwqSaFbXmAiZXRw55fhL+uW7vpvJjsRLlmd2qVx2HJmq9pgEl5d3r9tJ0bJe6XMA2QEXH1GG5yUqIsLK8jjf6FsDhRDRa4d7XttBAR1BdI0XlxvSB6tktZQafhlsAhpYs4EnQMX/d2+pZ7aGaHODLQViR7u9jhGEsWF5jzz15um89gCOje3FjrhGOU61eddwojfwepWZF7BSz2X2QNbEhAXs8DdWnjnbKpcu4zuoMSeVu1WSCAp8W7O5fZf9gMEdrfHI5WG7hg3hfgmv95csKHDtDIhxqmT8YGNOVBFnx85Nf4AZieYTR1rra6Nu85KdXfoYdnuyY4VB2eQPPzBkKHIk/H5PlenXdRHRfC7SVSmoIfyRYmG+ehvzpTKndqmLnA60B3EgN1p8wcL+LXd4kwG7/nlJubXfnOMHXSqsf/KZ+JtiMRkjBOsMqXKmhnXm1RPnoxewoC1o6tVRBU6TSy7nYqVEE8TmpnSiWh7ZnQSvrJzGTTs0CeEA8rHxDe7jUnHNJZNkL30XWfDXwpu/J0NcLgO1rxAhAS6h6VLKrgnKMkD5aejy1kpTdRQI6nFg+jYdwfwiHskboHMF61fImfBzKb6+bCABvuclMhfJ2tGiPwP4FOg5ccfwSYj791rWGBrlfmdP+JbS2w92ml/jCjdLt7WEdbdJaBoTi83N69UhIiRYR59Vy+VHXmFzZY4mn4pBXLBckeNEiFpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(83380400001)(86362001)(38100700002)(122000001)(38070700005)(66946007)(41300700001)(2906002)(6916009)(6506007)(54906003)(8936002)(52536014)(5660300002)(8676002)(64756008)(66446008)(7696005)(9686003)(26005)(71200400001)(53546011)(55016003)(316002)(66476007)(66556008)(76116006)(478600001)(4326008)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJVcnZYRjF5c1NCMEhxRUNJYzNRTnhxMzE4RnpUeEJnMXkyUWF1VEtFSk56?=
 =?utf-8?B?V2lzZU84ZmRpQWhYVWJMaWlpbjJoQURNd3BiU29mMzl3aHV4MTZoVUxXK2tz?=
 =?utf-8?B?ejVwUDlNK0loRzVoeWFvenZNMTR1V3QrcU9NUlhXS0JmdGlJMGFKMGJseHZU?=
 =?utf-8?B?bXh4SGFxMkRYaXlOYUlpRk1odUhQdSs1K0czWTEvVFVLb1VvckFIQy83eGJF?=
 =?utf-8?B?ZkEvUUtOZ3lMaWR2RGs2ZS9lbFMrdHdCOCtlVTFCR3lGSWMyclVtVXNWQnNO?=
 =?utf-8?B?aUN1aFgvNGxMNTZCaDVsdHBBcHN4aG9scGRqc1MyNUhFTGttekVzcnVQaER1?=
 =?utf-8?B?MWRGMEdDZ21OeHhRenI5cVdpRGJva3VyTEhYN29aODd6V2k5cVp1L0I1ODJM?=
 =?utf-8?B?eHZoalJRMHgyc2VZN25xUzMybVZoM0VySmxmaUhUK0JGMVRRNUpkVDUzQ2kv?=
 =?utf-8?B?S2NvYmhXa2ZvSjhOaVI3UjE5ekpRemxhUC9DRmtZTGZyMmpxQWNvVjZCT3NC?=
 =?utf-8?B?cEhpMUtjWUY2NUFjU3BXNjZOcUFOSm10VGRGVnBmbmRxdzRaK1lsUVpQTkxH?=
 =?utf-8?B?cjNaTzAvOTlNb1ZCdCtTVUdUZGxveUZ1M2JMeXFDM203STBKTW9CYlIyTXAw?=
 =?utf-8?B?b25HUnJsWTFLbE1kNTVoVHFEZVdNb3ZxelFOYXpXQ2dwQUNpcnVrTFRBemNn?=
 =?utf-8?B?Y2RzY3hEcEwxYkpCaS84MS9CVlNaZzV2bjFrZUQ5TVpNa0MzdE9pNXJQbFZO?=
 =?utf-8?B?VWZSVFp4c3ZjOUhpR25acDBIQzZvSWM0Mkxna21sYmcvUWRsNnVUbjZBVXBi?=
 =?utf-8?B?cGVqbU5tM0FhREpMQm9ua00wVE5QWFNreEphS3VZOGFEM0xSaW1zUUZPNXVQ?=
 =?utf-8?B?clpwV3dlN1J4R2FFYk95c3FDa2tXV005eVhReXYyekYzQU9IOC9UbkRYaFZW?=
 =?utf-8?B?cWZkaHhsclZUN0MyRlE1bmZna3hVQWNjWm1yblN4MnBuaW85MUhEbE1uaWZT?=
 =?utf-8?B?RU1rdVBKekRNNnNKSTRwK3pDd0JyVnR6bktkUWVOMjZHRm8vZWs2TzlTS0tV?=
 =?utf-8?B?d1BvYkh5Q2p0eXRTR3p4QnVvcFMrSmFPV0xxT0RndmZxZUsvdGdBcnRHVzJW?=
 =?utf-8?B?M2M0emJNd20zL3VxaktmR2kxYmw3NGtjTjJUSkE1ZHhqVmlGcFpqWFViMHpt?=
 =?utf-8?B?ZHV2N1NDcHJnWVhHNjJXZkg2SEpPVFRhV0RWU2NKVnBpZHl2U0pJVTBRVTB4?=
 =?utf-8?B?aVV3TkwrRFowRExxZjByREQ3SGVLNERGQXhjY0JIL1ZuOFVzbnhHaWlpMEpF?=
 =?utf-8?B?WTNoY3g2U25UNDU3Z0s5K1dreHFkYmpndDN2WG1MMm5DRnJQMUVhQ2dKUkJh?=
 =?utf-8?B?eVpyVy9VZHJESkZycTBBTHMrUWNZYi9BeUxsdnlJcEpHVWJzbm1SVmpESlZP?=
 =?utf-8?B?UEw3ZEFJNkR5YW56REJ0VDEySjJINTlJWUk2NUI1STdBZUh0MFVlMm9yYk93?=
 =?utf-8?B?MnhhVE9xTFhUbzhVbkRqaENJSmlZN3pDSzVTdlp2ZzlEaHBoaVRTZnpNSzhz?=
 =?utf-8?B?QmZkWjF6dzdZYUhXTFp5Ulh4N0pLaXFOaUtHMXdsMmJLYVRnb1l6ajcwN1dR?=
 =?utf-8?B?aUs0b2hsWVZZeitGTWpyclpibXp2ZDJhODUzU1N1b3R4Tk03Tkw1cHE2RjV3?=
 =?utf-8?B?ZjJPZVpYLzFnZnU1NW1TNzlWL3V4Y3FBMjRLb1UxcnBCdWt3L0gxVkN4VFN3?=
 =?utf-8?B?WkpPRkZuN3RLS3JGZ210azRtbVcrV1l6YXhHREoxOUl5bG90dlBKL0VzZ3Bk?=
 =?utf-8?B?K1dtRnI5b2pBcll4cG5LblgrM05uZi93Y09IYy9JREJ0UHNPenJPMkswYlBh?=
 =?utf-8?B?NHhVNVFXRkdJK2FmSHNCUTRMb2pyMmVnZlNDc1RSeXZ1cmRORnJDOWZpakhv?=
 =?utf-8?B?MnhkT0N2TEtub2pWSzF5bVJobVhxSmZodEtUY2hucUF4bW1BZmxxYjRIK08y?=
 =?utf-8?B?TEZMemRDRnA5c3l6S2t1YVhBMkZEL1hxaXAvUEpJV3R1cUxDQlNHd0lGT1U1?=
 =?utf-8?B?YjI4TWY5SjR5T1ljb3lWeGlXUnlDM1VOSDlzSTQxdkRwT25rN3dUK29qeFJY?=
 =?utf-8?Q?UMwM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdb2daa-edb2-4d33-22ff-08dac57f917e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 14:01:31.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7UbpiV1nnKMjfz+CheyrDRPRblpdh52U28ybR5N3eCh21d5cnsOtCHNnbXrmBP4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBTdW5k
YXksIDEzIE5vdmVtYmVyIDIwMjIgMTU6NTgNCj4gVG86IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPg0KPiBDYzogamFzb3dhbmdAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IHNpLXdl
aS5saXVAb3JhY2xlLmNvbTsNCj4gZXBlcmV6bWFAcmVkaGF0LmNvbTsgbHVsdUByZWRoYXQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC83XSB2ZHBhL21seDU6IEFkZCBkZWJ1Z2ZzIHN1YnRy
ZWUgYW5kIGZpeGVzDQo+IA0KPiBPbiBTdW4sIE5vdiAxMywgMjAyMiBhdCAwMTo1NjowMFBNICsw
MDAwLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogU3VuZGF5LCAxMyBOb3ZlbWJlciAyMDIyIDE1OjUy
DQo+ID4gPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiBDYzogamFzb3dh
bmdAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBzaS13ZWkubGl1QG9yYWNsZS5j
b207DQo+ID4gPiBlcGVyZXptYUByZWRoYXQuY29tOyBsdWx1QHJlZGhhdC5jb20NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMC83XSB2ZHBhL21seDU6IEFkZCBkZWJ1Z2ZzIHN1YnRyZWUgYW5k
IGZpeGVzDQo+ID4gPg0KPiA+ID4gT24gU3VuLCBOb3YgMTMsIDIwMjIgYXQgMDM6NDQ6MzVQTSAr
MDIwMCwgRWxpIENvaGVuIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHNlcmllcyBpcyBhIHJlc2VuZCBv
ZiBwcmV2aW91c2x5IHNlbnQgcGF0Y2ggbGlzdC4gSXQgYWRkcyBhIGZldw0KPiA+ID4gPiBmaXhl
cyBzbyBJIHRyZWF0IGFzIGEgdjAgb2YgYSBuZXcgc2VyaWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBJ
dCBhZGRzIGEga2VybmVsIGNvbmZpZyBwYXJhbSBDT05GSUdfTUxYNV9WRFBBX1NURUVSSU5HX0RF
QlVHDQo+IHRoYXQNCj4gPiA+IHdoZW4NCj4gPiA+ID4gZWFibGVkIGFsbG93cyB0byByZWFkIHJ4
IHVuaWNhc3QgYW5kIG11bHRpY2FzdCBjb3VudGVycyBwZXIgdGFnZ2VkIG9yDQo+ID4gPiB1bnRh
Z2dlZCB0cmFmZmljLg0KPiA+ID4gPg0KPiA+ID4gPiBFeGFtcGxlczoNCj4gPiA+ID4gJCBjYXQg
L3N5cy9rZXJuZWwvZGVidWcvbWx4NS9tbHg1X2NvcmUuc2YuMS92ZHBhLQ0KPiA+ID4gMC9yeC91
bnRhZ2dlZC9tY2FzdC9wYWNrZXRzDQo+ID4gPiA+ICQgY2F0IC9zeXMva2VybmVsL2RlYnVnL21s
eDUvbWx4NV9jb3JlLnNmLjEvdmRwYS0NCj4gPiA+IDAvcngvdW50YWdnZWQvdWNhc3QvYnl0ZXMN
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzIQ0KPiA+ID4gSXMgdGhpcyBwYXRjaHNldCBpbnRl
bmRlZCBmb3IgNi4yIHRoZW4/DQo+ID4gPg0KPiA+DQo+ID4gVGhlIGRlYnVnZnMgcGFydCBjYW4g
Z28gdG8gNi4yIGJ1dCBtYXliZSB0aGUgZml4ZXMgc2hvdWxkIGdvIHRvIDYuMS4NCj4gDQo+IA0K
PiBUYXQncyBmaW5lIC0gZG8gdGhleSBhcHBseSBjbGVhbmx5IGlmIEkganVzdCBkcm9wIDQvNz8N
Cg0KWWVzLCBqdXN0IGNoZWNrZWQgMDAwMiwgMDAwMywgYW5kIDAwMDcgZml4ZXMgYXBwbHkgY2xl
YW5seQ0KPiANCj4gPiA+ID4NCj4gPiA+ID4gRWxpIENvaGVuICg3KToNCj4gPiA+ID4gICB2ZHBh
L21seDU6IEZpeCBydWxlIGZvcndhcmRpbmcgVkxBTiB0byBUSVINCj4gPiA+ID4gICB2ZHBhL21s
eDU6IEZpeCB3cm9uZyBtYWMgYWRkcmVzcyBkZWxldGlvbg0KPiA+ID4gPiAgIHZkcGEvbWx4NTog
TW92ZSBzb21lIGRlZmluaXRpb25zIHRvIGEgbmV3IGhlYWRlciBmaWxlDQo+ID4gPiA+ICAgdmRw
YS9tbHg1OiBBZGQgZGVidWdmcyBzdWJ0cmVlDQo+ID4gPiA+ICAgdmRwYS9tbHg1OiBBZGQgUlgg
Y291bnRlcnMgdG8gZGVidWdmcw0KPiA+ID4gPiAgIHZkcGEvbWx4NTogQXZvaWQgdXNpbmcgcmVz
bG9jayBpbiBldmVudF9oYW5kbGVyDQo+ID4gPiA+ICAgdmRwYS9tbHg1OiBBdm9pZCBvdmVyd3Jp
dGluZyBDVlEgaW90bGINCj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZlcnMvdmRwYS9LY29uZmlnICAg
ICAgICAgICAgICAgfCAgMTIgKysNCj4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L01ha2VmaWxl
ICAgICAgICAgfCAgIDIgKy0NCj4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmggfCAgIDUgKy0NCj4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAg
ICAgfCAgNDQgKystLS0NCj4gPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9kZWJ1Zy5jICAg
ICAgfCAxNTIgKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgIHwgMjQ4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmggIHwgIDk0ICsrKysrKysrKysr
DQo+ID4gPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDQxMSBpbnNlcnRpb25zKCspLCAxNDYgZGVsZXRp
b25zKC0pDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL21seDUvbmV0
L2RlYnVnLmMNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmgNCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zOC4xDQo+ID4N
Cg0K
