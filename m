Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1D5ED29E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiI1BYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1BYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:24:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E019188BEA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVzByYh2Z85zrJTxKwe5RZO7g/uwAXzYFtRaUQi2eHQUX1cwcooimbGp+3QUEK0mMggQcJCHws2N2dOi2rk12+ShAWv4RxU6B/JRoMDx+Fue8IPgv1UWX3TFAiWUjSEk0ro4kTE7eHxdoXGsFQz7HNCGunxIDgmcelKzSMMidfEG35HZwOe7Q09jK1z+AvE0daaW9ZF08PqAKRbsV0WHHCbln54qZ8wlK53fPJ0l59tWFo7eXitjmBTi+jBwJxaLKM8jC7z4QYgKlH8Kr2d26cpSsrnopEXMoD8i2ilIlp3mtUAytTwWdrEhtrlsNUvziRJ7sp98MwSmkj+XmKD9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsqKnceNfrbZpxfh72p6lhcfB3QUq8CVHDns0DY92y4=;
 b=NWZVUytZaZ9Ge2OLe1Bpqvp4diwUBf4U42FScZfzEmT1v1hmHb9OP83n2ybRNKOCcD2XAsYvylJnG8SvDF5p/s1UUazOUlaeMbWlgonDzdqfesEoqhy8U4yb82URk+NcNuB7AqjI1sh+cmq8zn3JexlVvzc2opyyzWvFFNl55ixffWq8VNzgZgFzFiZfX2TMPQeA1nAyd1EwRck0rvztNKeZxjaxcxuxt1Tui6qrG1p+he26SvJoQ3lzOxUlnzdIMhdaMI1kXQU5QwG36l03xPDqMcoc55LhHjoLMS4uPkCdYsu7m2WMTrhyapaI2FHmcrdeg4jG31lHE4NXfKHmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsqKnceNfrbZpxfh72p6lhcfB3QUq8CVHDns0DY92y4=;
 b=KQPu7bsBfLKWARVFVyg18XDiRgRuNvn3LDrTDQGjGWB1DkCWh9NVHjZIuJ/taBIs26itp44qGvHWZ1ejtzGiLomk0O/m/SVYVXurVgqSdK4uTaNWtgwwNNd50zeXl2IKsEkaHDK//waAbfwSbTl194I0vSWrdnldBxaTCznoxjv0+Tkvy9lEBSZPUfSfc6idwDZ8Gii0E/71OFaKtfqNkABcbmQvsGFAK7HYDgCzuo5s54v3ZcICLGqgZWJu7n1FIRQym2tSY5WTu2L5J9WUkQ2pn/wvvizWA19axhC7a4qahZy0FHrv/d5pT4zCFhyudr8At/zeW1obwVmqa5dX1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 01:24:16 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 01:24:16 +0000
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal>
 <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal>
 <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
 <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Date:   Wed, 28 Sep 2022 10:59:08 +1000
In-reply-to: <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
Message-ID: <87pmfgjnpj.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c7e8a2-fd0c-4784-5e32-08daa0f0288e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3fKaRLI8kyP43GdpP0to1w3+wL67q9nbk0oDGtcCp05qMf1zwSvTAmyMPwqaXxQnUVrjWz39h+VBp7T21NGxERKbWtVcvrQZQDRbe5hkX3XougrjFeKSK5FyDvysKMP8sWsUq27bm+sYW3FwUQmlwGCKgEfzJ/cKPWvcZFt7PpjhiNlEKL1KnnJ/oPIstGiBUyhXRVMiv8wjSioggPPhtoa+LBqY5n2Ywxhvg8YrkSQgzHddFRw9WzIRbwxHmNuzJCZMkhTYenE7J7zC6ULTF+1ed9Rnp/pYsXb83020QM6AtpHrCjbX9ypJ5XdHdrgu3KfgeVMgQ/Pyf1DLB9KU06IF578M8DWUsA51D8R7h+Is8Y/0okmM7TBPR12xai9qKUH6Ze4UIt4OH54f3hpUqNyia1OrmZy7KAWACdtQ7WTHB9v8OLXEd3UsIVQTj64o0Tw5ftOR1d8cXYgdiIuun+QbbM42EIpKKaAjbu8bs/Vt618Pyy449vAizBAAJntOgUapQCrYQD6PZouOYawkq2hzns0f3SRr06v17qA2PbDN6SaKmegsj6LHWP7TZo2jEm0xuXJiR+tB6mzHOzg3CKWW8n0/1IXXIvGzQ0mS7D/LVFk/qDoMrgONZEQqe4RSi7HJIR+J5jjKcGF0CE/zr+z4N2MOPRmqahbhR2nLGvwUtCi4bjcHrm9mOoSJ7rjSz0E3KTqznrYK3EXWLrLYpc9gnpfLXTKPBHuVn5c5svsOgZyg3LPfiUZV0IrWeTuu72i4uFcW6lPOylM/TnhLNJIJSt89VIw3GBdWB/V6t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(38100700002)(478600001)(6512007)(9686003)(26005)(83380400001)(8936002)(86362001)(966005)(6486002)(41300700001)(2906002)(5660300002)(316002)(186003)(66899015)(54906003)(6916009)(53546011)(6666004)(66556008)(66476007)(8676002)(4326008)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeafwwNItSzv8E7LbNzy6fwWlxdF7LHvZ0SEKe1MRb+gahtXxjz4/ni3Kime?=
 =?us-ascii?Q?JTQxzDmodILlx09yneUPzNk85F8IEzO/vesn+xWE1cAZywoO1Kl8ywm8NRDc?=
 =?us-ascii?Q?FY1IJpDFhGTUuRP2AOxyrnNDDypGXm8JjmVcxJ1go8CWxCXEufVJ/A7fZ2yM?=
 =?us-ascii?Q?m1RmdOB0tzy4srvxCZzRrwvIx/25fwa/wIBH5NlSD9HE0W2EdczQTRlN+jDa?=
 =?us-ascii?Q?E/tlqIYiZt3HoVkE9TXg+gVBValzWHLqHRomRKx/DzYg6hHtgsQqOBku6uDI?=
 =?us-ascii?Q?2n8+8WwKtkSy81m71KWDfokhetb9dIsDRfkMJXH3qskPcCXMjul3rWb5Yddq?=
 =?us-ascii?Q?1AsF0+oDHnnnUeyBo6Avy2jE5z+mizaXIWE712Wul4ob/Xrvu9Cr3LZEVBUa?=
 =?us-ascii?Q?qiZLlCf5j8d95OZWxk/vseAUikG2OEIATIyk3yJfoEYEC+UfIgKroOIw5KhX?=
 =?us-ascii?Q?HPH4QjjkoPAlwDi/RxccrFNtxSvqb5OZKnLfkzQlQS568Ze6h2rwq+aN7soo?=
 =?us-ascii?Q?A8yd2pACK/C0MmKhZGOIe/69FVUqp3Ryvj6VseTymustDtrr0nDNbQ2rqF8D?=
 =?us-ascii?Q?MTdBWMtzhTav0PZiEc2+iYY5jqO3IA2YGEJ51KMSQZtrVhCHaiS44cBrYVtk?=
 =?us-ascii?Q?jddAqsDdclxQruHZEOqEvtY7P0czMCTBPdw3kdCgLyf5RdfjIAOO+1iAmVbK?=
 =?us-ascii?Q?0Pm6jAdelj++RRvGxrCDMzsPe/ulhCFC3cYE0HpIYp/y5HfXPgNiID3dJXJa?=
 =?us-ascii?Q?MeEIhvQBgdy0O74QLmH1W/YHBQc60ZC3BdJCfVSQG0/FAUlKrNmAT3yDlEJc?=
 =?us-ascii?Q?aue8qbK4nnSZrVIwhOSqMaU++Z3ovIeR3weaG2AxcouYASkOxbTYxnAV/qXd?=
 =?us-ascii?Q?JQrRswdutpmXrxLKrYB6AHbaPnB0Pv/6ELKjXMYDRLwsIt7M8s8lGB+B4wVQ?=
 =?us-ascii?Q?uDxPeqMmMMNmu7Dj2kPwLU5XviZMLuE94NvvRa4SVWvddEIWcREjNAyEMW4+?=
 =?us-ascii?Q?gUcWwjrdakJZmPFSqwIFRmP5w7c2z4/x2arXOO778AQjvOWh9ENVA6AypPrY?=
 =?us-ascii?Q?8Q83wN19KTDGcgZ3eJzkOdVHsF6Euiso+CLzZ4qX7E2QT87JKugjQ+7XIOCg?=
 =?us-ascii?Q?9OA2yspfDFW3i4DVXf+k8XxBtlJbNmVoH/qw9kEgvrOjYQeMILbsfGo4FzmZ?=
 =?us-ascii?Q?K9+PHgmQP3/YhE20SwKn60gwrkCzzsf2VEXbIRlqIfu+Jr/FFcLQ5d+6EUC4?=
 =?us-ascii?Q?/1+DDdigX3BB8C1wRzBKqtu+Q80kqZMlPX/sbJuHD/M1OmbO1N0ouWuexF5u?=
 =?us-ascii?Q?N/vB0nLonhNy4x9WGukdq9oVG9M6AI8o1CjXCHrYSzzyC3tl9lnmgKbVjvnB?=
 =?us-ascii?Q?2CBeF+ukkfQ2U2M8m8z/pEr92fecJE3BlB3HknzQqqQv2gds51mT2N/iQRmv?=
 =?us-ascii?Q?lOUautuJ6LEs8WcpO3ZKCz/FaxCtlYtE+kPDwo+Mw1Zu1JL69DFe4Qyd2f04?=
 =?us-ascii?Q?SkQAgyGKPiXJB66wiJrx6p/Mlwxbg/FWMBQHK/AQWYopxCQXdYubonRkP/Bx?=
 =?us-ascii?Q?q9pJcVIEGzsvsQbfYCUwBtI+MNExWDJ3G8qEH/UL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c7e8a2-fd0c-4784-5e32-08daa0f0288e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 01:24:16.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1PhbcMpNa8cI26UQMzEcIrhkaobZKxIKDmxyIOoI8eNrJFeHLD0fqCJ2Wh4ngNU2/EyZ2i9H6Iu/+TlKsaH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang Shi <shy828301@gmail.com> writes:

> On Tue, Sep 27, 2022 at 1:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 9/26/22 18:51, Huang, Ying wrote:
>> >>> But there might be other cases which may incur deadlock, for example,
>> >>> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
>> >>> then write them back in a batch. The same pages may be on the
>> >>> migration list and they are also dirty and seen by writeback. I'm not
>> >>> sure whether I miss something that could prevent such a deadlock from
>> >>> happening.
>> >>
>> >> I'm not overly familiar with that area but I would assume any filesystem
>> >> code doing this would already have to deal with deadlock potential.
>> >
>> > Thank you very much for pointing this out.  I think the deadlock is a
>> > real issue.  Anyway, we shouldn't forbid other places in kernel to lock
>> > 2 pages at the same time.
>> >
>>
>> I also agree that we cannot make any rules such as "do not lock > 1 page
>> at the same time, elsewhere in the kernel", because it is already
>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
>> (15) pages per batch [1].

That's not really the case though. The inner loop of write_cache_page()
only ever locks one page at a time, either directly via the
unlock_page() on L2338 (those goto's are amazing) or indirectly via
(*writepage)() on L2359.

So there's no deadlock potential there because unlocking any previously
locked page(s) doesn't depend on obtaining the lock for another page.
Unless I've missed something?

>> The only deadlock prevention convention that I see is the convention of
>> locking the pages in order of ascending address. That only helps if
>> everything does it that way, and migrate code definitely does not.
>> However...I thought that up until now, at least, the migrate code relied
>> on trylock (which can fail, and so migration can fail, too), to avoid
>> deadlock. Is that changing somehow, I didn't see it?
>
> The trylock is used by async mode which does try to avoid blocking.
> But sync mode does use lock. The current implementation of migration
> does migrate one page at a time, so it is not a problem.
>
>>
>>
>> [1] https://elixir.bootlin.com/linux/latest/source/mm/page-writeback.c#L2296
>>
>> thanks,
>>
>> --
>> John Hubbard
>> NVIDIA
>>
>> > The simplest solution is to batch page migration only if mode ==
>> > MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
>> > mode != MIGRATE_ASYNC and trylock page fails.
>> >
>>
>>
