Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9B73D0CD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjFYMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFYMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:16:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2091.outbound.protection.outlook.com [40.107.220.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79DE44;
        Sun, 25 Jun 2023 05:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iePCooK0PMPAs7wrWDLjTPDe8f7UhHN8zj78No6SeylhAk+kMuNmtQT31Eh8zhNVGUSh0lBByCePB8TKCBPMzg/Cf72jfXKCQU2XltuhUQ/I4tDPxtBrV4alKRrOno30kxOuDl32jBlKC5dw+ZNoT4b0lNyupTqO7tcROLKvPBhwFI6Cd/lJLSjDFKVrvFD/MdrjNzowBgEeyD0+SC/u5XYBuIKqoc2a7OvpvLvwhzwp6/UhKfV53gaiB1BFVnvxVDEyNsgB6kPKxs+uaoa90SHtILQN8cZt69IS21anMVxJ5QFd1kZbYd1zKTDpgm7yMheeAzzCHQim316nwJ/wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ6elrSezdGzMx453eRdXfeELlw61QliXWjqgWeXZJA=;
 b=Ck7JNuqOxPNSN3SQ3Vx2Q8eyYSymnKDdN11Ko9IfZv1BHq8UEibsUR7b/yVasrwT12SXVMuHdI/uWA45jAHtbjfM3dMkiyzYMXaxIlmJ21+hHN1bUHGOaLm+ceKQwcAxjuB2oVmltKigq0AQ6N+76Z2i2rtv1Ooy2+ugtfkpAwWokm8aapzalVy2gA47lev6/kJAa55oqrL2aWGQZpit9hvsqXvkmCodG6iXNpB4g3oIh7iWyDiPZWWmXGE+i0h3RRHie2lHXCRonOaVMVRY1so49pZzy6DyGP3GOEcq+6lXVT78R/fwOejoMT1n5a42Q8l6eevnyl626F/0oTF5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ6elrSezdGzMx453eRdXfeELlw61QliXWjqgWeXZJA=;
 b=N1pem204BZQHVXQYa+RGlz87+N7iYx5IQDOU7if0yHDZDQYnEd6HgMRj2Zf+MLfphDRmkfuK+T2Sm9VplDBGkilO9rrh7x3Fh2PrMdQ//wCmD/rpXlOrPcb9hRUjDagJ8TENTaIMh8oxQh2vfAmZiSdA/MdhsZRCGe/SnfHQvq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3725.namprd13.prod.outlook.com (2603:10b6:208:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 12:16:51 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sun, 25 Jun 2023
 12:16:51 +0000
Date:   Sun, 25 Jun 2023 14:16:44 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: xfrm: Fix xfrm_address_filter OOB read
Message-ID: <ZJgwLPjJ4m9U04zg@corigine.com>
References: <20230625092855.207918-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625092855.207918-1-linma@zju.edu.cn>
X-ClientProxiedBy: AM0PR03CA0097.eurprd03.prod.outlook.com
 (2603:10a6:208:69::38) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8425d025-113b-40c8-c262-08db75760e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FzciN8c6Bxr1yClBvEsAChdIGO9wbI4ZQX5NtTnqwCaCntAGLoKK+4thfeT+43tXLmCKPA+jSm7TUnfcDFeknQ8qAshpdzG/kyM6yQ8egegok0d0cMIbmnr+r5vhvSlHizbjIEnUFlFmCm0dyqsQB7Wt6ZHFRAnruSpLHw3GGpRheVeD9D8zMwmWgkI5U6XDvgXHVtqKf88ZJLt2AWcmoNTkM02miBdkmEPsCdHGMQuRdmuVEVja2LwedBAsumJDRp33JJcEfsToicfq4nPdFkH96euXPD1wyBocyqxFFVLBNi2pYp8wsMydb3sXJA8H7apcBZK41KP9tcvsT/iMNSs9Hg87Y98ccLmFuw7a1bzaPgq5FlvBA4Yg/Fms51V7Fi3NmrnP9rJvNFAASdwqf1mfgDKzoJvKMP8UXPZKOl2/HyT451yLi2uFs2kdz3TdaBrcVsNx6izcXPjSi2kRSrmOE/SqXgZzu5T3DJoFcHhAnz0QO6koXG1OtQgG8uUYZXldGRGGChCjE2jrY3xIr19u4kwFHaQSS644m7AyPqmHjgYv2VLcItscw36UXJvf8Xy1grL4I5HX2ZNTaf01qb3c8aVhYn0MhIpfpG1kr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(451199021)(84970400001)(36756003)(5660300002)(44832011)(6916009)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(4326008)(38100700002)(316002)(66946007)(6506007)(26005)(6512007)(2906002)(186003)(2616005)(478600001)(6666004)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lbv5x+7LgkIsfwVkdQ3My6cVrYFgqMsyzckrtw9q50+nfcW+IcegGq0rTI4T?=
 =?us-ascii?Q?OFhUBMWQN/jqSZy5YnoufvYkdcPbcP5LYBwNbASP00J2WjaHoIjKoSdXCX8u?=
 =?us-ascii?Q?TdqKk8M4q9P0jWFFkaAei8TSWbAhOV2bv6t/s0msO01vLYDCplhZLPAdfedH?=
 =?us-ascii?Q?iPTS0DEagBmdLDpUMqXHTBJ9HpaqyF1WDwvnS/vhKRasNBuI5txAdIHbgelW?=
 =?us-ascii?Q?CN13CR73dg0yXXfZjPqCkzvZoLf1Ga/N76KHx69eVVbo5Ih52HpB2uDcx05f?=
 =?us-ascii?Q?5W+RDXqHrOXbk3JXytyFfbnihW0T1FnvhiuMXCI+TH+6JFXbAs2aCK7/cKhp?=
 =?us-ascii?Q?5PXUzI/38wPPRwizqV7kL/66ZocOvEkY9hG6dyi7hBBP8Wf0efIJzpxBpXL0?=
 =?us-ascii?Q?DXeG802WQOLZ5K1NH8eSqIhm4024/frSPbn619B0/J4HKf9ni63UuojZoNj2?=
 =?us-ascii?Q?fWwhG95MMSGKbkYEwpxzZxobG6ilx/1yQ5hfEQY6BCYAVUGb0T3FzyvMOmbF?=
 =?us-ascii?Q?E8P8GFrBghmtQ6h/WnCYdO87LE0ihszxQahC0rEhYPBFAnsMpmSAuYhUiKwH?=
 =?us-ascii?Q?NTGjh9v1ND7uF9RIA0HF+2oJQisJTrPfjujhqMoVwMJicKKYi091Wt89470L?=
 =?us-ascii?Q?VZYYJcZf4gM7yVWp5Kvsx99gtj2b5jpHYenv8GRvx0bzB8gRSHrvH7JrETGh?=
 =?us-ascii?Q?sCkRVPkYzy0zBv/0XQejWzeK8QWhVxFWw5SJQpG27hYINSDAy+kJyHnUC53g?=
 =?us-ascii?Q?e0E0tuNKWOQvqdLZAV+Kc4ZYk/H3UGqHAXhMl1Gqw+uXJzs0lKDYsCCqsqNX?=
 =?us-ascii?Q?CwNq007+uvVrmoL5+/jpcYkIQj5dS3vA4mZqoZCufJ5U0pq5tkGWVb/C8YIm?=
 =?us-ascii?Q?6mI//Pm2G9pd4fJ0q2Ngy3XK+G0Za8g38foYfXhJdFnIHCS2gk9RwbP68R6y?=
 =?us-ascii?Q?zF8F9BksONNYZm+PMQ8TwAw8Sr7Z8d9IqU225vd7TnYcliad6i17X2/pXvd2?=
 =?us-ascii?Q?6TzKdr0ao84tjRlOuRoJYYZv37dqZvzNImhS5XUCCkuLmvrunFxUcI//xcZm?=
 =?us-ascii?Q?RPfvkBNBAMIo3pORSM/IyYrgXMevd62PiQsD1mQMcnUCcuZQY4GyOp16iYdr?=
 =?us-ascii?Q?wPnHJMqcmIp8p91zGocsQsxWlpUZ0hmDlF+IF+h40c1sFlfkgRDUCcDIXmhv?=
 =?us-ascii?Q?GSyJ3FE/RZ+K1JbnSxmqnTxkcHdDTrpilmprIHTSOBEKBumxDkdI2zKcIlb5?=
 =?us-ascii?Q?PFI9vL3e/uyYjwUM3TgRNVICnsCG4iZbHK1FKlP3wN/DvNg8Smc1UhjCX0Hn?=
 =?us-ascii?Q?cs34xEzpSnTneQL0FIbNbKAj5ymyFW12Dmc8TySaCU9zxFeMvb2Pn6enFoTP?=
 =?us-ascii?Q?eBoXZuHFzrUtcXRCjpSZFgQnOonoTgmsDRW5gojwTAbRoVa92YNoSafxDmfL?=
 =?us-ascii?Q?MdchovMn3E3BHzMm+vg2HBBFelv2lkqhUuGbhHiARZxkfT9b7/vSpRcyA3Rb?=
 =?us-ascii?Q?mzB+m+3+/KqNqm+FTyBs8Pug+0pKpzm3PgEd3IDXe0BY1EJhhMz65gVaj3nZ?=
 =?us-ascii?Q?8zVWF+k5lCAsTWqBmQDKrV12Pexqx5eUOuVVvrFmf3gEmZS4p90s1VUaXBhI?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8425d025-113b-40c8-c262-08db75760e8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:16:51.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhCHkXtHwipXUsY0rQCEmGVQXQZq9eyfDNv2BMuacNboarKzHbM9ZiED4t+gri68gOnfi8hTF/dWz0IbM/swJIaWMyO6oWXLmb6f3aghrqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3725
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 05:28:55PM +0800, Lin Ma wrote:
> We found below OOB crash:
> 
> [   44.211730] ==================================================================
> [   44.212045] BUG: KASAN: slab-out-of-bounds in memcmp+0x8b/0xb0
> [   44.212045] Read of size 8 at addr ffff88800870f320 by task poc.xfrm/97
> [   44.212045]
> [   44.212045] CPU: 0 PID: 97 Comm: poc.xfrm Not tainted 6.4.0-rc7-00072-gdad9774deaf1-dirty #4
> [   44.212045] Call Trace:
> [   44.212045]  <TASK>
> [   44.212045]  dump_stack_lvl+0x37/0x50
> [   44.212045]  print_report+0xcc/0x620
> [   44.212045]  ? __virt_addr_valid+0xf3/0x170
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_report+0xb2/0xe0
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_check_range+0x39/0x1c0
> [   44.212045]  memcmp+0x8b/0xb0
> [   44.212045]  xfrm_state_walk+0x21c/0x420
> [   44.212045]  ? __pfx_dump_one_state+0x10/0x10
> [   44.212045]  xfrm_dump_sa+0x1e2/0x290
> [   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
> [   44.212045]  ? __kernel_text_address+0xd/0x40
> [   44.212045]  ? kasan_unpoison+0x27/0x60
> [   44.212045]  ? mutex_lock+0x60/0xe0
> [   44.212045]  ? __pfx_mutex_lock+0x10/0x10
> [   44.212045]  ? kasan_save_stack+0x22/0x50
> [   44.212045]  netlink_dump+0x322/0x6c0
> [   44.212045]  ? __pfx_netlink_dump+0x10/0x10
> [   44.212045]  ? mutex_unlock+0x7f/0xd0
> [   44.212045]  ? __pfx_mutex_unlock+0x10/0x10
> [   44.212045]  __netlink_dump_start+0x353/0x430
> [   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
> [   44.212045]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> [   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
> [   44.212045]  ? __pfx_xfrm_dump_sa_done+0x10/0x10
> [   44.212045]  ? __stack_depot_save+0x382/0x4e0
> [   44.212045]  ? filter_irq_stacks+0x1c/0x70
> [   44.212045]  ? kasan_save_stack+0x32/0x50
> [   44.212045]  ? kasan_save_stack+0x22/0x50
> [   44.212045]  ? kasan_set_track+0x25/0x30
> [   44.212045]  ? __kasan_slab_alloc+0x59/0x70
> [   44.212045]  ? kmem_cache_alloc_node+0xf7/0x260
> [   44.212045]  ? kmalloc_reserve+0xab/0x120
> [   44.212045]  ? __alloc_skb+0xcf/0x210
> [   44.212045]  ? netlink_sendmsg+0x509/0x700
> [   44.212045]  ? sock_sendmsg+0xde/0xe0
> [   44.212045]  ? __sys_sendto+0x18d/0x230
> [   44.212045]  ? __x64_sys_sendto+0x71/0x90
> [   44.212045]  ? do_syscall_64+0x3f/0x90
> [   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   44.212045]  ? netlink_sendmsg+0x509/0x700
> [   44.212045]  ? sock_sendmsg+0xde/0xe0
> [   44.212045]  ? __sys_sendto+0x18d/0x230
> [   44.212045]  ? __x64_sys_sendto+0x71/0x90
> [   44.212045]  ? do_syscall_64+0x3f/0x90
> [   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   44.212045]  ? kasan_save_stack+0x22/0x50
> [   44.212045]  ? kasan_set_track+0x25/0x30
> [   44.212045]  ? kasan_save_free_info+0x2e/0x50
> [   44.212045]  ? __kasan_slab_free+0x10a/0x190
> [   44.212045]  ? kmem_cache_free+0x9c/0x340
> [   44.212045]  ? netlink_recvmsg+0x23c/0x660
> [   44.212045]  ? sock_recvmsg+0xeb/0xf0
> [   44.212045]  ? __sys_recvfrom+0x13c/0x1f0
> [   44.212045]  ? __x64_sys_recvfrom+0x71/0x90
> [   44.212045]  ? do_syscall_64+0x3f/0x90
> [   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   44.212045]  ? copyout+0x3e/0x50
> [   44.212045]  netlink_rcv_skb+0xd6/0x210
> [   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> [   44.212045]  ? __pfx_netlink_rcv_skb+0x10/0x10
> [   44.212045]  ? __pfx_sock_has_perm+0x10/0x10
> [   44.212045]  ? mutex_lock+0x8d/0xe0
> [   44.212045]  ? __pfx_mutex_lock+0x10/0x10
> [   44.212045]  xfrm_netlink_rcv+0x44/0x50
> [   44.212045]  netlink_unicast+0x36f/0x4c0
> [   44.212045]  ? __pfx_netlink_unicast+0x10/0x10
> [   44.212045]  ? netlink_recvmsg+0x500/0x660
> [   44.212045]  netlink_sendmsg+0x3b7/0x700
> [   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
> [   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
> [   44.212045]  sock_sendmsg+0xde/0xe0
> [   44.212045]  __sys_sendto+0x18d/0x230
> [   44.212045]  ? __pfx___sys_sendto+0x10/0x10
> [   44.212045]  ? rcu_core+0x44a/0xe10
> [   44.212045]  ? __rseq_handle_notify_resume+0x45b/0x740
> [   44.212045]  ? _raw_spin_lock_irq+0x81/0xe0
> [   44.212045]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
> [   44.212045]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
> [   44.212045]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
> [   44.212045]  ? __pfx_task_work_run+0x10/0x10
> [   44.212045]  __x64_sys_sendto+0x71/0x90
> [   44.212045]  do_syscall_64+0x3f/0x90
> [   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   44.212045] RIP: 0033:0x44b7da
> [   44.212045] RSP: 002b:00007ffdc8838548 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [   44.212045] RAX: ffffffffffffffda RBX: 00007ffdc8839978 RCX: 000000000044b7da
> [   44.212045] RDX: 0000000000000038 RSI: 00007ffdc8838770 RDI: 0000000000000003
> [   44.212045] RBP: 00007ffdc88385b0 R08: 00007ffdc883858c R09: 000000000000000c
> [   44.212045] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [   44.212045] R13: 00007ffdc8839968 R14: 00000000004c37d0 R15: 0000000000000001
> [   44.212045]  </TASK>
> [   44.212045]
> [   44.212045] Allocated by task 97:
> [   44.212045]  kasan_save_stack+0x22/0x50
> [   44.212045]  kasan_set_track+0x25/0x30
> [   44.212045]  __kasan_kmalloc+0x7f/0x90
> [   44.212045]  __kmalloc_node_track_caller+0x5b/0x140
> [   44.212045]  kmemdup+0x21/0x50
> [   44.212045]  xfrm_dump_sa+0x17d/0x290
> [   44.212045]  netlink_dump+0x322/0x6c0
> [   44.212045]  __netlink_dump_start+0x353/0x430
> [   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
> [   44.212045]  netlink_rcv_skb+0xd6/0x210
> [   44.212045]  xfrm_netlink_rcv+0x44/0x50
> [   44.212045]  netlink_unicast+0x36f/0x4c0
> [   44.212045]  netlink_sendmsg+0x3b7/0x700
> [   44.212045]  sock_sendmsg+0xde/0xe0
> [   44.212045]  __sys_sendto+0x18d/0x230
> [   44.212045]  __x64_sys_sendto+0x71/0x90
> [   44.212045]  do_syscall_64+0x3f/0x90
> [   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   44.212045]
> [   44.212045] The buggy address belongs to the object at ffff88800870f300
> [   44.212045]  which belongs to the cache kmalloc-64 of size 64
> [   44.212045] The buggy address is located 32 bytes inside of
> [   44.212045]  allocated 36-byte region [ffff88800870f300, ffff88800870f324)
> [   44.212045]
> [   44.212045] The buggy address belongs to the physical page:
> [   44.212045] page:00000000e4de16ee refcount:1 mapcount:0 mapping:000000000 ...
> [   44.212045] flags: 0x100000000000200(slab|node=0|zone=1)
> [   44.212045] page_type: 0xffffffff()
> [   44.212045] raw: 0100000000000200 ffff888004c41640 dead000000000122 0000000000000000
> [   44.212045] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
> [   44.212045] page dumped because: kasan: bad access detected
> [   44.212045]
> [   44.212045] Memory state around the buggy address:
> [   44.212045]  ffff88800870f200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   44.212045]  ffff88800870f280: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> [   44.212045] >ffff88800870f300: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
> [   44.212045]                                ^
> [   44.212045]  ffff88800870f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   44.212045]  ffff88800870f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   44.212045] ==================================================================
> 
> By investigating the code, we find the root cause of this OOB is the lack
> of checks in xfrm_dump_sa(). The buggy code allows a malicious user to pass
> arbitrary value of filter->splen/dplen. Hence, with crafted xfrm states,
> the attacker can achieve 8 bytes heap OOB read, which causes info leak.
> 
>   if (attrs[XFRMA_ADDRESS_FILTER]) {
>     filter = kmemdup(nla_data(attrs[XFRMA_ADDRESS_FILTER]),
>         sizeof(*filter), GFP_KERNEL);
>     if (filter == NULL)
>       return -ENOMEM;
>     // NO MORE CHECKS HERE !!!
>   }
> 
> This patch fixes the OOB by adding necessary boundary checks, just like
> the code in pfkey_dump() function.
> 
> Fixes: d3623099d350 ("ipsec: add support of limited SA dump")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/xfrm/xfrm_user.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index c34a2a06ca94..a73ae4ad8096 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1267,6 +1267,10 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
>  					 sizeof(*filter), GFP_KERNEL);
>  			if (filter == NULL)
>  				return -ENOMEM;
> +
> +			if (filter->splen >= (sizeof(xfrm_address_t) << 3) ||
> +			    filter->dplen >= (sizeof(xfrm_address_t) << 3))
> +				return -EINVAL;

Hi Lin Ma,

It appears that the memory allocation for filter is leaked if the
new condition above is met.

>  		}
>  
>  		if (attrs[XFRMA_PROTO])
> -- 
> 2.17.1
> 
> 
