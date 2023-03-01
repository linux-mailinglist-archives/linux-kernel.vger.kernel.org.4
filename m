Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFD6A6A00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCAJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCAJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:46:46 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268D3A84D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677664005; x=1709200005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=330Totb3cC2ik8PB1iVpepDCcMA5ykgR3JNLSAVZaE0=;
  b=YLgAmuB7xW2IQWc8Vo7wrkeTkny9hKIferkSbUuQ4AialJDYtgqqgelL
   4MFDlh36tU+dcxbqRjBydZeG3rd2DVuH1slP+ntqk4YNWAcc3r3MF8/3K
   THdRYAZ8oCP+eg8PbhoTm95vbx1J4yCxFMrgKvbIIy40Nxqm3qZcs3t22
   WvkQEmjtC1+PdVL7z/vsmdrMOfKuMEmC/Bpl5TAMak33UQhnaIAaOpzNz
   egcodZzMACqAJzY5f8q6EOpX+pRMWaZozWITUqqqdITsvR+APN7CMqn/P
   U0bJdrklpBQKK4Sd/Zd4E8PizQC0FbSSVW+J0rAeS3/tTmqqnIHbtBYBA
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673884800"; 
   d="scan'208";a="224297252"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 17:46:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kriim7F2yyXRvMUZuLHhiiVUDpGyRXXCdXRtTFyaS+kecGQv9VfhKWYOp06ET/GVw/Ucy/RtP5vh3PL1NEcdDWjonLQ1xt6Szk8eArWfsGWtUqNPBav/XEM89jkQu78gL50kADvmJh9AoK8vRpudKOX1eBawV1dF2REt3JhTptetpfUrcvu4jU17L8YKrTvjW8DIde5j/Nz3lF35K04Z939Q9DxMjCwgsnGK3KR2VIqpygAOqWDCc3fRDD36DenydfM/GxbLSvIsZwdMItNAkM46KclxjSs2pfzyudsQhD/xpSG9LdBZEo/JhuZuzV8APlr2yz+59XBZiwCQLxOEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ6R5cb1aILxvYeYw7jaYCWuu83fcDPRG41DpDlzGkQ=;
 b=ZBc5JZ0yXx7YWPIfV8lwG/uA8I42rO/yEHHbt/bEelZTMKbUcYGXtSlrxkiknGbAk19ndIw39I2RuC02Bobs80bxVxFm+5Bl0n71nBQjq98Vq5jZDF2mM4YoM6naaT19hPbiUZFCGI8iHJO770Oi5pDRrgiT0egtDvhaWDlXwnjkY1AVJu9VrUpMGuDW6Hjo34z93JBjEfc3i0QH9NeRELvbU/jci7nXhta4id8+ueBrsQ+erVIXAB+NiptXpAynzg4uSCAhdOzQQn/mDJpEbgG3SpbiOih79JT3MjVvbqyAszr0cTq39TswpMiItFdqTUZ+zwsOPvPMAtn2ejAlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ6R5cb1aILxvYeYw7jaYCWuu83fcDPRG41DpDlzGkQ=;
 b=Cra2JHwNyHXTUAuPcULvsI2jKghqhfnlOmqYCJjerH1jRkfioc79Z1dskJqNggcIg8KBmon3NJFu5FJwFdd+op+2xcym/jDExNolLuEKnPUkMCwqSUGGbxwam+yPovB9drPXnn+BlhNznvO/Hen5kyyEYIgERHXQPNWVwtdqpgc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7389.namprd04.prod.outlook.com (2603:10b6:a03:29e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 09:46:41 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6134.024; Wed, 1 Mar 2023
 09:46:41 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "gerg@kernel.org" <gerg@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Thread-Topic: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Thread-Index: AQHZS8bkMV7zY86mpUOr+8CiHQEYNK7lreKA
Date:   Wed, 1 Mar 2023 09:46:40 +0000
Message-ID: <Y/8e/7lfr0iWxnAd@x1-carbon>
References: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
 <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
In-Reply-To: <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7389:EE_
x-ms-office365-filtering-correlation-id: fb58231b-dd1b-475b-ed0c-08db1a39dbcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtEhqLM1EOeFMD8bZQmqwjWD+raiG1oPQprg4R/McuGird+c9m9wa5ZdisjexUEqRQpXGim+2DPmqrLwL/sNNGQaW7i22DS8zdXSnfatKRoUdVcl6v8iy5qSXneUPHqTxqnjzoMOlIg0IIS0FKpcsHdmUv6AYMg7V+nUsUE5L1KETGwY9g+dClDUSpWjkWtbJYU9lynx0rRUC4CqTcPAklgCe+OGxc9Mj/HfOO2YNHd1smoJdpL8sG3y8mAqcfUW3Fe5DIyXyuAXpwZQzFcNDQJuNTMuB4hjauo49JHBnIXUQOhAf3nE85g1k8qGmSQEpMvtiRC81/W4Ock+pbpiGD+5VZx2YTytnXsYRX7QC7HyaB9dK7+skl/LdkLLlyaE3pm7idjV39pLbxNJ5/+z34N/7SeN3GeOPrKQ1LUO4NFquaRqH6snp8qzfzfLkvGKTlfrqZiNDfa3Nr1z+xd6DH17wBiAqzMTlh+uOorj+KWwjcSqWgFc6r7LQ0e4xwGm3+Q6Ig2ljDcRDoGFSKl3QQ4LoDDt78oj01us5EzRZSTwEdTjswgD2KoWCM8TZLiulqIIauz1zvIhWEqXDf0gZH+YZhZFBo2pS8XillWPRch97PvoinkZwTxZhSgLIySExLqBByQW0Ez76jXGKBRgfiFbMwC/jYwYF7uFtfFqxvGlWWi14+3v/ImdZZcR45Hw/u3lH3QDp6IL9EDYqvn3434/pOda4ZXMZNMhN2U8pg/Y1yyh/7DfS3mvL0NgW08T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199018)(6506007)(33716001)(6512007)(71200400001)(6486002)(76116006)(66946007)(91956017)(82960400001)(122000001)(64756008)(66446008)(66556008)(66476007)(4326008)(8676002)(478600001)(54906003)(316002)(2906002)(86362001)(9686003)(5660300002)(4744005)(26005)(186003)(38100700002)(8936002)(6862004)(41300700001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HWYegVnMKQ3gIPNSogtPhYrzQrliMs8zoFVMz+BuTMBVqil2Wr7tDRc2vqCr?=
 =?us-ascii?Q?y1iQ5n4oAqSHRCP654wEddNFvQwHCYy/o9kCy5o22YW6N+qhEzVcFRjNL8IU?=
 =?us-ascii?Q?bL1CIe86t6NALNTDdG4bmQzw9/2lgdnqziUUTJrNTvG5jhyziSB1tze4RRDF?=
 =?us-ascii?Q?gg5Domg+U6R3FUD1gh31w6WjnRzAMlh75IqQCBIifXOqsvAViqJRwrx47b2s?=
 =?us-ascii?Q?7jenJcl+wxS8XHs3b6BDeAj5OfyYTzXafBMkDNgp2afFzLxgRUxOmcjitIl1?=
 =?us-ascii?Q?7KZO3CfA39XB7Bsqw3Px96aUMPyvsMYVJ2oaM1ymJJF7WufDi5W/JOLq0cC1?=
 =?us-ascii?Q?k+AWG2ZT07SDs0/RnaSS9RL1I64invbjyrCD1yuJfzPuZtLAVLe7EOu5eslz?=
 =?us-ascii?Q?2KfWj+QY125apBBGIk2EDi/G8AT8Bb4LM6UkrlRGNPhlkhstmDgOCP+zDsyz?=
 =?us-ascii?Q?RYtroiykVW6HDhQPhZIpoZDYXfqaS5fqpkFRt79YDbkw7w9lRqa0DlsBTyhx?=
 =?us-ascii?Q?eIO9emxWUWhF8zffSHJfB9/97Fvpixo2OqmVDZQIm4iCaq8kMFhXhAVCwo5g?=
 =?us-ascii?Q?SFOqINwB+hYhjTLN8BuO/l9wxLmM6VvKqpLx9fON/lHfui2XWq0K2SNlGo4E?=
 =?us-ascii?Q?/3O9yLFvxc6wPkJlzbKYnXADNFTXx3afKiOMKde0g5K7CXMuPnjltW6EmZZ+?=
 =?us-ascii?Q?xW1jI3WJ+Arq0qeJsjtMYoB4xKnRMPA0JZ1HhYRghq7xgFFFA9h5YvYR78Dj?=
 =?us-ascii?Q?oMK9gxNvPWSWZm+TyqAYzK37RVQk7kOQtvh4UwD++dUFWL0XkGmc8P3slED0?=
 =?us-ascii?Q?pkbOme9eCCPBhgc3eVZ1/q5vjUjmTWHM+bbTYATgsxTORgOS8yKJQAUNd0gc?=
 =?us-ascii?Q?Q9wcfg/pcH4Vv/ZKdQLcdg7AWw6u8wl0EsBuW3OGUTzTc5Th3wzns41jwdIV?=
 =?us-ascii?Q?LsynhCLv8M/2vLnCw6fl9KgaAaUaLahG3R82EmDIOTL8RvL/SuTa00fkDafn?=
 =?us-ascii?Q?Znv+ff8IwBKndSdPLYjeD/f+nygv0HEDQj7DYxmc4aWFfoLYkZLX9YqcO21+?=
 =?us-ascii?Q?VS2HocCvQ1FN+RQGwVfVgOLliWKpxa1xyHrElyPmnUJEh3as0xzqJUSkexR1?=
 =?us-ascii?Q?H16GsYBZk8z4T1JRD6O6nIx56dosVwBbTmqjeHi+N1yAjeuSqECaJuKC9TQr?=
 =?us-ascii?Q?lR2MGEtU2ysjoFjejqkB4TQNBD+f2eeecXN97M0a/xouGfFMdwGvfQvkClBe?=
 =?us-ascii?Q?R7IFfRmVxbZTbnfsBs6gWLKrf5ExTKrVMGMLNIds44tFpziGb1pso/SxwXge?=
 =?us-ascii?Q?KCOfyelky8SOoenI8wrqYscgJ0FE25QLdaOdc0jgHBAeVU90sYmFl2Z6fprO?=
 =?us-ascii?Q?+OfzJWvzu0eKS5Eo1295/7Uoym72g/bcjWr1CBgNsoIBImV32eU4wfH8JuZ3?=
 =?us-ascii?Q?CD9V4M1D7/nANvpe8EF4wnzSHszHAeu23Cz9imY6jfbg/gANFqSsvOTbwzyy?=
 =?us-ascii?Q?wkj4z5xFDSMhZerxbPc4bErMWi807CJTdoA6naLGyYF10PeunGUdSKz5CEnu?=
 =?us-ascii?Q?yFTDzXa/6Cp8SDCJNauKuZCxyLnOFSWJGtf3ZwwKMTPJ12VBPlsxDftEtdfG?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9F4D4AD6A5B42408AAC09D7768D695F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ztnfk6/TL++vDNRVaI8jMqfmvM3Z0JBsGLjuRJfQtihE038VJNUIQvLmd2TZJQln/xdcpge2WeWYR2y3Cm55fCke+0vhSzpJCDAnDh2uHad5wO4qLOlAO3y/H8nBMHnYBLFP2I9o8lsp5p5ow6LNepZOZPxr7TP+YuV40TlbdspOrpyB75xmwyAg7x8iafH/J/QRncEck1NgEDxeiPS4w8innroSd5+8+KgfW1+j4Xqy4eE29g0BPh8ukBecsvdwswD2sEzFWErcy/pT93JzRIr5k0nKAYwc/A2YQHyURt0rUwq2ZcDDLUz2uEErhCNhq23kcnW/lBp12HMEtLVIhHL/cq5gqOiKHOG2ZC+4bBdO2jVjHCZgD2DF7IR8oBZukFB+RtZyf6PpJKKRNlzkUUKCQZvlGjYDzvsRgwHCM1g5H/gSraqB6s5cL6urzPsVmnCNXkzqMhMbs8c5serkdMiU8aFdTD9O314TxgjZuZbyslPGx9o5RsM3/COsWzqIghgo8E2OQP+53L/rQaWL1/J13xUaMhG16ezrRds1erv0I3rXGj4sD4wh4DGfrHXaYFQKEFgw/CtH7OrL1sP46+CrD5eyLG01xeM6eyfqMmBJA+d6Vib0KCLMfxTzx69RHZUpDakCYOlBkgymapKbr6asM6dYNzI8vhU9aaxi1RfWah5Ug+L81f84UWuop9XJntGLz8FVF2Mq6JVpA8UgdUKWZ+lYDKpFrgJra+erdr71I6A299yYTY5TQMPb5pqbsW9EF6gQ+RrDyS4FufE8gWTPz/wJOZbYoSeRkY5bJz3FwyLPmsFljH94sgZWKhAb5mMeyfxFi/K69puQZDWAgOn8p5kpBZ/cFHMFhDf+QIZywBxFjLnb4+/87v1oPPz7RVbh0WHA7jNGHMHoSwbz0era8OkmVGqmdFiJ0u6mXTo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb58231b-dd1b-475b-ed0c-08db1a39dbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 09:46:40.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oif3iQvevN5mvgw0wbIPWP4tIXz6meMTs6o719mnr8+Zr2fiWziqpHTymfZqE9rQun8mv+Op7uPPsvfzPZYajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7389
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:49:05AM +0900, Damien Le Moal wrote:

(snip)

> > Adding Damien, as IIRC he's had some hacked up userspace bits for the=20
> > K210.  I'm yet to get anything running, but it'd be great if we get thi=
s=20
> > to a point where I can actually boot test this on QEMU (I'm just doing=
=20
> > builds now).
>=20
> +Niklas
>=20
> Niklas, didn't you add a nommu qemu build for buildroot ? Can't find the =
config
> though...

Yes, I did.

In buildroot:
$ make qemu_riscv64_nommu_virt_defconfig

The QEMU command line generated by buildroot:
qemu-system-riscv64 -M virt -bios none -kernel output/images/Image -append =
"rootwait root=3D/dev/vda ro" -drive file=3Doutput/images/rootfs.ext2,forma=
t=3Draw,id=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -nographic -cpu rv64=
,mmu=3Doff # qemu_riscv64_nommu_virt_defconfig

Compared to a regular riscv64 QEMU command line, the relevant parameter is:
-cpu rv64,mmu=3Doff


Kind regards,
Niklas=
