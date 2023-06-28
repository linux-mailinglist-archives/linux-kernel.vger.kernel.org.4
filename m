Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E74741470
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF1PCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:02:19 -0400
Received: from mail-am7eur03on2086.outbound.protection.outlook.com ([40.107.105.86]:52664
        "EHLO EUR03-AM7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231887AbjF1PBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egC6uWSpw0PeharmrSIaiLZ8cFjPRPXEcr2tHGa5pI2lWDdUE7AXOtbDHAT0vcZw8IWj1lAQysJWfg+TmnKR7MsPtq0N8unS31GKxLxeAQCcWLCF/bzgxV3np4FqUVr7nTU3yRsLElwfLac2UCHm3vi9hP1NX04VRAb1dZP4YaGjLcXl4nik6MvSr4Mn3GQK7jIY/vz8SXs4+MPbf+oBi4yU9JzZFNdwoagPVfkajSjTBbMQ/dP+DnE3uEcNDME5RpamyBwyFjjSb0gPJZ1Dd5/YxEdMCBTzrD2GiXg40h0L6fEWKfAUeSSiZSUxrRVB/esPOJVfuPm2whcgj+bYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUmn8s8f+yHM3L0V6YYEdHD1ycPbQ2x8M9je6d9+K+Q=;
 b=agpa/8Mk8gsuI7zjCjdDsV0ieJFBKujQB6aE02Ji9VmL9mRSt+9qGTixpT2OHBCfZnIjtJNPSX/LcMcFFy8Hz67jX+7rB93zAwNE364RuquyH8VTV7FSrwPE43kO42agYv11ryte48Ug1uwgKmvhzPIyFaGnh1V3wTc8jsXh9r/es6J8aNWZ23YQbYa4xEJLBZ8lZEtyeNSMnDe6gk8Zuc7bpn6zgYfbTQ5xb62DtEhBT2vMrE7isiN+FsbZg0MmEHfAs78bIaa9TxC5duBOTtAp0GdV+QtjRnZToTXJbYUXsQdNQZnWPk4CJ/l7AtUhsD3Hkm2XbqfOTQUXiwfjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUmn8s8f+yHM3L0V6YYEdHD1ycPbQ2x8M9je6d9+K+Q=;
 b=yJkc73qwGkZy95pH841NOsWtm67P7MZsD4fDeFEal8Sgm2K8S0Rviy8LJBqOj6bPHks43kw02tGTvlDKm4VETKvjxfVjxIx0Ju7YxPbsd3vrxYrxuZ3KBwHi00qoW8r5hGeKftvd/C91tzsZz/bN9qV99rhVeKcdN6j42PANAOX4gjhpgcgwTtwqP7h/3FG3Bz1mZsFGro65hB292KBOi6xBkiPgwtuVHQ+xAWRMb6W+8S7LTFkwz+m05d45oI94kppcUh0g9Jsn9z922609Oj9sCObBPNx47owZB+H+YfPRj3znHMqtLKdwVVv35kk7S0m6C1U6RRAMtNZa1mapeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:01:51 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2%2]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:01:51 +0000
Date:   Wed, 28 Jun 2023 23:01:40 +0800
From:   joeyli <jlee@suse.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
Message-ID: <20230628150140.GU21539@linux-l9pv.suse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::16) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DU2PR04MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: c46a7dd7-f81d-4b14-c359-08db77e89a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIayY1VDiqa9g/s6VOVK4V4LMeqTPn9qxaUjQ8h2UAXko6Y35ONEuvOM41BPmO9r/RRMIuzApzCO3fdfi9VXq4gSAk6uqxOPiFTtx0UOa2vkyyinjWnoM/XDXGB86asuLQfhTvYm4/CBAq39HzrMAoFxiklZOrA7niGX7bx1i5NEEkllB/gnJzcCknZNZ41tglPPZojeHpF0eL4/sDLrlQI9bZ4ajBtp5UX3bAVnSXSi/4KqyuJ6ITa2RGFjsLH4+WqioPU9IR0XEdb7BKSFRkk4tUuWAFcfa1azJiD94nj40Pjwz6sr9urnV0skBkYm0TEah3RWtC2lRWaANzIGzcs2x5l5n9JLY+iITSvr6ofcZ62I2pDszmIdDr4p4OAyfkOHwDo8Y4HrdrvjcqEDrJsfGr5AM5SSC2gVfitD1O1nEdJkQZVFsaF6006QLDEaxAIEvqnY7tVO0OEGnfF0tuGBdx0OUdUKZOuu3HUb01S1eB/RwpqZhzaXpn+LeF/fmFIU93nZH47LwnrvHcVZmJIOwerKzCoi5vEpiBuemmdcI5UO79X9prOryxT3azTwgH7xXOgkkqFz8yhcWTDp0bUxto2U6KmnI8kK+Y2b/TAZG6XH4ji4IEPzZsO2rxfzU8CjSvFktur4ssqyN8Y4nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(6916009)(86362001)(38100700002)(5660300002)(4326008)(66476007)(41300700001)(8936002)(8676002)(36756003)(66556008)(66946007)(6666004)(6486002)(966005)(6506007)(6512007)(9686003)(1076003)(26005)(478600001)(33656002)(186003)(316002)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvkQU56voeAWTZakO0NfAY24nGMyg8YUd5Zpms5I9ZZKswUGsdrJbd+Z+HW0?=
 =?us-ascii?Q?yMsrC9VlsLWuH9xw4ZMcZfep8TXuiQwIDIGd++6GfWgDy0x86Zon5TIaNVNm?=
 =?us-ascii?Q?Zv1ZZLuzBCuOy29Atp1/TYp8hB/K8V87g0umzJfAbSha1zDia3OCDTDphWoX?=
 =?us-ascii?Q?laQxTV9gYlHC4PUuH4PwnRB8FIWjNZgChwB0eyv0f+J7r3Vxc58+31h8NR4f?=
 =?us-ascii?Q?xs9xJJXC8W33IiX/EdHr/N7wPeCWUc3iLPQ4M1UTEJ/onsSgVS5w2w3dWukZ?=
 =?us-ascii?Q?vqaMyN7EdtQ5tA1k+wyVCzyw03UQFS1OKfJyZGuKixR804BpOaztB+5i+Rln?=
 =?us-ascii?Q?Js6EP6OqCvDklz6H1eJxXq3jOCs/NWlfGf72o6+aYf0MrYgvdxT1xJbNePzP?=
 =?us-ascii?Q?iIVMqxjYqDjKKbThRNgoRrsVMMytSyJ3CiNprVeZDAHoHQ2LbYnuRZN3QUrV?=
 =?us-ascii?Q?pHny5yWu8H3MM4RaoSkclCwdwiUIfAw++03IhXiVMIcnBm0yLS2U4FbDsrEn?=
 =?us-ascii?Q?bYsH5KeJv1rD2HrvtjxshNTIUkxf+fVDApZFs3tx42jJ7iSRrRmkOkJfOtbb?=
 =?us-ascii?Q?WMUrNdF5pLLIb3TpU2bCh40uCXG96glx2eWluPYvDQjjSnlEXcDlfY/cDlKr?=
 =?us-ascii?Q?0oJQ6nGelcl75UmMp1nUaJsQudXMmHhBc8oTnSb/jZcng4CD+mTAvFvRUKlP?=
 =?us-ascii?Q?JrhMcsG6P+dXUPxa6O62ABLukHoTvcA2dQpkfW0w4Gk9OqDG6ZslsfnD2czG?=
 =?us-ascii?Q?5M0r/WbGYS9EI1L3+OUEoPshpHY1eo593N3GVqy0TjS1MPoNKZvTXz1pbjCQ?=
 =?us-ascii?Q?3cNwU4sr3KcIJuH72KzyH9t18/X+4VJs9+rLlH9tidCoZSrNgV5Q4C9ck2hS?=
 =?us-ascii?Q?VdbcQve2kk+CBPYzNDto4j83FKYfJ6Qw+ZnvGE5bZPFcLZoeT/dSqGbXodo2?=
 =?us-ascii?Q?nAdKkzZ8v9rszCceyqKEt3PQGc2qicBLObOZt26ge2y3IbaWsqzXIkpJQCRa?=
 =?us-ascii?Q?ClPhI08bEO2fTq9+PqvcEjZ/lgufeaFXj9BBhuPAKSLfz2SmlNeoCY2vdBbC?=
 =?us-ascii?Q?02EufR+Nqdzf+pc+axmRk9kmZdlb04Nv2lsPJxY71vqkj9EWtEWlBGTvK82a?=
 =?us-ascii?Q?1z+r4HEmK47fxOyKYyL3td+QA3+qAT6ARSk4TIZMXfEq+aOVJntqlaf8rnv6?=
 =?us-ascii?Q?FASEZL40gXiRmz+UXDbbtqs+kGJolwMeUlWEFKdACRp2i3fwwxYfnllWaffp?=
 =?us-ascii?Q?Y5ZfPlR9rUUz0Af5Kl+F0KGtFocJ6+DWWt+1C310RiabvhqPGH/RwyvJXStc?=
 =?us-ascii?Q?dyTYCxuo1HDy5KTKRJaX+wb3A6Ai+Yn4RCcTkkLN1Jx9c5PW8VttbvmxgjjH?=
 =?us-ascii?Q?Oe74GeYY0iSFnvkXKSdLkpJou8K/IPIFmwoDMGR1R0YMUETsbRP6dQwQSksK?=
 =?us-ascii?Q?wUiL9yppPhPULvDEdfa5biUnRqCvDpYOmjrl88pbuDCtG3wMA9LOPpq2Us1t?=
 =?us-ascii?Q?SilWE6nwRY4uTUOVscpX2eb24WLsG23fwCwlauGeirIZWuFdFLrMjFp+XJq4?=
 =?us-ascii?Q?fPJ752U81zV0wW5Aw0o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46a7dd7-f81d-4b14-c359-08db77e89a78
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:01:51.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M6kgseMX6g7E1rXwBjNKT/jjT67P4aNhyrFLT2lpXEHd5IUUD0RbRJMmHAms5/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Hao,

I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl":

https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/

I am trying the C reproducer in your URL, but it is not success yet:
https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb

I am using v6.2 mainline kernel to run the C reproducer.

Could you please provide suggestions for how to reproduce this issue?
And what is your qemu environment for reproducing issue?

Thanks a lot!
Joey Lee
