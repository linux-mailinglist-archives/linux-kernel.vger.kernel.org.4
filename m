Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6DB74B7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGGU3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGGU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:29:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC812A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLUKqFiISFGeMucZdzjhkjISuxz+L5tUDTkEOBZeXABaqecq/RM4JTO80/7XIuDX38TZFOL9uTdM+XJPDf8OC7UGmTgousrbj07oCEQipCLUXnF8xeYYSwcw0W5q6lJco4ATYWCoPTmTYaVJaM7Xv5xumcBeqco6VKQ7SK3U93/78Egp4/qfcyefTe8h2+vZmKSEWUXa4EWMC89oemLD/tIPMMSFup7uSdFKbqZBUvl5OgWQBKrAQV6WUIObarmN50sS7TMShMIFG/PATM1u5gzxciYCPP5n2DXfNeessi9ur8PAnyi/4d2hDI/59yAjdWQxMT+x+KzTfjO++Xermg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1KI6MTN4b2Bg1XZ2aGoQWipCLktIt1boGydDsvc2Y0=;
 b=ISZj1nerKPJDyTELCfZuuv0rS8WbebMLqqnvTJJQmEsTemQeagh6qEam4WK++plv8VfzElO0KYSriV1pBkkYV2GvH/nk+sBK7LpCe8GY8Ov0CIRUFfxYDMuLpwfplkDxIdJw38DZ/lrYfFifwJN8WhgG1qrPSSWmSJI4ZNgSFfMiN0rDxtLXzPN5INZJB6sRWB9q7wr8QtJ48TRYbIUTbFzlz3AdnKj12QzEToO0lOuBKLg4yDYBUfGsmV7GGA2EHPwuHSGjIQvNfK2yTPwB2U/1STu38KQXwlqXsEjz0+felGF7Ts7aUjS2ci5GlhKuv9d6K03AD39BjLrMh0Wj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1KI6MTN4b2Bg1XZ2aGoQWipCLktIt1boGydDsvc2Y0=;
 b=jdHQkHPEL3t9a8o2thyDze5leriNGyeKgxn4a/rxLDPos//QhXJ0rBNDUhL1L7zaWx5zGzRmuhnLy93+0fMlI9HXG9cdincP9Jn7CMwiRcLHgDzKohVN2Dv7rKY1YukieSzsKt0WdpaKXf9URmRP4a20D4nPjYFnAbqAupOaH8Isoyv7RcYSV/UuF7skPkvcoMC1Pfg/YPwrgz38DDm8G/8kuSWjgu9C0JU41hgCu7PrLTbRYS1UgGpY5cOqJpNkUb0pkPBb8P8J5yd122CnoAfo3nz7zfdFugaNCxSlFZwK/zhJ+fvGvH/eCBtTqUWw/fzwsUZwgEKNzujbp+ug9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AS8PR09MB5371.eurprd09.prod.outlook.com (2603:10a6:20b:37a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 20:28:59 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::1043:fa08:5e04:157]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::1043:fa08:5e04:157%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 20:28:58 +0000
Date:   Fri, 7 Jul 2023 16:28:51 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [BUG 6.4] sched/core: Possible buffer overflow in do_set_cpu_allowed
Message-ID: <20230707202851.GA4231@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:408:c0::15) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB3582:EE_|AS8PR09MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdf80bb-00e5-495e-d2a9-08db7f28cb09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGpmKhCNck4lLydTC3WwfY9ACDjwvvmD+T+AJthB93RXGfNx8yU2EFcat+ARHWC6g+1HRxL34ElTkOOnJSSDlzXpeZwHKcKlMxd/Uj/5CFp+gtd4mDjuH9hVhEUeXDoBYLW8eBTMWszKS9oDB1JcTLtaQzZAODobUObETFAwYRe9zSiohXa6luexHWj1yF5rEj0p46/IoL2jf1jxmniziILR3A9UZqV8HLboLkgdW9slo1k07IP0Pu4ypZ3oW6njryvNtsuhk+G0QducDTvgwMWij0O9oisMTC4QggLl7mOKl1BTM3E2OKPAcLiZMJG+AENbDXogpmEdzgdao6dLS0eJfh16aBuzNiG2mnLDnnhRHjQ+hwPRvhsVlNisJyYfyh3i72EJxvqtXcAFqFyH2OpkqhJZ9Oh8bJuUwXKuRuME4GYCqIdnAQ2URA/JLR4D+nWnlWcP8bRp1ye8OC0Q+hHd6yF+PF3+OhAf+VYR5qCceKn59R0jUhkSTvVgutbcnry0c/hxitkGN5y5cSBBtE1ORYk251+PEpJQmOtA75sMtpYHsb+6EGpqb3xaD4xIFOLWDYe4Xeb6RsMwenWQkj7IdOKFf01qRe1/N6ePucJKwEgEzMUdfgJT52jhadEM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2906002)(54906003)(478600001)(8676002)(4744005)(33656002)(3450700001)(44832011)(8936002)(41300700001)(4326008)(316002)(6916009)(66556008)(66476007)(66946007)(6666004)(6486002)(6512007)(83380400001)(38100700002)(52116002)(38350700002)(5660300002)(1076003)(86362001)(26005)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nyuKWETujjLiGUstHSRoZFvznzKRg242Cy/8GNS7tJzROVEAAh0KdikyGQV?=
 =?us-ascii?Q?ckEj0GsKJ/q8R/VMf4CiqNT6rZHXG5KDX8XqMkQS2dV31ZYgUwTTqcONQOCH?=
 =?us-ascii?Q?RLz3NZozZD77TM7015ANXnvTREKXGIJqmWbBi+ZR8qmAKty+JjOocb9eU8Py?=
 =?us-ascii?Q?kxneKKTKIUnJ1BRSpSRyFUVkh0P9SdFu8AQhEB0HdZn31HHu2G7/95re/tBt?=
 =?us-ascii?Q?/EPkZ3iGsl1/Ga9ZVVwFM8/VgSP18RlNTDe1Rv8NShTvYX+K2E2cBUU68PVq?=
 =?us-ascii?Q?lQDWp2cQdSQR8BbtMdUTR/qdIwxEqxk0x6Csa3YyNuCUwGfMAWpD/J8E0Bwl?=
 =?us-ascii?Q?qDrnYrTp4v5jZS55JhoXKQxMOWCagc26kCBHW5iOrfMNVXwiFUbAe0tBWKhz?=
 =?us-ascii?Q?tVnsBdf+H3AEsFgMVNOFbAsUwXVzWDryR9y0xpHWSqNGAaA+n/QGRUw6wkwm?=
 =?us-ascii?Q?BXRyjjmUTkKLeQ7RBKCbZzoBJ0lhkhaAI2EIoNe7ROuuvml8enril3j+sY2w?=
 =?us-ascii?Q?Y4JFcQq0p0V5Vn5LEuZ0QXm+M74moyGR0tk8c9xZ7Bx48mXgOGhSLvq8GcRp?=
 =?us-ascii?Q?GY3FXVPQXWe8igkLIkvPU6EUusdaMITcZe171/1DFxlaIgXfCl572AbVRSo5?=
 =?us-ascii?Q?jXPmrHvqivYcWf38k12o24o4Pc+JT5wDLpaksQl042SmEqL1QJ9/mq3EMg1I?=
 =?us-ascii?Q?vSBlfOu3XxdikPqba6iKZPXc4LEBdZ+MgZuF0kL/jMFI5DGr3jQoL+W1sfkC?=
 =?us-ascii?Q?lJrOEUDpoUsBtaQEK1b29FtRV0mIh2VYu9ZsdohlSgMoBz84ulfpPTKHNYIY?=
 =?us-ascii?Q?fCoanvmTNLzNSBLYadATMkRbDNfnxbZXArWELZ94RyMquJgA7KjgCX4Q96fA?=
 =?us-ascii?Q?/m5B7VbBEzbg7asvuRiIFXNybz4thnbGutuZZFl/IvXLLe30LVNsYze0F7Fs?=
 =?us-ascii?Q?uuPPaIVoEFpjZEzh8gU5zf4UeEB1O8D0mL1uN+AsX46fyfCRi1uYP+zXY779?=
 =?us-ascii?Q?xyMEcMkUWxrQRZEMTfjg6daPnrgdz5KeDk6ZWlQ3GGSmIKN567HCZYleYpdt?=
 =?us-ascii?Q?F9nN7qPJ7m/+tc5UJ7vGhg3OFKeMgdi+XFxm77D704Fr8clHl0irzF+vUU1N?=
 =?us-ascii?Q?UiN74UMjGIrT6k2lEkNUWgtM07ClChMx4o648hWJKmMKEzeoXwHR4kIn9X4J?=
 =?us-ascii?Q?pVllau96pdwdkIa+KLKbXA3rP66ZvF127MI2pw/Ugp4AgzmHR8SYiHVFSaWh?=
 =?us-ascii?Q?UTwVRofIzAs3igO9yPf6A6YBe9K+zZmix6w8CLnHcoMG4z3+TyhnfQI51L6p?=
 =?us-ascii?Q?GBGkFDhgRonv8Mpi/uyx5S9xtf1xXGzZAj/WKi5jigGKhb7+IoA21kJHqSU3?=
 =?us-ascii?Q?6LqCtGIgn1Dz6m2qrFOiTG3emoGFTE5A/crdtHtnvtSnEX7LIKXIXm4JnGz9?=
 =?us-ascii?Q?MeDFO64sFhwHVy4+Au+qYKNTbc6bcmOEM4LCip2yL4JKMHkY7rYDXqCYfgwS?=
 =?us-ascii?Q?t8W2owKgEVR1iwQHkdJS14NWOqHpvkMJLdQt2fhO2ZT6fP27p/+aHp+ElIGi?=
 =?us-ascii?Q?YaQM0aTtIFZj+6f3gHUhnnQvn+C/iAVLAb7M/bWPyJU1qve4RdfRqfsuRytn?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdf80bb-00e5-495e-d2a9-08db7f28cb09
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:28:58.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqhUenYkPexAT1jb+7FNP4wcnLRBymIpcUAyysSF4G7mQTXvOTKXVAAxoaphaEzMdy9dXWqvM/pJCngYb4dOcGdT+2KCQug2j5h+4Re2Awk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5371
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 9a5418bc48bab ("sched/core: Use kfree_rcu() in
do_set_cpus_allowed()"), a kfree_rcu() is used to free a cpu mask.
However, cpu masks can be as short as 8 bytes and this is a problem,
as kfree_rcu requires the to-be freed buffer to be at least 16 bytes.
Thus there is a chance of buffer overflow corruption when the number of
possible cpus in the system is 64 or less.

I have not seen this corruption in the wild.  I only noticed this possibility
when reviewing the scheduler differences between 6.1 and 6.4.

Regards,
Joe Korty
