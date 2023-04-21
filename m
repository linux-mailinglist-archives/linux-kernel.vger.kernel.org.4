Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3E6EACFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjDUOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDUOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:32:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446513C31
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glfGhl8cRZuJ5jDKCnqAwxvq0GFnMviaRQklGP5n79icVgrO894ll7BL6Tg6mguUQTRh/GdUVI7Lbrj+Z6anzXgtAEeKGlhISv+9sSrWr4wPvN2zRZ6ng19cm2DOYVvzb6gBRvys4+s+BGOBWD2J3di0ZW6jEJVUhkBG8XnkndAzWA8nM5BSdP3GXtWdTAFXFwRLisjvPAPVcVyiAVzdNDvcCzK3K/M7Xn91UKA15M3spApg0yf+Y7xTXMfIhtCuyrIGMDjeR3eAApl65M7IoND1P3vs0gIM99r8KtvEWfSrR08tMM35/ydeDnLIWlsK/8akuPq8Z8tSg/oD4KJn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX33OWDlX/jsdc96rLs+S5+k6IAQrQwwQ5oe5Hg+3I8=;
 b=GpdVtiXkk9FjSCBOtRDF6v7ErA3M+MXurTaifjWN+LTLxZ7WUUopTjgOlZnzy7agg3aNxh5RVThHZZ9QkN9HkmMnKDWFUHPFX3V65aAMXukVgc/dbD4ZIo7TPeCh6Nqyc6J4W55IpHPTaU1CeX9K/V7ZvRVnMzlu/4goWVc/V5X90ogTi4ht9tSt+hzmBRIKKYCiWy6Pyt/dX0V0SUV2811BJbAO1yunwu9WPUsWzUXRyMvgVw+Wde9SCRnL9AbPZlPTbyf9D4leUbNt8NQinIcHVbf2VNxa9KLNsSRZMVEdZlq3U2rgvlc9DZjYKl2jBpTONpUd8WkP0leJhz6Y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX33OWDlX/jsdc96rLs+S5+k6IAQrQwwQ5oe5Hg+3I8=;
 b=ETV1MGUmQ1+6XtzAGC41yNOYEao1L+09j10PFjgMTxYMQ2Ig0bInIGtaCKwxs4ZrOCeGLoy9Nl7En/ESkQ3TrLLv1dVbVNepSuG3/6VkdqFVl8X2o3RbvBko4GrDZLIG1Uke22/hCT78tADwOkWHXa62tyCyKqBQMjV+1yq4fcfFVdf6tDs9uTezKfIYfRmHhr/4n7sgSbafm031cK6zQ+wOvv3bRL2a03LJeAhF6LoUt9RcRKch50G2T0DStRSIBPN3iTJuoKleXIE4O+euAm/A7Lezu/cqa54p3Fd3vYimh0N0YzSMIko+SeUaKtsbDwI/mb+rFLOS/dh4Tg1sfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 14:31:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 14:31:45 +0000
Date:   Fri, 21 Apr 2023 11:31:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v10 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <ZEKeUBiLyWWW7E+V@nvidia.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-4-liulongfang@huawei.com>
 <ZDlGC8SUXqKNmfSe@nvidia.com>
 <ca592d60-9a5b-dec3-9565-76cd5c0740e0@huawei.com>
 <81e11acf-0ede-d515-bb5a-3964c302f384@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e11acf-0ede-d515-bb5a-3964c302f384@huawei.com>
X-ClientProxiedBy: MN2PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:208:237::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fabd883-3838-423b-6aca-08db4275223c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0h/Poj2ZETTChbd7WH1StgMBtCXxsi4a9rXsggQDzCEhPo9hyRICgfFrXN47ccpiaAb4axq6AfprYtODMiVWoDENp/d1a71ZvoJguO/+Jw3bMc4BTvRLOghe4AVpD63hrNfHdZHyqqKK82KUBbWAg87/1jGbWdSj8DSYxlqbN8vMyJZYENtzixBWEgXKIBtj4zzBUfdCPyltA7CRs/WurbD1h9SKV1bkIm3XphK6vojkitrk7dWyw3kt2jGP+2/ifgpEbbK2jPzIgpj4VaapUfm34g21A1xZgaXTtq7jkMU1eCmvWuTWwtiHP2Id97DhH5NXWmrKX4Qpy43u884BiIwJLZ1DL9wFSG6Qh9GcMRKGACdV7KeTgQS5wc0jX0XvTo+20bBQk/bbSxyuXbLQN1GpLLp8uqudqiSlUCk4Zt+/K6y78jM/vnHxBWdHd8OjSd5DQ2WZ8pKQs4qY3LLGV7hLsDcAi8B+DLwGkvzfZPZbtd6IGgGVHoXCfo8Pldt3APPsW//1GjLtOEitn/sxyLpri4+ZLoPofWarzMGlB0CPHbHuQ8KgyRPmRwvNB91092+tDD6IuVNvKHzJvk1HyD67vGeJp6gOH8xIe2dMik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(316002)(66476007)(66556008)(66946007)(4326008)(6916009)(38100700002)(41300700001)(86362001)(5660300002)(36756003)(478600001)(83380400001)(2906002)(4744005)(6486002)(6512007)(26005)(6506007)(8936002)(8676002)(2616005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHtLpM3dkFrzuJTTH5F9NU1/hRLPp/xqBFFs2Isbzh1GOW5Ako5Ezoc9PO+c?=
 =?us-ascii?Q?kdIJlIkGwtSWmu3YTnbAUnC7rLjglaRZ3SnGVyWvfQjlNrBUYscSBddDO/Ba?=
 =?us-ascii?Q?xrJomWCzB1DwMAVgCMTrluBa0DdQipdK31p3uGqFArZp/I1UYcGmbDAHj5tW?=
 =?us-ascii?Q?+X7HPnesBZgbb/ae4ZRgnMbW8SDdAAvd4rPj/tn31JH5QHQAvVatFxg66IgM?=
 =?us-ascii?Q?GrurJBb1l6Ybqum3GYomhwu25CgR5KjevB94LqdGqzRhpG3d+vzGt0Z3qhFz?=
 =?us-ascii?Q?D8lhRvoXjrt3XxKYTbMjqPlb0kBoimJvmf47CNxwSQtYZGaxviK4e1eq3S7s?=
 =?us-ascii?Q?pCcyno443LAc8H3Fu0zsWA95JJgRzAI5b0PExTxJ7v15u24rzOuoB2gJaL80?=
 =?us-ascii?Q?Spmh5/mMR444trO/6YqEWkp6XbN4YMJy6gxfVu+decJeU+y2PTkz2vAiDqoQ?=
 =?us-ascii?Q?47eOTrX9eX15MLLKx7uG1t/zANghKwC0LJs1c6F6e1DdmbVguJ2sgPJWsfEE?=
 =?us-ascii?Q?ItrUkxC5FG5IpgXGYKR9By/qjrCvQla/umjoJ3vUlqxQokzRB9gjDIQR0Q8U?=
 =?us-ascii?Q?2t05nmVae54kdSWkn3R9ltaG+ziExN9Hcm1/lIKlMOv8S/I8PzW2C+q6QcEl?=
 =?us-ascii?Q?akrvj/g5oR9NikPsshpNObUt01B/oCQrRZa6xWC7yFRpfEB3hp9vwWjXoxDA?=
 =?us-ascii?Q?wiWaVUXYr00vhhcb33joS3qe87qXvSXrm72+l2VGZpwxcsyJhz4OHFb1HF3W?=
 =?us-ascii?Q?B0AW7KqOPrdUX5S7tBtb5ZeYCSZp0QoWgO5mKo3CTjbslZfNi2ffJ+y4Ni4l?=
 =?us-ascii?Q?dHxbSZojazYFwSFomf0FEU8fsTDEYGFHCpk4jG8x9Q9w8egCjkFiq0gf8agF?=
 =?us-ascii?Q?ZiQ9PkOHiApxb6MJEi5q0MAwGl5tpYA4yneHF0pndpJQmHeKs+jUsiaThHMC?=
 =?us-ascii?Q?dHC8nPxyPbWatqBaUuL8Eg9zb7cLuUGJ1YNqtQumS1hoeh7YzjJQZ5bmm+E6?=
 =?us-ascii?Q?ySiceksrVztJ3KSZ/ruxjW6aLX6xVVYBDdfPnCXS8/gLaVkvpWerau4iRGeN?=
 =?us-ascii?Q?mqeW9rZeWeffSYtiKROp8WRqfJefclROsZpx8FOGSgGr9bCRPAdb43zX7sBd?=
 =?us-ascii?Q?L7RphbxLDX+jHLXCQlWJX8S29iy2693rfmrM5OvzLWz+GwqDgPZhohht7Qy9?=
 =?us-ascii?Q?rRTPGj3m1/iGGfCWP3MN8LKZeYqxpdJjRvcXGb5BteG6deYFT4gddvOBjObz?=
 =?us-ascii?Q?292lgWu3Dt5JHDBPmAW2vNrjlWZdPGed7bEpYD7yLFtA8bH2rfzwTXGeSSSe?=
 =?us-ascii?Q?gUNqOYAoyMvy/nFksQVdeMbf9mEkHbv+gs2eSGp7vuUWY5DO01rdowF6Uajb?=
 =?us-ascii?Q?moa2NZZehMWXq1i0YkZ8VFyCG6dP8bAE1ovmufBuwYBf9+Q5ug+YyjRMkBfs?=
 =?us-ascii?Q?ftJqWx/zWuUkObjE4HefkG/cE6GQiK6WVzRpxZDVI2W2eHmex3tkmJ8I5P/M?=
 =?us-ascii?Q?kV9/wr0dhHGtrB7E0trF8h03I9Np+CGscm+wIT+qPDUILCgasIY2+D9t5M1y?=
 =?us-ascii?Q?twraUyQEjCfojD89AxY+PRXUuwdmkQjbQ6gB+ovq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fabd883-3838-423b-6aca-08db4275223c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:31:45.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fum1c5B/YPTL0rYyrdXYMiSrLfjFJME6xxiT0ztNAmK18ReyBUtYQ8jqPaHmMFxL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:32:47AM +0800, liulongfang wrote:

> Thank you for your suggestion, but the current debugfs method can already
> meet the functional requirements of verification testing and
> problem location.

To be clear, I'm against adding selftest code in this manner. We have
many frameworks for kernel teesting, please pick one and integrate
with it.

Jason
