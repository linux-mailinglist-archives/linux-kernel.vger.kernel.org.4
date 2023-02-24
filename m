Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406856A1F46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBXQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjBXQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:03:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B254E059;
        Fri, 24 Feb 2023 08:03:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqKYBxFhPXi6ivNGIGViT3ycUR6vN/X34lPM9mvT8cV6HVXlNT2KYBvga8SHdYrMdnYYpuZh+rHypetD5SUoPV4fZbh72d2HevUwbhnYJJyhNLGfur5Ydt+mVQ4VEzxyDd0EQXH5Bm/S4HyyYn1uoEKpmFqWHgdKFiMFemYPVwTBYksFq5tTsahYcwoj2d+BHCY/0m73mZ+N1oDNY78YxgPHB8A6+bVEYwIEr6h15t1pTCfqzx4oSOb10G1AnUVU8h8icXyECsTSDHJcFv9n71fFC0nNumZUNa1ZpFosYUyc8wpn0LeEkJoImLixPvo2Zs04hu0eBkPcJl32sVwmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5MA4zMt3rYtRUYASp0A2TFMZXJv4Wp6eLqXiCnRl6k=;
 b=mK+kfKgyHUBsseNMy2N9rTsOYsYySZ7jgqiV80PSHtdKlCSEei/73560jh0fYRnodZts/g0L7RCas2bc3PzcnLodvPHlCtuj2xKABtqVMLUzlUCCTYqhHI5zYZ9IZ7AACurkhEeCISo2JhW8k5tvcS65QqdctcpW7CAhKdx95fQRetLmjpMs4ITX7tew7ubAfU3zCt15fb4k9MSrqSQRjnbm/5reG7kZijAhFU9+KKcxEmkCcOJnkleVfSRhkpMnoZaSuz5zi9mritGiEKDLSpJ6pm7+rS/Xx9qjcs69xyE+coBbT3y+bSQCuUmHIbmlJnirlNwdt3MyKHgUw1JHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5MA4zMt3rYtRUYASp0A2TFMZXJv4Wp6eLqXiCnRl6k=;
 b=v4vFghSjwImlERpeEji+BDHPLw6gl0Tby6GuuY5VyqJyK81jhZ36PJuFDxN1lPlgtUVEnRYB97PluP2cqFqwf/FDEWilLU49qRmnUmw6MoINkeJUw3+JuNmwQZCbICttAHV4QTmnfzwfbRuy4bn9yZ6xNaOjc8t2bGZPdxWvmxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4540.namprd17.prod.outlook.com (2603:10b6:303:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 16:03:01 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 16:03:01 +0000
Date:   Fri, 24 Feb 2023 11:02:58 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y/jfsiFBF7RYoMvN@memverge.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
 <CANaxB-zTkCLbjBti8hrs9RVna21KzwC0GugyDu7=nTzGLLum2Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-zTkCLbjBti8hrs9RVna21KzwC0GugyDu7=nTzGLLum2Q@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c4ae9c-6a38-455c-86a9-08db16809aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phbRuVKNE1j+w9e50/3OykTeuatdgcScawPE/oSkBRnQoVcQppQbIsUjg3853lgWSBE/xnCOwJB3QPtv0oa6+qmTpnV4gnekEh3o/xxweT/LqJry2wOpXfbIzdaI7NeawRZk+g0o+olVx0JILvZBG07eJSxlIDiSv2/7QFI+EVrgL6yecd61NzszKeYX2F1ENkE2JRbpXfJCh/jqpZu0810cPLIdRcL6rMF9QQ1LeTTU2g9Mw0ivPC3/FHtE+R8glrbgJrE2FwnlME04F2f4SEQ4d/48PNrTseKJLXRzdHDQmUZiNp5BfRnZY6q32kROA+An3OsD/MmuwgtLqt/ElFYTujT0wEJcjBropE8pQTaiaxytZiJ0OeRYO1QrkCs0qfSujaBWLX4vTpIYN3LhuXSckEYikHPUt0TXBiNubwVGYGe+qS9UUliHBZ/FeC466TLzea/Tu/RLPY8WbZTFFDo9Hb4CDmfE37wJdNSC09DozZmkbf2yJhTqiIEKt2I8Hj8zHmOonTIXD9tpaNjfFcKn1b/dlPQfiHBr9lXMdy6VV/Zuw7CnPMTPiItFXmr9BPX3AgzvltULFS60dptSQsHcX+LZK2wFo5GeTqfMr0rbJicyx8vS/gpjIJBZLg14z04hPeYMkxW5cnfoAZ4mzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39830400003)(136003)(396003)(366004)(376002)(451199018)(41300700001)(8676002)(6916009)(316002)(4326008)(86362001)(5660300002)(8936002)(7416002)(44832011)(66476007)(4744005)(66946007)(66556008)(478600001)(6486002)(38100700002)(2906002)(6512007)(6506007)(186003)(36756003)(26005)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3N4sV1ntv981dlLWksk/zG+8oZD9Vk7STyfOF1A3sLWooiCjm0bG4U7ltPPY?=
 =?us-ascii?Q?brO8TlJhAiVB2F0tqM1COgAjrmiTXhspokFPAYTILbdGjbWhA+X+QG9FzFfR?=
 =?us-ascii?Q?K8Q8LuyQDqk9w8JlEjdyzRm4ohXOaa4n/XwaGatNgLz5a1LJAtZKpCgVSqxf?=
 =?us-ascii?Q?RuKeZFkrCvkCu0HnmfVoiUdbIL2aXhYQHg8NELtGhtnHQPGT+rXOIfKFi0zL?=
 =?us-ascii?Q?6k9B4lVdl86J5fDw7PNvb2Yor3jVZaJT14TralwuhxZjVutiMHfbkbYseBXF?=
 =?us-ascii?Q?84PYIRu6g8vWy4iihjx/yAPsXmPjFyIuVBw5o0ziEdW4UYHHu6Ip5YpKCree?=
 =?us-ascii?Q?rETq2//kHuGq8gwQjXIaDhPJLKpWh6cBOROdcZduMHCDHfufGfYlkjjB5uD2?=
 =?us-ascii?Q?K9MXxcDYTgMyOdXLLOR+cmYLX/Ylhxk5qFoo6q1wOKUqUbb7BQI0FZLlFPDk?=
 =?us-ascii?Q?wngzkqUBcnA5MA1J5PBcBOoDU15euCGNfFUM1j+4Gx9UEgQyXtJXjiNV0Sq4?=
 =?us-ascii?Q?52XTbfvquRhnNX4uwiwrlF58UtE8zRb5GlincBiSyKQ+zrUULZgcfWfPrbUl?=
 =?us-ascii?Q?I/gVAiWpEG3cbrqsvlOdIL/Y67CORrSKRJfW79h8vncfKix/gc/BVsMr/2/i?=
 =?us-ascii?Q?14GdQ1MWapXqsUAMfp6KfcTIE6y2Vp/VR3wNRY2rYdBqSIVV/9uLDUqFaqas?=
 =?us-ascii?Q?P/ZxtSOF69BExjStP2S+vT9x35iF03bPfm/H1v0xOdpK6ppWKY836vMKjTeL?=
 =?us-ascii?Q?JiT7Di8g0YzNBIF23IHXpopO1lql552cO6dvp2nk6IqnUsijsAcw+vrGDXQd?=
 =?us-ascii?Q?JzUyq7EuUYubzFNCuLO4F/GXpmE9s7eZD0z1dtNclcbb4vH+IFVXV+PonBIk?=
 =?us-ascii?Q?BJGAiiWzmmN1lQT41/t1w4m/lxq6+eBbQYR1GKGA3fdhnHuZAp+R3xxs7FrR?=
 =?us-ascii?Q?fYf7wig3Vms4pT3F9us1lHYnu03Yu+MJxZmmBMVgtC1zm7O/utn5Sot3ZYTt?=
 =?us-ascii?Q?B664Ov2a3uI4IC792BASuwGtB2bU6Jdaf4IPnix65tHPQ7+5qUim/7PeLt/a?=
 =?us-ascii?Q?x4pf8/gCWmGwavVnYvgZsu7L6oSfCLTEiE4ONYeGZgSzF2hBzIjR1dQb/Xl5?=
 =?us-ascii?Q?7wRpejXAPkeigOZQiY1hK+1HVpaHiKiUmM9cUThg7J7setTyejAjDqXvKwk/?=
 =?us-ascii?Q?C6pU/Bj15iKEVz7E2jHk7QBbKwOiWRCA35htsQaiiRMAvFpSS3vZkYJTPCBb?=
 =?us-ascii?Q?LhX6FzHND4ZRM9grXYu0Gc1fiK4QOofRerAYE9ccnXRRjJLYzboi8cHGMxda?=
 =?us-ascii?Q?rzerGzojh694TQdv+Di4Z8pf1wF44DBZi7qfoi9LWDinmi1ZoE36sa53mYbv?=
 =?us-ascii?Q?OUvhqiZOs6dZaGJAAe35ik0Tem9RV0bZ4ylyujoAB1Avo8WYI6uOt+LnYCDu?=
 =?us-ascii?Q?aFwrcGa3hdC4g3rXi25nT3h4P7XgNGniIcW+4/d1fqNWUjf7meqgu5u0J4J7?=
 =?us-ascii?Q?n0n9z6RyEfBEgRdB/TcliSBIl5J4hHWlj+oFlGyNE0cImG7QMJ3jFjYC85ST?=
 =?us-ascii?Q?0GYTRR383P6MgX+pBgLwr3bVxdNEs97vJhaqIZ0MUBQUgFA3+H15/8OXkNt7?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c4ae9c-6a38-455c-86a9-08db16809aae
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:03:01.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBYg6ELBuNbMSbIJegR0Q1w+V5Bf/C8dRxuYceFzKTWgg2vADZp/AJkepJ0QDtp5YltDspwCKRlK2iPBF6KlNpFquaJLoUEUdZptZxa8Wv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:17:56AM -0800, Andrei Vagin wrote:
> WARNING: Missing a blank line after declarations
> 
> You need to verify all patches with ./scripts/checkpatch.pl. Here are
> a few other warnings.
>

I completely neglected this, aye aye

> > diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
> 
> I think the test has to be in a separate patch.
> 

will split

> > +       if (ret < 0) {
> > +               ASSERT_EQ(errno, EIO);
> 
> When do we expect to get EIO here?
> 

artifact from an old version i never dropped, had to do with my include
paths being messed up and not being able to include linux/ptrace.h for
some reason.  Will drop

~Gregory
