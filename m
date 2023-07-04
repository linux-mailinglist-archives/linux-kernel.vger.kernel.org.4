Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB57475BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGDP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:57:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1106010CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+eC6bQJ3ueS8Ayb0KzJkY4xIeIQj4leqUcC5Fa85BOxNK+u4JbXhN8Hmsrannz+LUgNHn+KvpcYKplr4KQPHUec/kh2dFLYJcjocWsX6xdCZDGh1ULiP0WYUsO8Fdq3WbY6Psg01wJ0PAGlfo4XKo4/wkL7jsJ/f/lLLe1E4yBWJoiQFsjlPQO+qbuZKljVIBTDQpUepB+OsM8EaC7IxYJRkCNCtjd/XCAyZRBI3VpyQpKMOhFnXZWdnvGgFLWFlqzwqFudnQs68shy6DgGc1vyUGHPYPcV/IRabIg7ja1PsJXRYJjHfkS8DD9tbheVGvTN/57ikf57Wk5tGNTTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1xjS3H/COFM1zaTUlCFb3X5PxbGcPPRNY3qlRTa+ag=;
 b=of6PA5gcyEkuaS0LJWhrcMngfengi0Gh6AFa8cWShzUSKi1wQTW5xEbcx1kb6PBw+at/KvBpSzQc9LjXiIVSvo/AjzL/rjY2tkeLRVF4CmJBuNo49j5DKUz8aAVQ4iBqbl1MDYWgzgzcqCozY8V12Ys/yLUu1yVItZMexzQpWPBE9xypOhwbDcRoJOO9XHYMbnaAJ8VKSllrhk1w0h7hgSs/YQmeKd7K09ZfQE7JU3IR3FLQRyE2zFFZrRfny6FF/uCVQs0jj83r8gcRI//HTzU3fO7f+5CcoUBXgSAQkC/t1hwzIqS8S+Jb9+fFwsxr4kkh5Zr17mUI9NV9DzoW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1xjS3H/COFM1zaTUlCFb3X5PxbGcPPRNY3qlRTa+ag=;
 b=VNk83aSkRaHsXAUr8HvcltJqNxD43km5omfFHgaoB7LIOjOmKeA4E3tf0AhgLI3b2t7NGlHYwfs2F3ufCmFf2G4kDXwn6wBHFeXOsnue3LRxMpj0XHc0kCoF1GSpJsEZn3uS5BB0Zj+65wfhHpYlnbNrrw79uZsihGNYrU8iOeeVqvZqtTjUXWMIEQSM5Tbj8Q1wbZudgUVMASIDHpDnOvQMEqkIsoZsPIkh2fKYKYAStt2Pd+bY2R953827Q9aKlFvclBsqBYLTmIU5tMT0E0dYd1joy6+XIghGoEqfkowHG97ZARlw3l99R3eNyzbLlMLTagjICCykDaRWLm20PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 4 Jul
 2023 15:56:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:56:57 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: drivers/hid/hid-nvidia-shield.c:59:2: warning: field  within
 'struct thunderstrike_hostcmd_resp_report' is less aligned than 'union
 thunderstrike_hostcmd_resp_report::(anonymous at
 drivers/hid/hid-nvidia-shield.c:59:2)' and is usually due to 'struct
 thund...
In-Reply-To: <202307041500.6bKn7nCl-lkp@intel.com> (kernel test robot's
        message of "Tue, 4 Jul 2023 15:13:08 +0800")
References: <202307041500.6bKn7nCl-lkp@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Tue, 04 Jul 2023 08:56:39 -0700
Message-ID: <87a5wb7jrc.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c73f267-cd10-4cad-c81f-08db7ca74ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ihSOPrq4VpZDRQaPtVuapYGyzxg1PpHaQiSnmbbzEoLrZ92Oy5Gw5NZ3K3sC9UsmIcxHJTkzen571TufDzA3WkAsbzZsk/jUNsZQDh34oaaOe/rDTVuQOEIYlvklTdn/nHVbD/eeW38OptGbBIjyo6TDNRhapmKTYStsYNbCgN4xLZEgHYSzf2U/Iy8RM+T7lYGpbiDAoOi8Zoe+k4upThEwM9Z0V9TwgadAk/ovrrc8TTZmpDTr9rZ5Nr9nxKMjhXD3tDU2oj4rDKWr/9XUrLRWme8G3XmjSNIpkDMYjidy3B5232kGh58cVz7EVGB4242xTuaoavOU7noLxK4VbhVTMpYmUoauS7fAkz59pkqvS0Vk6C05cANaG/bBgxl6C5/Ylo9QGrS1KPwbWo8XNP8CjwYB3SqEAMYRL6w5eBYSUkHltUE4Nf3+oe9NPvfb0682fOXlW0amHYxsqe9XLYu8zIc7uc6isGScSTGy6eVKcZCn6br4/4UCtcdHy4D+PTfAItAmziY9OKocFbQML7s9KdnuRGx5WAfHrCTbOiL11xbzjM+ClOQ31mPFHAJZ9wkYL9D3QVAfxoDLD/PvqgVfIYEHgiqEUXPjWeeD/QJfdMdIi9Fh+tym/lk/WNsp4jSBoyuIx01lEW2Iouobw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(26005)(2906002)(6486002)(38100700002)(2616005)(83380400001)(186003)(6666004)(966005)(6512007)(41300700001)(86362001)(6506007)(316002)(478600001)(66556008)(36756003)(66946007)(66476007)(6916009)(4326008)(5660300002)(8936002)(8676002)(219693005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XKQ/XnW4Y3ffgg6lYUOOEoAipShFBrhnfzpRgqUC9CjHfJsrd+TrXi/mq82?=
 =?us-ascii?Q?ZmC9QVkVDxJTxJd4W3owuPCv/8TPB4HStXT1SUoQhWSTJs60QZYdiT/YmJeb?=
 =?us-ascii?Q?EU8f0Rz3ggyhHFQdj2OkGvkH6ZRJ8miC+rI0fB0OToyq5A7j4URqMBfzrKIV?=
 =?us-ascii?Q?/CpVZsPhFSvq7GkJA9Ag6st13H9aoa1U30gxc/fv3WXCcV/ML0bWtxYu+jcT?=
 =?us-ascii?Q?P/q3Aa5DcdABrmxyj4RNUGTPMMhM48M9jG2Ye9pFPSwYih4xrVcYGg6my2ME?=
 =?us-ascii?Q?YA7Jz3U7o54dpf9wEF4UfOoMQwVRaHfCIWZHqwaUdEUCfgO/ZKqROrPa8LF5?=
 =?us-ascii?Q?O8A05RaH/bfZPGT1b71OH09bye3dbMlN7IaoK8VgzYgZWc3d2E2fgTUaXQ+g?=
 =?us-ascii?Q?BaxNCqxC4/YqiXnmZhpdW0Ecje5ZTCWli/Hc4bOFpLda0XuYHR76C5eP1La8?=
 =?us-ascii?Q?rnAAsFN/yT6VHUGMzYjI2pfasP8j2ZDKZyQMBhPbfTCGh4oikkTBRD189CFk?=
 =?us-ascii?Q?L9pJTwVwQRaC+ra0i66NiM/W4fGqBkWChKiwUOzcjSBecYUetsWj7Dnk6DRl?=
 =?us-ascii?Q?TvmFA3gq52xQs4LI1MiXpCl6mpMvaeFumnhKm+0CXvrawoPCyrlz0aZAU7qf?=
 =?us-ascii?Q?F1Yura26YA7FLR2kDBoItrEg4e4Ja+xItVwW+Ch9FhPmRVrzQyKGokLqcxZH?=
 =?us-ascii?Q?qCMEpQcy4DJvCzT22LuNDNJ4EQxMDnzBjsqyahmxx1gXChSwed50Bqqo49wt?=
 =?us-ascii?Q?pKjTpsL6+7fJAjCKLmxYGrG36TIu+jDVF80SBKN6xCB01shSooNAzKZFDEEK?=
 =?us-ascii?Q?2OhYM0Sl6LrEQwU1GopPdT+ol7bU8QB29SQ2WlB7p2/0R4Tg9q2HcJ0m6NH+?=
 =?us-ascii?Q?HV9eoXO2PfDVzCAb1lgsdwW1kRc6FHyZEUg+BqUQnORoVQ352amQX489Boy+?=
 =?us-ascii?Q?OxZTwk58T9OELYe3KBvpYC7Vmc9pDWJ+ULbETh9DWf5spvYOzpWzyLsXjmDe?=
 =?us-ascii?Q?T+YV63NWhgI6DWSw9gG3HwF0KZXuV2BRpBF3rarzj7RkfRRwI8OISzWVPf6x?=
 =?us-ascii?Q?nfYQKazCAPTy9cffgB4nFRZMB/dun1Lg17UeqrceOZ0TQenPfarFx3qXSiqG?=
 =?us-ascii?Q?Ui/K4lMJHURU6TMJaMOgfYJFvvAYRuEYiptqTooHmszBF46C4DWMGj3sb4CF?=
 =?us-ascii?Q?V4hNdJ7Z+Lam/E87U2KgxJxlrRMIm2FiJTsbopkv89YRFlCY+qgQpEAofx92?=
 =?us-ascii?Q?Ja4kpZm8T0HD8f6hoPbYiXiecOIgPKC0P6fl6D+xqu2Fego72ejuQt0xddFv?=
 =?us-ascii?Q?bK6FUqciyxFgpKYt3sRGgk91fMLlYkaVfA/s+aL5eqPUzQ33Mciv+MkS6Kuy?=
 =?us-ascii?Q?9ppxW3yTNRLb8b+OvV11ZQqPYGgBYQGaPaGZ/4lDPaPzw5P6VORr0zG5puBD?=
 =?us-ascii?Q?sExVu1wpdhg76uqXRMSTRLmhswPHK7tQK1sZEWrNztut6jVlhnh6zOysFray?=
 =?us-ascii?Q?cFgMwnT8NRJSsGYipROnyeG0J5ymOVtRpe2T/k50zpebF7WkqTBKQRNg0TqY?=
 =?us-ascii?Q?kd7gLcOJr+MHmhAwvoj1bxvj2v4WEMBnuT+ehRk5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c73f267-cd10-4cad-c81f-08db7ca74ba3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:56:57.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rX/UNoGwTpFAXaPcYoq9ftElVyNrIv7b4R3FU9x1fsWJEztkWuRwq9pz/zPuFbmn70fb+iOCJIuYD8xHOomGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul, 2023 15:13:08 +0800 kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   24be4d0b46bb0c3c1dc7bacd30957d6144a70dfc
> commit: 09308562d4afb1abc66366608fa1cb9de783272f HID: nvidia-shield: Initial driver implementation with Thunderstrike support
> date:   4 weeks ago
> config: arm-randconfig-r014-20230704 (https://download.01.org/0day-ci/archive/20230704/202307041500.6bKn7nCl-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce: (https://download.01.org/0day-ci/archive/20230704/202307041500.6bKn7nCl-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307041500.6bKn7nCl-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/hid/hid-nvidia-shield.c:59:2: warning: field  within 'struct thunderstrike_hostcmd_resp_report' is less aligned than 'union thunderstrike_hostcmd_resp_report::(anonymous at drivers/hid/hid-nvidia-shield.c:59:2)' and is usually due to 'struct thunderstrike_hostcmd_resp_report' being packed, which can lead to unaligned accesses [-Wunaligned-access]
>            union {
>            ^
>    1 warning generated.
>
>
> vim +59 drivers/hid/hid-nvidia-shield.c
>
>     53	
>     54	struct thunderstrike_hostcmd_resp_report {
>     55		u8 report_id; /* THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID */
>     56		u8 cmd_id;
>     57		u8 reserved_at_10;
>     58	
>   > 59		union {
>     60			struct thunderstrike_hostcmd_board_info board_info;
>     61			struct thunderstrike_hostcmd_haptics motors;
>     62			__le16 fw_version;
>     63			u8 payload[30];
>     64		};
>     65	} __packed;
>     66	static_assert(sizeof(struct thunderstrike_hostcmd_resp_report) ==
>     67		      THUNDERSTRIKE_HOSTCMD_REPORT_SIZE);
>     68	

Will send out a fix for this soon.

-- Rahul Rameshbabu
