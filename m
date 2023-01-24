Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32173678D03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjAXAvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAXAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:51:51 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F432E70;
        Mon, 23 Jan 2023 16:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Grgw9chSrCId5Wx+zPGKRF6F0NsfS+7VT+1RgL04sfqXioDO4XAgtmRnlZ7pypmOuO4jX59BpQOrG70TKUZNjv4qBQMBldnvxaUDUVlKBZ1ncUkp4vATp8IV7Sqo92nCVIP7X3Mp6noR8MYAz683sGSpJ+sYRFtxULeROjPaKIhd6OsQAYPO03Kz+CpURTQAnEIu7KWs9+6AFBGrWcVG/FXAMWyhJgCIq1POWsSHrKKtrntUoiUC9Dg/n7FaYznzVfs57C0kp5PO+yjApqqOmO+11NrMSkkmOlzy3etKFT+Py7FijxW0XM/wAgGwOc+HnPTXiVyMt4RWa4iPfv4TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPK6Ft/aJv9LjVTm1anqMLCIJO6+iAAo+nSftw2Ji5U=;
 b=KnXUoEawyNu8yFmyOUb2WrVYfTq0MiUwMi63dGYfcHCZgOUlrX2AyQHg094OnoBdLZEnFKwvzWXvfEioZ+PXRejFb1Bf+2he1Q7xFQcm2ejNnjKo7na6MyRISbRDH4lBYJ5VjQRGNVbZniuwHcnQpb5QIx7ICRGH7jkPRyTvB0oeuIRtz71Cw6SWjBe8KcGTHRn+R17CToHW0zF4b/71MD+HB5DpxhpM1yzwNnGEKk55kuEzWGoXsPPEMHE/Kxth14U4AiMdcOKVnPIINkNhmp+pGkRUtYwh0F1B8S2GDZz1YTGlSP5gkKvEEm0vjafqI77bmZwjbTY+lVLwSAWESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPK6Ft/aJv9LjVTm1anqMLCIJO6+iAAo+nSftw2Ji5U=;
 b=sLLgaUG6owLtHlOwqs3/Pd1yZYcjmDQMP/7TLkpUws4rDZozkBVh+NKUhCb1ptMsAENVi8Mm18uhk4brRs3eJ58ABBeKE+2ienP9jHt6Hi0c+jWOKev52J0L8FMEIb6XNyY8asp+MR9eQrG9Ci1OShh/Of3qfRjxE2Oh8EWwqGNocaK44KYha2Fe6rpuWvr89y4EhSlS79L7grJndFfa/TTRlZweiALiw9Fase+VUlVJKUhtRjlBZYHxaf6b5J5PhNgs0L5Jb+rjnlZnRhxMPmhyqkG9JySe6SGs/K0ohJv4A/2gEIZPxAtVjm2agJZmlILNDWGgB1U9qf7G1+V2bg==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB7695.eurprd08.prod.outlook.com (2603:10a6:20b:520::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:51:48 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 00:51:48 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the gpio-brgl-fixes tree
Thread-Topic: linux-next: build failure after merge of the gpio-brgl-fixes
 tree
Thread-Index: AQHZL43upRfDzR2TUEe4BY7YyxSKeg==
Date:   Tue, 24 Jan 2023 00:51:48 +0000
Message-ID: <AM6PR08MB43769CCE04DA7C624CA3028AFFC99@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|AS8PR08MB7695:EE_
x-ms-office365-filtering-correlation-id: 2fcdae4e-91af-4b86-2139-08dafda52c62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbxd2jvMNEfWUDLLdH2Mk5RHxLsXMzglasUoffv2cAb/2lT8BlFO6LgLGyzYaT/Sl0xaQMaM622HGxLvcajbJWCdsRzRy/m8Cz0zdfQkWK9V/XxK91juGk+vVf1dkhX8JBSMORgNV0NnRBMpcNbJLV46hSkv8Zeic49KZAdC7L2kux34RN3V1wl3rzCR28EzF4Ctnwqi7acoz0WppxARiB3wFsJJ/Xiyp1Iw6VBbpbMcZGciV7OIRI63wsAK0lBvcLlDTckidzzzd+vhZkil7gCXaeb1I2Ht4OsWXjqTfj9xu7Enks8fyXHu9lVd6sQ6xyAYz+vfhSOd2de1Mi0MZ3m/i2Y8uQnxQYM95TiCsZjcfFM7bC5rovu2hXikCfwr+hfdiUKcJYw94PnefJU+lSf/4Hkb7LvAiEiysOVsZ7yt8q537jU5y2jIV4lGxsGzp9iNZO1+8wenqESUGv730HADchRpqPUgubbDQyv6B8eBi4R2F0BPPXOlgeXmglEg87gDEp1J8kdSb/R2nQ7FvJpYaA+td8ab9F06RZs6rhTi8bWA3QHmGTyf7tXnHFnJowhz/E1RR85GOs+Ghc7KMv0vy0WoQzAxZ11BmnLkIseR7McyhFLG1sfVrKZNWpNEw6/lN8akd2bFAtmRE02pAvQXFBeLKVYMsRNTCPuYtotYTdA6djCEba2ZigOo6TYMI2/4D0a7TdeFlIudf7lcVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39840400004)(366004)(136003)(346002)(451199015)(66446008)(110136005)(33656002)(316002)(54906003)(86362001)(5660300002)(2906002)(55016003)(38070700005)(41300700001)(66946007)(76116006)(4326008)(91956017)(64756008)(66556008)(66476007)(52536014)(122000001)(71200400001)(478600001)(6506007)(7696005)(83380400001)(38100700002)(186003)(8676002)(8936002)(9686003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?gh3N8813oWXEvy1dFPH3m5mdSa0+qbwU+DmUU3+kUsVi3fL46XE14KOU?=
 =?Windows-1252?Q?quq0IpTy+Gurt22t0oqZCAxAvzAPRLt9lHdkI5MLCrzTqlh+bHuAyq3b?=
 =?Windows-1252?Q?zxc6V8JqJDDt6QMJvGFDK15wOmr8GP1LY39G+yOxMwz3IsFadapt7O7t?=
 =?Windows-1252?Q?fS7q9lccGmPlIwwIe3U18FhiLcGmfhx1KXJVFlYs9b+yKVUrChaQ4fYw?=
 =?Windows-1252?Q?/Og4JEUvJy7Da+DTtA32WPxCemsu9eCrtOgCmuX8ilgkRqpS5rsx46s/?=
 =?Windows-1252?Q?zZ/cJ1Abgb5wH7iYpt3lWK3AAqgjUyfAj1TxpBSMuo9CpZlizZKNCqtE?=
 =?Windows-1252?Q?vHpt1yA8g9/UDMtY7V1MilLVzOd9YY8C35lxiHzcys1LHRJJcglulLgC?=
 =?Windows-1252?Q?2LmnXrcfmiTiGJXzwgAh+p98j4/GPNrkIxU+ElWtllUL4fhXCw9VFYLw?=
 =?Windows-1252?Q?MOATOy9t2Cck3N8T7IC8ph12RP7n+OvvQokBCUE4enWMvHwb96LmjRlh?=
 =?Windows-1252?Q?x/nGKq1Y+yenE1nNht62CK+Li7nfcRyqx7yiqY7RGUlDICDawIFdiNo9?=
 =?Windows-1252?Q?HmLXuuEnomcACPINKQHytj1MeEmEP7LxXqIzpkZc67atIjwFplvr928f?=
 =?Windows-1252?Q?ovWz0frfBh1FMEZ2oU/4NAmEKnRBofWjKiR2IhCAUsENCXYQTypyp4Gx?=
 =?Windows-1252?Q?SfHB+tcjVPCDnyOk5crWCLr2fl6VhK1NCQJYuLjK1HvFhpdDATohTcg1?=
 =?Windows-1252?Q?tbBgfcMnenTq+daGbIyQAXWTpk6QD5S0m5+tvvb1ZQ5HPgrIsKMknfTJ?=
 =?Windows-1252?Q?4fcXhCQmjEHfa4Pu2fgXwGs3ljVP83fTZb8/vSFB2xxZNPfi3R/Qwy8Q?=
 =?Windows-1252?Q?tI8BucKqXZfrO6U/sXGvmZJ9I+tIMMKs4c5/xqBZU93OV/6Y5VmuAQeW?=
 =?Windows-1252?Q?C4r0Bh/EOXDK5d3wrmCxjP6WWD/oOle/DjcBb/bGlSLdv0U8Cm4PxxDt?=
 =?Windows-1252?Q?aT6Ur3plIF8MSXQICDw1rNzxScxvbAqKN2h1BcmAp7FHSrBO9S3rFMsH?=
 =?Windows-1252?Q?1IASQu1ZGit4tHWS8WluVWP4NaKQVlQ3rO7WnMeerPU90twpZo4gOE6l?=
 =?Windows-1252?Q?M+T4xejsZ2eJBqk3iH1dRnQA8CtxyXylSXZoLsJ5ziWiXotJxjWPsxIE?=
 =?Windows-1252?Q?AiJrw/6ZQOvz8l/eYkr9zQiAOAU94exTW45C+TuFVQJyCFzWXmAF/1dK?=
 =?Windows-1252?Q?dkUM8bKtCmDm1n6kLOowWd3apDmjo5OpcfHFeQaxbnPp7OcJq4INVUVd?=
 =?Windows-1252?Q?mS69UWYfClVw+9DXCqeiwAnTIAYX+roeAajRysvDDAISMbLIuxpfntqb?=
 =?Windows-1252?Q?y2QhJ5YrXhw7VO+edAEd7APghz76BeUZjBB4Ywf20FbSiWyhzfGm0s7d?=
 =?Windows-1252?Q?7ieT/Lg8rW+DPF3SDrJm6nlGQG7+WCiwPzTW8Nc+1exMlQAf4O/mwDvW?=
 =?Windows-1252?Q?nAbD/VkZOnBxLrVUEtYPiwCuA4rvt1TvBoWYDWcnPoDug6cxI/ZhBd60?=
 =?Windows-1252?Q?oyBW+G1bFqkTs9q7Ph4fm+2iImh4wSTNkup8sIxBDP2diHIQhlpZl1Mm?=
 =?Windows-1252?Q?Vnk5vGDU1bLWC2Jvx6Fj5mRxkLf+7+Fm7J6KVb+AKzdng6seBm3CWLp7?=
 =?Windows-1252?Q?v98ohOh3+V8NMtILGvW5Z0iYJ9gL3pmw?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcdae4e-91af-4b86-2139-08dafda52c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 00:51:48.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9Pga4/M6iN2nnQLFf5YHJv38Vml3nc4hehq46Ex8F2WvsjGEmI8Z29egshZjXkhVH5/PqXp/ZlycYXr9BQxoeFvHpRB6BrO+gSqXdcaZRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 21:56, Stephen Rothwell wrote:=0A=
> Hi all,=0A=
>=0A=
> After merging the gpio-brgl-fixes tree, today's linux-next build (powerpc=
=0A=
> ppc64_defconfig) failed like this:=0A=
>=0A=
> In file included from include/linux/of_gpio.h:14,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from drivers/net/phy/mdi=
o_bus.c:27:=0A=
> include/linux/gpio/driver.h:782:68: error: parameter 4 ('lflags') has inc=
omplete type=0A=
> =A0 782 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum =
gpio_lookup_flags lflags,=0A=
> =A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~=0A=
> include/linux/gpio/driver.h:779:33: error: function declaration isn't a p=
rototype [-Werror=3Dstrict-prototypes]=0A=
> =A0 779 | static inline struct gpio_desc *gpiochip_request_own_desc(struc=
t gpio_chip *gc,=0A=
> =A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~=0A=
> cc1: some warnings being treated as errors=0A=
>=0A=
> Caused by commit=0A=
>=0A=
> =A0 de5f701724ac ("gpiolib: fix linker errors when GPIOLIB is disabled")=
=0A=
>=0A=
> I have used the gpio-brgl-fixes tree from next-20210123 for today.=0A=
>=0A=
> --=0A=
> Cheers,=0A=
> Stephen Rothwell=0A=
>=0A=
Hi Stephen,=0A=
please provide detailed build instructions.=0A=
Building with=0A=
- commit id de5f701724ac=0A=
- defconfig arch/powerpc/configs/ppc64_defconfig=0A=
- powerpc64-linux-gnu-gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)=0A=
The build fails almost immediately as follow=0A=
arch/powerpc/kernel/trace/ftrace.c:839:7: error: no previous prototype for =
=91arch_ftrace_match_adjust=92 [-Werror=3Dmissing-prototypes]=0A=
  839 | char *arch_ftrace_match_adjust(char *str, const char *search)=0A=
      |       ^~~~~~~~~~~~~~~~~~~~~~~~=0A=
However, the same happens rolling back de5f701724ac.=0A=
Thanks=0A=
Pier=
