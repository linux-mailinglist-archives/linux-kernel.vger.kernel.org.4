Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364D5F3D20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJDHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJDHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:20:15 -0400
Received: from spam1.phison.com (spam1.phison.com [60.249.103.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177551CFDD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:20:12 -0700 (PDT)
Received: from pps.filterd (phisonpps.phison.com [127.0.0.1])
        by phisonpps.phison.com (8.17.1.5/8.17.1.5) with ESMTP id 293NSxah098667
        for <linux-kernel@vger.kernel.org>; Tue, 4 Oct 2022 15:20:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phison.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPSPHISON20220831;
 bh=Pw3UlxjSUTapMC83rK2kAMvh3ej/oP4TzKQHhAUNujQ=;
 b=QX+My/XP/4UZWDsnom9lxX2KF2uMH5+3h1XJ87OrUlbShvJnP8ZipTf1HovLaeeYVtfC
 y1KCCT6Do0Hms7o+L0JeCpz20NOd4gze7utZbCK96rlGucyu6NWJwDlCbYNGAr91Uy7P
 CucbeKbWk1ghHBuQGPwCSwzGKPFYbuzFQGpJQISnMTEtoKhPlN4rkg3fEnPRJxIFWn5x
 LSGi4RJXoS81xkE8aKUo+x1dKjT20VyJCqhc3SH8E/3+mhubER3cYzJoTKI59xed1PQn
 nbHWUbowKsGL/bHABcwkKMOzOLegD8Eq9VtJg5GKVvEt7aEjPzkFxL6QMmCF1zNyUL81 RQ== 
Received: from spam1.phison.com ([192.168.10.11])
        by phisonpps.phison.com (PPS) with ESMTPS id 3jys94t39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:20:07 +0800
X-UUID: 71db42a0126f467897e221408210a5b0-20221004
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3e521f7d-83a2-4820-8c93-75a4e5407646,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:8c25071f-b96c-4512-b576-5860f4fb25e5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 71db42a0126f467897e221408210a5b0-20221004
Received: from mail.phison.com [(192.168.1.113)] by spam1.phison.com
        (envelope-from <ritach_lin@phison.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 885214815; Tue, 04 Oct 2022 15:20:03 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX2.phison.com
 (192.168.1.113) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 15:20:02 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Tue, 4 Oct 2022 15:20:02 +0800
From:   Rita Lin <ritach_lin@phison.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?/FPqyax8?= <redd_huang@phison.com>,
        Tina Hsu <tina_hsu@phison.com>,
        =?gb2312?B?Vml0YSBIc3VlaCAo0abSwdm7KQ==?= <Vita.Hsueh@quantatw.com>,
        "Wang, Audrey" <audrey.wang@hp.com>
Subject: RE: nvme-pci: disable write zeros support on SSDs
Thread-Topic: nvme-pci: disable write zeros support on SSDs
Thread-Index: AQHY0kHS5oNwRgsGI06uVIp7z1+XBa391xOg
Date:   Tue, 4 Oct 2022 07:20:01 +0000
Message-ID: <1a5c4e8559d0495eb78479cd18fcbe95@ExMBX2.phison.com>
References: <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
 <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
 <20220923061130.GA15835@lst.de>
 <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
 <20220927070822.GA15262@lst.de>
 <3aeb692e9037462b9f9a23a60277b80c@ExMBX2.phison.com>
 <20220927072141.GA16372@lst.de>
In-Reply-To: <20220927072141.GA16372@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: NQTJdwnTkKlKGe9VrPTzGwo6owMIk6VX
X-Proofpoint-GUID: NQTJdwnTkKlKGe9VrPTzGwo6owMIk6VX
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=745 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoDQoNCldvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIHBhdGNoIG1vZGlmaWVk
IGxpbmsgb24gR2Vycml0IFNlcnZlciB0byB1cz8NCkluIHRoZSBtZWFudGltZSwgd291bGQgeW91
IHBsZWFzZSBjb25maXJtIGlmIG52bWUtNi4wIGJyYW5jaCBjYW4gYmUgY2hlcnJ5LXBpY2sgdG8g
YWxsIGNocm9tZSBicmFuY2g/DQpUaGFuayB5b3UuDQoNClJpdGEgTGluwdbdvezTDQorODg2LTM3
LTU4Ni04OTYgRXh0LjgwMDUxDQpyaXRhY2hfbGluQHBoaXNvbi5jb20NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgW21haWx0bzpoY2hAbHN0
LmRlXQ0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI3LCAyMDIyIDM6MjIgUE0NClRvOiBSaXRh
IExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVucyBBeGJvZSA8YXhi
b2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg/FPqyax8
IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvbT47
IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2FuZywgQXVk
cmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRpc2FibGUg
d3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNClRoYW5rcywgSSd2ZSB1cGRhdGUgdGhlIGNv
bW1pdCBtZXNzYWdlIGEgYml0IGFuZCBhcHBsaWVkIGl0IHRvIHRoZQ0KbnZtZS02LjAgYnJhbmNo
Lg0KDQoNCg0KVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlh
bCBhbmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcs
IHVzZSBvciBkaXN0cmlidXRpb24gYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJl
Y2lwaWVudCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIsIGNvbXBs
ZXRlbHkgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMsIGFuZCBkZXN0cm95
IGFsbCBjb3BpZXMuIFlvdXIgY29vcGVyYXRpb24gd2lsbCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQu
DQo=

