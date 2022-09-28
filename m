Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50E5ED619
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiI1HaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiI1HaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:30:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A55FAF8;
        Wed, 28 Sep 2022 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350183; x=1695886183;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dn1Bzd6bDFtH0kAHNoB2giE8U9YXzwO/9hE6J7opAkKcRO++DMGr416y
   PscRwfnjo289L1WiRp6rqRfh+aoDK/ImSq5xKKk8NFYnZpOIPdNf8HXz7
   D8OAsGDaz8fcO9KAYdc4iiW1f6xe2pjlx5NYlsMtXtsIt5L7tGc8z3Pfj
   AcllpOIGbNv074BYkSe4MJ5zVY2uoPCTROYfaneKVrbNScHlm+TFcO/Sv
   Kd0Un3KsnmGss6WUr1AM/5X7wMpGu9tdkVkjsrnU3tboPppBbIMpBz2vh
   CH2IiBWY2qQIN9mhpLj6b5NEU0tXRe8nS4a6e3hFysngR/Z1V2MQy6BN7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217644515"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:27:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0CndQoGEGcztMHZxIN1m4TrtLtuxCBAsQGHn0B27YvAmwFKL3Kt4y8PkFZ5nBZVQ7yP74mOZh07A7zZq44WD7RvhSimVT3s8HSKYTxYITessXTVUV/hvecI+3cKsNI33Ek69Y/RCp6cgS9s1sEX32SRoY6QvGud93N7EYyEethKm3XBEKEw8CB2ONXba4AEc04Oz9YmYGiSLbiS01obPRIcP3xgmHj2pfSSBECp/3VmTDZIfoufDcLjR7c+Hqotm2JTjy2EZkRp7tI1ztknXfHknSR3xdkR3vYY1kDmUvZfNe7VltzOVuFfASGZaiAJsgwCwOcmvmAn8ubWZ50mAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=D+NVA6JESrpQuM3jY7OeTwlXxWW5lTIysrckcN/2kSjrT7tHCSCgG5L7UoLJgPGwXbjuSwQMOlHjV+5tKcJrjC6wCAN7dge+Na56rGzY4y+W96mqKxCuDNOM7kYlg7HTthQLM9UjrDZOJTY/zRGFBVmzFSOgiQOGjhmfRynozfrD0WaMweKIiLZqZTyDQoowaRELLRKE6eCnDNyLuzJ2SkaDUqNwTztwckThSwifsc94Vx9fU3vQ62GmNA04WA2y5W+dXC3eEXXq9TIiP4k9cZhVDzzs7haIj8U+7ThC1kqF6Hp3cp+WceeE2g8WMHxnHPS/mEz/AnEfJjUTnhHbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vBZI+dg0EQpvFc8uokn6tKwOLQ+NpbqzKv+GLr57VS9yr2ijRL8x2JVw6sU/id0z6BICeiRdcoamigpQwX+hN95Z22rx8tUYl0JqYOpLdhOgPnjLeUPKt/5t2cfcWYCKBm3ovyKq9/vnZ6f4rt03rnO9WZu9JWYE9oP2x8HBjOw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4487.namprd04.prod.outlook.com (2603:10b6:a03:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:27:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:27:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v6 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
Thread-Topic: [PATCH v6 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
Thread-Index: AQHY0wUfiOqXyr/h/kSvEtTjwoCxbw==
Date:   Wed, 28 Sep 2022 07:27:03 +0000
Message-ID: <PH0PR04MB7416E2935FD181D94ED87A789B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-4-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4487:EE_
x-ms-office365-filtering-correlation-id: e1acbc7e-6b07-4d4a-ee26-08daa122d740
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MieIOl9AvIKr4ouSqRl+tqPs8eiawq6Nz5isFWBkHOJ56ov5OEI3muSpY2IT/QeZeX9XRzfZwpS1zWmFBMnzRMYxIjaUPjpDCw+SSQeIksD54NjvO+hchoYYRwBDfHt0TjBdPHyw2lgZEFYebDVJ80NpdwgmGHdRlNDvxF7zuLB9Jn8BKCze+T8M5WOnTCmZokGTZh5gcwOlSeDVFSXcCDT5c9OcNb6/4UMYUWQpu2v+eLr5nKTswsOtqqCL5reBobIeRnAMNrOXzBIEOqLEXffsK2yxt27Bq2fp2UW6prWoCPPwfgjkup4UbH6kBf5c7XejuV9QlYIbTYJ/iFxlcZXsYbsN5ANt37zuzZKc9ck0Ip+/HM6926aUk7dLoiAQgDphQDQAAPB4JvyvEavyRKsIbRbH3+Ms25ZvPiKK3RNsID+ud9UKkVhWJ1i+T4UL2zqo420JMRpTupQZTtJNU+Ba/djY0iSl3nz/1P2yaYsZwOUxHkPYXf9wQAaL+OrfPWNp+4hKubXoJLIyz3e5UJIeZjry84DtN/h/QFalZg3G4x8MwpUZJy6uTf/9Q8a5n80U06x9lcUgPKOZC14KBwMDF6b25q/LIPFQH+d29ISNbtzoT0HstctQXThCwVYjYLmTbMFz09ORT8hdlmTJHw6dmOCGJQ0lau6pdl7LEgIGCtkt6O5MV2KnXlFW5Zfqs/EomyNnkS8rwLwjaj9R6YMtzXBvQiRi/hs7kT5CKw/jnc43Oz2TSTHdF09p2VI/BnPZpF5XA9cyEGoAKFdghw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(55016003)(86362001)(110136005)(316002)(54906003)(66946007)(7696005)(9686003)(82960400001)(8936002)(52536014)(2906002)(19618925003)(33656002)(8676002)(66446008)(64756008)(4326008)(6506007)(91956017)(38070700005)(478600001)(66556008)(66476007)(76116006)(186003)(41300700001)(5660300002)(38100700002)(122000001)(4270600006)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDMC8ImcjYt1yNGRjNRcXKOtPv4uF62K6it/WuarYAfUqZBbaGdebbQVjqpE?=
 =?us-ascii?Q?pISUr784U0czMherngYFDtGlDsUBpKdKMqV62rGZ5EirOnqIz5b3JoLURPye?=
 =?us-ascii?Q?w7TSGmwSSnavyHmMDDT3dFh+AUtbTmiiIhIgM3gJH5IV3tAUYan7aGm4TDoZ?=
 =?us-ascii?Q?KC6SGEV1Z1hsjIaG5IRU4mNzdcWBYdiHPYubLyCOlNFUHwXqaiSH362NnGg5?=
 =?us-ascii?Q?28FC6uMMuJuhwRiGlpDqMYxbLaJYV1Q9P7I940J7Zy6HtBOrG130xVXub5JA?=
 =?us-ascii?Q?QKon6R6o2dh7RHYxefQGMfTET0X4UHZchixTAVDqPAHlL5RVu1W5NVWa1/uF?=
 =?us-ascii?Q?b3bbP9WQBW+Ekq8Pq4q5HB3f+i/kqbe6uaeHZh94KK01x3wVj79gXkE3p9+V?=
 =?us-ascii?Q?MypAdo/cGu6voIdNg60X5Wc6CjMWTXX6AN956U+3353wzVchONuXDteQ8Ilg?=
 =?us-ascii?Q?iPtm8ALyd8ak0Ox7US9ka4ZOK3eP9T1IYUjO4hgefSgclITIETcNmSWJhHeo?=
 =?us-ascii?Q?Czb6/+SMGm/zVZKgFXMbti2ixcr/BDDLqd4aNNKHz7pV9yGeru9DoW5tQYkj?=
 =?us-ascii?Q?dw2gV+n2D4z02YPXQ3WDCL5vppgulR0kfuMF9B0nw3/UZjkRTuGnNxME5VLo?=
 =?us-ascii?Q?z8nv8jSWx1TBuyvJQqZ/IRy8QZEz8ud+hu2IyYDYf3rR+odpyPacFSUqWxZQ?=
 =?us-ascii?Q?N0rW/aDFPfWc5lhPU+QRN89bIg2GyKf7u/a3ZFUgxg57yrv59LZz0ONrcDEi?=
 =?us-ascii?Q?3cIpX5YXitED6hB+nfGLifBcvjLCLtbCSIFuIsIDU5MJl4ou3mq4aOjw31Un?=
 =?us-ascii?Q?PDZr2B/WtxTTdQfFdqCNuDCbJxeyeKGXc0Tf4foNi4tCQ4ArCR5mNCfNwkpV?=
 =?us-ascii?Q?faL28PYhKIjIC2qVdI0oKrs9M6S+XFQivuN0nZ+qUBKYTVq+KljrBpmnSVFJ?=
 =?us-ascii?Q?d+dXEh/h3iyAWas+3UwvIn5iUzuLUB0saiHPWTn5LkPU90pd2pT92D0yaYKg?=
 =?us-ascii?Q?gq+QhakOlIZmZQZjc0CmwjhjPT3fbFiYEpF+hQwn20KLkw9QQbhRKGRoufw0?=
 =?us-ascii?Q?7h1sM9lsWOillSG/jYVVsndxoVJe1rRtZD2OiZvB09XzrcAd006qwwegn1/u?=
 =?us-ascii?Q?I8B4a96aWgQlXP7nnP4vXgFJJOZkevKIKPlPg7HJUzNA3EYizlMZOrOnHpKT?=
 =?us-ascii?Q?HnpFefRvtTJlNezPKiYv8D6EBs7DOHjykBS69VmIU8ZvnVo+CaSqXOj5Dq6O?=
 =?us-ascii?Q?YLNEkpC1MwXGp/LeFPztSnU6ERUTy4W7kKqabybTvUgYEtkOtCLuOWAhAF2n?=
 =?us-ascii?Q?eu8LOQN423WMR58Wk0fXT5wuE6xGdVyuB6Ui7IS3qeeqp0wU2Gz87VPJ9ttf?=
 =?us-ascii?Q?49qNZo+YlDx4aZCT5ElhvgLJDH+qAQ/xQBQj+aJN1HQfsHrOIQ/l1EcWDCK8?=
 =?us-ascii?Q?vDK4PdTMBqGrAEtyaa8dr/rZjg48ibJC740rLUXNBVEq1l3PPAgPkeMsjkHD?=
 =?us-ascii?Q?q4A0V97kQFSwLWCt1wM26WwFwQWOAik1v6FVQjl7wsOkjVrOHTtkfXOJ4I8R?=
 =?us-ascii?Q?P6adr8jFlsH3EtuKOkDo3PFEW1H4du/4lgMi145orDL04EgvzBTgfy7YwHtm?=
 =?us-ascii?Q?c/qsJoXFAxMZ82Mfa6kx6G/eK9bK9nuFBfqoObfhl8aupQtpuHPTWsZVz7CG?=
 =?us-ascii?Q?Lu9oCnTvebX/mDxyyGkC1+yxubw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1acbc7e-6b07-4d4a-ee26-08daa122d740
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:27:03.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aB2UYP5RKlzQDd+PZTSgov/Vg8w+Vl3P3XoPhOzwoObq3CM//IGIu9OtolbIJnOxfw+vMHOFASaNZv23lyblB+8LT5ogv8+joo2y1HaRDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4487
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
