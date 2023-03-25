Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84466C9109
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCYVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjCYVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:41:50 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E097AB0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 14:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/q3BIpMwexgTKI6eZtESNcMtgluI1/Yi0PtuAXWw1xcjcX/hff7FTL7zXxSar9Xf6ELYcGnOaMUMqKMgEjtELQwfVP7LrjcPz11jcs9bfkrGj67dPmUGD83Q/HX6Q76N97JXiLZLhLieXA++gJT07bYJrHy9C5ak3pE1ccBGKfVVVwN7VyzNx5MqkFsIW0yvRCHHcgK24GaSQdyouHJLUtmz9duaE0r4Dfzy7dI88m6yyzUllHzTDVn/Bcxj7cy+w37To9Ahkrkoo5d4GeBrkevTNGnLaBTE3lXM2O0i8RYUZxtXWfPR7yAhHLdzcTgR5+4S56ZIDa8sOw26igEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4HaF7B7+ULDcoVyRanbuTHY4gw1ZCEBuIFB2sRyG6o=;
 b=By8UwrXaHsP0XVHaVvjuL7980k6Cmc5DcIdYqeYz+iqfX3Lvex4oX/TOfqo+Pu0HHQ+bhynBDWMT53EWFw+eEEzwoGmNfl8BpW0MytKBLY5rXvDtlxFPwinE25yqPOIoTRogT/CNy1QGGoU+6QaO+1K/e+U97zeiLW44f6r5AQfXEHvxy4Z0cy+O0TI2LA/LSG+ba2IgRIkm7kf8uznMy5+aP0gU4bRW3E5IKm0RebPNcJjweH/gE5hyLHrLaNAkFvW1aEVZHUASMAE1pkdt/11MGDdznxR4QtMq8z9OFZKnqogNl2wDxXgadlfUESEdGnqpKT3BIIyQGNpy6gz46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4HaF7B7+ULDcoVyRanbuTHY4gw1ZCEBuIFB2sRyG6o=;
 b=E+ef02Upng0hYzt4NeQTT6fpJc0eL7lprQUEAauqb1FoFGdHy8Ej9fKFveUuSX4Ec31OcYA7b05j9mfE9eO71H3KlJNBHSHdW4ftKoRr9p18S6reGJoooSSAjJ7abavXQTMODmyv0u5D2GMinc6sdyniQLTIKv0c2JHzU2sk9fc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1339.namprd21.prod.outlook.com (2603:10b6:5:175::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9; Sat, 25 Mar
 2023 21:41:44 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6254.011; Sat, 25 Mar 2023
 21:41:44 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZX0LHO2PHn+vxM06Zq9wT8JNfLK8MBmbA
Date:   Sat, 25 Mar 2023 21:41:44 +0000
Message-ID: <SA1PR21MB13355611D3DFA0D0884A443EBF859@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=190081f0-97fd-42c6-be4b-a473ad2c071b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-25T21:40:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1339:EE_
x-ms-office365-filtering-correlation-id: 7602d2c4-65ea-4e0a-05e6-08db2d79ba2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0t9ngR6mPaXRIaUcp0tkyyuAGQBx/s+OEtbl3jrL6aXzmCWBnK/m7ZMu2Yz/zeizjtg3fCmzIbwT57rqC3zbnvgHirF9u3A93qQKYip2J3oP0MpbwDSp9W0aIFas4n2zTatxMg7UFDJDzFRqGYkDAuV4wlK3zeAWc2VHe/SfW13uKv+y+UkJFfIQauAnXWodl8mKCgsPy+26Hpn4xhmffeuAavYudwYp2zDw1WOxbrfpPDe8N37nkDIIjqrzSgNffls6sJsmxQFb0FGRgGeiNgn6PKdBqksUB5oYuVf/N4EatwhFEuTH+xQd1xHNszBA7DutAusgAD7tXbLaZuI3XxTgtDLq7GaYEk9qRDardR6o8CII3sUG1NQfMfDMuioyJPz15J24h8W8k31c7CoQdo5wOIiXsWXtVmVhax92Ag0qhE5keIc9wLYsm2Zv2sdwf+o1SdrZBosEp8mLQMDRCzwKWOelB2ws9L0SuoYs1WhtrzexGqTONbj5MKX7BJP4o4P4hoV1TgQUKd01h0+au2D40ExEXJgC5/2VDOWXZuBCjCkklPUIW/UqCbXbU8r5VvWsKF0mERkesgLu2CHuNNtDNbwuDJogR3P8aqcUPAtQJKg9FeOR9dlkB2Hq1IS0OxBbE0oBKgBfmadVLeI8ykPLG7oioOrnyKv/1T9yVto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(5660300002)(122000001)(76116006)(26005)(2906002)(38100700002)(82960400001)(6506007)(316002)(186003)(9686003)(41300700001)(8936002)(8990500004)(558084003)(52536014)(64756008)(86362001)(55016003)(33656002)(8676002)(110136005)(66556008)(66476007)(38070700005)(10290500003)(82950400001)(66446008)(478600001)(71200400001)(66946007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZxnZfndoGjdQxS3b+liuDL2MUpZ53J6ow6tBwGCyvrzCuar2x8S87ewL5ym1?=
 =?us-ascii?Q?m49oESn5y58Y+UPc58AlqoBPE0K5MSusa8wDiLE9yTN5LeqtUdyMpARfmhxQ?=
 =?us-ascii?Q?rpwz8oD4vGDHc0AJnvDQ/LpLCZjJEZmka9pUNCKMCzif8H96a/tw1JREm8QZ?=
 =?us-ascii?Q?b9JV/pACRbZPJXu+Ge5gW8fNzwpdOYynCv2mhObwuTnKUKTrnjhDcfvLhVys?=
 =?us-ascii?Q?whynFGOWTJMDijCMES3pdK7wNwfeKk/fKKA1hJ6kn0DYMgbUxpjGw5xnw1qG?=
 =?us-ascii?Q?M24MkulceMYPTm45zrZHRPEUnIZ5dgFWDwS9YqH0hVSckUxiHBm+y3YMfaEi?=
 =?us-ascii?Q?r7FDnkIrk7DQ8LBqVthONvibVabkq/kUIXCbz6zHMZewq6lx4av3mRnz3WXG?=
 =?us-ascii?Q?xAwYFJHm3T5IbIjYJGfiyrooHdYzm4PqPVByVKECzsQa1zQW1AXWTU/ilPc8?=
 =?us-ascii?Q?gQXGTRPK0S/CQK5sBsCfCS3lqvSnguYPZ/ij+UArZRBueOTBX0LuWBFtUNl0?=
 =?us-ascii?Q?L0K0YzuAl8u2CSL+JPUW8VfH9I098Drl/7b3ur1RD6cE+94Ae8CD/EEusnT3?=
 =?us-ascii?Q?8/kJGlvMBVdL7AmTE9rPa/q3whAq6gXRuSa6wYJ0njao6eessHk2hIFuGout?=
 =?us-ascii?Q?MC8ZgUoRJNnWOxT/NOL6yNkSMJElyDE0kfzgfjErEkW68oOW/L9qd0BGWHiD?=
 =?us-ascii?Q?U1DPJWVAufltv6GqDHKjye2VQr7XEUtPwpOn/q1J34y5ps8x5wL03/KxGlp/?=
 =?us-ascii?Q?iWKZUrny+gJDBfzBKhZMqsZjueL875S/bzqrpzQe3X8DmwmtfwqgmOj7MuAQ?=
 =?us-ascii?Q?FknLxcOhCjWy8kHTV0AjV9Mn0wj0b3wc8Up3gR4NLKOm5nux/0rkcyMWEPXx?=
 =?us-ascii?Q?hJWQpjNRbcjV3+mOy0LXjgFLpfu/4NGGH2n6CL5+rEwmJdTg/JeQ/qgmsPmw?=
 =?us-ascii?Q?DTLxdK1Fdw39utQZCEMbMyf3JVNEAwOTK3FERggoab8dawW5SRg9EdJmWL2C?=
 =?us-ascii?Q?QPkYcyEAV6qi2BDKwJNrArfOqQLT2FfilFB1CUaDLngOi6rj412NWzOEoU1J?=
 =?us-ascii?Q?WTe514FZ3KU7wFdtwX41otF1G98M183jdDBQ1qYDNeOfULDCIm505CYvBOQA?=
 =?us-ascii?Q?WnByEJSERBZU6S55ScGF5HfXaHrBbuKftyuWPqYssX23/1BhF1ylLMwrVo5t?=
 =?us-ascii?Q?1bbPg93ASKGYhUCm/o+JuMMea08eIRrrsrRn63mlGhqhkN5ZRNoYbefiaDYo?=
 =?us-ascii?Q?6YOjIR7GaAMQs3rHIiGr/g6Y580OfL2mVWZKIaPF/1MtDwnUiLJls3eZtRFz?=
 =?us-ascii?Q?F0YoVtoBayHRHSJFHKR3324yFJkCn/lIN3YUQokVfqZ4BGU4R4s3aLX7zA3j?=
 =?us-ascii?Q?LVjEFeU0hOhr9RQEHiYwUBDWfbONyV2sEdwjWHhWy4tmZFhLrr7dABOo362F?=
 =?us-ascii?Q?X32zp3B5UlWGPsTZDzelLVXUqiayFWN1VuK8BfIprgVjXV7E+sKb2d5CvWvM?=
 =?us-ascii?Q?12E1/JR+axQ84c/XHej2ym9JoeYMFzta62EdoXol+wxMJmMpPevzGcFugAMJ?=
 =?us-ascii?Q?lBt2SRNSF8NLOApKuZMPhgC4+3520Cjo8I2fGI9a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7602d2c4-65ea-4e0a-05e6-08db2d79ba2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 21:41:44.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfiE2UJSjsVZTZaQIPMkDktHVUSUs3OZdRSOUK5FfPk3bcsczuYb/2KRlOgUDL/k4BDkTuhldfv+GbrvJ56Iwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1339
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Saturday, March 25, 2023 10:53 AM

LGTM

Reviewed-by: Dexuan Cui <decui@microsoft.com>
