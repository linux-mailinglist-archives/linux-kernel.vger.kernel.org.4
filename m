Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B1730028
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbjFNNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjFNNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:35:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EA1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxSh7+QU/I6GSgTlbukJVRN2NPPqPp1T90BU/BRVgyH/6yQ1cvlfzTQ2JoACuW0GG3g6g7oH/8pu5TJ2yYgtaO/ZBDv9JY8NWi+kZ1Qj9VB+BY1nea/pNYRN2hzE471edp4w4y2EbGEeDrXcBcVjxpszIAy+Ub+EfrQ8etO/lvKnIWi2c1Ev9RIOHnqbNaXaNALQ/YCF0+hhUl6CEYkbUdaOrpyPWTd6b0jAr4UsmnVA35d+7aRestKSJgPlHMk0tJPKigQoNTP/3ozh9hOPBaSwOaKDB1GcGLE+7OFMuCB+lhRuUIVsO1oLbjDMNX8mE7lzVsBDoCzlUUGGhI1b+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChncBBJ7wDyCjEj9ZJtJJhyv2uH8GfJPoWDMaGJ8nqo=;
 b=CqpoYOmdwuAZJpt+p3E0qOyJIbBOf1VtuML3YCPDaF/ooHuzJCQ5woGaPNETcnup4Uk7EJ8n9axWiOCGSOKHepLa3hdkUsmULCNRIBdAmAAJOlbOITkgI05IccLru1OOmC7WFAhdXI3MzRJuT4yGCwtNmeNoDbhu6HI6EcsSImJLa0plKKzJPDmDDzwx9ADNIIfx6HBx9rpdW6r/F1D7oEYYWq8UduJ17RUbdv8KIJ3xQ5gyHeqduwWsEjjnMQUARPbJu7ft5BTWpC3m3zew2nPnzjiOreyaWEI5cU8hrm4F5a2FY4btO7R5v+BPSjkfQWuZZfZ5+Cnw8Lg/yzkWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChncBBJ7wDyCjEj9ZJtJJhyv2uH8GfJPoWDMaGJ8nqo=;
 b=mWh2MJKoZvwcLvBbqj3QRvohyZOKOOlQ3zcGgFsCTGfiVLQKdCvWEHNgbOodjBGxJrhRtQBrd3owRdweryNlrfJBOAkfO8sBhcVutfyed426IRJef98j/+75LSOWvsjf1gA/c3Qq+HkTdgr+WPTOcbrZfn7iPmUznfXNXHXBgCQUUnqy/xRlZtLeFWy8XkbttzeChQUYgK4uv1ZSeqOlw2UgPXRS0pXiKnIiEBiQ097t8JxWcqacxdYU0wf1mauYmKG7OVNtr0jQeEr+y5o8WfMDbL1pb12nRoGNoe09PWHVYNPXbaDbeQFmgrlkPF4dNWLKsqDGpRPJygIzIBe9Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 13:35:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 13:35:05 +0000
Date:   Wed, 14 Jun 2023 10:35:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZInCCOCh+OhDGBBh@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
 <ZImuIPrB2YeulNn3@nvidia.com>
 <CAKHBV25g2M-35ZQ9X-mx-La7jVDgBm6rw-umOkNdgu3_jAiA-A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV25g2M-35ZQ9X-mx-La7jVDgBm6rw-umOkNdgu3_jAiA-A@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: db75cf44-4b55-4b1f-517a-08db6cdc29fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2rhYOioW7ad6ARO+D8Y/WPnVZcxVMQNv84OjMz662XeknCPZBJvDuBivHqKz3Z2PnvkAEr093zLZ5kKhyQ4PXfviMKH0DbLzw+CCD1Ld8LP6aya+x6FiYenJ3QoqzSEguJKrRH0C0cCyfjXwOMlQ02DS8TdoT0lAdT3zwWK/19ltR2bQSaS1SWHD2CvvNSV4a9WV4B8/Gn5VQYNy7JGvmY15MlSigMtzytdDeNiNBg7VMRtNnxSs4pSNrPqaRb74CFF24EzOywqcMSQkj7JeIMDALFZEDAf+hDoRuihSDU+e3M6/EODEibPiAnwRF+npCEm3SP96ED7X6JYTb2GHq7N0ndgCW/d/+sScugPLFv48ifINirsDm+r/2SBSd/wxKpZND8A34a4LiLdu0oQ3MsUvscsJKB7gAnn472n8XDMzeFdSLOznM7R9E9432r8+TlRNus8NiokxxfujTPKxzPcWLYIFBhDpUtKXES7t0sq+4zQzpuEUOQyRK3CV9zWHcGLdsfA6xBYbBgTSsOQ49263EKk/fdDydveEUfz46pzsnZ5FAa11RUx2R+a0tqThff2i1eJvEQmr+EU2xlJt7dxLLGQc2QOExxaVtzD6hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(6486002)(478600001)(186003)(6506007)(6512007)(36756003)(38100700002)(86362001)(26005)(2616005)(4326008)(66476007)(66556008)(6916009)(316002)(66946007)(8936002)(5660300002)(8676002)(4744005)(41300700001)(2906002)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iX6OUPc6vjTLauJBx7y58L69UTRD5niTLI6JL3HuklIDNEONs1n9EMnJ5LIH?=
 =?us-ascii?Q?V6srzn8kzOBYkAkkAJTLysSOuquhG6fdDacR3RcsbG9aw2I/3XiWcZF2xli7?=
 =?us-ascii?Q?zX7mXGWTEfeVgCLoHrBc9//Yc5klwoGYAAZ/47/ipNawDaBUpOqF4QUoDWN5?=
 =?us-ascii?Q?g4UhA+Eg/jj1bbfa9Kkxw5TbKrxkw0fewd5AAsDJukzDpkhxGLFWfFr/zhJ9?=
 =?us-ascii?Q?cXn6xGbWNaLx3vSCLWFS+nSvhf7DebhKqQU8HbJiKAKY9oX6ewOZt1wPS9v0?=
 =?us-ascii?Q?jeAzxNC3xh0rtIsPzzhvTc2yCRGrQ9ny4Ie4O9prfh7MWeHfjfLgFGNntukF?=
 =?us-ascii?Q?CtXc0PDFuVao9AB4SpwiHekSi42OBwdVNwVEIOY8Vj4njDvXHmRN39EW3YoP?=
 =?us-ascii?Q?Eh24kW4ap00X4NYbqghyYssyy7F4E+V8XCwk6kn025ngbyl0bCGvIlNjedL5?=
 =?us-ascii?Q?JJRue5lFM6L21TCODHl4FIzt2PeBhdfVfF/iV/7XRfbMY7dnsmmQj9U55+Gm?=
 =?us-ascii?Q?rN341jwAuKGl3CCS6TtTNBXz+n26qqvHrGL/IJAIU5PkLbxAOk2kji7Y7ty+?=
 =?us-ascii?Q?bCrQa7Ih2vffz69KsqSEIldggQi+jiNh7KBDfrJK3jZMKk6GdpM8VfOWL48B?=
 =?us-ascii?Q?+hS6B/qzkkA+UOtV37b143D0HDYUiWjhQE7j7PVNy6BdTVAXRwZTykzhvQwt?=
 =?us-ascii?Q?r8rw1GJvFIvuIACFdkWkQJB1Zq/iiPgwO8/MNyiFCmbQMkxNb3t3TQ0y2M6U?=
 =?us-ascii?Q?MtnoT5Nl8izSHvM9rHeQfANdTuPhhol33Uk6BFgYzBbUZeZacJF/XhOtdk+K?=
 =?us-ascii?Q?V3zyS89rtYQ/7TPIcqYzhcSCkIN9qBEcfJNRlbSeQvmy+Inzc6fqOWACw9b6?=
 =?us-ascii?Q?P4XZiWv90ey9rOFwppyB8aOl8HtkdRc/sp0uYLvv6zFaA9d4EFcqMtgdtq1l?=
 =?us-ascii?Q?8LY6ucRNHZccLy/8cSBAA/BZQBItbP8yMgjAdFQqUql62HGShFeuvEhIBhmz?=
 =?us-ascii?Q?hGqDskBqICho6USReWf0ncOCXCMEtfL2k9uzlYR7dUcpVE0uowQQCbBjBddp?=
 =?us-ascii?Q?0N3BIE6ee9TJXvREhCPo9i6n7YrWuggaMS9R2hBHVexs7vu2qWuTiUwSKgtq?=
 =?us-ascii?Q?u+p2xXqIMbR7gH6bnNIjsEB3FiWk2AKrPrGRy9lXfMzblx/J015ykIb9OBLZ?=
 =?us-ascii?Q?R+BS7u7AQ9f/Gt/wIlykFXaSdrjbLV2eJ1aGhxyxMWWk9Q2PG22W+ADeQr0E?=
 =?us-ascii?Q?Tl8F8bVr3oFiGZRlwtXxX013FqmLysCWBebmH2H0DkYWd9VwH6tBUEa7rcuS?=
 =?us-ascii?Q?7Ek0zGpW3gz3Met9RQhpfbzrxxvNu+YxU9jeYsv55Xisa/KCayKohZ4woNg0?=
 =?us-ascii?Q?kaBa6BuoZZ+/W9eCK6K0yQ+fa2QlYxC0sk4I6IBiTbae+2muUpCvlgeZVtw+?=
 =?us-ascii?Q?2RB0HOkzqzlAFNekZwIfIW9/D04DaIOl4sYtTGmDhjs1hG6JhO15XIL4RUAr?=
 =?us-ascii?Q?RnpkCHYeaGV9owAONcxDT+YTUiqcMfYphFapkOY6DmYU+/4wxPioke/tIUAR?=
 =?us-ascii?Q?UFSK5xeG5+p2hMVIqf8RfGIwZ8V0taYpRJ6yIw1Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db75cf44-4b55-4b1f-517a-08db6cdc29fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:35:05.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlnrvrD05ZJwzowegxaAcRWLq/wK6Ff3Ad3/O+Xow7K4/hbVJYQ60T8W/IkyoVf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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

On Wed, Jun 14, 2023 at 09:30:34PM +0800, Michael Shavit wrote:
> > I think it is good to make progress, it looked to me like the first
> > part stood alone fairly well and was an improvement on its own.
> 
> Sorry for the noobie question; it's not 100% obvious to me what the
> next step is here. Is there anything I should do to progress that
> first part forward?

Reword your cover letter to cover the new subset and repost the series
as v3 with just the patches you want to go with

Jason
