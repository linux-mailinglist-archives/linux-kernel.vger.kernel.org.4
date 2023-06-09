Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE87296D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbjFIK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFIK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:28:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C14C23;
        Fri,  9 Jun 2023 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686305892; x=1717841892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iPOoKzR2l9vIU4H2Zjm37aXpiSg7RmiveuosUG+RJ3w=;
  b=QCAuoDBubQkGJgRVK4j4wNcgGu9Lly24DxNpUBxPtw4sjL8E5NS+cPn0
   6AfCWmCMMqpbsvBY0O/YHBjEyY+3vwzmtgHZFDdNV11So05u2U4J2ywhz
   nw5xg1oWy2gJe/Pb52UU2+T/9Hs6BB+Tl8PtnHcqpaS1MZCTfLmtzBSZj
   Kpo317bKRR7+e2kUydssJFECHsE/welRBCFav1Kdjzc4PLI3f8S3XfAlO
   bny/aCNh2B82CvcBAwEpFQ8FgalceEvYCqItlttfr+Hv6yfuergxxdLkP
   UzQHct8ub/B6f9+tkeNmVK6DKlX4qy0kRAlZfu4EEYyC987Q4ohNsFXGq
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="234570984"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 18:18:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxFObmWWCUxmGKDbWO0NjLc7T92WgCQIWTjKQSHVSxJZ0WFmASuazkVGPRI/6PXf/243rKXlWpW5cQ16F7FXFQ/iRQGhLUXoQHqaIysYaEX91gJVOv1YJTCC7nFTkRM2DrTvdMYKXtW8HmxKxtunEd5+OA93wFVSF7kK3XL0ePg7QAQaOWDQ9o+UHUH1gCYabcYQcwJNp0dXgJlqPyQttJun+bvXTjpqd1EpOxmwyAyxF5Ka2PsrmYk6B1ojAQ4DbQRZ7ak+xO2p1A6r/K0JVVqqhcd8x5nIaLlR5YzUk/L1KP7vN+a34H/QnBZoHL9XxJyOVBL7yp5x3hpzDDFlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XrOvhp5P4OfC366cRBdwOW89OtWeCBzIyWmNUfLEjY=;
 b=mKAZ/4Zy6C/q2VsGi6b2NEp38c7zYjbmmFXXn0N04wZKevcCYXM4UV+pRM395AfPG2DZOgTt2X87oc8HgVlUMm7yEPdiLQuHS85XFt75txW8DB/So15OVDjmP4UbWkcv1p6vC/Qk+pv6cemVjSM21VkDO4z+YqnDtO/zx+blxBwrVpJIVdaakWJxxoPTsmUKBxUUcNWlKwHmDhgzRqDRp5+sLQxQvzZtOMQ8FiJNAUplnEZjLokbiqCfW2vKJzWaIpBCYpprM+L77L7AihMbvixnHwQZki+eonQcYnTsbwocNodJgOVAZPiqP+n5VkTUSv/j2brPsNDV2nKpTxc3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XrOvhp5P4OfC366cRBdwOW89OtWeCBzIyWmNUfLEjY=;
 b=uMnTjLnJylpza2hcufTD6zf9ENaGFhJsKsWyDCZQwyc8GD8nqcfQe4ApAONseLKrkF5Udj2HzbpUVlOxo82yeeWD/uCMGP90aJhHEtdAzzgakLWzjylGACB/11ZP6lZnWqQn5os/GQCT2ozAycjwGLFnWojDUnRkEMV+d3mzwbo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6519.namprd04.prod.outlook.com (2603:10b6:a03:1d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Fri, 9 Jun 2023 10:18:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 10:18:07 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Peter Wang <peter.wang@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" 
        <linux-scsi@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v4] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Topic: [PATCH v4] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Index: AQHZmrJi4hsth2Igeky+y402m8cNCq+CQbuw
Date:   Fri, 9 Jun 2023 10:18:07 +0000
Message-ID: <DM6PR04MB65755CFCA912182C5D5044BFFC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230609091113.22531-1-luhongfei@vivo.com>
In-Reply-To: <20230609091113.22531-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6519:EE_
x-ms-office365-filtering-correlation-id: 3d094d3a-1759-483b-53d3-08db68d2d18f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWwWxJmx9vakENiG8XXUHnSMPzAdpBYG90YxJOp+eXDCzofsR0pWoaslBEassN8/qmaMPuXfL7IqEB9UC+q3qZN9wuR/yoINHRwhG0nLVV6CG7yyF21k6JhVeqx/TeVsHtMo1l0rOA0KU7TsqX1WcNN7mHIqcyxYlFrpYc+erMqsaNG6KX5jbzsWoO4Nee/8mCch+dqd4jw72Vy07y0MOl9Cy6Pe5U6LI/pJiEprauB2blJy0HbyVlnPcF/+zjC8N4+CfwJ1boi8NyUufs7z+oijbdLvBSS8ypFX7orbOb9nkFbIEKecdbu9Jb7m1LcJWLsYXsFPvHbx7SPo3tQH2OckPntRLbZCU2qU5CMph5/Ju+l71dZMR+6HeTmn0DT0qttTXkqdaUrf0StS11is46ZNwoAlp8O2Q1DpdZbZMpOcEV8ZGE3+RYF9CeQjvEKMinHxAoC51FhGtKN4awuekjvkjOLl30F9YyTRc0R87g/ZZamX+ME7KakQINm3Ve2owX0wwbSwPrc1JkEx9U/bSeJqd7kOwwLAauAgN3fSnqBJu1y2HKxDkM0AazsrrRZMe1VCHdCGOSBfCiUCjxhWQiAWxDLXfNH+XB7FKI18gPOMfDaE575P6nADkLk+Msjb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(66946007)(66476007)(66446008)(2906002)(478600001)(4326008)(8936002)(8676002)(64756008)(4744005)(110136005)(316002)(41300700001)(5660300002)(66556008)(71200400001)(76116006)(7416002)(52536014)(7696005)(6506007)(26005)(33656002)(9686003)(186003)(82960400001)(38100700002)(55016003)(921005)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xb01VCCtfGknwVDqhmsWgJnkmnDT0f/8yfXdO7DzqUdg3JxWNlNZXLkRtNzW?=
 =?us-ascii?Q?guazMfOpYxOg10wOo3iK3u3yXIvSIXay07jjNbErakPxrAkm4CBZrdWIB347?=
 =?us-ascii?Q?gGiDsIV1C0EeYm/xvfoHs9LlsZgknjQ3hcwNLa9O7GUMak19374aHt01Ai7i?=
 =?us-ascii?Q?bHQ9zRGN1gYkwcTEUZUeXH2ow3vAF27Hldw2KURLE9hdSi1vbFBViSj9GuFe?=
 =?us-ascii?Q?zPRQYGYhItgsFLiHgfD2qxgzzf6lEHnS7qUU512pbZLgODK5RSWmfxg7rh61?=
 =?us-ascii?Q?65iXI8kLYPKP1a4YbiFP8w+nbHNdinmKNuIhGBs+LJVhu7HnhkJuMldda5k8?=
 =?us-ascii?Q?5N63RPE0EBpbZqG4isagAjU+DI3sLJRN0Gnz2Cxq30zNr8V8yW2tWxeUCvJ4?=
 =?us-ascii?Q?ZMWn8Aa8qHK2DRjrW0WaXdvmvrTNWwz9eZWtSm/aUpeH+TCejeZC9WNdtLz/?=
 =?us-ascii?Q?9bFcV7aNaD+zzN9Wjo1dWgcIlX7cCbTedZ/EKxkyJvrA39W3Zgp2JHqIRmvc?=
 =?us-ascii?Q?w4ZfscgnucX3EXonlm/NFysBDcu/Q+fMECzbX74akO/EeU2Nc3QW/SI2z0w5?=
 =?us-ascii?Q?L829hy201xtTAEd9Cp/4ZXnj/GY4eI8aRMh/SX2JICPmhimb/pO3OrnlpyX+?=
 =?us-ascii?Q?mdQJjQUWI4N6JOOX4U5NiffNh8FotpIT6W9veKNA5RAvKydOHWl/KVkypAEQ?=
 =?us-ascii?Q?1pJYVfql6bvBET/HvLHjYtc+FdA6S5wLNuj0YAe2oREuWWdVRSKpqLiXMqAm?=
 =?us-ascii?Q?a9nNp59V6hBS40v54y5AOO/XvWaD3mFhTiNVBxv4WawRAKDThcrk5JLLur+l?=
 =?us-ascii?Q?Yw8yisYp4efi7aoDJr1346Ua+NyXHsxHuXgO084J3lCkZqT/z97VzKq3I6+V?=
 =?us-ascii?Q?uL2f/TS6IQtzTNLimRBCX0zLAmuAgqXUjb2tmzxuD28ZC8Le2p10G8k0o2BM?=
 =?us-ascii?Q?jOXCeoSJC4iHXwK7FSqnc99mylUb6BySwMtY+6Rt/4Hze4wfsK2IYKUCLZ0o?=
 =?us-ascii?Q?oi76+KncwWGsvrIFDsBW/Yldn5lPVBRetB+v0sj1hzDfJLilXx9NRtbzT3UM?=
 =?us-ascii?Q?5cHMJX/aZHcrWvshIq5sRy8vtUeoq0y4mtBms8911PdsYthTWXtd/0NirXHB?=
 =?us-ascii?Q?+odAr4NV+SQmcqrxXdrqr/DNyunOqxzQG2DF27vTuRCpJuLhBouh8qF31TJz?=
 =?us-ascii?Q?qZ+9SB5pLA8/LngDlqkf9U60sk5ZaL82HU1sjbkS0FkQyuNmLr5zD9dbsSFC?=
 =?us-ascii?Q?WGI3jQ4BtVuClBQT+PSoesIuhMf1pwQCjklNgN4/1fnq+goVOXMS12wpkI4P?=
 =?us-ascii?Q?airPtWzt0SI4/+GP5vSzA8NjzcBUrvsNcU4EJDvwe8Vb20apG+CvxgNsJsnO?=
 =?us-ascii?Q?cqDDIWbqJghJoVyrlN14A8AbcRQNBHd2t2P4FtnRj2mx4W4zsj2ONPvn64MS?=
 =?us-ascii?Q?ct4se4K5MnY3uvEsjgKjypc6RfTICT1mTCOeQe8hm9ynDfLjO/6Vmem1Pz5S?=
 =?us-ascii?Q?zqJ7ZujvoHSty8hiR8YO4oeIENzTgFF4/Jl/i01U26Njj5xHPf0Jt+xzeVUh?=
 =?us-ascii?Q?WLiFom3UCiTS7FSM9DBlMlSiu6WXwqG60lBx+qcx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jCNkLoYIvtL5Nidog5eylyeqt+S2/bfOHpukQcqxTXlHZyCEChBdrCchg2XW?=
 =?us-ascii?Q?vhNPf+Dd9XWJLentPUzgGZULkvp+Ws4x3udMgqlkR4LAnzbLtflXTmEAekcT?=
 =?us-ascii?Q?Vo7LeGpC7PUjb0a/HoMh3YJF9W5fnk8+vHUBKOD1dfprpjX7iWJJVxGfpTqu?=
 =?us-ascii?Q?K/em2nURUN55+yE4VlmMaIsBibH0reQW+UUMClOjlxRhseiBHRLtSUqHUn+n?=
 =?us-ascii?Q?4Dpfsuws+MONlxtqtKABjd1ql76B0YFsCxXdECGRCdY5fLP2WAF9J+NeITrG?=
 =?us-ascii?Q?WMdxqk+fk3hYCaNtv8jY0c2+ao2jX+RA6DS2URG31/gO0SgaBY4tWNgwNZbq?=
 =?us-ascii?Q?MbVoMexhpxkomKgXBhbSzg7jpcTq2dwBZUSRu4ttDZuYXiutob0FEXqgHtyD?=
 =?us-ascii?Q?q7HTY/+NEZOqLjUOz9ZywWbnj0CNn8Cua3FlB84RtcPOgW50VAkWSiwKZ2Wp?=
 =?us-ascii?Q?bY6J/Vm8KN4uK4WUo5SeQ2lXg46UxXa0FLcfwKkxa2Lc0NC/G9DuaF1KDLvs?=
 =?us-ascii?Q?iNI4SmXw58zb5w1LtCWV7X/GnpP1iJc4exHLLQxZJ9wIoSpWOozJPdADENLa?=
 =?us-ascii?Q?pDKcIoknONUaYYRwyJ99vBM7nVuvVtWJxpVqnj0O+HNu76ACL0pduzpwWLYR?=
 =?us-ascii?Q?fHSDAZVUFpKNLv+1uIkuF7WOYYHYruQ8ssPf3mRp4yt46Jb1dBavYCYVx/lZ?=
 =?us-ascii?Q?yMmqmiX6TZ5aMIpFoGG1V/qum9nF1ydMNiVXgzYt/8JeoWg5QticMnBEMFaU?=
 =?us-ascii?Q?z5c+HDej3TmCCGE7vbh5SqJ6UhHDijU3D9ISCzHEzT41MguMzQT3tIHFoI/U?=
 =?us-ascii?Q?p4gLHlB3KufqRwy91Kd4xXxtwHaK3oZ8QHVqSN85U7IvM72nDIqeIVAr41Ln?=
 =?us-ascii?Q?8N5a1mCIgW9NhHtQsfT63S6jhSfXfMurvtYcEclyNAXOYDM0ijxi4b+VYLPR?=
 =?us-ascii?Q?Snntpqha050cArfpqzyAsmFTiPB2T2mhVsVN52R+vtBMVxe/bdmrYiVb2f5+?=
 =?us-ascii?Q?sJkIKz+14RyslWyjpzdhTsU9nw=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d094d3a-1759-483b-53d3-08db68d2d18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 10:18:07.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8y+RxRHayrBSquj8+0mq8RXedTeMWhPCYJ34uW1kBqnGrRDJDWWDXBT0ZQa2GCHQZSGttDUPcgAcDCzBrdOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6519
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> There are three flags that control Write Booster Feature:
>=20
>     1. WB ON/OFF
>     2. WB Hibern Flush ON/OFF (implicitly)
>     3. WB Flush ON/OFF (explicit)
>=20
> In the case of "Hibern Flush", one of the conditions for flush WB buffer =
is
> that avail_wb_buff < wb_flush_threshold.
>=20
> As we know, different users have different requirements for power
> consumption and performance. Therefore, we need the ability to manually
> set wb_flush_threshold, so that users can easily and flexibly adjust
> the wb_flush_threshold value, thereby achieving a balance between power
> consumption and performance.
>=20
> So the sysfs attribute that controls this is necessary.
>=20
> The meaning of wb_flush_threshold is the percentage of WB's total size,
> such as 1 representing 10%, 2 representing 20%, and so on.
>=20
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
