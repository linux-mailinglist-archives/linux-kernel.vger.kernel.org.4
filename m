Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC9704D07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjEPLvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjEPLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:51:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185030D2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSISE3Rj3/GaDoGzK1GdTjdLRqCWgGAkAiU6nwAHS/uANK1/DbtXQ5/nggnQgyxlRBV8/jjQzN6pIlsvwAMBB7GgyH3xGB9ouYjTgxgx7PoEGP9/aadxXf3As9auptOpxirBHUnidmV4CuJzCRM1L8htMNNV1gF5QRmfaRUKiQoRnuU//pu+W/xyRb2u5CsTRwvGFVmlScThoMosB/YKI00ROwJ0MffM/J3sJvzpWanyF10qpHK7FIvTXFKYxxMNz0Eh4CN5opQAmKNm65RsIHGXLhJTl3BdJzNEqwbkiQoo7g/eiJh6Q3wnm1h1P48to8wEi7KvU5uP1RCKB1EQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C1TKnq8gxGCEH0z7Ynu0mr8M1pRFSakzddBueSLrr0=;
 b=XIVsxBk+dt2CjP7nHg5AKcE+U7C+Tfb0XrAbGEd6WTLENQ+9TOziGtRYBH31loBNcj/UEaxVGWbwN7uLLupruNdgvIV27Bndrr+DdELj91ycAruDjbpNLc5oxYSc3v1DFajGStUMqoWrGTgBpl2g6aCUOVl/kv+PkLHaSU5BPUnIa0GVZlMWJOF3krq8DblBgNUEbX300HsLs6FlYb98ffypAoECha+RvnTDlQIOjLXSciqf8mFN0k+NFYuFhW+zi3uQKaP0tphP4FeOnCGQ+xIYaEjaI+jtkR7xs2f5dS2ewPQLK3dgpQ92Js/+LV5seLG1DDTxjCCa6nftMVCJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C1TKnq8gxGCEH0z7Ynu0mr8M1pRFSakzddBueSLrr0=;
 b=LLRcnXjtiZlVVG+tYSdNI/tzaV/LhwLuFd5wAmkdFTX3XEr3XKQJLu6yVEM5PvqcJ36GkkAvcmfJdFfoQRZdhgg/lef0AGqthsLbsIaoY1GWX/jJydZxneYmmD+/T8fVs8925AKEKMYJjt7J/ZqDvLqC4KAsEjcudd8G/PtFu/2lCuh5pXdB8xvSwdtzkjbPEENgpCZbTZWUflv0SgmJNXP+Ulq7xgcGUymrtV2H8FTVK4ZbUpM3YeQDLZ7va/p/mQjM63ZCegepWv/QISBkO+KkVuTaNM4eNHk+LWmpYrE453CCumQEIaAzGyhLftH7Oq32NFphiDqagTXKwW2IFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4876.namprd12.prod.outlook.com (2603:10b6:610:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 11:50:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 11:50:46 +0000
Date:   Tue, 16 May 2023 08:50:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v10 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <ZGNuFYQJz488Xrdr@nvidia.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-4-liulongfang@huawei.com>
 <ZDlGC8SUXqKNmfSe@nvidia.com>
 <ca592d60-9a5b-dec3-9565-76cd5c0740e0@huawei.com>
 <81e11acf-0ede-d515-bb5a-3964c302f384@huawei.com>
 <ZEKeUBiLyWWW7E+V@nvidia.com>
 <fa3d47a1-0af5-f8ba-d14c-8d9a756e2c23@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3d47a1-0af5-f8ba-d14c-8d9a756e2c23@huawei.com>
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e2d68e-474b-4052-45d6-08db5603c968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTdX2xzSvC+kushxtMwFrWl2BtBo0w0SiRD0publNToSBnlqcbUxzUH2SD0MCiZquNw2sX28aR2dqAEry49O+LygfOPm1RoSTgreJ0GE6Lmx57uLz67V+Ld2Ye351YnCAws1Nr4MPj9Z7dXmjPe5gillPNf63n+VuAT6dPz4OxgZDSSoM91DaRC+ewgds9YOcz2uywlVefJHfCbmr6UbGHzyjwMveZ4px7sjdjPI2R5+KJ570rmGY5c73DbnP4VW6hiIoIMJUBNUFpAzfe6a5TToox2s88cDuVfRGiW0lLRqN7q1senOH+vQ5SlQMs5V2u1813cIysIw9lEnNHstzpSDEEk5Np9pXnQQaeGT3jq0jyFnLoPertHCMCUcXmoZdfQtaXr3dsPWjdM9SFBMqpGkF4PLWNzSIKBlpX8JRzoBlncMHtndzZTdrD4Cq8uniUXkrUcoYFcUuoaMsCn6CXA80zTJ20ZrGtxUtSZwp0jX9Ix9yhvVBvJihuhzJQOwe0Ai3qx/+AtU42jaPHRhnQVGVgomRyt7UPhHHEiFtY0hWDUcHMrMN3qKV8DRNjHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(478600001)(66476007)(66556008)(66946007)(6486002)(36756003)(86362001)(316002)(4326008)(6916009)(186003)(2616005)(38100700002)(6506007)(5660300002)(41300700001)(6512007)(2906002)(4744005)(8676002)(8936002)(26005)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gxmvs4VeJeDxO2Iph5RHEyyw2d0ioWqBNpOLDJvF07XyHpgQme25+dz/hpWM?=
 =?us-ascii?Q?kdaJz4sEb8zpI4L41gXWqp6isTh9r+FMtQECS/BNGGpMrmc1dFredkUcq1LT?=
 =?us-ascii?Q?PaKrC0J/7IIAvVmO+sJkmRDvi3DrZ2e94CdQTuYcT5YuMwJigpW3TXVmOAm1?=
 =?us-ascii?Q?OUOm5qFQIAQzwPIq8hZphv9LPV3WnVQ0X8NPY4cnbdd6wmH1B6BnfwJyNpTg?=
 =?us-ascii?Q?XuLgM1snc3DtTzSKd7dv9Azjv3ZJQxtJrMlu00tLlEyXnd4/26Ep/NK2OLJY?=
 =?us-ascii?Q?qGkTfK8yn0oi/jYhswx5gJlmNne58BebpAF3KPhoMiZuylwjKfOfqWoaarX2?=
 =?us-ascii?Q?mFX6rWM9dOS1+kV4cQQIiPC2hKw7iY/TVE+FzEVrhtGeOrTBEESN2irfHiGf?=
 =?us-ascii?Q?MT+qmDV6WzrlmESGacNdLUQD7tHO65MEww+gub5LGwz4jbpfpIOjSRlzM4e3?=
 =?us-ascii?Q?ZHfC4LvyF97zlYrecAREGT+42vlCaIONEvwCyiea9+R426m4FeJ7pd8HJBkn?=
 =?us-ascii?Q?l82Bz3EjN7zzowWJF4aNTPuVI7d+f6jL6ZEIYrScpE7vYYIG2We4uvhugwzv?=
 =?us-ascii?Q?ew9kRP4TLGmX3JKR5VsObAM/f64f1xfmEAF1TWepbXbjLXmaokwCE7yOhU4+?=
 =?us-ascii?Q?bXK/z9zONYBcc6jSLct3fC9V5xj9gk27jIXFyNAlp+l8QfSKxXNZszdm35jp?=
 =?us-ascii?Q?3Kk1wsuGBWJsK2m5XtdBS7BhyXP/q25Q6foA7EugNF6YjIWzfTzGDRVkWolj?=
 =?us-ascii?Q?iA6St4Z1FuCd4LQPBAVjARSudKx0YVppZ7xW2kZaZxr9UPUkyB5psHlXAwdY?=
 =?us-ascii?Q?lxuLSDq7zAiP6TSqmsgUuwRoFk1zSnMD9ZCSX06FddMmgdSxbN35DB5yViRs?=
 =?us-ascii?Q?4l/2wgfWOEyDhe0+8uvElKiUpsH5IO517dba+cdZTWFKQfz7JBq7y6FT62Vr?=
 =?us-ascii?Q?QLLGJlguMolLD0plMvMo0QMUnLqRCrRU1zJjfKsKg5PNVDojG5MlSSpuqBuZ?=
 =?us-ascii?Q?Rckgt58TSE/g3ZoooLlRq1Bbe/BJbC1V726rRCDG+2KGDLPt6OSazS2eW33m?=
 =?us-ascii?Q?2AErKSDwlecFndOcb3EDRtzK/hvup8OPnNsE7zJpj5clU+y7RnlIZ8QTTQE4?=
 =?us-ascii?Q?Zqzlnn1rqFAyhWO2aqLt4qQ/wwdky1WVoaMFrOg2zyij1NQwIAUkRjQnl0Ks?=
 =?us-ascii?Q?F+uK037QbBM+gZqffHEU+47d+4zi3lGi3rRiADM155JLcWMme3q/bqcjAmv+?=
 =?us-ascii?Q?9hplJTWiub78RnQvJhqrIkKmapOtgmy1f2ZLglXT1t9irCNHuhZgK8mrNsAp?=
 =?us-ascii?Q?66eX2QC2QzMCnGFyTxPSenjZi21ps2rzZKNj/6gZ+TIVV9ItOgjHAzh4cmz9?=
 =?us-ascii?Q?wj6utcqXMLExQAqSYYH/2fNKPFZDhEdiUjdRmZNYkVVueCfcTlWNo8GXUGT/?=
 =?us-ascii?Q?e6laBPXMK2qyzrZPAwT/oBv0fYFDKQC0zvjJSc7nZRSSYih5Kugxjl/yg/U0?=
 =?us-ascii?Q?kTz3DDmDhbIosT+jaIEB9EStN/j0Ct+bFIrps5MthwIj31fSf0TI96ebH0Ns?=
 =?us-ascii?Q?J4IQ69fLrUWBlGP3mY9A1kT6T6TZvNIH8zOQ8Gxg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e2d68e-474b-4052-45d6-08db5603c968
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:50:46.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvevc+G5N+Dc55ii6llImnBSX7HEs8EI4Dwfzm24EdNBMiwfDmzy0oyK4MXxx/DO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4876
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

On Tue, May 16, 2023 at 05:40:36PM +0800, liulongfang wrote:
> On 2023/4/21 22:31, Jason Gunthorpe wrote:
> > On Fri, Apr 21, 2023 at 11:32:47AM +0800, liulongfang wrote:
> > 
> >> Thank you for your suggestion, but the current debugfs method can already
> >> meet the functional requirements of verification testing and
> >> problem location.
> > 
> > To be clear, I'm against adding selftest code in this manner. We have
> > many frameworks for kernel teesting, please pick one and integrate
> > with it.
> > 
> 
> Hi, Jason:
> The purpose of this hisi_acc_vf_debug_restore function is to obtain the
> migration status data of the migration device. It is a debug operation.
> Just to obtain this status data, user need to complete the few steps
> of live migration.
> Therefore, it is a debug function here, not a self-test function.

A debug function should not alter the device state, or do a trial migration.

Jason
