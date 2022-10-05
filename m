Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB585F5BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJEV3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJEV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:29:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E182842;
        Wed,  5 Oct 2022 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665005339; x=1696541339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4bmQU/f4oOtvM4W/GKYu69sp2euS+ksAVnQhLbxvtls=;
  b=UsK5oz987zBicrK9lTCWvFZOpJaY5nlwPIbLT/StvLil0DT3yz8yd6BM
   KO7ZET1hkQ0MAhqFWcpXhrPhnXGyVx95ZXZVfb4wqjdIVhH5I9qps78IM
   HIW2QTkrpfdtvx/sR0mi8HYIcB48Yo3xQ1WlcGjVXS9EMhQXgHH/OxiIb
   iGB8J0sKvnVe+9W+R0LSZnU77rDSG0XVE1kzAxcoWKEMQieOx4O/j5voN
   g2cB0nPmeEUqhBSdkJK/RN9FurohzD8BMmLf5itIR0RbIl0vg7xAQbR9l
   WB/JvBMF3TSQ+UEe9CraahK9fl31bNi70wWHvdxyxSFKpLXsqFuf/fITC
   g==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="213480770"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 05:28:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3cFWKoSttiYR6fGjamhBRsmJFKb2Z1cxBZUnS6p3sXFeXxXFXosQYZP+bbaY6gh3dUMo0cjx6cVKwjAg4qUEi1OOz2VwDok+y3QVnwHXdsxdWHOp0x3IceaYgWw3mTOXoDu5jmf05XKyKxtpCm0U/OR0lmCLKImCMmfm7M/98qLfecVIAQilvjZU8OJXWdqg+vXKNAFvW3C5DQ4jdwuIV4KWQEsdz/AJU47lBDpzDAfnUKksiy28yqmvUF4UVpGpIEYGo8r5/zuzg7/ys/5VwQdA1wxtPvdHksJYjq3DOh3AKSTNiFsPFDLJZtIj+JAnuAxub++RZYFNrUallsuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUKqnDuZhlMROH+OazFVjjeCLKRHsCknwbdvxx5SxR0=;
 b=GmNNZZiKxqMDYNKVb3fdmmcfguKFPWQZvtMI/wlADUJXPNmtcB0dBUr9jl9AQzvKzO8jgdGzSK4XrSHKU/Q0P2LeXuSr+E4QrKH6IBWmd+YKEq/WZhu15MOKmzaY6ddJJCOejic+ts6NM/90DfsBzfePdDRfNMoWEfvYOP1RDQcXG30UWfXabvXg4W1hpbZDfKl/OnfieMUc2Ek4/vMw3bFkpCnZwJMug5TR6o0n2kTUCCPAMjFxSLhCKOX1dVVJyN2NOhhbNrciRfUVGwpwev10/uGwL2nIIDEjPgqlgcrmt1USkZFoLv9P2fQHYYozTu7L/9u1gW1NKfJMa61Q+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUKqnDuZhlMROH+OazFVjjeCLKRHsCknwbdvxx5SxR0=;
 b=R4gpcMFQZH5POmubvHuidNexDYWIrmkF4HXyAwXdxxJuAkA6bCCcgsPZi03Owyp9ek0K6cptu0f3PDbVkSdrFexRQDuhHsTkSypdL+wF3Ww0RM4MlHg54jbFnbOIm4fW7dCJcS/401zPvAaCpe77UAiAukweUQYRfDA+6PTtQQw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6376.namprd04.prod.outlook.com (2603:10b6:a03:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 21:28:53 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 21:28:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Topic: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRa3+RKaAgAE7cQCAANLyAA==
Date:   Wed, 5 Oct 2022 21:28:53 +0000
Message-ID: <Yz33FGwd3YvQUAqT@x1-carbon>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
In-Reply-To: <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6376:EE_
x-ms-office365-filtering-correlation-id: f560e882-f01f-4b3f-2423-08daa7189a45
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xv6YLq2zSy4huwxjT1/myhF2XRFzVBIjQVBgQH522fVk6x8p1hDGXHcsO8XACqHzF4t2u0LEA/PwyyNiJu54LOluQ8vXdcNL03iZelH4Uit4q+kkLnWeYvMCBH+uSBy1zZUCOBN9KnjEtdHQDmO1WDwHkp+J8B0JxscPLPcBklYSQEss7JsC5mWwErITQmyRmaF9f9mxIBOs/dm1w9eFiAr2/QURR3nSnFDNLdI6FrcZGtwiHrv5YlOW325wQrBSTvDW9GlprhkBvqharQYySYHcF5vjw8XZnNxYjrZMED2Qc2ATTrJRPrJG6J4oD52/THXZ6kYmXF+kCE4r4ZSP44Sp3PMKUPVDosVozLZqwEqquLVDgSTHki8d/pKbIJ2xIxpORlrgrNkauiuA7iYGBIEA/VtQ9y6cAcK6mD0bQnt1hMZHqkf5Z6bdbMR1iNWrqXN0irKOdk2gu7b9X8JgatI0InLOq3GeYxe1JIMxg3TN0s8aQGWBu7bGQ1u/IPdhEQvcGjpJZ1a2YYFf4S4sUzAwuO9J1nWzR/CEhfP47EpGgyJXKx+MiADKTNiMEKmmhghSJ60Voj4Wup/G4Pf0x6cMrEJDxg4oik1GkoG6E7CUlasd47pl3MXeEJ9HhXyY+0AwZxactzrYz7uFDlm38FMv0SupgYUmKwpPq94zlGasIYY66ag7vVfUTbdwIG8nzA3QugIH5mHOO777B9aBQvEXyQBO7tGvts9iG65XmYFXWskzQWgC3Jghzr+KtwVEyTe7ZpsHd6DzozCwrwHGGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(2906002)(8936002)(41300700001)(33716001)(66446008)(66946007)(38070700005)(66556008)(64756008)(66476007)(8676002)(86362001)(91956017)(4326008)(71200400001)(54906003)(6916009)(76116006)(316002)(6506007)(53546011)(38100700002)(122000001)(82960400001)(6486002)(478600001)(186003)(5660300002)(6512007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9eVidCLKt1Tf71LPgkga1eUZFQXVWfwBZ6hOlyIAE8oWqlYmZ2hmazcklw9Y?=
 =?us-ascii?Q?c0maXdO6Qm7bzcF+4b+z90mfyrf6ruxUzr3cL4uue/b/pZjkKifmFYdd5/Wc?=
 =?us-ascii?Q?o6d/3VOvx5tZS3n7SY1kFJ7uEv6NUdaHZEYhBY7xN3RvFnVVPkoHS7DJHYBG?=
 =?us-ascii?Q?z5R+Pbl09yT0ry2jxMDen5IPZlmDxnrgiIFsKQVv9He4TokiV9V4X/Eyv7oj?=
 =?us-ascii?Q?izwiPsW1okPg8yww3If9IL67SAMfIMZ9EgUJy8sgusQ/jzzicZxwBxkZwNiq?=
 =?us-ascii?Q?ngGtqJQgC+5ckvUhR1jj00wJqt9IZ1el/PeKQiX/af+jTt/+7vyOCWgCgyGB?=
 =?us-ascii?Q?81aMKuuUkdo0iYOJMGjYF4fHqx/BNHbuZpNrqU+oDpcPPvatVx2G0iMAZX9J?=
 =?us-ascii?Q?1ie95e8npCGPj+hEmvkkgEfmYp7/hru3feJrzLhrt2jkNGK3ukyevp/pn3J6?=
 =?us-ascii?Q?i14WYaLk6QYFF3XGiC3+XHpU7pRjZzzhiWFfZ8UNAIhaNJcb1eMeKROiD22w?=
 =?us-ascii?Q?mXZdnq+VyKJJ259VbZnrnKlXiLW7wJctMnPRWc/pUu41ijnbzN/0AHXKVGkF?=
 =?us-ascii?Q?+gpUJjg97Wt5yG4tYw0rgPKdvOGygNUV1gFFYVdYgDNd2aYy/sjD7KuzHx+V?=
 =?us-ascii?Q?qXiaV9abnOvkcy12Y0F742o93qPtieTtHzg8OMP8HfSElxWuc0OTlAthV1ju?=
 =?us-ascii?Q?QW7ORV/cwlXF8D0dwkjKfn1vxbKdlnOQOqg0lZnb1P++qN+O9l6+UQRoW0z7?=
 =?us-ascii?Q?QINGX2u8dBZ6k/AvsUCEEfErBPpZqh6wiaamIUFi8BAzkMGA9czg2ht8MoCk?=
 =?us-ascii?Q?5ReFhCI6YNR/oMX3zfHXYUJ1L2Ik4uA1+k83v8bEcaqIcQl+9gWVJ6pbHJ/Z?=
 =?us-ascii?Q?jcQO3dWZ2J3fjmKNYMpD9ditnv2I//zwhlzyyZo59uUYZqODPMkyDMcTq9hy?=
 =?us-ascii?Q?6WL6UmOoBfhWdyLohkYwnluGqMUh0GwKyrJYhPnmPrHKMYcO9Zfns+K+gBQ4?=
 =?us-ascii?Q?IX7oGl/KYv/bPa+wmkNMRtVyVkNEG/YxPwl33aC3TC2KNltbyDGrXwdLQCxb?=
 =?us-ascii?Q?snVdJIZtI7YEtAXzhYszndFluRt7CPgFQqM+SowJavSdDTkVoLzuitDBUwD7?=
 =?us-ascii?Q?UX9BQcBCpSf86I6yI/n+D61VSsvGEE1nbMgal5YqYLiqNqQ+fGraUXIJBzdC?=
 =?us-ascii?Q?BwLR5+JsR9GJmqeK5ReLOwWPy1+CSzyh25++YHFSjCftWz8aB97FH1uG+YJF?=
 =?us-ascii?Q?69BAL9WTNaDExxIlzbXcmhWbZS0AQV5D5CJCfSfsToiyV3t0yVd8d0tX1c4x?=
 =?us-ascii?Q?XXleWfW/UialN3bMtAOdiXB7/kMBNICmDD6FaGS22iL0AoSc3thGtZSRfCSI?=
 =?us-ascii?Q?IP3jK9BuKtUaPs/n1WujQrtaMaYYPxi3Nprh2jQT32UtQ/z/pX54DrSgb5K9?=
 =?us-ascii?Q?nS9GDfLJO5kxHc2ZYkvtuxpyJ53mF2h+7H9cdH1h4UkqhUgCSybCg95XiiEN?=
 =?us-ascii?Q?ysi4fYVmuW9M2S/6JfQh7O4OR2CZ09DFaYA2JlelPmXkeFh7Y5JUnrbKuV19?=
 =?us-ascii?Q?DLZkEzA3t4N8Ni7yOeFfOBn3zP9JBeF7zZdukSj9+1YftLFkYHAiFtLbPK7j?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303AC11B069FCF4BA1ABDD57118633FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WmvKot7r9bZcspnVaH6ojGV4Zmgpip9+KnQu5vecRvVWhj2394/xd2wmVwo8?=
 =?us-ascii?Q?7a6orz5EO7h1J0n4HZKjgkTpPTG5ewP9U8EMIFE8pUNq95h/iDfXMIFHiLoh?=
 =?us-ascii?Q?JtvUQljOGITeKUgPuu8ap+1bhUmAByy0pDce0E0z5CETbknY+zcQVIhmRPla?=
 =?us-ascii?Q?tNCYjl/3R7sPlsGzqZQGejTvNF3hm9/rkXgesX9xiM5z87Wl8vzG686BsqCD?=
 =?us-ascii?Q?GOzWI2YWgYCTNGuzYsC8qS4J8vsDz601ad/jXNAh/Ep+oMbNU2IJfMh/dJ5R?=
 =?us-ascii?Q?4tYELA7YADk4smMF2iT84oc/afmqqWv9V84gjJtFyLPdWaWRQA1IMiRykiPc?=
 =?us-ascii?Q?w8XAoOGa0S4hz/zbYU9jAnT9zFbiPNDKJE2CSsaGDkAfV0d+sXmPSDKka1Me?=
 =?us-ascii?Q?N+bgZw6BNfe/XShsKqeQtugYnQp29hxZxaq7JMXHMsMyTxc056dPP32XYnZY?=
 =?us-ascii?Q?4hAuKHUaOTOcKEOiqa1wyyikArP4R0hxQbkG18GPrMzabCUaFmIONAJQQeWJ?=
 =?us-ascii?Q?wjoL9fBkeNqHfhQQi6QhCj7gzDADU0ydtb52uOEv5Gp5a6M+rWodcqHyMesJ?=
 =?us-ascii?Q?BqJzvtbydg86UI0zYI0m8/LlBwsC/FODaxmRzaJ4jguWXOp8AnMbVs9taLQ+?=
 =?us-ascii?Q?LzlXUL4FKq5kJztzo+R6kaaNtNu729HSCwpgy0rC0FSeT809ZS1Vfca2Hthj?=
 =?us-ascii?Q?cIIoC+jVlAOtJq24lWMTsXiaDy/ww9SC3khCFwDepDgXgrFHy+dOw4Ri8H9E?=
 =?us-ascii?Q?mjct+zL8D/poEzauKBl19tHn79b7B8h89wLjPmawiasa96xkqNYr4OqUongs?=
 =?us-ascii?Q?DbmEPwbFZJ0D+olHWwwFf04oFJIDe/4TxW7a1HZeK+nABheY2OlqKc5NGT9D?=
 =?us-ascii?Q?Sv8j22MJqYQLj22LGsDco7AXJlTXFrFb0sWSgeueMDVf2A5dcqksL/KPcHSe?=
 =?us-ascii?Q?3mZqpXAC+uvJZDQFYPfgjswMYc405DpEbMeKDyRcWuRbLqlm2PzkrC7ZyAbV?=
 =?us-ascii?Q?vYQyyZabMSlUd9JiJwCcMFKWiKlN1GR23ewm+6HMWYSKHCk=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f560e882-f01f-4b3f-2423-08daa7189a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 21:28:53.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHa8K6LuLv5tHlWW+oxHRxw6Gt2JLQY6/VpnhSPFGVTPBVw4+FdOZnZWYPL+hz/fayK1qewtiXUJnS4ZexAe8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6376
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:53:52AM +0100, John Garry wrote:
> On 04/10/2022 15:04, John Garry wrote:
>=20
> Hi Niklas,
>=20
> Could you try a change like this on top:
>=20
> void sas_ata_device_link_abort(struct domain_device *device, bool
> force_reset)
> {
> 	struct ata_port *ap =3D device->sata_dev.ap;
> 	struct ata_link *link =3D &ap->link;
>=20
> +	device->sata_dev.fis[2] =3D ATA_ERR | ATA_DRDY;
> +	device->sata_dev.fis[3] =3D 0x04;
>=20
> 	link->eh_info.err_mask |=3D AC_ERR_DEV;
> 	if (force_reset)
> 		link->eh_info.action |=3D ATA_EH_RESET;
> 	ata_link_abort(link);
> }
> EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
>=20
> I tried it myself and it looked to work ok, except I have a problem with =
my
> arm64 system in that the read log ext times-out and all TF show "device
> error", like:

Do you know why it fails to read the log?
Can you read the NCQ Command Error log using ATA16 passthrough commands?

sudo sg_sat_read_gplog -d --log=3D0x10 /dev/sdc

The first byte is the last NCQ tag (in hex) that failed.


I tried your patch, and it looks good:

[ 6656.228131] ata5.00: exception Emask 0x0 SAct 0x460000 SErr 0x0 action 0=
x0
[ 6656.252759] ata5.00: failed command: WRITE FPDMA QUEUED
[ 6656.271554] ata5.00: cmd 61/00:00:00:d8:8a/04:00:ce:03:00/40 tag 17 ncq =
dma 524288 out
                        res 41/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (=
device error)
[ 6656.309308] ata5.00: status: { DRDY ERR }
[ 6656.316403] ata5.00: error: { ABRT }
[ 6656.322300] ata5.00: failed command: WRITE FPDMA QUEUED
[ 6656.330871] ata5.00: cmd 61/00:00:00:dc:8a/04:00:ce:03:00/40 tag 18 ncq =
dma 524288 out
                        res 41/04:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (=
device error)
[ 6656.356295] ata5.00: status: { DRDY ERR }
[ 6656.362931] ata5.00: error: { ABRT }
[ 6656.368897] ata5.00: failed command: WRITE FPDMA QUEUED
[ 6656.377471] ata5.00: cmd 61/00:00:00:d4:8a/04:00:ce:03:00/40 tag 22 ncq =
dma 524288 out
                        res 43/04:00:ff:d7:8a/00:00:ce:03:00/40 Emask 0x400=
 (NCQ error) <F>
[ 6656.403149] ata5.00: status: { DRDY SENSE ERR }
[ 6656.410624] ata5.00: error: { ABRT }

However, since this is a change from the existing behavior of this driver,
this could go as a separate patch, and does not need to delay this series.



I also think that we should do a similar patch for sas_ata_task_done():

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d35c9296f738..648d0693ceee 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -140,7 +140,7 @@ static void sas_ata_task_done(struct sas_task *task)
                        }
=20
                        dev->sata_dev.fis[3] =3D 0x04; /* status err */
-                       dev->sata_dev.fis[2] =3D ATA_ERR;
+                       dev->sata_dev.fis[2] =3D ATA_ERR | ATA_DRDY;
                }
        }

To avoid all SAS errors from being reported as HSM errors.


Kind regards,
Niklas=
