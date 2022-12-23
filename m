Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594F654B15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLWCXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:23:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD5FD2F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAIa9Qf5tjFG1PL/vVJkShjbgPW2xaZDDnn62muw4i2lqBJ+jkxlG7XBYaSnHn/I9gZHVwHvIzOyjlFJjnnrJ8gwG8svEdE9up0Uey4Ap6eE+2h24PqjRoKFWuyuF77xKfmoqixBIm6pC4NNyFAn8cpPK0HCxjERdyZI8btz5cELYQOH8+5XkIAHa5zgKmd8urVOxAO8Em/UUcCASM8TY+YmbkiuevOzbqtDC1N29DE0y2wgz6JUoRWpJovhWixeJF/LQOaH8PkYJN+5OJDbcSWteokxEpJuh9sY/aFW5k6VQ3+2zJCIRjMJI5HdZ1Kffj0YO6JVa1zilbmSN44cPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxbzQQENuAr+cp7JVbshjwv9xLQ4+HUe8l+kRgm3qRU=;
 b=m2INNvhpC5EoK0n7qJ8WJwoVBosndW0WEbV7cglnn5GaHqhnYoYaTck7ZL0Z5SWpAnef3cvTjBsDZQQ99Iiof7NOTjg7NkR0sJ4e69LCwmV5xvbf96nV3By+P3gVbr9URjpVzVkxZnQ8B4BUm7UVTrh27JCDmvJFTwQ5hnrf5aNo3eoE05gJvovdG+l2SpP7q6hzuRnHy/DY2w6oI1SK4aTB6vqOpDXr7IQPEJo/pKieKmFhoupLxms2B34uvl409CUnAYCtLwF7NyzaOJskRdzahJWW/sdpVZzKAFoMicktBk4J3wGn8pAab8r7B1v49mgUV6+FH+yN/6SgeL0XhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxbzQQENuAr+cp7JVbshjwv9xLQ4+HUe8l+kRgm3qRU=;
 b=jmlQzwB4mwAIqH1vXSzgaLcV+YG2hY+2NKSUlsBH5iEJovM8aHbZ5P8woTrs4qiMzukh+2KoO8mbDepbsy/ar3wfXkjehGvgOBfHWmU7gXwiiGgWYv2oCzgzxlCkvjD3MPiZj3lNoVo+B/jgPzfUnSsVEdOKaL6Ab2YX2mx5ZSd2FkWNEHmKlhcC290+Q6L+UOkwhKLBXxgEQX96CG4CSsOkBUZZcITIBbNAkx9Ba3n83QnAaiPgper6jbdNRVAKTQ5yc1G1jhZJvT6xOQwd7Dupolo2Caav093mrLwjyAXgQcJEZV4wbkqVkVwX+uuZDkQmzNdtoesBAH4UKZcoJA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:23:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:23:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] virtio_blk: mark all zone fields LE
Thread-Topic: [PATCH] virtio_blk: mark all zone fields LE
Thread-Index: AQHZFjwk4yw1R1Bn2ECn6OdqngFwRa56vqUR
Date:   Fri, 23 Dec 2022 02:23:35 +0000
Message-ID: <734B5750-71AE-4229-AEA9-7EACE8114973@nvidia.com>
References: <20221222193214.55146-1-mst@redhat.com>
In-Reply-To: <20221222193214.55146-1-mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6134:EE_
x-ms-office365-filtering-correlation-id: 3c72b1e2-dec2-43e6-b915-08dae48cb194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AodnFI03V6ZuhA4Cz1FA+r9Ngo6nbu0qXfIS2tcb/Ihe03lDEgvfmcuZwkIYK9gO9ls1x2uGf6hCnD9Aao55cnVxFkZG8NNcCQ7VH8LwbY23Ro3zSuLfp8cLSaH1zL/L9c0wNL+DO1P0SriYCSMgpJLfKAGHCCoU1KmwjCukIg5wL9K5gX6bsrSAvKKH0fpVLLKaCfHtDRvyaVTOZLvMzkPP3dEY/621SN9Tnp4FsS20mrd9UVhTjudNUWvnbk4uOmQhdywwrJgmsXgaJtr4668h16k2JK1/MhEgwdHFOToFJaPqrgmIn+28D5ZhdtFgUE6vKbtjRD0fUHqlfJaS4cNKLWqWLyXLfs61SDdf/QW3diaGUB0zFwoKmAHtMZ9G6iKGWBVL+G4XZt6aqlmFJc5nX+KiIl3YE+7ds9FaMHO2obkLt30nYI4mvstS8g1d94r5MZwVsCZuhiMWfMzx2LmWYdxuOc3pigT28dpxavTM72bVGeNBtVVXFi+Z+aQ0e5zjv9tgUAlSBi/9v+H7UJmesIub10eg/RhRKzPC8hscEDKwsmt3oKL5pbQ19ezyG8wsy5o4do64gZltAPJ1CxBNCKDEIjRjZr5fVZMw+pLZNHGDqlY/SahBIXdD8/V7tfef+IaBAuxGUX4xXt2Jouv/HDtf4ZaH1CyPtLDL+bl+ss9pxQI0xJ4B366kApjM0UdvbZO6G7n3czTmyZxq35FP8Ngdh9/IOzyDHovJUI0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(41300700001)(83380400001)(8676002)(4326008)(38100700002)(122000001)(5660300002)(36756003)(4744005)(53546011)(8936002)(2906002)(33656002)(38070700005)(316002)(71200400001)(478600001)(6486002)(6916009)(86362001)(54906003)(6506007)(66446008)(76116006)(186003)(66946007)(66556008)(64756008)(66476007)(91956017)(2616005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZIcXVjTjAzRkZOa1hOdS9sL2VYTDJsLzN2WEk5RGR4WTFIdDVnekNDOTF5?=
 =?utf-8?B?bFNiTEwwcElRK3pVOWJLRCs0UFZYSVRIK2FsMjUrcnY3dUUzTVV2QWJXTkZD?=
 =?utf-8?B?Q0JkenBxb2lxbkVJR0NmcWVQZE03bUFpNGdZbGd3bWFKU3dvWFJIRXgrZmsr?=
 =?utf-8?B?ZkFvZ0ZkS29KdFdnOHJrVHBXK3Bqa3VaM0hlWnZYaHJhZGVTQUh4dzh3TnRp?=
 =?utf-8?B?UGFKZ0l5QXRFLzdLUjY2cnVLTEZKQy91dnREUitub2wzUVRuT2k2VkRLMTNw?=
 =?utf-8?B?ZUZGTUlDVWdmT0dGd2VVcmZNQ1VFam92WkJDMXhET2tFOTQwN0Q1dGFDOFpJ?=
 =?utf-8?B?N2swb0ZpSmRXeEZ6UDcvcU1VQ1U0VVMrcVhNK3lyNUJFeitQMi8rMGVNaXRo?=
 =?utf-8?B?QXFYeDkyWCtHS05QQkJDaWNzR2tsbXA3TjF0cnd1OUVkNGQ4emhmelR5c0xK?=
 =?utf-8?B?b1grRG85dm84UlJxV3VXOHFabzlkMUVJeUpzdlAyOExyODJNd3RrMFMvTFho?=
 =?utf-8?B?dHlXcUFQS0dzdFJpWFNSd09JdXFyY3ZCcXRuakNRNFFvdzFXZnlzT2dpakk5?=
 =?utf-8?B?UncvVmxWNWpLaWZBZDdEVHNBMkJEeS9WSGltZUtuem9GS05LQXRtblczOFFY?=
 =?utf-8?B?N1hwa0picWIybUsydlhELy8vTzlRdC9CSFFHanZsSkRzVUFjV0NOUDVwKzBk?=
 =?utf-8?B?YzZyemY0UmxIejFLYlp5T3luZjRMZ0lKWmI1Ynh4alhBb2VtMlFITHFPc1pN?=
 =?utf-8?B?bkE3dGNLN05qUTBpbUtkM0x4dHQyOEJocGgzUUpGZ0xnRDY2WWxQZXBSaWJO?=
 =?utf-8?B?R2NyL2VSWmtUM3AxSnVlb3FZSVMzL3NWVnRtVDh4bUlrZ0ZiTGs2bDA2TEhH?=
 =?utf-8?B?akp3TExZYkZVTFEzVGcrVTdaRUtERFV2aWswemhhQ3hiTjFMazEvK0toSmFY?=
 =?utf-8?B?QWo3K2IrK05BTWV6YUdVcVNvK2lQQ0o4VCtNTUlEVmthbnZZY2NienMyemJP?=
 =?utf-8?B?WUdMdmc5V1NobHBIVjB3TElxL2VzTm5TOTl5dDBjaTRacGlyTmdjRzJLcHVU?=
 =?utf-8?B?RU5aTkc1S2RzbTdoTlREWnkzRkM2KzJGbHB4Ulo0cDR1RmNiREVXQlZ4WXBD?=
 =?utf-8?B?N0dEa2J3emdlWUVOVkR2NE84ZVduWWpSUmVqc1dyTUJqbkk2cEkrV1V4S3VU?=
 =?utf-8?B?bWNvUnZ3UGIzR21jK1B4TTdwbWptK1NienJLbmxUL0c1VEdKbzBZWElLeDhZ?=
 =?utf-8?B?dXRiM3lvZXlXNWRuT2lsZWNOWG91eUFHNUhNTjZ3SW14b0x4c2dmcDJxVEJi?=
 =?utf-8?B?N09QSWZWSWt1L2JHMktENzRwL3JPRnRxNW1nWG1FVE1qcDZGdlg1TGtTV0ly?=
 =?utf-8?B?TTQyaGlHN24wa0RKWGNTRnlqRnQ1WTRKYk5YU3RiOXdWS1E0akUyQXE1V0RB?=
 =?utf-8?B?NnE4ZjA1OUdCTXJLTzJLeWU4QzlhRFg1d3lpczJmNVovY2lhWkhaNnVDTmdK?=
 =?utf-8?B?VGNFMDM3MWpnMnhoaytZdzJ2c3piMUkrNVBZT3RJNG1ySE1vb3FYYm96Z1pT?=
 =?utf-8?B?UUltRzN3RjROVDRrWVRYbzMydFR5RHBYckZobVlEdi94OXZ3d0g5cGtpOVBJ?=
 =?utf-8?B?dERRQnp6aHR2YzdyTXhRRnJFQ0NIYzdkS2Z3QlBkckJhWWVDb3pDdmsxM3Vt?=
 =?utf-8?B?Qm5sSjJ6bTBkRFkvaFlOVTgxYVlXeUp1dFdPTlRhbWFLRzk1Y2FlT2F0R1FD?=
 =?utf-8?B?aWRNUkYzVjRrTW83TFFkQzlZbUxaTDdjZS8vY0x5dnpuaFUrb0x4d00xMTUz?=
 =?utf-8?B?VWRlaXY2UGFhbHpDcDFiSVBsRy9SQ09Lc3h5aU9vU3Q3SU5wbktuRGlpa3dW?=
 =?utf-8?B?dWppbkpCb1hHNGJZKzFqcmZGWmZoK0JLbjU2UWFsMTgySmxyWnRYd3JvZHZs?=
 =?utf-8?B?dWpyUGdRSEViT1R3ZXhxcjNiaXE5cWUrd1FrdHpnNDhKVldxQkRMS2xBUDNh?=
 =?utf-8?B?c2VMSEJ6T3BFeG1XeDY1WkpSOU9kT2N4YlN2RXpkVFRrTlZESEFGMmFBd1dS?=
 =?utf-8?B?dWp2OUY5YjFkcStmNjNRWXRicVBFNjZvV1UzY05Ua0hxVFhtY3orQ0hZZG9E?=
 =?utf-8?B?Y3dZb1dRdERPNTJZMGxpWGhTZ0VVQzRMdm4vTlA3eDVHOHNPdTkwdStWUThZ?=
 =?utf-8?B?VHF2RUozU04vNm9NZzJpc3VKZFBVNjFkWm9XWVFxWGxXaWlLc2VaSHdNR3Vy?=
 =?utf-8?B?TFcvWFZYT0s0MEFWa2hySnk0N0d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c72b1e2-dec2-43e6-b915-08dae48cb194
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 02:23:35.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dO645AWymNDoFXxNkKu3yNk+Zr8TgXljSGDBqoM2Xndpu8oMsIom5qbig8vrn+XXvhlz+Ga4b20uzQ8vBSIjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gDQo+IE9uIERlYyAyMiwgMjAyMiwgYXQgMTE6MzIgQU0sIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4g77u/em9uZSBpcyBhIHZpcnRpbyAxLngg
ZmVhdHVyZSBzbyBhbGwgZmllbGRzIGFyZSBMRSwNCj4gdGhleSBhcmUgaGFuZGxlZCBhcyBzdWNo
LCBidXQgaGF2ZSBtaXN0YWtlbmx5IGJlZW4gbGFiZWxlZA0KPiBfX3ZpcnRpb1hYIGluIHRoZSBo
ZWFkZXIuICBUaGlzIHJlc3VsdHMgaW4gYSBidW5jaCBvZiBzcGFyc2Ugd2FybmluZ3MuDQo+IA0K
PiBVc2UgdGhlIF9fbGVYWCB0YWdzIHRvIG1ha2Ugc3BhcnNlIGhhcHB5Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IA0K
DQpFdmVyeSBmaWVsZCBmcm9tIHNwZWMgc2hvdWxkIHJlZmxlY3QgZW5kaWFubmVzcyBmcm9tIHNw
ZWMuLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg0K
