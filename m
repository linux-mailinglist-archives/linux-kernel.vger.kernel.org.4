Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B05FD821
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJMLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJMLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:09:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011B112A81;
        Thu, 13 Oct 2022 04:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW+ZcPfyQbj1iEAEdsDpBaimtoEWIRsVeDqLp880VjdI+hn1hv5o4MKSr4BQLgHknTzWBxSosOGS4TvQaeFesR1PrQKjk1E16AxBSpuHoQjVhGeRnpAKmTZ64tCcAhIjtoQ2ZBGUxiLDqgDTsiduh4BSRIZ2UUVtb6Ugye0HVkcGIVO0ApJTahYlCJ78ccINqalRsOQVmaXXEvPy/wngAxJqatZT2jCqlrvum4DJCecoDGqTsmwCPW3Rq6Mp+G4QtrkdwDq3v+42/DUvlmMsx+tjZxjVwZm7mQttY4y7FYvsToizXzuPFosm8ELoyTERoCgtAVPAAjzRYsOGvMC0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn0nJYnoCsS0SnY2tE/76j7xuF4dngzsBQrQsZxZr1A=;
 b=Z+QOgJk063FEHrfhY0X31t3BQPR4yuMtmH4aXoumzvv8emrBVStmW8f3z2fr65rpwwjwQVzHIKbFOGiwReg6XM25hIi3HA4kT+Jvu6B312v5HStSMktY/YGqDxxXxOhdRxvzWuv29mA/s3q8XZO2slL6Ur7FYei2g9fa2DeW2WECpUmPZN9Nj1bSfZjJ4uFlyYs3N4u8OMwss0kouJnkN7lgB5DokQb/d9pwuKJD16SVXXgLMtiVysJsp+adyHvPEQxqq1Nkk2/5pUtto+87mS12y7E/P2tbI5P+/MCD/wges9BL/zsLfFWOepVSt5rRFiR6DMcvMqdvJVdO936TGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn0nJYnoCsS0SnY2tE/76j7xuF4dngzsBQrQsZxZr1A=;
 b=xWUa3Byot/wet8h57Gk567fykS9SA+tporB2fYH5X5SaUtB6UgFQOvpLYRjX4LeO06Fr91ipjB5MBmChUWBC3cUnZq6z6B+6khhDuyp95Xrk4DltmGHUghdJDzfm/fd6VFdlZqwThv3xw9mGrwVBbdQLUnYpX1pFwenUBGg+RPsONrup+e4w1aeGsTaNYh5K4ZGHDPTxEwexgh/nQRW/HbOyPiknqTaWgHgjsQQVKbRH+a4+a8mXbx/OveOynfCdV6HZXYCZmC0/nn6zX7RMAE+tFowl62tSdRXDB2QXqrIObAWmshIlxYoQmri/Q9kdOspDrGpirrddoKecVAlaIQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 11:09:02 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e38:b6e0:190f:415]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e38:b6e0:190f:415%7]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 11:09:02 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tty: n_gsm: make n_gsm line number configurable
Thread-Topic: [PATCH 1/1] tty: n_gsm: make n_gsm line number configurable
Thread-Index: AQHY3gbMspwb9KtWkkmd04dUQP7m5a4MLFeA
Date:   Thu, 13 Oct 2022 11:09:02 +0000
Message-ID: <DB9PR10MB58818736388F209396CEA749E0259@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20221012061715.4823-1-daniel.starke@siemens.com>
 <Y0Zjqxl/MAivtf02@kroah.com>
In-Reply-To: <Y0Zjqxl/MAivtf02@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-13T11:09:00Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=e50b5d0c-24f7-4a4c-b0d8-2e6d20e0f0da;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DU0PR10MB5217:EE_
x-ms-office365-filtering-correlation-id: 10f211f7-da4a-49ae-07ea-08daad0b5639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb0OivOJkmeFYlVQKFE7AfG07Dil0Wt81Ndv4kog1NHg+O0ufIQoik+ZENaFso5A5Uq7bHxXsCHVWvnMN+Fgd3nn6kn6UDc3r14PT7RkJblGxmEAHXAWRzwtbMja/tKwkCXNy8r2CqabJqWN2tPWAm2dX+pes40HUYHz+fCmJuUXjijWdruBmDAMiddcX/c5+fD2xqp/6m+uN+wFRSqwGbHeDZknyAGvRgiAx19TILATji35qcSc3YKOoydbRb8sRB+0UmKt7EnpY0t9JMBwTQIj0v5FN/nrKk3jgN28Q/7OOi8ZtGiyZJyf87GSr8Y71r55TQYb4FqoYm9EvjkG9YOhlLNNOS+w84OrRl+t/fETCPrnmrhmqfzUqiEWDLupcR5ZMBwy4TAAuLwHLxo+IdlsE4hEl5tqH1QNRYqkQOEUFJ7CukEAkXsGpCh9erEkcnvbTT1KuYX2x3ehY8Bq88fRyfYNi+evwu1qkEcvTKsLrO2Dh/U3lO+Pv1MbxN76no1UKdJfes8fcZhuv53JQ5g7vZHFfdEBnnF9LRFy4tVt0Qsm8q8hYWyYnirbo1McQWQTw/9nEskHkhwSrLJ1xVQukGrrzv/RZQJZZBnrs63J0AYFm/mQhYVNInc76uGrGPeGF8IIGDEmsJVu3v6SSJKlDzec6Iy1Qj5J8SgaUQl9ThXbK7wcru2O8EOHr2pK9RZKwoag4ZlEH4P8t7GmdPfPNOdq88uvlobxabaP2t/qKJUuFPLmc6+DAB5CbwIW9Nmfizt8HA6zJZKefYx4PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(26005)(4326008)(83380400001)(54906003)(86362001)(41300700001)(38100700002)(6916009)(7696005)(8676002)(6506007)(64756008)(76116006)(66446008)(66476007)(66946007)(66556008)(2906002)(82960400001)(5660300002)(33656002)(52536014)(9686003)(8936002)(186003)(55016003)(316002)(71200400001)(478600001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X6SMSOPqf7rnJiZGjD/EMkQKMnbAPaNtdliyfJJXbmdj5BIC5o1ytb1XyizH?=
 =?us-ascii?Q?b2uzHL1ZeCXPd8xc5AiYcCSvmVIzQ80WUuN9Ogb0mSE+gApAss6t0cAoHenk?=
 =?us-ascii?Q?2olOg487BOc1ARFRwM1LvDPCb7W9MZVhuDpNLhPWFMYYOghpGzXTHfg+l26c?=
 =?us-ascii?Q?g99iaiSJMiVD5GVoRWv7REAvJH9m8lkHy3y6est+vE60DJtk20w7sYn2nw8Q?=
 =?us-ascii?Q?0gaHI4DpTCr8UaNI2z7q8SyRf48CWOlt6r40Di+B8w5fwLF0QroIk2ErdX2A?=
 =?us-ascii?Q?mXWXS3cJl/yLm49+KuV6zyktkcQ3ECQqqZ175kNwUlc5+Bocb1LpuWYC6BVQ?=
 =?us-ascii?Q?HCbmuBPUIOHtXBJo2vNndIiPAPMeuyMPkgl6cBL+sbDzugTd1WSxE1wVQ/xz?=
 =?us-ascii?Q?t+WRXahIsvCNeRZe8ELekQZgox+dXBtJswVxzjoAMwcmFvb0kG57Xckego2O?=
 =?us-ascii?Q?nALxug+ER1aOhSGbRwEcJmkXWYibMsVv9QM4WXzywM+FS6EX1QBNSUkGCXpz?=
 =?us-ascii?Q?jQqBJBDd3L+piDTCDnyO6xbSWVhOTY2S2b9Kv/thsRRV25RI9KVhLLJ2IzNq?=
 =?us-ascii?Q?9YdgS2HHWRyv8d6lrNfX2Xvv7gtHGP1BLbyfhoZpxcszmD3V4/kxfc44VDT6?=
 =?us-ascii?Q?I9PWcBAg4GNgoNGMfvv50MugUCD8PSOa+7UtxdUWkYUJr6+S8Jh7xsKPZDGX?=
 =?us-ascii?Q?od163hZPym8MwSHtbikiaxTx0TQmGSrgTM1WH4qmC//UJPfLOrF08yAnEgZ4?=
 =?us-ascii?Q?J8ODjFcDohMZuEqNsr+UAJCH+l8wTFCsmvJSm4r0kou/8ul6J0Z+ZISGTvDZ?=
 =?us-ascii?Q?ov/jMkqds5dT70RfgycmDMZz08vasE/AXhvVO+zjhU9gqOA+mXnY8XT51HHF?=
 =?us-ascii?Q?xGFLR6c1BKwy06JYHyQDHEgFoFDXmEjIz+5uvL9vaRzNqlKQOiLq9hitM7UO?=
 =?us-ascii?Q?Gk2g+GktcnbBVlmPBrV2QtvFpzrtBcS444xDansndCbxUSslRelsjmrf/N/b?=
 =?us-ascii?Q?xBgEUmOyPePNjwcjL4iHTDbd3xveZZBIka6/IhSCMwxCcgadg8WBWDc44Ili?=
 =?us-ascii?Q?HkRIm9fzGeni0LGpvgbVGTs1BHiutFe72y2iYtooDr1BJUI0de87+DABTEaD?=
 =?us-ascii?Q?VX5ngFEZcQ75QleQCFQLZtcKaQ0/D+dubq4YmNpm2I0wOJSmPXMf84ZXxWTQ?=
 =?us-ascii?Q?nO0mQnIcdX2L2p1iiSkZ3Co6HiOtPEW3zzxWzTqj7B1GN0S+vNKs8w8Vfd86?=
 =?us-ascii?Q?XUOpljzu7VfuW2MO6CkwnOsEnu3VIX3jLtfsyU0Jb32colAXu3osNMp1Ip9t?=
 =?us-ascii?Q?Pbvn3e4mxJdWqCABHowlLcCYb3WTPbL4SMuZ+3k1P32UKg1l4BGyyEQH/ANx?=
 =?us-ascii?Q?VIixkyAIH7rj5wrY/0rfE1seyeHs56ohr5+icFJBNtoJ09rD5d1ZZbr9nNJU?=
 =?us-ascii?Q?G6wbHNGM2ldL33cka+jSnuSsU+YHIfWuUHcxH+7ZqTNirMVfW5IHftnMve3U?=
 =?us-ascii?Q?OW5H0BWwFsiTeeWzeKQFlCFBmkPbuLxPnEp0fliBEx7RWhp1oolwbkzlSkpZ?=
 =?us-ascii?Q?qOuTkiBjV9Dinzxccc+ZycklysHdkgQdF7enswHg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f211f7-da4a-49ae-07ea-08daad0b5639
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 11:09:02.8701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soU4Xa/RPXI5RNOAc3PiYeNoDibknXeZ0WIWAtkZSnWRRRGddMmXd2cv1uYPi9xJiZVM3Ke86Qo+I2KBW1oUptqsC268yIfIrw/D2TLeY48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currently, the n_gsm line number and its derived virtual ttys are=20
> > assigned in the order of allocations with no means to change this.
>=20
> Which is fine, why do you need this to be changed?  What relies on specif=
ic
> line numbers in userspace that can not handle things correctly with the
> normal userspace tools we have for this type of thing?
>=20
> > Introduce additional ioctl parameters numValid and num to configure=20
> > the line number to allow predictable virtual tty allocation and numberi=
ng.
> > Especially when using multiple n_gsm instances at the same time.
>=20
> Ick, please no.  That should never be needed, the kernel number and name
> can be anything random (and people have suggested that we do make them
> random at times).  Don't hard-code numbers in your userspace tools, that
> is just wrong.

Thank you for your feedback and review. I understand your points.
Please discard this patch.

> > --- a/include/uapi/linux/gsmmux.h
> > +++ b/include/uapi/linux/gsmmux.h
> > @@ -19,7 +19,9 @@ struct gsm_config
> >  	unsigned int mtu;
> >  	unsigned int k;
> >  	unsigned int i;
> > -	unsigned int unused[8];		/* Padding for expansion without
> > +	unsigned short numValid;
> > +	unsigned short num;
>=20
> This would never work anyway (hint "short" is not a valid uapi data
> type...)

I am surprised about this as gsm_netconfig already uses unsigned short.

Best regards,
Daniel Starke
