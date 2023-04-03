Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5B6D5548
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjDCXu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDCXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:50:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2122.outbound.protection.outlook.com [40.107.93.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F043C14
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ9wlk/+2NIRMbgBBjSkdsStEUe+RawKwssT22Rw37nL2nTnRZRRkN15p/7vsSuN1VoIXr4FMutKqy4aD/ltSPQPstIqGUTRHKejGF2jzyT6xTCgedNUropTj043HUihQPext1JjxYPxYmya+GkytpTB6GAM3pMLvSFbftnCoOtX5wAJhgloykQtqRMF7zqeemMhl3hYvvC9WxAOs2ntcp8C4NkfbB8LmCBNvZ+DPdlMGPamP3w09ZxU1PuOdyK0CixBUgl7ijj1NKNJmNbd6xZIc6zuYFIzX7Xb9IuLMAkbuDyB4AcU9D+qQ5wz5TU6gsmcG7alrDcSjJ1R8otYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9VQfausaTV6ExkCrqaAvtmS1qAs2X7B0HEXUyScZeU=;
 b=YahhQhsR+lD8OHpjX5kFMcCZ3ydygQvhC0dEpN5ottsFaRcnicKMykN9qVvbjb6loqY/o/cM8i4aHEsItDC7nLHSo7Da7qWQJ+AIcwT8AFbKycJL4J4BxnQKcAYX0fE5Fk56+vZKaAnrDjTvNhr0devtTCwp1V28JooqkeYz01kmNUMY1ZC6R0RbE+bbbqLr3ztyHRZFheu1GqZ9QEcWcVglpYyIbyiKrVPDUIGzqjqxoHiITqUP0BMVfZALhu+U0+4UV4Ov1Kf7T3QEQfkp/jGb5P4YWj9zYehzflLZ2rJ3t1xgTqkXQV8rXuOC6jU05J9Ihcb8ceQ1GVtnOXp8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9VQfausaTV6ExkCrqaAvtmS1qAs2X7B0HEXUyScZeU=;
 b=YwwLo3tXejHc5rqyPSVA23VAxW9IJ6hbgRJ9h2D0T3qyuXD2Bbm9hJsu5bTC8FwmYzVkPCKuG0g/jHaNyCF7l1AkRwzjJV621raMqWPN2hXT7w23tI0YC7DAPGEQgOAesfScAY/nss5v6sUROCp+kNyUtMRAqvJbora3nsvXVas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 CH2PR01MB5992.prod.exchangelabs.com (2603:10b6:610:4a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26; Mon, 3 Apr 2023 23:50:15 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::c091:3fdb:5662:5198]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::c091:3fdb:5662:5198%4]) with mapi id 15.20.6277.026; Mon, 3 Apr 2023
 23:50:14 +0000
Date:   Mon, 3 Apr 2023 16:50:10 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        "D. Scott Phillips" <scott@os.amperecomputing.com>
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <ZCtmMie5skEIc0Tt@fedora>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
 <ZAJMwLMNizPMPzS3@fedora>
 <87mt4th9zq.wl-maz@kernel.org>
 <ZAJXQUY2nSiGMCX8@fedora>
 <20230403162620.26t37wpmyohnuzoo@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403162620.26t37wpmyohnuzoo@redhat.com>
X-ClientProxiedBy: CH0P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::29) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|CH2PR01MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 13604740-4a2c-4180-c632-08db349e2baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpVO98NmHKoS2PT1fiTYzG0neuagc6ots3Rb3ztM7jYjKpJbhmGUfBiEKpJm/wM2QFqKLYvyD4wF1+MSCkF0GTuiSi+FyKyicQ2UJAJdLs7n2Kdsp4H4OfzZdvoiUX+Q+oBB3jWO6uCrRYbIpWeQCI85mfRYW7stwDCOw0z7xjJUDwpnoMhlfGI/fxebxChtiSTnnkNf5y/Mv1XaF3EtkHhRJooUoZqVuYJTRUCcGSwM4UVsW16jS5tMnvBOiwd7FHojyZtUjt3LZLWK3qgOPZ+oseuPZ7gG3CXvE/PUG2W9D9vQ28fsAkANkg4bvnavcJCWjBdnfAgxwG8HiYWdc9lOXw7e749giiom0k0Lo+OVze2JwzFRozIzef3wCffq9tGOM0pNAn5NDnfGlAmFCV0zcU9Hu7UMw0SjAyD53YhtrHzMcbO/bhof4uN3Ys9BGX7mijLewUQ8p8ZgzIlTftEWrFmUu3smVlvLeqk0xy/ICrkEXQA1xs3Pp69lN4Y+4qI24nOmwLfbxfT1b0wAGsvScvgcqBggUIltWkDVCdGAxAq5gvPTzpHkZ2JKI2HIdgVImfx/OQpYtZViquBGIDnwqHNmn2qXkYf2ovf/L1P2Icp7B+FQ1ADKTwgcnSen
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(396003)(366004)(376002)(39850400004)(451199021)(86362001)(316002)(66556008)(66476007)(66946007)(41300700001)(6486002)(6916009)(6666004)(52116002)(54906003)(4326008)(33716001)(478600001)(8676002)(8936002)(2906002)(4744005)(5660300002)(38100700002)(38350700002)(186003)(9686003)(6512007)(26005)(6506007)(83380400001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4emiMLbLRv9vUxurBjOarMF9B0d9ejdB0yZs4SJ0CjVr5Sx6gFw1rDiODOV?=
 =?us-ascii?Q?To95+WPwcUE2WfqiGxgND+2dQwk889oZAgX27Y2Poi92ElTnAkGhEV07uuJE?=
 =?us-ascii?Q?QWqsds3gi8ux8TmsvN+djYABI2OXOuFH26RihH6qNWY79hv16EuzaazVDXmb?=
 =?us-ascii?Q?Jj9LeiDo7EQ6BMAp4FSv4t+LAJedQvOw3teqG4q5aTdX/S1UcpZGw+9mW94m?=
 =?us-ascii?Q?1RVGpOU8sD84Jxwd8OW+b2X18DtXdKXXetmZITAf7vSBJv2N44JpFG0hIXb1?=
 =?us-ascii?Q?goRck/ev6fjb2GKRlUhB9ZE0jnjPU6XQhDi1KLwLtOj3/uZSQ7SLGOPKwMnc?=
 =?us-ascii?Q?kIhXlHL3fHU/l1oXsOdzlQahCj2rigivEKsBnon0VRiA39NZRNIOBS1kEZzx?=
 =?us-ascii?Q?vuhJOL5PYO6JT7rmPNXc8AO6frsx9Tb8+WdL4/KYwQZi/dJFlSs58dRRZB1U?=
 =?us-ascii?Q?6R8kzYOHVjowO45NflGfL5mE6aOIqNg0EqCN0JxBEZ1Sr8SD2y8n3HTpkmfC?=
 =?us-ascii?Q?mdmOgapz9UmYi7M8FzC2hldum0Yx29LYWLSOMtWx22g8fyoNFznwNKKxEGCh?=
 =?us-ascii?Q?OWBLUDbEQ38Hl7908GFrmGs+fInkt1zgyYMnrUJTMkbGa3si3U5mUaRgZGoG?=
 =?us-ascii?Q?I+8Czzd8Ht5IHW0WQRAP0dyf38uuSd5Pk5drOoJ8HktMwiqIycw4HO7haKLi?=
 =?us-ascii?Q?+waFopCsrw110LVPa4jUXZ9ql3MTQBkMfL+vI23lJlarOKJPYx+6ZAa0l2tu?=
 =?us-ascii?Q?MUWIhwyHUhTcApZ3kze63bYGzUzLo2owMV/70fl5RBZqi2P1FZHXdG92vLNW?=
 =?us-ascii?Q?y8wvaUdwnjIhqm+Rtt8jr0nL0dirEGgjvzxLXYigBnxhPovsUrrtFiN1g7Uf?=
 =?us-ascii?Q?keHUg2RMSCvft1Twv39FJyu3qWWH1271u5Llw3Vc0hNSywa/2Zzs7Ox0CtY6?=
 =?us-ascii?Q?L1L7R6HRj+h7RphrNN4GT2ZUPrC9D7JPA4KGvs9JGrHRhI7i/pTvSth3lzdJ?=
 =?us-ascii?Q?XHxy1LOnJ2Qc3vuwEJepurj04hcAm/srhhvk+BmPeLQ6A8OOBol2I9nz//0X?=
 =?us-ascii?Q?5osHlwH/S+I9TPLYQCNvRKM0T8B5w0AOecfOpQOGmpFCTlFoQsjkGHAnbIeN?=
 =?us-ascii?Q?GzzvuqW0ofsVsx+kAjOC5ThdkZA3szOftKVnaoSW+uVh2Tzobvseo4pqItsg?=
 =?us-ascii?Q?5Y10w+TgJRjQ3lDXi2VtvBYrmSHUEaQGV256s6XikmuqHKxSykLeF2QCjK1m?=
 =?us-ascii?Q?SU7qZkrhoG6Xx4jrENmSYEVqCo5OE4AgkJAHBnxHOhYbJMLqHW8ntF2IYj1e?=
 =?us-ascii?Q?eg85npqISkJVitL5AOSOBisWO18m2rcq9lDyfSsSPNUz6u6vTCAHxXGGtKo2?=
 =?us-ascii?Q?hjYfD4YZQGYnyxzhTqYUZiT8R8O0v8Hu16kbQLtTWzESWNq6U/3XlmDrTp+m?=
 =?us-ascii?Q?4rxlNSevnC3J8bd/Hm5WTTIHCeQTAtQhOnNbEit7IqeVV42sJVVvvZbXPKTe?=
 =?us-ascii?Q?Qx3yG3g3bw1s7ZiCUi5fjKPdwnpp03/jsYUFcGi5bAqejW2Q8ZMAOLCMDB1V?=
 =?us-ascii?Q?vPSNYp3mp8VctU3FBUWHvM3cHNES7xwMfJkifre29NomUMg6KxELCmCjO6ab?=
 =?us-ascii?Q?S5jMYzLuR/49SJ6ZbrkY0hw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13604740-4a2c-4180-c632-08db349e2baf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 23:50:14.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urncTUSEVNvC9cXka1WI5isPFQSmBREzgzs/ecmC/81sjFkONTcZcJ1bbfDAag7MJBMRizGD/gzvvPZ2a9M5r+jxeX0tTlFxn0fYAA3hfEWs4DSRRLoSYi1tDUu3+aLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5992
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 12:26:20PM -0400, Aristeu Rozanski wrote:
> Hi Darren,
> 
> On Fri, Mar 03, 2023 at 12:23:29PM -0800, Darren Hart wrote:
> > Thanks for the detail Marc, let me see what I can learn and will follow up.
> 
> any updates on this?

Hi Aristeu,

Thanks for the patience. Yes. These error messages are benign as the error is
managed by hardware and has no adverse effects to software other than the severe
looking messages. A firmware fix will address the issue so the messages are no
longer printed.

Thanks,

-- 
Darren Hart
Ampere Computing / OS and Kernel
