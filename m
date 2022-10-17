Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72CC600C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJQKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJQKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:41:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A35A83D;
        Mon, 17 Oct 2022 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666003266; x=1697539266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U9OlTmrzOSJL5MP4krv7xA39mMyuYByKYw4hGVX8dKU=;
  b=mfKX2lv0atTFnypjk/K1G/MhtpowvQYfZZZDruuym8esi6KHrYk8Fy38
   W3WlKM8/slQA82Je/MS298uEKtcrJix3KnXEorV8OLp6UEoCRGHDGcoRu
   8k43kSzyhTpg6Pv7ogMA7lN3y6ouwH+LfPVjlRyH4EqGyqPa+vjDOLojf
   W8Whc9gyd/eo90fko3sb+EhoSpwo39cABk+O9vm2of1coLLRSgVfDoDDL
   Mieq/2Up2+k8rvkj2I40/vYlDdqjxDnzCAj7QkEbeIeEDQADmL7kRFJEg
   fxR+E8fJJZ6r9huwd6zgLM1NEy2LvUKy01vmec79QzTqv3+nJKS0bXu9B
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="219165198"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 18:41:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLDC2ZKIfNh/C0dlu452TjUBY1gm9pjJb4rnaObMKF3uN7XlmrmGWZ5XDyY/DWprvFJ24bcTYi7g8vRJm3wGGjfxYk8EaONAXvr4EBJWkAXIILpTiddc5zXbBra8SstcpyUOKwy8ztKKW0ZqyI+eXHVochGbZzMzrtz2aC5Kb5IIPSHuXAS8NDaGQkRJ1YQd/KF+wE52eiQbi2UBqYtww3MgLsf8j6VTLZTr7umnPQ07XC8At3eU9Ig64FOS3kU18qQBADKhSS0g/mvQiaI6/7eYIdtbUZQoMJ+rIbrcEHYTKIKgFdowkrI+a0bpmlZlPRfd5iHIbWNuMQ6A8JeUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4oheN2VO2oc8iQ5/iKMw9WEaZsugkJFisHBFtT1Z5A=;
 b=H7CjpSIZy/CWW2wtgd/srlsItFssRQU8l81UuzCQslKJCxenCoDHPcKpfXx6HZMh5QgtGbQuY3fRl2sSOxqNL4FcsZ+6L4NA28ekqgacFdtO6yE5pqU1mvzqcd+KJ+/6xRdjCweqDs9K1ZeOxwnXgwRWvPIzbnDlRhNrKTIb0nRGpzEjHbV7t85emV5mO4812YbGEGSBePlW90GOyVCDbCNOj2HnovIXWMNNCUnxEn0pF7i0+FQ5wqxrD5VYy2+K/ujA0g0bFl/xxtGlc0Ex5wJRy646BqpN4D8qGTdup9r4oXWDUxq7hZ7Dg+DmzuZKBoi1NjM0g3i9h2E95GnNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4oheN2VO2oc8iQ5/iKMw9WEaZsugkJFisHBFtT1Z5A=;
 b=StI9cbEzLzGDwK+kkWQrrzB/8d9DLa6AQlAJpVPJRtlu9ewb8XFDOh91YPUdozPk38HY06fv9JANgg1HAMkyRENK3fjRDmJuXjgCFi6+6s8HOGVcYea8broaOE6CUv/6dyheQyY2hboPyYxUbAwzXOJvMR9NXmVAyQDv0p+pOHo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB1243.namprd04.prod.outlook.com (2603:10b6:4:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Mon, 17 Oct
 2022 10:41:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5709.015; Mon, 17 Oct 2022
 10:41:03 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>
Subject: Re: [PATCH v6 8/8] scsi: libsas: Update SATA dev FIS in
 sas_ata_task_done()
Thread-Topic: [PATCH v6 8/8] scsi: libsas: Update SATA dev FIS in
 sas_ata_task_done()
Thread-Index: AQHY4gWIffPyDhEbSEGGm14VUjG/1q4SZdsA
Date:   Mon, 17 Oct 2022 10:41:03 +0000
Message-ID: <Y00xPoTeYEVkhMMl@x1-carbon>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
 <1665998435-199946-9-git-send-email-john.garry@huawei.com>
In-Reply-To: <1665998435-199946-9-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB1243:EE_
x-ms-office365-filtering-correlation-id: 335643f7-0c34-4e2f-5793-08dab02c1705
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Apn2U9rHg69qDRb8bAusG5+ZB8KE9fE7UDRwqyBIIkuPfZO9Nn6oClUJ/2gHkPASTSWQb/zzlTfe07gtce8eptZ5Q019VsuwndbusHYxRu140rn8mw01G5mFNYEFrSuK5ZfI/a40oMRuGk2XuOYU1aw8xSa4iNmjpRh2QZp3obwJx4Sx7TOdXfW/qqHcFcUkjgE1l7AB98+cMvHJWa3mnt/p41WT1xj2mDfnPuCi9XvTKxyrM1egzL5s+bsL+wGJqj0/j+IfkxWWVqtBOQ1b6VzvXK4bd8+fJNLTDHM42ztq3VzELiaTjwprG1wgS9ohDI6fn0qJRYuLlYwZksSjWN2M4G1ye9e/scpqImR+7B9NxxhaLz7K7o/eKPgE1PNEHBg5zCax4yop5+u7mB9Dnrf8LAqGztzvFty28m4uTGrlTJ5Hj+U58wsQYAAnokWDYqEh0FwMKgVMJ1gGR+yxvmg0iEn7+ga1vF+Bi1RUg/O+Djs5aWzsHglJhKNOaUezJ4w40TS55nMrAZHD3TYqgFLe/AgQxVohdIxn/tEv94RMSWu3qUSyE19rBXzaA91cC3sj7Ahf4o6jiHRp23JNuoDAlS/UpGuHQECXORRHHmV+1bhbk55L/7iblqZ2pUpOOnDzrZK4I9LQxo0du64REj6faIWZoXokkDlsSzbDb8uogn+xhcJ6C6xlcKDKKQuFuZNw9kYbxLpvrQClx+IkBE/wUUSUtE1+qPcC32w8dhru+MfyG+z7X9XgzFcj+Cdde9nMDqtJGgPchvIp4Z8VVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(71200400001)(186003)(82960400001)(9686003)(5660300002)(2906002)(122000001)(38100700002)(8936002)(4326008)(6512007)(6486002)(6506007)(54906003)(83380400001)(33716001)(66946007)(91956017)(478600001)(26005)(6916009)(66446008)(8676002)(41300700001)(66556008)(64756008)(76116006)(66476007)(316002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRUSJIdzuQGGRZe5TQneTiyUJtHsk3vEBQ85pBhR6YvqH3KwvgWyuxEyQHFz?=
 =?us-ascii?Q?DlGKqnt3JJqNmLvUALKLv2XV47Lv7xgIDhBaBipArR70SyYnn9K2WJr/GE25?=
 =?us-ascii?Q?D9N1Zuy51WvutliK2QqjkLx7YgTZPV4SckXzSjtoZCYPq2iGdwiGW960U9Mf?=
 =?us-ascii?Q?9B75gXs2wJQt4pIZcKaTbSX43vclhzqb3aDlmaZQESa2VzO4AfHC1qcrNsmo?=
 =?us-ascii?Q?4uob2Z6iHeHi8gfEkrA37Gg893AjidYs+Aw8rzoj5qa/MQIiAN448BNmBiMm?=
 =?us-ascii?Q?Vjp2eWWujBt/uOP5fw84zHr3j3CRX2ZdN+G3+wmTSQUWHA/rhjb4/TTk7ZiW?=
 =?us-ascii?Q?qfnhHN7UBVa+Y4RTkiLZZK/n50Up9WY3QhO/joLz4utCCldsyZbgw1R8tJQw?=
 =?us-ascii?Q?v9MoscXufpboB7h0D7CDLhdUqcg1S6qh8YfeUx2yCe4shM8tMS0DpTxysSFh?=
 =?us-ascii?Q?4WZsR9bx7iV8+ejkdg2gbiPFt7AOWFaFQx4aHOP7eiwRifq+U34DfNcBMI4J?=
 =?us-ascii?Q?xCKhWXy0AYukSrhkreRJ6vOzVnJu+fxApFxXUbGXOKRlC2w9zV7V2gCjrMxG?=
 =?us-ascii?Q?Mr5saICxQmw2IpJlFe7E9n3TKu0f8k54EaTdNVgFyEJZLq9PTZTNghUzDVt/?=
 =?us-ascii?Q?lF7hOw8yus9v76FXpWDiz9avG7UEjIo0MqDGUTOjKHktLrhvw1HJIIsVUtB9?=
 =?us-ascii?Q?PmWlNbCQJGcQ8UK5t7+v/BQFdADQmOFyJ4RIebmlrbYgmaYEh7tQrILr+756?=
 =?us-ascii?Q?aXcd4irjqDFLFU/1AX7pDanUFVCerB7e+EhGp8iPL3tV5DYH/Bhf0alpepf4?=
 =?us-ascii?Q?hG+zh9HGaZ8/Axp0rlNkaTV8PoF/nTvHvxlhQGoYHEO2UwvdpFJwIE7L/idu?=
 =?us-ascii?Q?F034s+1aZe8cELxxcYRMKuMO8UvTpFL5KbtP3iWroSK3zy3ZNo7Wf+/XgVq1?=
 =?us-ascii?Q?eT4iTNgxhHo8EDIbpmClqWq5VYuecx7rQ6O6mGIb4Mb2qU6EEY6YBS9p5eQl?=
 =?us-ascii?Q?5DGL1WE2mU5cUJ9MB8Iv+GPs+9ZhRhWtZT4kRJcAPcN97yKf6SPdqdtVBq2M?=
 =?us-ascii?Q?9vkRs4g1I/38rm0GsrFrEOFfDxdg/CpWdd1XtxfB2qBBMWfsuNGeV860WpWr?=
 =?us-ascii?Q?seeCsagZn1TTg0TDMkfQVOxOUSP8xqPdt5zjWqn+pV4BPRtdyfXWifVk0x1I?=
 =?us-ascii?Q?Spgfy82c18YbR5zAkdnnY1HCxJVX1ZMyfU63hXzN9tlL9ypWTWunDEIfwBWF?=
 =?us-ascii?Q?j1DlQ6z5qPN7fvj6MEgeO2ifi7Bw1q92KbIuFjkauPQ78OYqOEJKdNv6KiC0?=
 =?us-ascii?Q?2FdNy/2JRUu05IB/XCrvJhKYY4HRrfAmuZ4bFmr5IYMlRSmI7tSUFwHXQJNf?=
 =?us-ascii?Q?56BuJYfDHNY0L9vNL1qyqZBw1KRx/8dfA+eZy+QNtSgypSj8Kw9lnJScnBkQ?=
 =?us-ascii?Q?SMFx13drsjNwsZmcV20HXFE09M6CEPgRYtbd+Ns5TIuEmaRPyWT98ZEBmwJI?=
 =?us-ascii?Q?Z6CbsjNCQDjOQ+a3f2Pm7smAxm1lmBJzizmjQRBOx9xszqko/syH13rP1Ueg?=
 =?us-ascii?Q?ouzeBVhyuPXFCHl4Xp8w7TCxgvtci+0NyBfEM3biUbFsPryK3cvSoAJKauBC?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CECD9F9755BDC94C919BF3799388B8DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335643f7-0c34-4e2f-5793-08dab02c1705
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:41:03.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARh4LMcZt+HwrMD6LLBZydHgW+/J13Y/y4fH8NWlLcH4SwKYpYHcMkOGZ8ORbWwvKZB5XBUzXhIgheSxXjyJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1243
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:20:35PM +0800, John Garry wrote:
> In sas_ata_task_done(), for commands which complete with error we set
> the SATA dev FIS status field with ATA_ERR. In ata_eh_analyze_tf() this
> would be interpreted as a HSM error. Set ATA_DRDY, which will lead libata
> to judge as a device error, which is a safer bet.
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.=
c
> index 61f64d54e67d..78e6046fb55a 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -139,8 +139,8 @@ static void sas_ata_task_done(struct sas_task *task)
>  				qc->flags |=3D ATA_QCFLAG_FAILED;
>  			}
> =20
> -			dev->sata_dev.fis[3] =3D 0x04; /* status err */
> -			dev->sata_dev.fis[2] =3D ATA_ERR;
> +			dev->sata_dev.fis[2] =3D ATA_ERR | ATA_DRDY; /* tf status */
> +			dev->sata_dev.fis[3] =3D ATA_ABORTED; /* tf error */
>  		}
>  	}
> =20
> --=20
> 2.35.3
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
