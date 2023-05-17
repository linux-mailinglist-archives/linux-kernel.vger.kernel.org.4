Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885B2705F15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjEQFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjEQFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:07:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E7213B;
        Tue, 16 May 2023 22:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf7ve7qQrDc26BZs3f1Y++zZJlVgH2nA6YosDQQed8Kb973mC5BHWNVmb+g6MnbA7HYoRrMTvoBJuSVpRCdd1Fqgb+TpvMTR4rLQYxUNRtolWOq4P0FbXPZh7cUwaw89pPZEXHlG9A2lev4Yw5S6M2FFbgcJl7vHWNvO879bZjYqNbMRDNLqfbp98A/9t+E3Nn0G6GF6rTeM4mFBeP2CuSqGyjmnmRTKMhNrxzix3JDwUNjLShONzXMb3ufqJlKMCDXtqv/P4uC9tqCf0Wn+BYAFmAV6kTgLv7ARIeVjgjU3NaozYllYJiD60XJob5Ni8mcTGWyUUlEbL3qNohm/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5HMPtyJmg2C814FpwUDmhWGPTy8ZH7Dy6NvZCT9fck=;
 b=bW+cl/UdNIxlt/IeWqcEu/gryFvKp2LCagVk3E8axw9Puddbko9pqLmn4YrUtnxOQku/Z76vajFmgrx6Ot0lkI5gICw1s0stCaHK+xkJEyBAdIup2YoxUpXBu02lVwnqcUh7S8EmoPvkl5FlfbRDBnuSQ3rySArVCPHLO0qmhVTcPMa/uqBnaMfQGnB0QsvLDNgd85Glbn+AT1Tc3W5P+Ngxj6/LPQy3oStCIXuxR6v62/gJG8akz9fImKdJyDEJRXF1RKBM7FNUPXwnOqZkboNVlFP13w05F3WLO5pl3+KXqVCeuz5OIbLiL14RNFrcosfIPTqRh/PTuQzlqBXF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5HMPtyJmg2C814FpwUDmhWGPTy8ZH7Dy6NvZCT9fck=;
 b=IrQKzSLJF7VRnk+icdgv/XmdaMk7+Me84vCAquQEHNfH1zfVa+K7wZBz7mP17B54qaZ/dlT36yX4WC9K57ufxM+5+0yMX97VyNOid/aqmsF600l898uuISw98Bk9RhLt9ray9y8EDJJZ7P/f1SVIYsWDwqFCAaDC3Dd0NnZja5pGNH81hj73cvjTMFG6x9F+uDBTloRZ//8f+cXcu0YUveLgokagYxzmZW4hUnXcJ8hDYlT7b3zQKCQFCseHCrvH4bdxoJ9J05kQW13+Bhbp0COSJx54XLvk3tWTuIMBj3rIUROrmrCDHX9n4lt80YeXr98LPUHdcKjQdu/4wGe+Wg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BLAPR20MB3794.namprd20.prod.outlook.com (2603:10b6:208:334::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 05:07:12 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 05:07:12 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 17 May 2023 13:08:26 +0800
Message-ID: <IA1PR20MB4953E20DD5DAAF77B55F6DF1BB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4950f67bf989a7f5eba462c44d6bdbffb34485d1.camel@maquefel.me>
References: <4950f67bf989a7f5eba462c44d6bdbffb34485d1.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NsW+Wh7ivfkiRe/bmELBw+/CkRhc9Oo5VKJ4yMTe93U=]
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517050826.931323-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BLAPR20MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 019cb21c-7b04-46e2-e281-08db569492c2
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3mlyp2+JOGVZPNsiRYtPAhIheQ4054tzPZLT0fBLIVVdtTjDlbHAypeeGocA5eiXQ6u43hn/nf5OJR7+/qZBGese3OOyZ6yy1d1F0tm624S4u5L/hl1TlYAdOIDDO/CGNG7DvdhmrEHvhpCgPe5qyeXCS2/TMrgJk2pnXepWiNXaI6dvUaxRJfVCL54oovzSF5zksjDtVwWl4tfnaYzz/YY8f+Lsx+UHFExcTm+A0MwlruPRMDHNA96zdyacHAgT6Fdoxo0JDb+CZYE0gTcvERIfTpxBwoBVPdLl7XdHaaKkn+wxIVt2PP8HKa+XtX+y8breaOsMNjeiJcBanYGJ7Rsh7C/2BhEVq3GRHPVX8SjEd99ZeqUOGWnBhowTuUT6ct4uzx0DZ2S2OzY+3eMTr2puLXLWe/IQs5+h9BbVZWVytlhP3Nb7nq4oGmiPCWFaMahyU+6yBdk16Z/Zx+EAdqV3+Ca6PWpkczn0ICLo2XntrktrWLEo5NwrSIop1PgdjDtpFk3cs7NUToT+MZ3k+doN5uymer1J5XE4fWtbVa285FgUvDNIWdxTZ6gfPRtgAT8cqONPe0dPqy32OPl6NXbDfcWBKoWidm5FB5wZo4VcYbyZqUhjx5zVByIcQ2uV37mEskwanFQnaJGcHuMMQsq3tBKfokFWCsC4qDDu9RSw1sTS4PMLaHrHU612FMGjwQXulpA0GKUyUxBK8yqDYsu7DTX7PnGrd4lr+tYZ4qfU4tK3VSiQJii97N4iX7RsRjArAGwvsA2jqP3KXGUFCui
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMS43T98lBJIODUz2XdQZuY7ALD519NCBY6bsJFYSG1uEYd5rT5RVviYTqX6R3wjnhET2YFvP8LnQS2P/OqVEFCFPYKzC4SlfMsnxtNKtFrJhD17eFUSjjHO4t+AerOvsBbOOQ654N3nx+9dMVjHoDmKAj6gE2EUyynsApnvIfZTutxFyYfO7tvm8tY/ry5QyilBPvItXshrjVJtWbCamh0lt8KMb1CUiD081u6TEJ0qNm5C3KM07lFRom3itSKa/+hp6ykcvyym/7gjWzKT+8utMxxZMgA/NxtKeCYPvsCUIWct7wic0TY0JXGN1Isla8wU4cp8dpbr/YASROQnRadOHriJCq+MiV7qRy3PTLV0G9LY3h2BR4SYZLgu9yMCXNnwBE4bVMkb+gwFtW/F3gaYaKzOGeMRKi/Wh0UxOoRYap/p9XG1Hpx+zn5oY8F1SW5BXuXRzj04g4o1hgEmTaAkNWezBKsNXrLhC/OTXoxWYNW9RRpsGD/Ua3ClYdMzW0XvHO7irxdd2JsWa1NSMyz9X3J4Vc6bhdiarEhaYqvCEf7NB8fo465lCqT7adY8qSjKVS4/Aq8VfHwYJfaCPM945rV06V6+iTgLPT3gO2sP4TbG6m7V0u5TtEEkuBnEPAi0siZFOkFCmVaQUHCfzA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPbV8li0eN8LfdMiCRjd5z7B2sXLnGFiM2Rn/yMShk33h8MjeEahLwSGV49U?=
 =?us-ascii?Q?CGr706LRELUcGGaC2TB7kwAXaTsLsptnarHNhxsveDsGuY/fw4UZjfRqfvla?=
 =?us-ascii?Q?1vvg/rzPtHo1YSsihWuXx0RXvBLRY7tWyJtSIea1sBCIaLx3aScwp7GOQCDe?=
 =?us-ascii?Q?3ugRx6EaN1j0tLvrTrRjw3kHPPwvW1JOJFDMc1870+APwy1Ifq4w/KexTSuK?=
 =?us-ascii?Q?UYCUvvAf8THDnW0DnF8xj8pMfSJNeT+iuLuHjgLTc0sbCjdsxyljBLKSBEP+?=
 =?us-ascii?Q?PIRidXsayxMl5IZCzf82InbQFxcJ+0u1elPsZC9js6re818UsMek6V7+nklx?=
 =?us-ascii?Q?lNBwftK6QcHH35jJQQRpquBx72iFkqENu6FZ2dznboShzbDs8vIlw45Bdml6?=
 =?us-ascii?Q?FUYDXxsI8yOimCIxrZIO+1FAYx2rMpUWEvHW9wzBfl9vQe+4cy7d48Mo+Ggb?=
 =?us-ascii?Q?+zDf7R9ycDbsI4ij0wU3n++qQvuM/+Y7nsagzzy807xaX29Y3g5VFyxceVb1?=
 =?us-ascii?Q?f9XKyZyZUGucOzYtfYdpqWbnlsla7I8KtowcmXxicelsedmnFZdRIzNCYELh?=
 =?us-ascii?Q?p3XIQ59y9xWmy8reYYC/Dg19H47Qxf3RkPF0UnVaZsNPh6jzUJmDXy6kJocF?=
 =?us-ascii?Q?bV3xxbKaT1br/rcDNrhgMzqOXCZc1pIZZSfmcjvzak900X9lRnyDi+N6ne0O?=
 =?us-ascii?Q?+f+S0OIENkST3CN+UccHOe7Y3of//SxfpfgVLRRq2I1T9MXe21V7pScFT/qX?=
 =?us-ascii?Q?dYaZowkOwuzFbbA20Dpc1ee8kmuKjgSa7vmrr6rIiZL+2cIqTjwnwi46Uzin?=
 =?us-ascii?Q?zLk+8HMpqIJ7csBAFkcF4LrWcA+DYUHHnzx8KvMyyUTvMgphIcDAsMR0t0UH?=
 =?us-ascii?Q?59rvQisDiVpwD6aKM/AMA5l5y1MAABRQICzym0O0Vv9tk/S08IcRiQPJ9FGK?=
 =?us-ascii?Q?mx10nX0kkRuyowBe6r8qTPnSbUw8AQQsTeFD8OWlyCO5Y4nkGgM/F3Y84O6D?=
 =?us-ascii?Q?SQWkVAJx0lrSSMLhEJZnQW5oiwNn8aM/+ryNP9LVg4ahT203Sh4pAQ8eALTM?=
 =?us-ascii?Q?5pqZNfI68IXhc7NaKV2JLvbsbYsmGSZyJyZ0OM9qgWxbBzDTxvhrYhb8/HJs?=
 =?us-ascii?Q?FsYnLVNhAKYLfPwB/+Y9wdUEFrimsKLJzE7JEBnTgNjoOBvwtcY6iNWKIl80?=
 =?us-ascii?Q?kp9VUsjfVrjVOpuGSl8qh0zMEHihb2krfr1Ea/7TkyILjy+4pzf3tto9onc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019cb21c-7b04-46e2-e281-08db569492c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:07:12.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB3794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> They are not the same - they are different in many ways. And c906 list
> seems more complete to me.
>

They are different, as this summary:

event id range   |  support cpu
 0x01 - 0x06     |  c906,c910,c920
 0x07            |  c906
 0x08 - 0x0a     |  c910,c920
 0x0b - 0x0f     |  c906,c910,c920
 0x10 - 0x1a     |  c910,c920
 0x1b - 0x1c     |  c910,c920 (software defined, >= 0x1b)
 0x1d - 0x2a     |  c906

> I think you should drop wildcard (it shouldn't be used anyway) then and
> name it c906.
>
> "0x5b7-0x0-0x0,v1,t-head/c906,core" would match both c906 and c910.
>

Drop wildcard is a good idea. But I choose to
