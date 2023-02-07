Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBF68D6EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBGMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:39:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A1EB51;
        Tue,  7 Feb 2023 04:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY02VNChEcHfXe0lpOFG/0c0XIRSyN9el5xv7At+vLFfIBRt7dbBJ9FrgPfjj1qTuqxWGh/dmaOtz4cFFpxLb8AwLfMVw2KGwBoSzPmDyTwnVO6A51I+WBH9fnCDJVrMrzU8BhZSM4MnWQ5S5iHCtbY9rImIU/L0ln9uXhG7CUWXjIt6M4RM+MT45lOQi/gpiG2draxFOtMp4e+M/8YtG0DFTRaJ7VNlotMPfYmJSC8WkYLOJt9tCi0e/jAEFaxMmN8ZGkDKNf/9SCbwyXKP4XMiEMsP0+bh3Lv3y1jkODbWHOwJRGQIClGTb1Rxrj6nCVOPkGJS5F0YWQQ1WqeHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgSnE+q7hoUoGkmzi2iid7Ju5OBswmZqPQWopKj812I=;
 b=I7TkKkv3isatrcFPy5XAx4ETBgt/dWkx1EdxiasC9DaASNohT6AO6c1Y4r+aai29QkiKIUHWgrCF06giHrEBZs8cLq+Utb2WuSPMtwxK+VY28JZYeHNIgWzzeXKidd3B+S7En4MjQ1xgrHHQ0m9plXbAyxNpMiWUgrrKXnOCCByoz5Tc5nBO6r9Emfttbhpa686wCoYYVSKoHZ5LR3LLMItHD35mmkliv3rT8Wg7EcsS4E0M5J5/gAH6rXvl32rBGTNwoYlLQ3oEM8QM5NK/4DjNwAAGCRuo8/dA5gKzG7OdaIFOdd+3RmhE/COOxwl6HSaOKEKj9sxQbMQMqjFqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgSnE+q7hoUoGkmzi2iid7Ju5OBswmZqPQWopKj812I=;
 b=cl0j9GgjgLwORoasO3F+ztHVB8roHAeBfZCH0uzGiiT+FX+B7C0NAXgSBcqLN4CFbMOQX8uEDm+rhSH4PEzaR1Kygcn+yvn24kfXYvmDAlBxUtjq2yBUmTeMcHmoD398cITkx34dURGgAUTB1nMpuBhYCK6HK3cg1OfUKIH8tMzPuMuTwEFMnAanwk9Boz9wMVPpczrPdK3JripmONMDCW3Y+MECaHSQveA+vqeO05knbol7meSVGOaL5RkC4XrrjCrWUZ2L6kLPuKegbMVgBdlbhkaI9xJ5gJDm2SLPhSxGdMHVUK2NJokHMosoZLVArhJuhjz5VcaC2TcTaiBkpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 12:39:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Tue, 7 Feb 2023
 12:39:35 +0000
Date:   Tue, 7 Feb 2023 08:39:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        LTP List <ltp@lists.linux.it>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: LTP: preadv03: WARNING: CPU: 0 PID: 101250 at mm/gup.c:2121
 is_valid_gup_args (mm/gup.c:2121 (discriminator 1))
Message-ID: <Y+JGh0+a540TLr6V@nvidia.com>
References: <CA+G9fYvAURcTwqyGwoTpxAOR0EDTbU6a71d5z74R4Wv-qT02OQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvAURcTwqyGwoTpxAOR0EDTbU6a71d5z74R4Wv-qT02OQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:208:32f::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c0a96c-621b-481c-4d2a-08db09085ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdD/sMrzjX+OsWcGNyJYdkJXkyG5t3T585/3Cva1XqSM4k+gslXwd/UttHv9a4WrUo1EXh/ZMOWslQz3I0wmJBCSSaN9I/gs4TWJOxzBo5W7xn4OH399lnZbg7YZ9FuFTywTZszFLgYdkV8VKk/aG2VBrMeDqEIeGcdzEN3xTkInwlhLBJ6U8sJgtY1dMNnXhtMYlPt5XG4Xe8MQYu53UrOTttZB2DHH+a7iT3ezZou5NJFG43jQp6wjeGcKGjwIs4dZBERaozqMmKh3VEIHzp8+Zhfge/9Rl1Th4n00qergW+CVijXbGrOS7y2rrl7CWEjwQw5buf6p8SM5gaaprX1Yidtq5aujcAu93Nj7NhDRK3+hDsNdd5/in0mI0O7VfyzPi/Gsc1xN2d+TcVF/vbmpTFFZc2Uexi3Je5V61Dzc384fN5/HtFsWE9Pk9Fu6lpAhTdenrRyNaA6YGEE40idVvaIo99/t2UuA1s+Y4ey5SElw4lm98ZR8uKB4jY6nUUmMNkSf3Zc+BI6KqkUaxCF72mkEbai4/QlsBm6YrjszZhshIL/7CzL2aF/RWnP2mc7L7xW3QRHS1NERPUl+k9kpP+xPY4S1ayeILMTg7H8WpUlJ6xnhe5EjmBZmfHxj41KU0X4P3/tDhQxp5xkR3WQl5juyGcKCU46dvQrHHhBLOiCfNUVUgzrxcQjtrj0A4jLqinJY7i//d2ReyszjM92G8CdKJmvAXJqGxQr76uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38100700002)(966005)(6506007)(6512007)(26005)(186003)(36756003)(8676002)(6486002)(86362001)(478600001)(66556008)(66946007)(4326008)(83380400001)(66476007)(316002)(54906003)(110136005)(4744005)(7416002)(5660300002)(2906002)(2616005)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CcNDrI8hs0C/xHgLFm3iSB0OK6otIrtoA20+BV1lE/YSPR68sRC31PH/pbF?=
 =?us-ascii?Q?i8BsfHzY0JlxcA8a+SeO/39dw32nlZ5M1uSkSQVzMazhDS8rDTcOZ+KxP+ar?=
 =?us-ascii?Q?5l8MIEpo2Zs0bB5wqNPnB62r8NmbN/HGuDY8rtfjEyPJgUOg8GT89FjVx7a4?=
 =?us-ascii?Q?o3ynHwhkruyMsXVu4WTRKthiqWph9oXRznZN9L06J1zRfg+zSmFXwwWROEuK?=
 =?us-ascii?Q?+fegg+37zpCNZpNiz5stK4/0S7Su3X8qsZbegSlaY0+A/9ks5CI6NWqFZP+T?=
 =?us-ascii?Q?PGiv0sw+gtrUyKQdfWe6NQw8LuBeYCEdgd5AowdMr/82F1P8h8iXRMJccyM/?=
 =?us-ascii?Q?WWUnF9HQuZDwLEea6zksY9an/WW2nFOBpaUzdG0VWvWnVlF57MKaoSTjji2J?=
 =?us-ascii?Q?Q87VqWgj3YVVMfi+b16bTROgLqZRmgrAinTXi5K9paUBJQnz5oydvNzt23rD?=
 =?us-ascii?Q?dgbsk9qBgORmtqJfFNebudfYoKKiITlOYNQ1Z5K4Rq2xwhBixuXNe0VtDf0o?=
 =?us-ascii?Q?YHEq+1yxLc4O3phi5CIlCd8wztv1G+0kvY5rw1j/M6DiDZ1uBhf6oF2OHw4m?=
 =?us-ascii?Q?g+P+kuoQFC56kVtsQ5cQ48bKT3527OqQKulWUJ2eooXFyYe4FbP3+HCGeuCn?=
 =?us-ascii?Q?TCRi1ldtVkfxb/mYnjQp5L0hcMPV3/zNKgEYY3DW+wgj+alE4mbe9S8nizw2?=
 =?us-ascii?Q?eawVVMBt/SuHrcssRR3LCgtwIts8OaiBSWmJ9pKyqPYE28ioA4V2ozEVuIAQ?=
 =?us-ascii?Q?Kz1ojocheh+kpsVMUunSm+yXic0ClPHAphO/ujlq1nNA9D2ygaEImIN+ncN6?=
 =?us-ascii?Q?PqwNw61qclQ4QV6vi/wo1aeplDCQmA4ywSGGUD8hb07iiLPqCglV3ixTHAgV?=
 =?us-ascii?Q?sQhL45NZxzXczEGZ7wYKJcwLyc0G097UdO0Kr4bN/i3y/FvWPa4TsrrLuFDC?=
 =?us-ascii?Q?cvf3dSghoOzs7TQ+CnVwQPQlfMFrkwRhjIIzohn3Ia0N5QJRHg9jrH7NALE3?=
 =?us-ascii?Q?f0CNbS1nXMcE91CC0HRynqlCFdh1K6sc+7nMdihYsrBoZ8QZaUszmVOfdKNh?=
 =?us-ascii?Q?0lWFlDxxZA+j93VKfIjcpXIOUdqyAInt+Y5FiiAd9NEPZ0Nma8DG6FvLul9g?=
 =?us-ascii?Q?sOMCIJjYJiDMDE+R9ThM+BHlN3O2lLfKDQ8BzUqSnUylIdNZfbwnTtAgGX8P?=
 =?us-ascii?Q?uYpGazX02VmT7GrY/CE22/y7XZ16/6jHaopbaXFYw3hgetZ6BwD2C6rkoz7N?=
 =?us-ascii?Q?8nnqM5UBq6JjHprAwgY1A6b0KTTZhJX3+RqnH6lEq3/b1qMDTjIDzscE43nT?=
 =?us-ascii?Q?veU/MuifhlWZsrKEazLPmmRf9kz0tzjKbTDuS0xxjwwGqRxOe4EzW+ZWMtNW?=
 =?us-ascii?Q?1BZCi2196ho+w5L9RNuzdt0cfiLWTqndOuEtFi0vwiyDsRc9SzH9Df4CtQ2c?=
 =?us-ascii?Q?/Kv+02oPwi4esGcQawqMrmNRJ8EaXw0eCq5RQ7f/MX4WQF8zJ5X28n2pbAKZ?=
 =?us-ascii?Q?BfF1+VZmDkUh1MQ9wxMoGaJdcuvI6ncADN7Mgulg5XOvhWwCi2Z3hXE/wa7I?=
 =?us-ascii?Q?gjOivSHnDiX1uxQ3DRDOZPSCtWEiAasGXFjFQbhM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0a96c-621b-481c-4d2a-08db09085ea8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:39:35.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFE5rjgH5UwqLdhYIykeayxeZGBXfVLgVGmb4ZMKiAGTMqV90kx7BJFsF6hvYIIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 02:09:27PM +0530, Naresh Kamboju wrote:
> Following test regressions noticed on Linux next-20230207.
> LTP syscalls pwritev03 and preadv03 failed.
> The tests use external mounted SSD drives for creating tmp files.
> 
> Regressions found on arm64 juno-r2 and x86:
>   - ltp-syscalls/pwritev03
>   - ltp-syscalls/preadv03
>   - ltp-syscalls/pwritev03_64
>   - ltp-syscalls/preadv03_64
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Yes, this is what Stephen noticed, it is a merge resolution problem
in linux-next

https://lore.kernel.org/all/Y+JBak3Tt8Pdw3yE@nvidia.com/

Jason
