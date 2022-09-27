Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472285ECA60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiI0RCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiI0RCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:02:15 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 10:02:12 PDT
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E09DCEBB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1664298132; x=1695834132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EgSzBqc/InVVj9kWIufZe2LxJbLa3ZofMcsaR4i9s2k=;
  b=WUrUz95dLBnuUffLObrpl+3hNGPofvTFflpGaJKLi4SSStSTVWtD6/C6
   Pb+QxyAnQiSUE5IPkBgNvlzCEnphasF27lgXb531fZuHuehlUqRHIH3dW
   dn19D+VAB0LCALKjEyIgdp4VK4EW8Nre8w8ZQWIh9JGham+IgO8OvlvxS
   w=;
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZB+ri7ef1scHAfPAM4b3MSjepP0BEoxuRprIqQMOsX5Kx2oUF2pMQR5v8mTf6OrhuL3SgAvDn9UyCqgCIQjz+a730LloKP2S8tZhOFbTQp5lWFbJar8/NK5/KGhQARFZHTuBVYDjqlkTHvsUc7JGsi5w0SRqgxTb0aCfeVMLN9Q7v1SedErcB/xVSpnd4UVWG7w4EQUx8ODz29N42P2JVGeDys449Zf1pfoxZNTodjXChLKYlqYRt4kcFkUWyX7srDUMOB6iyi98DoZXxCSn5qzvGqQnJnrkYO7MsB8NXGF+LvYMf7hhewusMM5n2d/zzCRvfU9T3oecd3le6QrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgFPxMNZ1W9FcwENtl7Wf/+X2AyJxUIq7vubH7QhvIM=;
 b=Dk1Iwz+jfnSbsyiZoDeQ9EzdU5Jprx//O3/qIBsLiuuPEPS0UmbrpjCsI8nlFAon01jK4wZ3nt/AM24qio2UVJLuF17e32lJr/aVX3+HSP4jxydCORIthIm5j4amC1Gts7hMfszbbhUP94A9DQeNK5VVu81UxWKtl0tMuwHKFV+4gqEZ+z5nWvzs2h4bQAy1b4KdG9+QRJfsobZH9YZ+7EB6xkg31gBF+wRbR0746Kh/UxK/tz8y6UebaQuFy02Pjn0mdFrIguoCMYKZf531hMj2HdBZxfa/ggh3MTy7lQLgRMz/kI6UBEsRH/oTaQEyyUry7oO4+41urTmOg/Thlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgFPxMNZ1W9FcwENtl7Wf/+X2AyJxUIq7vubH7QhvIM=;
 b=HQa6uiN6nE2TQtJVOP0oYxU3WPlnpigXjeX9oSJkw/VZnN/t53XmycBKUXyLZ2zGl4wJSin/ZSx+isbxrumoX75uGgspSCE1p6FjdbFjFM9GnbDN2D+D1HwTgC7Za8qt8Dvakg2OIO5lxiJyUEdKE/U0u2/bFrpf4UdTxkGNKm4=
Received: from DM4PR20MB5061.namprd20.prod.outlook.com (2603:10b6:8:88::22) by
 PH7PR20MB5444.namprd20.prod.outlook.com (2603:10b6:510:204::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Tue, 27 Sep 2022 16:59:00 +0000
Received: from DM4PR20MB5061.namprd20.prod.outlook.com
 ([fe80::b57:5079:91d4:895d]) by DM4PR20MB5061.namprd20.prod.outlook.com
 ([fe80::b57:5079:91d4:895d%6]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 16:59:00 +0000
From:   Arie van der Hoeven <arie.vanderhoeven@seagate.com>
To:     Rory Chen <rory.c.chen@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
CC:     Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jqgAzCDACACvKxAIAVNerrgACKJICAAAiMhYAeOIMH
Date:   Tue, 27 Sep 2022 16:59:00 +0000
Message-ID: <DM4PR20MB506103C0D91FD65A0424B663F1559@DM4PR20MB5061.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
 <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
 <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <D21B6E4C-F190-4B53-88A7-4650020DB6A5@linaro.org>
 <SJ0PR20MB4409997FB0529DF0B2FA153CA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
In-Reply-To: <SJ0PR20MB4409997FB0529DF0B2FA153CA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
Accept-Language: en-US, en-001
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-09-27T16:58:59.598Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR20MB5061:EE_|PH7PR20MB5444:EE_
x-ms-office365-filtering-correlation-id: 81d94833-b726-43ff-2513-08daa0a99327
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWJySk7KMZk9mjyWJEIvJCmQ0kmlgjACf5VDCeK1iF6Qml1ER9tKgSjKa1YwjjIFzLf3h/3Q9eV493q9fW0VNRnxb2Xj9l5SVxvTzfJVmtkMto2+cbQmZT2aO5IzvBtCxZ8UJFOyj9xeEgIM6r0mw7waooPaCw2kmnjGwaozBBnFNu7fkA1kAkfbu9QS4LoewJIlFg6HS/CRgYKqX1UOE+KrthW66ajx+wIYLOmYo1igBM5xi8hF2nnoUqfuz5u4tKUZLZebIbLdw3LcO1D6EfeuVxGA8gNWeyZ8TwpDssaGTwC/RK2uTWyj/VRut3P8BfTUNABNuPp3+ilzDQv3iQ0EPRFcchyZJv3+1/vMTx2ph6kF4ZB8JW9j8V/d2Mg7v9EwYJKedICTHi6ckXNNBtm93rYklQWkeCiZRtW+Ddh0j1FujT+Y7A5y0zk+3VeJPpxuR1x/tXOyxyzsFOeWWrQ17rl9d/8PgxNSSpnKhS8AX3l3RfCSX6kJ+fPaDxiTaS9oJozeEL7tgpbZFKgFI6Y22s0i5TY1PYDVMd++tXdqDx0khsJA0rQXg/zbLQTy5Eqk4KPqNgXHJdXj/WOyxa9yItibuRmY0RvkItxRlEEZd6RWyj+4UFCrRe45en9xhqT4ZAQMgvWQBEg4SqaA5K7BZh3r6fZ87HLcMFddVQo8pEXr56+1fpf3OOjgCkLhNfcrPMxUYtMhi/q6ahrdlAXTUpJ986dWmn1HjnSLEAs0c23ZY3qPfxUtBBFeNdQH6ugDls/aek0W04iIP4/aZI50DjeYh0ebT/CDb6vwSKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR20MB5061.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(5660300002)(53546011)(52536014)(86362001)(91956017)(8936002)(66946007)(76116006)(4326008)(26005)(41300700001)(2906002)(30864003)(6506007)(54906003)(110136005)(55016003)(71200400001)(316002)(186003)(966005)(9686003)(33656002)(478600001)(7696005)(122000001)(83380400001)(38070700005)(38100700002)(66446008)(64756008)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0HOfekjZj7ULzCPJ8nyAnqzfIUqz9BgngoKuqqDOv3VIXC4Y8+vER2Yleu?=
 =?iso-8859-1?Q?fe3BW5nysLX6rsUSKl+DEKrNZh04gexHOlL3zhh9MTPIs2wCHeAK+pj+AX?=
 =?iso-8859-1?Q?48mY3vUoGP7X5tjRn1ajRROn2cVnwNHOlieD+5A/xyVS9vbbr/ep5/aohS?=
 =?iso-8859-1?Q?y9GbTbT1+nOr326UvrMuPLaNZdga0S6OChujEZCGet3Zz+wcVav9n7Vmp8?=
 =?iso-8859-1?Q?jsBioYFIO/ChNUZqlIzBa2/KaH0H7rFAtq2hJKK4UUoimL2rQpFcdQLD2r?=
 =?iso-8859-1?Q?4N9uirpyLWvk1Uw0eRsGWgkxP6XvdY+k0RwtG2hy8GV7HJJaObK+t5OlMD?=
 =?iso-8859-1?Q?av0wQPEl/3njjTVhZA+f2cm9HtnCYbTjlAd0yGlMTXp1DMAYHHKx9QztZL?=
 =?iso-8859-1?Q?XLhTnuZp0OPXZC73a1EKQJcQ8usAd1spI0/7l4A5a53QypeGiZ1KKScB7t?=
 =?iso-8859-1?Q?SnMWfCeBjMvb0lemye0nzYZ3hqc0CNIDkJoQjNjn+e/J7hqCtJCeYyaU6u?=
 =?iso-8859-1?Q?DoXezL490nQlQ4hNeOQ3urGWQ3gXbT9cNgcuZ2cuGQan+alclaot0yTl/B?=
 =?iso-8859-1?Q?q8VzV4W7wZhQgLWJk7VG8beZIEnhXMibQLEL1CCt8Kj4AS3iUrBPjZtI9U?=
 =?iso-8859-1?Q?OyAVott2NpkjDQf+RyZNigh9ghh9qeEP6DsGDN9O7I+4/VmEXmK3g/TrMO?=
 =?iso-8859-1?Q?ldzSK5bv8ituofjBQR3ar42gsF7l45B6pLzALyW/yyRy/c6wCef/sbFvSD?=
 =?iso-8859-1?Q?4UdAQ+n6+3CjDmjHJqvKFDDp1IJ9xo1FSRHe0NwqcMvjyeJANJ03DUtH7l?=
 =?iso-8859-1?Q?Xg5Sshry5I4sFQhMu/ekpWP4MqJoAqsV+IGH0loNaCEk3kkPYzXsjlW4v9?=
 =?iso-8859-1?Q?EL5vbEnNt6jMKnRorKIxy3kdDYc2s4BOhNh4CTCWwOe+kFeKPkj31hmNE8?=
 =?iso-8859-1?Q?gUEeLOK+LZg/Bati4myAg7afKC7820k5ZhX+ntJQjrN85QOFxVptlKfVEG?=
 =?iso-8859-1?Q?lgrYkNxypNj9mqXT0BDQx7husEtww5USAundq0jqUX2XCmmfHwBXr9Wez5?=
 =?iso-8859-1?Q?ioUHGJgv199QRQ0CF4di81N0TdG0e1b9xANi6+5xjqvoV7VJOH1BrA/KeJ?=
 =?iso-8859-1?Q?7p5LKkhrBtyYWefAqtMeekXRBaR/DlMHwuDlJbQERCRa4sIVMbuUM/hxer?=
 =?iso-8859-1?Q?zIhWAHfbibqy1NzHg8RAjzJR/mKZGostJR90o+BSGzUKDUN8puM4zkZ9is?=
 =?iso-8859-1?Q?FuFL9bZVqWvXy1KNzRNdR5WwSWy21Z32QPnuDHhRu81MHoCeEwViOIjjzY?=
 =?iso-8859-1?Q?9ARXeC2ROjGnhPLoFQhQ4WjrGseS6Hgd0wfweSKpx5ApO31qSWVWj3AGgh?=
 =?iso-8859-1?Q?h3pB7a8mwKEB9R+1pUeUP86p7obeMhEmiEKSsQ4a9R/r8QaT8IYgHos6Z3?=
 =?iso-8859-1?Q?nV9WyIfbFAFYC3yNh0rAOO63ehnWLq3RTf2FA06s2X3AoMf1Qcm/eyG5pH?=
 =?iso-8859-1?Q?VWjCWwmonBLtC6mpmc7pLMr5g3NFyylaf3UhDA4qyO6Lrsxfqs28o8DMYI?=
 =?iso-8859-1?Q?sGhC1jEOJc1Quzk/8YVUM2Ghr/Lxu6p3xaqqzpMjQ3f7Pe/n/3Ed9CD2wa?=
 =?iso-8859-1?Q?S/O3+JqEGNppLgLVL6r+TbPSZVU4xgaIeuDwEpjEvFIN1MEEIgcyBm6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR20MB5061.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d94833-b726-43ff-2513-08daa0a99327
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 16:59:00.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6fXFbJyAmovx/JVvG6ZIbHpvp/D78qsGHCUpkSCChR+nqcVNxNr3SumRkt7dsemuaXgk1zHeEBSW2aKFU0zdOg6JwYqoHLp2BYQXYo9z6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5444
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chiming in as we have customers who are having very good results with these=
 BFQ patches and are planning to pilot NAS solutions in early 2023. This bu=
g is not a blocker for us, but we do need the BFQ patches included in Linux=
 6.0.

Rory can you submit your changes or is it the maintainer's responsibility?

Regards,  --Arie


From: Rory Chen <rory.c.chen@seagate.com>
Sent: Thursday, September 8, 2022 4:34 AM
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Tyler Erickson <tyler.erickson@seagate.com>; Arie van der Hoeven <arie.=
vanderhoeven@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; lin=
ux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.r=
ighi@canonical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <g=
len.valante@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English=
 <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varu=
n Boddu <varunreddy.boddu@seagate.com>; Damien Le Moal <damien.lemoal@wdc.c=
om>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


Oops, I attach wrong code change. Here's the right change made by me.

<               if (end >=3D iar->sector + 1 && end < iar->sector + iar->nr=
_sectors + 1)  //Changed code
>               if (end >=3D iar->sector && end < iar->sector + iar->nr_sec=
tors) // Original code

Unfortunately, the crash is still existing and I can't find any clue from /=
var/log/messages



From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, September 8, 2022 6:54 PM
To: Rory Chen <rory.c.chen@seagate.com>
Cc: Tyler Erickson <tyler.erickson@seagate.com>; Arie van der Hoeven <arie.=
vanderhoeven@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; lin=
ux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.r=
ighi@canonical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <g=
len.valante@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English=
 <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varu=
n Boddu <varunreddy.boddu@seagate.com>; Damien Le Moal <damien.lemoal@wdc.c=
om>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


> Il giorno 8 set 2022, alle ore 04:46, Rory Chen <rory.c.chen@seagate.com>=
 ha scritto:
>
> I change the comparison condition and it can eliminate the warning.

Yep. The crash you reported also goes away?

> <               if (end >=3D iar->sector + 1 && end < iar->sector + iar->=
nr_sectors + 1)
>>              if (end >=3D iar->sector && end < iar->sector + iar->nr_sec=
tors)
>
> I don't know if this change is appropriate

Unfortunately your change conflicts with the standard code, taken from
the original patches on access ranges [1].  I've CCed Damien, the
author of this patch series.

[1] https://secure-web.cisco.com/12uvPqOwOjHJPiVGM6hJ7791jpWxxy8My3bFD1oA0p=
Nh9m0W778f8IM7HPxjRUL8-94N0gKahHwtK-sEv1Tgk2Oo4H9GTAlLoml_uWF6BGktvDAlDp-zd=
NQUzCL7y1OCz_MJMaNlS5h0iwsE3q9m7tJsCFUWW0YEgcJE6LRTrZDQpFJhG3pGCLFgoPIuKa3o=
8B136dJoQvEtek7ZOQFKqesuZKbu4lvM4ds0HOLs5TIgJR_mSJ8UmhP5_M3a1CaDxdDzQ784H3E=
ydkRN9a6v9-Oogo-wYUqS8fRq35rUyw1t2IblmgJzr6aoGazZsJHxBXPjpxA9DSEQqUtH7oT5RG=
M4qxLpEmYjgyzpJUZqhUCSXye7-lCTIQIB-SGzRuZDVbIqK5tZd3F_YK9LcAN0iVH_qfBM4zRe_=
4w4h5ikJdhc/https%3A%2F%2Flwn.net%2Fml%2Flinux-block%2F20210909023545.11016=
72-2-damien.lemoal%40wdc.com%2F

Thanks,
Paolo

> but  bio_end_sector deducting 1 said by Tyler seems to make sense.
>
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, August 25, 2022 10:45 PM
> To: Tyler Erickson <tyler.erickson@seagate.com>
> Cc: Rory Chen <rory.c.chen@seagate.com>; Arie van der Hoeven <arie.vander=
hoeven@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; linux-blo=
ck@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.kernel.=
org <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.righi@c=
anonical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <glen.va=
lante@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English <mich=
ael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varun Bodd=
u <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=
 drives
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
> Hi
>
>> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson <tyler.erickson@se=
agate.com> ha scritto:
>>
>> The libata layer is reporting correctly after the changes I submitted.
>>
>> The drive reports the actuator ranges as a starting LBA and a count of L=
BAs for the range.
>> If the code reading the reported values simply does startingLBA + range,=
 this is an incorrect ending LBA for that actuator. This is because LBAs ar=
e zero indexed and this simple addition is not taking that into account.
>> The proper way to get the endingLBA is startingLBA + range - 1 to get th=
e last LBA value for where to issue a final IO read/write to account for LB=
A values starting at zero rather than one.
>>
>> Here is an example from the output in SeaChest/openSeaChest:
>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>
>> Range#     #Elements            Lowest LBA          # of LBAs
>>  0            1                                               0         =
  17578328064
>>  1            1                         17578328064           1757832806=
4
>>
>> If using the incorrect formula to get the final LBA for actuator 0, you =
would get 17578328064, but this is the starting LBA reported by the drive f=
or actuator 1.
>> So to be consistent for all ranges, the final LBA for a given actuator s=
hould be calculated as starting LBA + range - 1.
>>
>
> Ok
>
>> I had reached out to Seagate's T10 and T13 representatives for clarifica=
tion and verification and this is most likely what is causing the error is =
a missing - 1 somewhere after getting the information reported by the devic=
e. They agreed that the reporting from the drive and the SCSI to ATA transl=
ation is correct.
>>
>> I'm not sure where this is being read and calculated, but it is not an e=
rror in the low-level libata or sd level of the kernel. It may be in bfq, o=
r it may be in some other place after the sd layer.
>
> This apparent mistake is in the macro bio_end_sector (defined in
> include/linux/bio.h), which seems to be translated as sector+size.
> Jens, can you shed a light on this point?
>
> Thanks,
> Paolo
>
>> I know there were some additions to read this and report it up the stack=
, but I did not think those were wrong as they seemed to pass the drive rep=
orted information up the stack.
>>
>> Tyler Erickson
>> Seagate Technology
>>
>>
>> Seagate Internal
>>
>> -----Original Message-----
>> From: Rory Chen <rory.c.chen@seagate.com>
>> Sent: Wednesday, August 10, 2022 6:59 AM
>> To: Paolo Valente <paolo.valente@linaro.org>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad =
<muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org; linux-kernel@vge=
r.kernel.org; Jan Kara <jack@suse.cz>; andrea.righi@canonical.com; glen.val=
ante@linaro.org; axboe@kernel.dk; Tyler Erickson <tyler.erickson@seagate.co=
m>; Michael English <michael.english@seagate.com>; Andrew Ring <andrew.ring=
@seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuato=
r drives
>>
>> The block trace shows the start sector is 35156656120 and transfer lengt=
h is 8 sectors, which is within the max LBA 35156656127 of drive. And this =
IO is completed successfully from the slice of parsed block trace though re=
porting the warning message.
>> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>> 8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>>
>> It may need to know where calculate "bio_end_sector" value as 3515665612=
8. I have patched libata and sd driver for Dual Actuator.
>>
>>
>>
>> From: Paolo Valente <paolo.valente@linaro.org>
>> Sent: Wednesday, August 10, 2022 6:22 PM
>> To: Rory Chen <rory.c.chen@seagate.com>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad =
<muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org <linux-block@vger=
.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; =
Jan Kara <jack@suse.cz>; andrea.righi@canonical.com <andrea.righi@canonical=
.com>; glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk <=
axboe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael Engl=
ish <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; V=
arun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuato=
r drives
>>
>>
>> This message has originated from an External Source. Please use proper j=
udgment and caution when opening attachments, clicking links, or responding=
 to this email.
>>
>>
>>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <rory.c.chen@seagate.co=
m> ha scritto:
>>>
>>> Resend the mail as plain text because previous mail with rich text
>>> makes some mess and forget to add others at Seagate who worked on
>>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>>
>>> Hi Paolo,
>>>
>>
>> Hi
>>
>>> I am from Seagate China and face a problem when I'm evaluating the bfq =
patches. Could you please check?
>>> Thanks
>>>
>>> Issue statement
>>> When running performance test on bfq patch, I observed warning message =
"bfq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hu=
ng suddenly after some hours.
>>> The warning message is reported from function bfq_actuator_index which =
determines IO request is in which index of actuators.  The bio_end_sector i=
s 35156656128 but the max LBA for the drive is 35156656127 so it's beyond t=
he LBA range.
>>
>> Yep, this sanity check fails if the end sector of a new IO does not belo=
ng to any sector range.
>>
>>> I captured the block trace and didn't found request LBA 35156656128 ins=
tead only found max request LBA 35156656127.
>>
>> Maybe in the trace you see only start sectors?  The failed check si perf=
ormed on end sectors instead.
>>
>> At any rate, there seems to be an off-by-one error in the value(s) store=
d in the sector field(s) of the blk_independent_access_range data structure=
.
>>
>> I guess we may need some help/feedback from people competent on this stu=
ff.
>>
>>> I'm not sure if this warning message is related to later OS hung.
>>>
>>
>> Not easy to say.  At any rate, we can try with a development version of =
bfq.  It can help us detect the possible cause of this hang.  But let's see=
 where we get with this sector error first.
>>
>> Thank you for testing this extended version of bfq, Paolo
>>
>>>
>>> Problem environment
>>> Kernel base is 5.18.9
>>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges
>>> VPD page:
>>> LBA range number:0
>>> number of storage elements:1
>>> starting LBA:0x0
>>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number of
>>> storage elements:1 starting LBA:0x417c00000 number of LBAs:0x417c00000
>>> [17578328064]
>>>
>>>
>>>
>>>
>>>
>>> From: Paolo Valente <paolo.valente@linaro.org>
>>> Sent: Thursday, June 23, 2022 8:53 AM
>>> To: Jens Axboe <axboe@kernel.dk>
>>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;
>>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
>>> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com
>>> <andrea.righi@canonical.com>; glen.valante@linaro.org
>>> <glen.valante@linaro.org>; Arie van der Hoeven
>>> <arie.vanderhoeven@seagate.com>; Paolo Valente
>>> <paolo.valente@linaro.org>
>>> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
>>> drives
>>>
>>>
>>> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or respondin=
g to this email.
>>>
>>>
>>> Hi,
>>> this patch series extends BFQ so as to optimize I/O dispatch to
>>> multi-actuator drives. In particular, this extension addresses the
>>> following issue. Multi-actuator drives appear as a single device to
>>> the I/O subsystem [1].  Yet they address commands to different
>>> actuators internally, as a function of Logical Block Addressing
>>> (LBAs). A given sector is reachable by only one of the actuators. For
>>> example, Seagate's Serial Advanced Technology Attachment (SATA)
>>> version contains two actuators and maps the lower half of the SATA LBA
>>> space to the lower actuator and the upper half to the upper actuator.
>>>
>>> Evidently, to fully utilize actuators, no actuator must be left idle
>>> or underutilized while there is pending I/O for it. To reach this
>>> goal, the block layer must somehow control the load of each actuator
>>> individually. This series enriches BFQ with such a per-actuator
>>> control, as a first step. Then it also adds a simple mechanism for
>>> guaranteeing that actuators with pending I/O are never left idle.
>>>
>>> See [1] for a more detailed overview of the problem and of the
>>> solutions implemented in this patch series. There you will also find
>>> some preliminary performance results.
>>>
>>> Thanks,
>>> Paolo
>>>
>>> [1]
>>> https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
>>> rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
>>> iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
>>> NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
>>> Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
>>> a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
>>> DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
>>> %2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
>>> -optimizations-for-multi-actuator-sata-hard-drives%2F
>>>
>>> Davide Zini (3):
>>> block, bfq: split also async bfq_queues on a per-actuator basis
>>> block, bfq: inject I/O to underutilized actuators  block, bfq: balance
>>> I/O injection among underutilized actuators
>>>
>>> Federico Gavioli (1):
>>> block, bfq: retrieve independent access ranges from request queue
>>>
>>> Paolo Valente (4):
>>> block, bfq: split sync bfq_queues on a per-actuator basis  block,
>>> bfq: forbid stable merging of queues associated with different
>>>  actuators
>>> block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:
>>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>>
>>> block/bfq-cgroup.c  |  97 +++++----
>>> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
>>> block/bfq-iosched.h | 149 ++++++++++----
>>> block/bfq-wf2q.c    |   2 +-
>>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>>
>>> --
>>> 2.20.1
>>>
>>>
>>> Seagate Internal
>>>
>>> Seagate Internal
>>
>> Seagate Internal
>
> Seagate Internal


Seagate Internal

Seagate Internal
