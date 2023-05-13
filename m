Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ECE7015EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjEMJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:53:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC4CE;
        Sat, 13 May 2023 02:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2FLg6iS1nloMNH7FASRYln9kPHQYqEkb+6oKdtwvV+kph0Iy/vC9BQoOpopuJgfu3wfFXiWKuD5uWOXtcb6RjHWwK8k9UboZSt/g7VdvGBFpZrtQb9/ZFlDY+YRw38NdMR/1yI4NnqsV7BDaXJdfH2ciyVIEZKhmK8xrlopgI8hECqNGkROMiy3KhO/FF1fo9srcXoCARPHUGBECUgKSBFTSVe1E6eJerOJ4As2nkjehYxjxn1bgfyi5MfzavlnY73VPfRbXH0S11YbPwZDJvkNxb9b69GckBE7CJJq/bmV/h9OXWBtGBfi1jCSWGqqce1uoWDaFVe/Zl3/5ztDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl22NXZFfZLJ92Kd4fpPLvxW2nstk8AUAXHWnN1yZKo=;
 b=ZrPVq2z0A/xzKZx9zo/TMRtH5Q4qXCxs5Q0Ru4qLBipoubxF8apwXeWYDDlPdMe2HZ41/MmEBJu8aU8u9Hmmp8k15WR/AmsvrEXOHa4dY//dC/Kt4KrDlM2I3Cy3B/SMHromp6botN7eQ7eOO0wL2CLHytGDe+LjCgMK0aFuXEg2mu3IlY7PVwkG7now9DXrDWOcyvpEUS/KizppUKE+TcOyEsWjjeBJxO2oqhKl6MfWdVug+A67EU9k8+iNfrwhc90bGtvFwqZ7INtwJwmY/Clq0nMWI2eVXsz5cpTiy/RELQHxNkQo5XMWvUn2Vl3rJ63IDJD3O8yp893osrk/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl22NXZFfZLJ92Kd4fpPLvxW2nstk8AUAXHWnN1yZKo=;
 b=g8Tyf/5RrHgeFREocpzi5IwFMN7Xb27AqbuQhv7MqPPIT7qdMLPY83j2dZTlH+2BbwfzNSJ9Y7trLAsWA06JUr6Zvl3sZo3wvylvgn2RyNvzeGHTLXUDXM645M2psJRIY+tXkJDm/JSe5hvCNkLGi08BogrWHkTNiruCy8xtwEj+/Zn5SfvthT/iOEFkYs7hdIGAA2OPYj9WIO2zwCe9e/RH2JIQ9BXPsS+QngLE10KLHbSxVHVtWPTdUa/jk5wylzT59/hczm3lsjjzg7PROg/6qXPQVP2ODGbXvl1l308iMdyM32/o3ojWi53ODFSLb38OUIYrnDltzz1YD+vkTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAVPR10MB6813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 09:53:37 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.024; Sat, 13 May 2023
 09:53:36 +0000
Date:   Sat, 13 May 2023 11:53:26 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Wu, Xing Tong (DI FA CTR IPC CN PRC4)" <XingTong.Wu@siemens.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
Message-ID: <20230513115326.0a9f669e@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAMRc=Mdfptr0ZXV=fzBE0T+=vTxhL1tOKxRy+ccFLOqinb0w1A@mail.gmail.com>
References: <20230427152055.18380-1-henning.schild@siemens.com>
        <20230427152055.18380-2-henning.schild@siemens.com>
        <ZEuBMCxeWAx9OilV@76cbfcf04d45>
        <759b2df004e2445e850a01b33e748972@siemens.com>
        <20230428113332.3a7b9a18@md1za8fc.ad001.siemens.net>
        <CAMRc=Mdfptr0ZXV=fzBE0T+=vTxhL1tOKxRy+ccFLOqinb0w1A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAVPR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bad70a-fc61-4c36-fe4c-08db5397ebbe
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq/9eygm8akuKCPMZ59+5cXp7pC6kda/e6N3W2cRFRy9lhxPOrK6kIE/UmYzTaFia+X+uU9i1Fi35PVyBPRU+pDGAsI2v/gPIMw5xJ4+AJUqpeOlIrDConN68WfD0ldhlLPxlJ8uXAj686EHBHiQxmMt80vwwKnoWkSUpDPra6qwM9cZp4/Ac4aZZEavON7EE3m+OSo/dQk5BeDBAOiP+Nt1P2kNszeic/vhKPBIYi0kDIhMBjS/WXYfWvnT/nfi9IQYhDJuF2PmI4mD1kaoa+1ptckAOWaGRY2n8LcBlIhIYfnTFHUqYif8I6wjX51JYHZfspr9MJHpHBDO1osTOM2CNEZEkgjoWegMJaef3eXWIuIqYRVkaiL+n6UPXbosS7tFIPXr8t3VrqEIEyGX63XPXsqnhfjkQAnjqLgEkPUDRtp55P9ORkXTXZHSCSVe+uHNHvTGRS18gejj6bCb7i4x5OavzLC4GC+9crfIAfYU4TqFdWBRTYVzk+lE3H8ZE+L49qgC987Pyv9f9HPmjmBrPSZ5ZU5JtgoRUelVlywcJ4fyptjFenB9H15bNQpK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(82960400001)(66556008)(66476007)(66946007)(38100700002)(44832011)(5660300002)(316002)(6916009)(4326008)(8676002)(86362001)(8936002)(53546011)(2906002)(41300700001)(6486002)(6666004)(54906003)(9686003)(6512007)(6506007)(1076003)(186003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzcwT1BWYmZCV1RGSWJmUjJUSkNUYVdSWFZhTHdjenZ5YVJhczV3SDNlZFI2?=
 =?utf-8?B?VUJUNnFxK0dyakRPdW9jZVl0QWI2Q1VUREpjMzBzWk1LdGVCVXFwbzUyT3Vt?=
 =?utf-8?B?N1h3bjJhdHl4bDFJSHdyUzI2OFJpVVVHWlVFWHkvTmk0ZFZpeE50N29vUFFK?=
 =?utf-8?B?Uk9vd3NLaE9EVVV5RmtUWWdzVHE3c3dpNHlXay9rZ1g0NUNRNlNkVkdPZGh0?=
 =?utf-8?B?ODNmd051NnhmamwwY0dVT1psQmNVVE9MR0c4Q2t1MWxFZFg4S0pJbjBicGl2?=
 =?utf-8?B?ZVdhalRSc09yaWlEb3AyQy9VV0RFdG9Ha1ErWjdSYkNaY1RPVE1ZQnRFZXFl?=
 =?utf-8?B?RFUvWnFFSnRhZHlvZXRaczZqckE0UnhJQThtN1ljc3NRZEhZT2tIbWJmZ1g0?=
 =?utf-8?B?UG5KNkJLNkhaOUVPbi8zZjk4dWZOZWJSZ1AvUE9rMGRqMEdxZDVGSWpMRnp6?=
 =?utf-8?B?Q2lPK095ZWE5dTVRN25vKzZTRXNGTDhEOUpZdk1VWmh5aVJJQWpqRUVVMm00?=
 =?utf-8?B?ZkR5UTFiNmpQRFUyOHBQcW1mdG0xY2czSUdvOWpYeUdRclRUYnF4bFRXK1BV?=
 =?utf-8?B?bmNUTGNOclpOcVZ0dTFSek5jUnlHOGZRY0JCUHJBanJWYW51MzFtczI0dzVs?=
 =?utf-8?B?eEdmaldhaDZaUjFMb1FmUnNWSytHUDQ2R0dkeHBrWVQ4d1YzdWRvTjdTdkF5?=
 =?utf-8?B?cXV3eFFiUVRDMlN6QWxRdFlJTnFRUXpqMDUweWZtSWwvNUxxalF6T0VHS254?=
 =?utf-8?B?enNBbjBsSDhYWlY5TVVWb0R5RDFLaTZKVUZmLzJ2dUt1Tk1XT3VTejZhVXpo?=
 =?utf-8?B?YXVKUDlYMUY4V3lvZ1VHNy9jbWk1bStYT0J2K2NwaWRlWldhdk1DT2ptUGpp?=
 =?utf-8?B?VjZkVHI5TmZVTG05ZXpQcGJUZkE0NG9DMXB3UEw0c2RqaHUrTEdnNDJGYkNT?=
 =?utf-8?B?ZmdVczF0eHdDWFk4eUlsVUFseTk5Z1FhNGJmVnM5VXNZV05qNVFvaWNPWVVp?=
 =?utf-8?B?TjNSa1VNWm1zZ0ppaEw3ODFJZ1R5emY2WmtOL21KM2wxQU8zUGV2amw2a0RJ?=
 =?utf-8?B?c0xFUFo0YWdQeWpEZ1h0SlBZQU43VFFoYW1DY3VDUnhiaUUvdlc5aW82a2FT?=
 =?utf-8?B?ZklpY21vSnJGdUV0dkdPU1NEYS9TVTBxVXRUa0hoSWhPYW1zQlR4S0NhZDQr?=
 =?utf-8?B?a1lXdXc3VEhWK3g2bEFhdFFhSlJtdjJRY0RzR21uZ2ZocGo4Q1JwL0lySGFY?=
 =?utf-8?B?ZGdpMHdpT3o0L0JOQWJVNDRnZ20rTDFlOE1FRnEyTkZpcWVnSmh4SjhDQmg3?=
 =?utf-8?B?dzRPM3E0LzJXTWxMZzhtTHg4TzR2aVNIa2szMUhhSjQzQnovNU5oc0poQU51?=
 =?utf-8?B?TWc4Z213d2YrRy9zTVRTT2hETGpWMWVMZ3lXWFJmQklIbEQ5VEZJa08zc01r?=
 =?utf-8?B?RFVjdFNLVGNkaXhxbDlRTFpFcEhyNXgrWUo2NnZYdDQ5emxZRkgyZ3RMblRp?=
 =?utf-8?B?c29IcmF6T29qcW9HUSs4aWZ1YVN1eisxRzNrbWJOZFZjQXh6bmJhTXVEcUhT?=
 =?utf-8?B?TkI1L25tZFpDRFppYlFOdStiQzBXblhMdDFGMDhJc2l0WHdJMjBPZ2lTZzlm?=
 =?utf-8?B?Z1dtcTA5c05NdFQzZUlqZzJGNUhBdEZuRGVGTTFMaVJ1UnI2VW1GZnIrMWpl?=
 =?utf-8?B?ZmFsNnRqc1VHZFZHOWY0bmtCRG1Yb1lJRjFVdDB2c2R6Ui9PY2VWRVcvS29G?=
 =?utf-8?B?VFNWdzdRMTBWWnNYdWJ3ZEozUmUrRjdHUzFUcUcwaWJaZ0ZnUEJ0emF4SGpC?=
 =?utf-8?B?Y2QxdVM3QzNSdUJhTUJWK1hvazh6N2Q5TWFjTENtYXpDQXpZdURYa1FXWTIr?=
 =?utf-8?B?dGl4QkFrVk1DaDRtckZ3THo3NlVGZmh2LzBrWHpmbUc0ZisyaFU1NUtJSy9P?=
 =?utf-8?B?NXozMUo4RlhtcjZlTGc2ekVZb25wSHVDM2UzYTFVaHBWckd2S1VWeTBLYVRu?=
 =?utf-8?B?MmxEVjh3QlhuUWJsV1ZjZUU3bm55TmhsOTJ1SURQajExbHpkSkVHUHEzSEl1?=
 =?utf-8?B?dkNkR2pkanh1Y084UlFTS3gzenNuTGtIdzFoZ1RhOEtWVk55RWNJbGlteTNF?=
 =?utf-8?B?cUE1RWVqRHpoeC9sR3pOcDlucEhqcEFkQzNzN3NaR1A0VE9JZHhoWUVHWWxP?=
 =?utf-8?B?R0RKQUJaSW5BK2RqK1ZBN05HeGV0OWp0bDB5L1dtUjAwUkRvV2FEK21IZkdh?=
 =?utf-8?B?WElIdDltMnNDTGtmNXJWNEhUdUZ3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bad70a-fc61-4c36-fe4c-08db5397ebbe
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 09:53:36.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpLir44XFXU+lV1Fj0I76D6FFT8aOzMq475ewpgo7vMfc4ZFYXcJ/3Z/k5cBNzCkxmIdFbRKR97ZS7c1dsgrjbEMMUOpPDSQovM3uDYvYXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 11 May 2023 14:52:17 +0200
schrieb Bartosz Golaszewski <brgl@bgdev.pl>:

> On Fri, Apr 28, 2023 at 11:33=E2=80=AFAM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > Am Fri, 28 Apr 2023 10:26:18 +0200
> > schrieb "Wu, Xing Tong (DI FA CTR IPC CN PRC4)"
> > <XingTong.Wu@siemens.com>:
> > =20
> > > Hi all
> > >
> > > The chip id of NCT6116D is 0XD281, you can refer to
> > > NCT6116D_Datasheet_V1_0.pdf, Page 291 =20
> >
> > Thanks Xing Tong. I think we have come to agree that for now
> > NCT6116D 0xD281 will not be supported in the kernel. Maybe until
> > someone has access to that very chip and a use-case.
> >
> > But you managed to somehow get these datasheets, which are still not
> > publicly available. Maybe you can use your contacts at Nuvoton to
> > kindly ask them to publish those specs on their website for future
> > reference. Some specs are there, but not all. That would help
> > people to add more chips and avoid mistakes like they happened to
> > me.
> >
> > Henning
> > =20
>=20
> Henning, do you plan to respin this with the ID corrected?

Bart, no this one fixes the name of the chip i have at hand, and fixes
the size of its last bank. So it is valid on its own and should IMHO be
merged as is.

Since i do not have a NCT6116D (0xD281) i could basically just guess
(not too hard) but not test. And i do not really feel like contributing
untested code for which there is no known user/tester.

Henning

> Bart

