Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6D6A1EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBXPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBXPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:35:33 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65986126D4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:35:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7GWnqqOIQJ9i1+7lJgxYOZ4sErLQD58hER6YfS2zXIQcsOpu7Iug2gBwool1PLNqcWvLv658x5xNqOWikFRdNI7RO+Y6Jo6fB9wBDQskOFDKIpzOGm84pNBifzM+DFHo1k/JaLRTO5X4Qi4+cgruA9tqh0oI5d+pxZwmpwzQ9qo0pJUFqIiWmTlPnqP53UOXa0j4aBvCuQc+u7ns5LmfIyKVt2PCK+uAWZ39978GTabSdzCePezuDDtEjKm4D5XW39iKlKQchcWIujcfpfhU9JOPZHi2eeiMch+h7RxIP/26bIPm5kX19hdeHGc/HtO5eJVzGOsy3C3Hm/9TyFHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvnh2GVd8TsUUtNmxk55pbUgeUDB0AzqQOgwGsF/kiQ=;
 b=Iodzt4Kw/1TaBzG+Uk+cZgVGr+FS6SB2ppLaganhwIEhElYXQV4gfEaR4O/pBjyRD9bKCGlNxN/rj6d7c0oy6Z8NI7a1YXLBUjnRU5x7WP3RBekNy6eh4k3v/0VBIfc4U5Yb6kSnciNi0C69sIAGkOWb8M2eu7d5MlYBonEJzxR55VN38+4HHgE14AEw8NIs6IofW+kw5rkL78U/kwRYZS9N+wYNVuVL26fmlgIqEy24oy0OzieXIzuG9dz+rmGaqaBmvTxgiIPDsaLAEFZn/Q8s1ScZy0vreTd6SyKrO2RsAD7nNa6gfR7a91wp7QxrP2Kq9CoovbDizE5CRA/+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvnh2GVd8TsUUtNmxk55pbUgeUDB0AzqQOgwGsF/kiQ=;
 b=YTYm8/imRljxbpkQlYdkECBaGYEUVe94NJRYPcO8WnmxcZHI5QcKXtuHNs0YnCAl7qqvc13vsi3iOM9Rk+HpjAUIIQev4/HFbgiX95h7OVNnYY/+68m7KNW9/uHTlxCIB1UN453jxQ5Usbr/e3LnCGXu1HzMAApbFaT/iiSjHC/m7cR0u1hiqf5bruz8jITCkzFGyaNtSv1DLYSTsOvJEUET1ckS4LDTP+dHUJW6m85AmsimGBwVHIKpOvGMPCHQbCIkqTP/BStMa7g8OWZ/HbfnBRggkBov76vShuL9AM+Yqg/p0/hxxmriXhH56AOiyxZ8G4gwJBwn8JznLPg0ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.polimi.it;
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
 by AS1P251MB0407.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 15:35:25 +0000
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff]) by GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff%9]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 15:35:25 +0000
Date:   Fri, 24 Feb 2023 16:35:22 +0100 (CET)
From:   Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
To:     Mike Rapoport <rppt@kernel.org>
cc:     remckee0@gmail.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add tests for memblock_alloc_node()
In-Reply-To: <Y/jPKvcIpqi1zVgC@kernel.org>
Message-ID: <273bd6c2-ce77-3ce4-db7a-8d664adc8d24@mail.polimi.it>
References: <59d4745b-7b2-bf6-7b8-f6571d78d336@mail.polimi.it> <Y/jPKvcIpqi1zVgC@kernel.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: ZR0P278CA0182.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::15) To GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP251MB0767:EE_|AS1P251MB0407:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cdb420-a781-415f-68b9-08db167cbfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li1IIBMCWRL09mUjZ79IcZ80duqUx6d5eXLrrBXkmZ8btDmCvfiISA8JrQ0FP8VNKzrr33SqI+VoFex5KLO0Tr42oumdbheTDK0G4LI5qRsfCg9qhQUgj5x5VqRV9px3xMNRZI0CD5a1xKUM4HmsESViIMRfD7SddxdczObO5alfD4OBPqNZrSNPFfg1br8DPK0jFezYc1K4d/TjkqphE2dh/MBxY3JIjyOyv2DrxJLHdkpeCJ/Q5o69z2Gg4IDYseK2O3fe35E/FUPLjVo6ymI4tTY+ypALkh8ygxdEcJlDuOstgpQX5dcADQhyg4bSrZSq5qls4DiJBQoZk8GvHqST6i1gmFAeadO1IfnjRN+dakJm2w4jQSRepXco3lA5Tq8LKGvz41Pm2mvewJHhR935xteiJ/7zjP6aAKyFopkZvRT1hma6u0UfjsU8s4kl+qTRZDWX9pVMacSGwfYXGqXxZTFolu/jH7lfDeLzLhlL8OpEAYtFcd7Oy+k4gsvAaF70041geXjcOuobJzCTuDygXnsCEz7sGcIMj6mgOkbGOPkMKlqpYtuRQO876phbk5vIwQudEHGZ69FeYrsGdyCahFjrc5aaSfNETAwB+3mlq4WBpG7z3RfIYeWxzz4kJ5AaYJYx8weMIvIt1tUb9f1JvOp58CjeN+69Ady1VYTsszBEVXK4es6zzhYl88tt7O6tSF2Xc/J9MLWMZEswoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP251MB0767.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199018)(2616005)(66946007)(41300700001)(83380400001)(478600001)(44832011)(26005)(186003)(8936002)(86362001)(38100700002)(8676002)(6916009)(31696002)(4326008)(4744005)(5660300002)(6512007)(786003)(6506007)(316002)(41320700001)(66556008)(6486002)(66476007)(2906002)(31686004)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nx+1ituNK+QVaYVAKMxsldGKGjFclvq8XrfH1NUDbatjg5dweMhlyMQXthvf?=
 =?us-ascii?Q?uo9q0H6Af9y8ZFlrNiDBRNKtdXNPKWCmE52B4wAly70nurs4qfoh73bWtgyz?=
 =?us-ascii?Q?nMZot4dcRmqxRAmMWc9R6i+3JWhi8dBEl09vFJ1jWqYbRGQvVEPKrWT0HR0h?=
 =?us-ascii?Q?bVAmJkA5vMhNkZyWjBlQffkL5XH05w8L2iXWZox1AjaUpLEknHqfpyJCa605?=
 =?us-ascii?Q?p1Qpp9ogZIUNoqVogAREs809frEys+wtcSXGW7wTU8ur6eRZGkxBfMWuLWLf?=
 =?us-ascii?Q?C3qaJthFJtEMWgV1b46cGVWtSboZVQH914MdwZI0h0GpIWiO0e61/f3K+gdB?=
 =?us-ascii?Q?bf/05Iyu8ODPnXrHFt0arX92GcUm/r6tVMb6z84sNHoFAZZ+YNaZVoJEhJlW?=
 =?us-ascii?Q?Joxc8e2ayhk+Qzt2UFdhzZ7mBzadUpJ/p0k9AYAnK0u0b+GsE1sDCLhHjDvI?=
 =?us-ascii?Q?sEdDVcNbtHhVBPjHnwsfu3oc31FciPIksA5LKbj09Vsw2kdRPgOGbyHXyrbO?=
 =?us-ascii?Q?UZmEdmcGw1qv0LIU/4uwJ+XPxhTriNOVfZkVvNA2eecRF7NXaXZ21pSqqwi8?=
 =?us-ascii?Q?/lAwyE4JZwzcK/vXR0nhzgVK/HwlNzW697F4E2GKtsBdSpxfMHpntnY+NStK?=
 =?us-ascii?Q?nXYIhpe/GoHFj2ga7V/Sqy40jN6E7xnTzo+HosXc++ro9zFaf/vmjPK1L1jA?=
 =?us-ascii?Q?CjfKYZNaVeT1964cQwtgiqZpF8oqjd7PQJG8GkEmV125QEV0O+mgR0ulaoBt?=
 =?us-ascii?Q?KTCuIYl8vJ9ZzrOTCVgesgmKc+DDzMm+7/BXrhR5q8nYP5eOqibWBI62DPqg?=
 =?us-ascii?Q?KTZw+EHQA9xiLX98TNppuopu7/PUZOHS/CJVgqxufrnh82dpV/dIgA2l8TbO?=
 =?us-ascii?Q?uPDAG/4CXxwA/AN8dwNiZoqYeGwScqHnVDi/uJcVkA885XY9r7OZiENb0tyC?=
 =?us-ascii?Q?VWlaLwi1rv2Nbne7zsDypl5gj0GGk8NwbkKoztFhh+zZrtY7h/F54dcWpNRe?=
 =?us-ascii?Q?ltWaQns8taoHOrKcP5m3FEwb8kJ+gueFylRq1UD6FFfbK/eDe67rSrgkxvCV?=
 =?us-ascii?Q?x/l1qsE5hhyA/KpAUO6fWVTt89Jk4rlBvUTpOAtjNLUxk2aM7ANdjPSnY+oW?=
 =?us-ascii?Q?K79x/HMyOfmb+do1CCxcjm940pQ+nUkCa1Nj0PGt1s7uCv/PqhIl9ZXDHf8q?=
 =?us-ascii?Q?ZCsX9Z2JNlZvE7iYlJPsBvF+khaeijHSN1Yo4hTwC7pT38PtU4m3h3jxoAWe?=
 =?us-ascii?Q?xpKUx1FDXaMhjYSiWaRHbekdskiw2ZNn1GmtfP4IM5h0PUDmzFRMNIMwSKc/?=
 =?us-ascii?Q?gThXDlohWWZZlm3XzmgAKStN1u8yUSM/XxmHqDAYZRvS4QzG9Q1d7CwtlGBm?=
 =?us-ascii?Q?NV9EO00ZAqHKKpbf5MVI3hnizrz55YQxJzF39d+NKAiTcPQxR0qK9jULUBG7?=
 =?us-ascii?Q?s9i9UQOrB9ZQiufVB9jaXdUcMTDVIIqQ4F3be7vN/TfXDoKaAy4Llae+xGxK?=
 =?us-ascii?Q?xFaCFD+xXtF1Xh9eGVnJkl1VXKL976/NC+uqarvkyvVelAClpTqvur69yDLU?=
 =?us-ascii?Q?3FCH/Li+fd5gF8SbDTJQUMPfIeVQw3eMmi5rx6Gg?=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cdb420-a781-415f-68b9-08db167cbfaf
X-MS-Exchange-CrossTenant-AuthSource: GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:35:25.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvRp1WM/jKOjHMjy+7+om02lguIoF9HU5rLDGcMF+3vk/HikcdkrlBExn91p18NnHngLsgdXFd1MCsChcKtENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P251MB0407
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Feb 2023, Mike Rapoport wrote:

> Hi Claudio,
>

Hi Mike,

>
> When I tried to apply your patch I've got these errors:
>
> <stdin>:188: trailing whitespace.
>
> error: patch failed: tools/testing/memblock/tests/alloc_nid_api.c:2494
> error: tools/testing/memblock/tests/alloc_nid_api.c: patch does not apply
>

I'm really sorry for this. I'll fix it and post it in version 3 of the patch.

Thanks,

 	Claudio
