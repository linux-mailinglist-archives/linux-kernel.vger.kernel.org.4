Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E346137ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiJaN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJaN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:26:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD771FADD;
        Mon, 31 Oct 2022 06:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mique9jWrQFr4jC0jvk9+u+TEAWrKOmJjQX5b+oWM1H5urNF58YkPbZUawj4wirzvVC7bXU9PN/+8oY81NClx2s0Q24H9vg/InZLNwLDvBUwmFgfQM/3z9CegXvdSCbHrqZbWGmDa+i0lDEuDJ7Vw5e1Hg4oW4QzSleX35R8GhV0Z0sHT5He/3Svem9hixINAkDaRaN5j4qjLM4NAPAHbOQoo9+royug0qaJUnCmqN6OL6whI0kFHF/itLyDY+FuJ2ReSa4y0KN7geSYDLvMB3gOh9bQFPUhFOwzvihftKTm4NFmccymEakeA7TtLS5FSCCqB9BaI84QY310Azf06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcnMCqyg18VXaAAYw7mPj/UZcQ8A+UQvbyBmbdNCbWM=;
 b=d1+ueDRyV5y2A3IsEpte34MfDz0v9jWbeQUu5gUP2GXkf7y89TVX0kzQ0FyAEss/oZSjl8d3nmBzMB2oILXjIpdr5C4vAsshKxybuupBeNJcXAgMBpWOd+FrVRrKczbKk6kIpjGouaGJh9RM7ZA89XIm7OxF+3Lhr500haPspdtHfOX9nHgnzIADEU2bf2i2dSDNQSNmQcCcLlIIaNbQeN0XATLicxjtf0nW6+JdEF9aJN3flC3FnJ+BSTClgSWrTrPWdQdCzq6FXKV3Dr06K05YSkhDvNzNBFEBQ0x12kVYMXiqN0dahtG3+HnzIXADJ7dguaB2STJtx41MEm+D0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcnMCqyg18VXaAAYw7mPj/UZcQ8A+UQvbyBmbdNCbWM=;
 b=btB79p95vlLe1ju6xZoBrNSrhhQv1cabVWGSa0No1yjh6tfnzEvCz8Daq6MI/NKCyuj4WaYvc+FMO8jIX0nibylEIWPXwUbEA+UA0vyUP+BX3PAM9vpVEHM4j5kq4+h8ZZ1X/fmafa2cxM+WMBUHODWwzM6ia+tQh8pjNWQQ7FGyPDunRT+4VHNriONE12udkktD7cJxpV9d/X48lRHV3IVxaBtG2fjvjhOLKNP7cRiQZmVibAgDTAvRtSdXos/CjUuyFG5XpEqCYKkP5iFhuXKc0CbI8agRMqVs41F+r1eLFXQEMBhba6CWp5DekCyKVjPb7DemZ0kBzwxGIIfEAQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DU0PR10MB6979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 13:26:50 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d685:1677:f545:a5a5]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d685:1677:f545:a5a5%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 13:26:50 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Topic: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Index: AQHY6Gn4fI/RQHsoj0KTBIsRrsLIca4oiAhQ
Date:   Mon, 31 Oct 2022 13:26:50 +0000
Message-ID: <DB9PR10MB5881479C5BE3D2A97A7D354CE0379@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20221024130114.2070-1-daniel.starke@siemens.com>
 <20221024130114.2070-3-daniel.starke@siemens.com>
 <Y1fQ3G1W8PUIrod9@kroah.com>
In-Reply-To: <Y1fQ3G1W8PUIrod9@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-31T13:26:49Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=50c699f6-c3bf-44a9-9663-a272665285d5;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DU0PR10MB6979:EE_
x-ms-office365-filtering-correlation-id: d350be0e-dafb-4aae-367e-08dabb4391a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0x4P29DZCaCNqu6ptxLhwWRWyQ13+VAau5/ZGoc4tbOV2AjcWeL8hq5UvsEFmG0ixGdpcNC8TlwP1l0SYZ+B1uRDmMARcMu4chrLMVhpxi6alJBgPkm92VOGcG84mgwu+y82/NRwwsq1Q1NzH1QdwmUlDOPYK2vSF1oZx7zcfYb7wfINK+A1NdZmI9fk9DQ2qjG8bbBjfRGzJy/qN6tdTcdEkGKJ6WaPf8Z5twmjeWIFrO7TNN2PDeIYgKfDkQiXzMHLqDVBGBhtX3YFAAyQWmDhiVTzr7txV+hiw7G0/j3KekzpJJH8A5mT8QGAoO9CpHYwqjdxC/KVLehC9qvwFPrZae1xC9R9EAk31HvnhGqXdzql7Ei+riQlAolQjIdoJw7ko4SskIraXH3j8dfeEN+wOcX6gfsa92shhquz8Q1owhQ1JMIIZZXxMqFZccBHaVJ5gKZRvmEnXI00xgnTraWRekMEjMx7eL3VV/VLqQJCoc59X/N794WWYycOPVcn+G3B+axO2oX3ICoUpWYdxp7Y2koBjHoysU3aECfp5c0w6dxmWuOX1XZS71VPAnmC2rlj8D+/Yl7YzvJiYvLSk551bJKU69suMckoEo1kl9ZFoaAaDirfQhr5ltftPEqYZrYG1C8ObVvtNspUJrNoebx/6UHmpFYtjDCvNZrU5IGPmB8zkig1blJjQvzV5VkeiXliPqT77U+K7EhEr1b08y2g3pTPl2cJuLtlqHh2FuzE7ai4JBd8t3HWsRuEIvwsGWKjsS0qw2H5t7PTzcP0vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(122000001)(6916009)(5660300002)(66556008)(2906002)(66476007)(66946007)(76116006)(66446008)(54906003)(4326008)(316002)(186003)(64756008)(33656002)(82960400001)(71200400001)(55016003)(8936002)(38100700002)(41300700001)(52536014)(6506007)(26005)(7696005)(9686003)(8676002)(38070700005)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7mMQ63Wu6walVYPS6HEC0BTqQBGidXG3LLgynEMaOtv07Z8qzOwdX3GLoFP?=
 =?us-ascii?Q?uv47wvXq0FQvmKRIctf90KexIpaYFZCUKrd8uqXfHl+SdBt+iioIIAZ+3l5H?=
 =?us-ascii?Q?NvzBoKOtQ2q+7xFoK8Ofk/vFCm3gX2v4S/ZtBJWYgmj7xgln0bdcp8rMpd5p?=
 =?us-ascii?Q?5KofhXz5SGNurO/252b+SNPxFjUBYy9P+eTbN/oVWsgUaFA/N4+5reXHXaKq?=
 =?us-ascii?Q?KN9yMUYnI5LpUfBUo/+fSneDP4Rl+m5rfgmYWoSolqNaTCI9IrJ9uOsIh9ip?=
 =?us-ascii?Q?CftxGci7PDxtVqiPdch3Y5ened0MeDgpsQZ/OFp77q/LU1DdzpRZ5vjzHoRX?=
 =?us-ascii?Q?HVKL1IDId96FHMara2UyK2z2iK9v0GtSU27ZHFO+0n6zmaNm49rkw93kIc8y?=
 =?us-ascii?Q?N5kjLizFfccWz5dwnJxoEOK0vzlTsbBsYRIcvUugCWsDJ24udAZSOJA6hBzs?=
 =?us-ascii?Q?ab1WZQHOkGi3oAgJO5v/0UTvDHmHAhdcemyK5V26iTgMQ5ESXkCb3wrhE8XO?=
 =?us-ascii?Q?E1nRR21qzHqRW+p5qFkrg5WXaOdm948dZPYyjpjfW8j7fbFqAMgP4Gu+Jt3B?=
 =?us-ascii?Q?6HdptfXomFA8PUklmmmqZ38JIMNy7uSBtAdbDOPuftVbZ4nJZT5j54JNdWAB?=
 =?us-ascii?Q?n9CfUvYs89dS71+Mesc/fGWjlqeDy+U939CBafzbYEydS5dAZm4x1hZ7LwLw?=
 =?us-ascii?Q?FIMjAUBqnGIvMXBWu4m2UlAKjGsDRW2BOloubsv9WlU2j0ZWW2SZjkJRsoQi?=
 =?us-ascii?Q?dmvVXPS6QM8OhJEpHPo/ccm5Kl9LgiMG8R8DxbOx9V7rhfj2Xng2ohpM+9Lf?=
 =?us-ascii?Q?K6ZeR8nRrgq6GAL8QOWToiJRTBImzSAQ3CvNALGmfJJcDJUhAoPnBuqOMKjN?=
 =?us-ascii?Q?S0SshPdirbDHomiN+jB58Km+zJUFggBKbCcg07AxceSCw3IOfA3Qk6rwa6CL?=
 =?us-ascii?Q?LKcAEXjz1un+YZw+jH6FYoxwusBqI7tEYdzg7UQ4ZWLs+3vFCTfeq8njxhZh?=
 =?us-ascii?Q?i2bETcE7PRIhI+5bNoEC+yB5OPXU6DIxMBOuVAZSliAR9hrrLKsJZRJJh160?=
 =?us-ascii?Q?jl4gAJwu3jt+o/b/K3K8QMiGDB7W25UC5imNRgQqvAkSaFoFFiguj+VR37X8?=
 =?us-ascii?Q?Br7tQg0o1KxaZssfUOYEpZCp7NYks4z0Co8KIRcT6eVK2qOOlgQ+Qw/vPq33?=
 =?us-ascii?Q?hp+S2/2twXYglvPrTlGrU7fuK8m961+OZ9o0P9yC6qERmVD0UxIykqdnYD5O?=
 =?us-ascii?Q?HqZxH4Ks+uvrnbFa8Ug+QhtKDRh9bSgjS5Chxo5ZfpRApu7XW3FippylHYZE?=
 =?us-ascii?Q?tBU3uTGTCRKIpwO9P9jc4auwt09RKl+5PtlqxmzoowNBijbRNO7YEamIW/QS?=
 =?us-ascii?Q?eNT0yWNOJxDUlUiYIZHn3RuOX2nDgjqedgAg3x03xZPA5iuMc9zVjhoAsoE0?=
 =?us-ascii?Q?JJbuACOle5KctbqWEmWQpq/xlngovO1lmOcvUGmwaBtJVSX5/QVrcjMVETEz?=
 =?us-ascii?Q?IOmQVqAEL30NWbAWbumx3Nqn5Slk1usBaGM0+zpzeN5P1W1z+EveIt0TCfpI?=
 =?us-ascii?Q?V+YqF1yrd3HXHAD536smOWCT71nYT5PcRZTScc8nxQHxgVxcH890mHxjU8td?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d350be0e-dafb-4aae-367e-08dabb4391a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 13:26:50.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzTRyBlmbF9VpIq4NcuDbnlThzgE474OP6BLGNV41imnskTuWLoFJgnkjfBiGkXDnPq+3/P4EpszULZzsCE8ZLN3/4heu2aaeXLE5+wtVqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your review.

> > +		pr_err("%s: unsupported frame type %d\n", __func__,
> > +		       dlci->ftype);
>
> This needs to be dev_err(), right?

There is no place within this driver that uses dev_*() at the moment except
for the timeout function of the network stack (gsm_mux_net_tx_timeout()).
I do not mind either way, but I would prefer a consistent variant within
this driver. Therefore, I suggest switching from pr_*() to dev_*() in a
separate patch.

> And why is it not just dev_dbg()/

I used pr_err() instead of pr_dbg() due to the fact that this mismatch will
most likely make it impossible to use the n_gsm driver with the connected
device as it stands. I am okay to replace it with pr_info() though.

> > +		pr_err("%s: unsupported adaption %d\n", __func__,
> > +		       dlci->adaption);
>
> Again, dev_dbg()?
>
> Do not yet userspace, or external devices, spam kernel logs with
> messages.

These are related to the user API. Therefore, I do not mind changing these
to debug level.

> > +	if (n1 < MIN_MTU) {
> > +		if (debug & DBG_ERRORS)
>
> Please use the proper debug code in the kernel, don't roll your own.

Again, I am only reusing what is already there in the driver. To avoid
segmentation I suggest cleaning this up in a future patch.

> > +			pr_info("%s N1 out of range in PN\n", __func__);
>
> This should be dev_dbg().

Same as above. The connected device appears to be incompatible with the
based standard. It will most likely not work. Should it be debug level,
nevertheless?

> And never use __func__ in a dev_dbg() call, it's there automatically.

I could not find a hint that __func__ is included in dev_dbg(). What is
included is the subsystem name and the device name but not the function
name within the driver according to include/linux/dev_printk.h. Other
device drivers like usb/dwc2/core.c also include __func__ here. But it
appears to be possible to automate this by re-defining dev_fmt().

Please let me know if you prefer me to segment the current printk-related
code by introducing dev_*() or keep this change open for a later patch.

Best regards,
Daniel Starke
