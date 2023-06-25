Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36F73D217
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFYQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFYQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:23:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F39A8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAL7/HMhFLGHp8YTE5rkVwwrSPPpyaCFBvo0vH7odywq6xrEEuJIrj0QjgarHhSgRiG9r20mCJdbosFikbUxElwci8m/o+e7u2ScrMbBwQ8TN3TRU4EiEk9CGG6HC3XHF8qgekpDB4DGtELwi7h6GJSP1+VYJLXmsUcgkPdq+C3zXBM7IM0ndQSY1LOjAiYrAfnmZXCT974qKmcRuugmnH0TLiDqaSR4lZo3vwhznAq//S4h47pZQIHtZpLbHVUVmWS8h8LRsvmYp3DJcYLbKWKG0SbFfLSD2I52EnvktW2n5JilhaBXow5UtiTwzqkApvSdzbJgUFJBZmNM/vPhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGZTnvMo6Po+M8u/HPP2Kmqw5w4BvrHq5tLOfQt0o4I=;
 b=NksagqynyDp/FsgjFf57KFL0mcfJmI/d5dIGJEzZZG8ULqYb8T5bXimVkqgiHoPPa/D816xUEC1d/4HQ7wzAG5tX0wBY4GoTkoRCRiGHv19DQKoUB991hMe6Sdii/EspfCzlCWbyWXDImrliucWAvZT8ND62TLWCqBQY8IWMyl8At0Bb3TWOgrm87NtylfKu06cfyJtD5aBXonf3C3bl+Ssg1A83/NkAIDi7acnAic360OD92NK17lxURmeXRVXeKMYzeONyijXcJLdqHEMuIJv7zayJGTvDyYA5Emq+e0sW0Kty8p+L9ApNMrdPq58OCERaOdGkn4lJNHyx5h+/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGZTnvMo6Po+M8u/HPP2Kmqw5w4BvrHq5tLOfQt0o4I=;
 b=JOFaKIVGMKFMQc02P0R5l9E/dALB99Pl6fofbgTAn+6/Kgjm/6kl41bqd1pwsrwHedEjVqGgk2Ukr0GWPMWAQc0WqwAyIHpLx9Dc5ZCSuSQdOSAFb1a4UiqBlKwuYppNFoyvteMVQKLpZvGuCjsmeFhQ2LHBHj3u3W4JTXaDpPY=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYWP286MB2731.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Sun, 25 Jun 2023 16:22:57 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 16:22:57 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "pteerapong@chromium.org" <pteerapong@chromium.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: aloop: Fix &cable->lock deadlock issues
Thread-Topic: [PATCH] ALSA: aloop: Fix &cable->lock deadlock issues
Thread-Index: AQHZp4CrxJ87x2u0IEK4c5YXsaGunQ==
Date:   Sun, 25 Jun 2023 16:22:56 +0000
Message-ID: <TYCP286MB11886E8193AD36C16451A0AC8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYWP286MB2731:EE_
x-ms-office365-filtering-correlation-id: 578704a0-cdd4-4c2f-184a-08db75986f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGkTURwOkLPlH7waGtLhCaHczWEXLkhvU5WL++OoXcXIB3jECx5unPdKorv+o536o9zUOTL5tF5BXsqH2fMXKbpPzDVuTOlol+mWb+2oz/psIIg5xedKCt6wtHoGErgiXfwE+4bVk54GyrhfCui1wzA1VGe6BxHAG7Szj/HmP8md2z/PrOwwz6H6yvb+D3IIjpjUVTOcpZZiuLjC6C5yWUUI8S7pAp5v2BLqzz9dbolgb154VNrSHrHRT5JrmRwKcrzzHkwdSnEFpWgqmX9tUbEzo4ecnYWzGT4VXcNEXlqRnIJlISj58jE8E+gOnaqBFVYT6q7c/Dpc8vQalpQdZzewJMEnN91IeRnaWOKikz99vTAKp8PTFLiBq56+fJYklRkitlibpGubdgxwyO9K5W92lZN+yOD31HR9mjWZIEUKTf38YzgJJ+SPp82QEwQVbFpz0UYAiCx39vaifXPaCPlYIfPmWdPAV7bsqvnw/zT/8l7AmUgus3yOMxrB3s9WsQ0wBWNgo4C03OjDrgXL7Y6KeO6VY+syDBEEKPrxudkXlLgyrGv+h9j0RnP2HhxDD58odPj6QCm7mN9+oBh6+zx/mtxm4kSTonH+gxFEdXBFB1t1dgUqkO/g5nZySVxl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(33656002)(52536014)(5660300002)(41300700001)(316002)(86362001)(66476007)(66446008)(8936002)(8676002)(55016003)(38070700005)(64756008)(66556008)(4326008)(38100700002)(122000001)(76116006)(91956017)(786003)(66946007)(26005)(6506007)(2906002)(9686003)(186003)(7696005)(71200400001)(478600001)(83380400001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NHV0a3NUempBRlkrQ0ZGcWovN05jTnN4QU0zUFBPMGhMZmxYUkhJMHk0YTRG?=
 =?gb2312?B?c2YxUHJ5MXlDN1VhQ1oxMTdNR0hoNXEwaXpOQXNGT2pzSXdBS0ZDeXI3RVln?=
 =?gb2312?B?UTVKSkhNdU0yNmp6NEdrTG5ERWs4dDlDL1h6RFlKU09NZVI4bTc5ckZjTHMv?=
 =?gb2312?B?NTJKclRvV21YbWR1M2REMzBvOTAySDlhMjZRTW9XY0JobDRFTkRTS2pFWGFD?=
 =?gb2312?B?Z2l4M1NVYUROejBLK1I5UjNUaXBWbEpQaXowK3JYenMzWmdLQ0VMdVBxbEVp?=
 =?gb2312?B?SzFtblFUMjhhQ3NzOFFadSs4cTRQVmxPR0RJVTBSNXZHMDJqT0lxMHF1NEJK?=
 =?gb2312?B?ZmFsL0w4dDhnZmJpV0VRYmN3N2NDMW5YMk44RjVQUTlmRUVmQ0FPOHVaV2tB?=
 =?gb2312?B?QU9jUnV3T0lHY2cvMzd0V2NvSUhoSmJPdUZqNU1xajZDWEpveGp0a205dWNN?=
 =?gb2312?B?RTlhTVVXZmdLdTQ5RGpFQzYyaitzNlRxRU5PcThydDE5b1hVTEx2RHA2WlFw?=
 =?gb2312?B?TzhyT2hYVnkxOUw3cUJpbWlGSExIK3VZU0R0M1hLaGI2emxxT3cvckFmS0dH?=
 =?gb2312?B?VWc3emVOTGNOWk5NZTZpUmNaMUwremhZTk1RMStPRTV2QmprVWd0NjlvaU9y?=
 =?gb2312?B?WDRXWWZUVmdqMit3SnJHem52SXJxUWh5WDFIZ2J0SzRKd2laQ0dIOUN6Zlhh?=
 =?gb2312?B?ZU4rdXpLY29JblRvL25aeUF0R3JZSDZaV3dDaGJQTG5FMXFRcDVYTEJKdXd0?=
 =?gb2312?B?NEJtcGZWRkgzeUdWQjl1UGNGaThCV2hNdTN6VVNrd09SVHZ2OG1GQkdkT3Nu?=
 =?gb2312?B?OWZNODFyaWtObktqRG9ia3pDNEFwUXhUZ3dwdzEwdVl2T2tnTVRoN251Smsv?=
 =?gb2312?B?WGU4T01VQXlVOXpRK3BDQVIxSkJzY3h0b1VjK2F4Rm9sY2xWcTNJc01haUhI?=
 =?gb2312?B?RjhxM0tFMnlQY1o4YWs3ZTJPT0hrL3JLS1NReXJXb2N4WVliNVBuZVUrYUVX?=
 =?gb2312?B?TFRwN2Y4a2twMTk3SXhUMUc0RllkQ3ZGS2YvbSttMUhJaGRLMXN5d2pobDFs?=
 =?gb2312?B?SFFDbllSS1JPOVRlYkcvVTlyRnBHN1RjVDRGaEpPdUM4UWlXMU13R1RjY1Rm?=
 =?gb2312?B?S0EyOEEyK1RRQkREYWoxV0lGSFRxODBWR0VnK2dQNlRVdGxFaUpqdkt4Z05j?=
 =?gb2312?B?bHNWdGVXWnB6dktCRmVnTFNvYllBSDBVME5QME90YmFiWUFhMEFJK2Ruc2dQ?=
 =?gb2312?B?aUROa1E4YXlobUQzK0ltOE12R3hEQkpnaGVpN292ckVxUmRIM1YzbFJUY1po?=
 =?gb2312?B?YzN0a3puOEh6OGZTSlJxLzUxZHBCb3hDZFViS2wzbi94V08vYWF2TjJGeUc1?=
 =?gb2312?B?c044aStaaWRUSSt6K0RiOXA5TWtHcFUrTGVzSTRGelNnT2p1WHNRaHc3OWtG?=
 =?gb2312?B?WVhraVRyUlRyamo5YlpuOEdLODFLckxaZ0J3L1FsbjdDZ1MwUHhHUEZsQ1Bu?=
 =?gb2312?B?UHNXb0ZaM0puZ1Q3bjF2bjZYSWJyOGRqekVVWTRXbG9EK3htVnJvQ3diSVAw?=
 =?gb2312?B?T3RVdGJnclAyYTFSNFMwWUdwb0NDMmE3MCtsMlVoYXFkcFhoVUNvWGROVk42?=
 =?gb2312?B?UUdyUHluN2Vsbnc3SVZnTzdnZndJemhXeXdDa0lMdkN4cmk4c0pyZmgrUE9H?=
 =?gb2312?B?cGJRZWNldlMxb0tmYkM2WkljeCsydy8vSXNqTTd3SDlhY0VIOUQ5bDN3SDZI?=
 =?gb2312?B?TG0yd2tja01NQ0FCdzgybjM0NXdsZDFkK1oyYmVpdEs3aUwxeG4vRXpseVhB?=
 =?gb2312?B?UnpEVTMxRDlteEFjdG1ySnoyVno1SnI4MUNSNzdqYXk2Wno1OHV2bGE1ME9L?=
 =?gb2312?B?c29LQU9OWitNQ2h2ei9RMjRZUFVtdnFWSk5aYmQ5THpKaTZXTklnN25qcE5I?=
 =?gb2312?B?YjhTdnR0K3dlb1ZENVFNakR5QTk2aTNCYUliaUlRbEF2QVZMTm9qK2swdVBP?=
 =?gb2312?B?L1RnbkJQbFMzWFhHaGFDQnBXOXVTUHNaM1RGQnFGVExqN1FpQjg2WXJCVVdr?=
 =?gb2312?B?ckdYaC8wNFMzS3JSOGhqQWZHT1V6NURTb0kzQjVsbE1rSFRteGRPUHJqbk1C?=
 =?gb2312?Q?7GrTMQ27B19a2TUtcF/U2LfWh?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 578704a0-cdd4-4c2f-184a-08db75986f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 16:22:56.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZmEpbbeMO+DfX/X516MGUbERggJTdG7bMB0GjbNrgjw1ofFZbCI5U4gEI13DL3elRZJAfDGy48kBW6CR8xqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2731
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHRpbWVyIGxvb3BiYWNrX2ppZmZpZXNfdGltZXJfZnVuY3Rpb24gaXMgZXhlY3V0ZWQgdW5k
ZXIKYm90dG9tLWhhbGYgc29mdGlycSBjb250ZXh0IGFuZCByZXF1aXJlIGEgc3BpbmxvY2ssIHRo
dXMKb3RoZXIgcHJvY2VzcyBjb250ZXh0IGNvZGUgcmVxdWlyaW5nIHRoZSBzYW1lIGxvY2sgKGku
ZS4sCmxvb3BiYWNrX3RyaWdnZXIsIGxvb3BiYWNrX3BvaW50ZXIpIGNhbiBkZWFkbG9jayB3aXRo
IHRoZQp0aW1lciBpZiBpdCBpcyBwcmVlbXB0ZWQgd2hpbGUgaG9sZGluZyB0aGUgbG9jay4KCkRl
YWRsb2NrIHNjZW5hcmlvOgpsb29wYmFja190cmlnZ2VyCiAgICAtPiBzcGluX2xvY2soJmNhYmxl
LT5sb2NrKTsKICAgICAgICA8dGltZXIgaW50ZXJydXB0PgogICAgICAgIC0+IGxvb3BiYWNrX2pp
ZmZpZXNfdGltZXJfZnVuY3Rpb24KICAgICAgICAtPiBzcGluX2xvY2tfaXJxc2F2ZSgmZHBjbS0+
Y2FibGUtPmxvY2ssIGZsYWdzKTsKCkZpeCB0aGUgcG90ZW50aWFsIGRlYWRsb2NrIGJ5IHVzaW5n
IHNwaW5fbG9ja19pcnFzYXZlLgoKU2lnbmVkLW9mZi1ieTogQ2hlbmdmZW5nIFllIDxjeWVhYUBj
b25uZWN0LnVzdC5oaz4KLS0tCiBzb3VuZC9kcml2ZXJzL2Fsb29wLmMgfCAyMiArKysrKysrKysr
KystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvZHJpdmVycy9hbG9vcC5jIGIvc291bmQvZHJpdmVy
cy9hbG9vcC5jCmluZGV4IGEzOGU2MDJiNGZjNi4uOGVlOTNmODU4MWI0IDEwMDY0NAotLS0gYS9z
b3VuZC9kcml2ZXJzL2Fsb29wLmMKKysrIGIvc291bmQvZHJpdmVycy9hbG9vcC5jCkBAIC0zNzks
NiArMzc5LDcgQEAgc3RhdGljIGludCBsb29wYmFja190cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1
YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY21kKQogCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1
bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CiAJc3RydWN0IGxvb3BiYWNrX3BjbSAqZHBjbSA9
IHJ1bnRpbWUtPnByaXZhdGVfZGF0YTsKIAlzdHJ1Y3QgbG9vcGJhY2tfY2FibGUgKmNhYmxlID0g
ZHBjbS0+Y2FibGU7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlpbnQgZXJyID0gMCwgc3RyZWFt
ID0gMSA8PCBzdWJzdHJlYW0tPnN0cmVhbTsKIAogCXN3aXRjaCAoY21kKSB7CkBAIC0zODksMzkg
KzM5MCwzOSBAQCBzdGF0aWMgaW50IGxvb3BiYWNrX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQpCiAJCWRwY20tPmxhc3RfamlmZmllcyA9IGppZmZp
ZXM7CiAJCWRwY20tPnBjbV9yYXRlX3NoaWZ0ID0gMDsKIAkJZHBjbS0+bGFzdF9kcmlmdCA9IDA7
Ci0JCXNwaW5fbG9jaygmY2FibGUtPmxvY2spOwkKKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmNhYmxl
LT5sb2NrLCBmbGFncyk7CiAJCWNhYmxlLT5ydW5uaW5nIHw9IHN0cmVhbTsKIAkJY2FibGUtPnBh
dXNlICY9IH5zdHJlYW07CiAJCWVyciA9IGNhYmxlLT5vcHMtPnN0YXJ0KGRwY20pOwotCQlzcGlu
X3VubG9jaygmY2FibGUtPmxvY2spOworCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjYWJsZS0+
bG9jaywgZmxhZ3MpOwogCQlpZiAoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVB
TV9QTEFZQkFDSykKIAkJCWxvb3BiYWNrX2FjdGl2ZV9ub3RpZnkoZHBjbSk7CiAJCWJyZWFrOwog
CWNhc2UgU05EUlZfUENNX1RSSUdHRVJfU1RPUDoKLQkJc3Bpbl9sb2NrKCZjYWJsZS0+bG9jayk7
CQorCQlzcGluX2xvY2tfaXJxc2F2ZSgmY2FibGUtPmxvY2ssIGZsYWdzKTsKIAkJY2FibGUtPnJ1
bm5pbmcgJj0gfnN0cmVhbTsKIAkJY2FibGUtPnBhdXNlICY9IH5zdHJlYW07CiAJCWVyciA9IGNh
YmxlLT5vcHMtPnN0b3AoZHBjbSk7Ci0JCXNwaW5fdW5sb2NrKCZjYWJsZS0+bG9jayk7CisJCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmNhYmxlLT5sb2NrLCBmbGFncyk7CiAJCWlmIChzdWJzdHJl
YW0tPnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKQogCQkJbG9vcGJhY2tfYWN0
aXZlX25vdGlmeShkcGNtKTsKIAkJYnJlYWs7CiAJY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9QQVVT
RV9QVVNIOgogCWNhc2UgU05EUlZfUENNX1RSSUdHRVJfU1VTUEVORDoKLQkJc3Bpbl9sb2NrKCZj
YWJsZS0+bG9jayk7CQorCQlzcGluX2xvY2tfaXJxc2F2ZSgmY2FibGUtPmxvY2ssIGZsYWdzKTsK
IAkJY2FibGUtPnBhdXNlIHw9IHN0cmVhbTsKIAkJZXJyID0gY2FibGUtPm9wcy0+c3RvcChkcGNt
KTsKLQkJc3Bpbl91bmxvY2soJmNhYmxlLT5sb2NrKTsKKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmY2FibGUtPmxvY2ssIGZsYWdzKTsKIAkJaWYgKHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJW
X1BDTV9TVFJFQU1fUExBWUJBQ0spCiAJCQlsb29wYmFja19hY3RpdmVfbm90aWZ5KGRwY20pOwog
CQlicmVhazsKIAljYXNlIFNORFJWX1BDTV9UUklHR0VSX1BBVVNFX1JFTEVBU0U6CiAJY2FzZSBT
TkRSVl9QQ01fVFJJR0dFUl9SRVNVTUU6Ci0JCXNwaW5fbG9jaygmY2FibGUtPmxvY2spOworCQlz
cGluX2xvY2tfaXJxc2F2ZSgmY2FibGUtPmxvY2ssIGZsYWdzKTsKIAkJZHBjbS0+bGFzdF9qaWZm
aWVzID0gamlmZmllczsKIAkJY2FibGUtPnBhdXNlICY9IH5zdHJlYW07CiAJCWVyciA9IGNhYmxl
LT5vcHMtPnN0YXJ0KGRwY20pOwotCQlzcGluX3VubG9jaygmY2FibGUtPmxvY2spOworCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZjYWJsZS0+bG9jaywgZmxhZ3MpOwogCQlpZiAoc3Vic3RyZWFt
LT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykKIAkJCWxvb3BiYWNrX2FjdGl2
ZV9ub3RpZnkoZHBjbSk7CiAJCWJyZWFrOwpAQCAtODY1LDEyICs4NjYsMTMgQEAgc3RhdGljIHNu
ZF9wY21fdWZyYW1lc190IGxvb3BiYWNrX3BvaW50ZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW0pCiAJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVh
bS0+cnVudGltZTsKIAlzdHJ1Y3QgbG9vcGJhY2tfcGNtICpkcGNtID0gcnVudGltZS0+cHJpdmF0
ZV9kYXRhOwogCXNuZF9wY21fdWZyYW1lc190IHBvczsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwog
Ci0Jc3Bpbl9sb2NrKCZkcGNtLT5jYWJsZS0+bG9jayk7CisJc3Bpbl9sb2NrX2lycXNhdmUoJmRw
Y20tPmNhYmxlLT5sb2NrLCBmbGFncyk7CiAJaWYgKGRwY20tPmNhYmxlLT5vcHMtPnBvc191cGRh
dGUpCiAJCWRwY20tPmNhYmxlLT5vcHMtPnBvc191cGRhdGUoZHBjbS0+Y2FibGUpOwogCXBvcyA9
IGRwY20tPmJ1Zl9wb3M7Ci0Jc3Bpbl91bmxvY2soJmRwY20tPmNhYmxlLT5sb2NrKTsKKwlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZkcGNtLT5jYWJsZS0+bG9jaywgZmxhZ3MpOwogCXJldHVybiBi
eXRlc190b19mcmFtZXMocnVudGltZSwgcG9zKTsKIH0KIAotLSAKMi4xNy4x
