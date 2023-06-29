Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECA7428C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2OpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:45:25 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:28001
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbjF2OpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:45:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLb27ayn/kJf8UbMh9zCyVvcH4VDMyXnzt64AMjtnOxDPgMd68X8A73Fw2uW0UrzKs8c5Gb2ackXXRrMDMm2wIdcezfId6xQI/WtV06StAmHyXnQuJKyelGx1EOTM3hatfmpC6ZPB4spim/4zJLqVeDTt/iDzXsG34CPgZRj/fC38yNqo2bRMEZYe7oI3MrOOvFFtLdRjq8kX62Z002gHlFnQLR8jB6pKCaXggobQogQuXsnApHlPLNk+UdNxCdADROYlw3JMO/K4QXDreZOHFw/7j2GqcxjpKQRZQ0ETBoOqyCUaDvebkE/YADEqWMSPLKsP3p0SOBuzl6f0BeWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGl+4523hblsuJPuRPZUjPdp4fZFJoNF99GmslSu5tA=;
 b=jNqEGthnJtKo0uPp1uxaszAUh7yfjsX0qpPelqLuFk/WPPkgYW+WkfoD6k0SwJbspoozj2OxMRWli1HIPEhprSzo3KUrO4Zy4VOHiFrZXyfO1fY4RTGu18i2w0UbdYygSZnjN3P96wf+dLfjr2qVh0lnPqwDRhNSH28+OhBEM1xJgrXW+j8KteVt7eDlUM0ZzNy7GKKoxjVO0jdyS7mLKw2N4q3zsyZvLclrfs+lQP7/U2S9N8GRfROkZAhTy6gx91R0DA6sv28Y3l74t7ChNY/NENKvn19OWIqc7BUuCo/fYdBCVUIZPr4nErFOr0s3NyCvMkf05wYC4M37zacTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGl+4523hblsuJPuRPZUjPdp4fZFJoNF99GmslSu5tA=;
 b=j/MYPvv31b6bjLwTqGhrEo+BM23rKWa+b3fs/I4U6VtQZsrhPph0dsN0v9BJ/m3Uy3TNw+Ywi/ye3LskntsHefEcu/Wp78ViX5zzcgFispfGlfdKuIO84U35gwpA+RKWD38Ph+TLr+GQH8//fkYKhtw0hru3lqarUCIIj/IVeJJ2v1VkusHwFVvZygnN5hSZaU7E5EIlFhpUY2SH1dXVmC9HESDK4+d4TBLHPz3MWVmpr5QFR+kZrQ//jMSX9u3G616joVxHpVC1UXQB6/82+Jaw3YIcvOiQYGWMS4u5u/Rgy8huAIzyWAEThaYcKu0yH2tiMI7ebA+y3Zpawmrx1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 14:45:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::4651:eac6:ec70:dc3d]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::4651:eac6:ec70:dc3d%4]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 14:45:20 +0000
From:   Aurelien Aptel <aaptel@nvidia.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
In-Reply-To: <20230620145338.1300897-11-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
Date:   Thu, 29 Jun 2023 17:45:15 +0300
Message-ID: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: b4235566-7a86-4cef-19f9-08db78af7674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89qbR2ViLgfrMf2bDgh0Gf0PYegvrNc3E9NaLP8gC7Kf6ve8JJ+GQU8wnq/UX2ZH8Rgq4FCDUuIKIqqpPPXs+68nD2Phj1vwEHifgzsy7vYnhxZlVdkBXSVtC0ivMeQJHLDAmryV064gny7OvR1gUwZgbZTkauQtcYOSIsmvVhDyZ2QLwUzS34ySp++0eKkxgCKhPFb6f+r6qsZCurhKBA7G0colPrEs7nLT51FH4JjyxfR60+9GEcJuX9/Hs0EWs5mte1hRSUQAOQUNWnXsi+YGqCwUWJ/Jl0EMkg54ujZcAQeYrVGiWQF6HL7tyN+G6apsPRAoT8IrdI9fFaRucCqKepPHDJ/wX8Pig4wyScaORt/zmQBKIROu4FGWLiU3OYmz6nGhQN79Wmfu1aOA11hN2hWpsTSIF5uleTa1dX6UAqp6B0jyBuwIlnZdqu+YuQc6WudNW7iVhU2jJ2qy+2qaWHfpvYYf+3TJ6KQje1d5GQ4HeWf44VeinIdGn4bAroVVxHmCBlcnQTpTYsx72+yfimdbWwfPT5ngkWCaGlT+kQu0j+r8rvel1PAxih42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(186003)(38100700002)(2906002)(45080400002)(6486002)(6666004)(83380400001)(6512007)(9686003)(6506007)(26005)(54906003)(41300700001)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(4326008)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KcKFs2PsSxrRm6LsEqdpp8GXCSnANx27qHX2lPu4FwX/TBb15d/Hwp5UkOaJ?=
 =?us-ascii?Q?WFdpk5qT5Dtyk4Jdi8pk3iy5qJT1fuE3JstYRVXcLEhu0UdCEKDd/zB4kfMz?=
 =?us-ascii?Q?VgDFDUScgUkzYVwbii3ydM9u606HymfRN3NE2LNme3b5ig4+oH+lhxMm91bx?=
 =?us-ascii?Q?2MrP3Kd2tDohwhNB6U6iFxyxyOlYESAJfRPrqWCfQjGVjdPlWEMocwACszfj?=
 =?us-ascii?Q?cwGYmAJ39+WcATss/LvGU514PXb2plqPSJny0rQicFjRM6iVrflwDRFVmnXV?=
 =?us-ascii?Q?/QYN3HNw95SpEeqg4nZX95p1QWe+KnSpqWCbzyfry729cvJVrmgkuIlsTJYc?=
 =?us-ascii?Q?kQaN3QY3Ud4BzvA4wCvKpi3nRkA+4CU+SFtwCxdxnchBEkq+lRlQFrGkjXUO?=
 =?us-ascii?Q?MDGz8utddmSL5MSWRlsG67MshmyoX3Pb2QiHrSjKei6QMCFEDPvzq7TjupGr?=
 =?us-ascii?Q?LZ9dNvcFDevnikPoOk3vj/ejxBl8Xz/StNNeiOyYPHoCAIY3vvH/F0KJ7EDZ?=
 =?us-ascii?Q?bD68ZnbscHuYNe3RsJGDHP9tB8IVysuFcbIoHJqz09chFU7YA5MLA368pBwX?=
 =?us-ascii?Q?yyXVcrsuDEh7SYUu+mAHJCskw+lINHOtTxwWEFSpduXnS+uj1AFuoCMFE6Ha?=
 =?us-ascii?Q?CqPTsB6fZfiKHrVikN7er1MUMrZeOtMITHrrbuvwp1auQ2JfQjuqxyLQWoHp?=
 =?us-ascii?Q?xDEmYQ5jHV6QnuHaR+8TdW0O+vzZehThjcOQ7KDDjaOVrQ4qfVmsRBLbUMvx?=
 =?us-ascii?Q?AWT+fYbsfa1DWhuoM7XvNYsjVUu2tZZRcxUS0vgSvc4RgqG/f7LrB5shIILi?=
 =?us-ascii?Q?U6o4+oPegGKnDsLrMwCLTQ3B50pRjfyUNHfufMnvQr6Tf279i5GzhhxkQqRH?=
 =?us-ascii?Q?eHSP8+Y64f5GX7kSJqpfvxO4EM7wJQdzpwzSqFjRNHhaZVyqR0vHhcsvqmB3?=
 =?us-ascii?Q?DjcrdHaRPC6WLIoRuh8oOi4/vTjCpoS71h9ICNwwB3QlVTQ+u0R7HPSiU3cE?=
 =?us-ascii?Q?ZiS8yzvO9Y6jk5qRKbzafEBk/ALedKsHHcAh/IHr4qpJZX20uW7r6f02hW+I?=
 =?us-ascii?Q?lui4lDRpM+AT9IV5wejWIHejdVzFGJ5WrcujQDNCI8qf+wyOMWNdM+ixLYpo?=
 =?us-ascii?Q?pjweTU0tFvPGmDCFIwfNmZftq/HP/NLXwGyGPPVa3sXG0Om9hkK+Y9rstU2Z?=
 =?us-ascii?Q?lGoOKilK6w8URD6L1r/qjTt8MdP84eNAwKNT0mpZLDBfKDJZkVqz+cgNhQLh?=
 =?us-ascii?Q?zq0yMKVBgNDU1aU4rRfB3XcYGjKKBB1alSi4jh728RNWkthQHKr8K53Vd7mY?=
 =?us-ascii?Q?mnUvnU3nsBlpEOH+8LKAef2FbAEgjyz2tT6G2GRAbPz8HwaI+oM3+lmzKOGK?=
 =?us-ascii?Q?4gfRGJrtZn8Umc5isDUq9XXxXM/tQwFHe1RQy/FM9FsB5xuwSy22eJ7Dl0bX?=
 =?us-ascii?Q?HeYaJchW0q0LlsGU8rGXeDI9lAsyhb4sL2PXlwiEe7IFIpUrnH6GQLWwurl1?=
 =?us-ascii?Q?lkGw+SEvSLp1u2bXYrvvy0oZ5K2x9cdUgg5OY5XNyzTExed1cTG0wyHK4fe9?=
 =?us-ascii?Q?R5lN3vZ9A6bP7IVMZxm+gTYJYdGWL90Ak/n8izFq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4235566-7a86-4cef-19f9-08db78af7674
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:45:20.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYsH4bfu7wa88DivK/BSBmp7HnO3J+ExrE5L5MfHS1Y8YlcJG5XzVXvZsavdi4U5TEWuasNoESLVzoWqCOVwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Howells <dhowells@redhat.com> writes:
> When transmitting data, call down into TCP using a single sendmsg with
> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
> performing several sendmsg and sendpage calls to transmit header, data
> pages and trailer.

This series makes my kernel crash.

From the current net-next main branch:

commit 9ae440b8fdd6772b6c007fa3d3766530a09c9045 (HEAD)
Merge: b545a13ca9b2 b848b26c6672
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Sat Jun 24 15:50:21 2023 -0700

    Merge branch 'splice-net-switch-over-users-of-sendpage-and-remove-it'


Steps to reproduce:

* connect a remote nvme null block device (nvmet) with 1 IO queue to keep
  things simple
* open /dev/nvme0n1 with O_RDWR|O_DIRECT|O_SYNC
* write() a 8k buffer or 4k buffer

Trace:

[  311.766163] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  311.768136] #PF: supervisor read access in kernel mode
[  311.769327] #PF: error_code(0x0000) - not-present page
[  311.770393] PGD 148988067 P4D 0
[  311.771074] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  311.771978] CPU: 0 PID: 180 Comm: kworker/0:1H Not tainted 6.4.0-rc7+ #27
[  311.773380] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  311.774808] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[  311.775547] RIP: 0010:skb_splice_from_iter+0xf1/0x370
[  311.776176] Code: 8b 45 88 4d 89 fa 4d 89 e7 45 89 ec 44 89 e3 41 83
               c4 01 83 fb 07 0f 87 56 02 00 00 48 8b 5c dd 90 41 bd 00 10 00 00 49 29
               c5 <48> 8b 53 08 4d 39 f5 4d 0f 47 ee f6 c2 01 0f 85 c7 01 00 00 66 90
[  311.778472] RSP: 0018:ff633e24c0747b08 EFLAGS: 00010206
[  311.779115] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  311.780007] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff633e24c0747d30
[  311.780861] RBP: ff633e24c0747bb0 R08: ff633e24c0747d40 R09: 000000006db29140
[  311.781748] R10: ff3001bd00a22800 R11: 0000000008000000 R12: 0000000000000001
[  311.782631] R13: 0000000000001000 R14: 0000000000001000 R15: 0000000000000000
[  311.783506] FS:  0000000000000000(0000) GS:ff3001be77800000(0000) knlGS:0000000000000000
[  311.784494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  311.785197] CR2: 0000000000000008 CR3: 0000000107f5c001 CR4: 0000000000771ef0
[  311.786076] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  311.786948] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  311.787822] PKRU: 55555554
[  311.788165] Call Trace:
[  311.788480]  <TASK>
[  311.788756]  ? show_regs+0x6e/0x80
[  311.789189]  ? __die+0x29/0x70
[  311.789577]  ? page_fault_oops+0x154/0x4a0
[  311.790097]  ? ip_output+0x7c/0x110
[  311.790541]  ? __sys_socketpair+0x1b4/0x280
[  311.791065]  ? __pfx_ip_finish_output+0x10/0x10
[  311.791640]  ? do_user_addr_fault+0x360/0x770
[  311.792184]  ? exc_page_fault+0x7d/0x190
[  311.792677]  ? asm_exc_page_fault+0x2b/0x30
[  311.793198]  ? skb_splice_from_iter+0xf1/0x370
[  311.793748]  ? skb_splice_from_iter+0xb7/0x370
[  311.794312]  ? __sk_mem_schedule+0x34/0x50
[  311.794824]  tcp_sendmsg_locked+0x3a6/0xdd0
[  311.795344]  ? tcp_push+0x10c/0x120
[  311.795789]  tcp_sendmsg+0x31/0x50
[  311.796213]  inet_sendmsg+0x47/0x80
[  311.796655]  sock_sendmsg+0x99/0xb0
[  311.797095]  ? inet_sendmsg+0x47/0x80
[  311.797557]  nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
[  311.798242]  ? kvm_clock_get_cycles+0xd/0x20
[  311.799181]  nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
[  311.800133]  nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
[  311.801044]  process_one_work+0x21c/0x430
[  311.801847]  worker_thread+0x54/0x3e0
[  311.802611]  ? __pfx_worker_thread+0x10/0x10
[  311.803433]  kthread+0xf8/0x130
[  311.804116]  ? __pfx_kthread+0x10/0x10
[  311.804865]  ret_from_fork+0x29/0x50
[  311.805596]  </TASK>
[  311.806165] Modules linked in: mlx5_ib ib_uverbs ib_core nvme_tcp
 mlx5_core mlxfw psample pci_hyperv_intf rpcsec_gss_krb5 nfsv3
 auth_rpcgss nfs_acl nfsv4 nfs lockd grace fscache netfs nvme_fabrics
 nvme_core nvme_common intel_rapl_msr intel_rapl_common
 intel_uncore_frequency_common nfit kvm_intel kvm rapl input_leds
 serio_raw sunrpc binfmt_misc qemu_fw_cfg sch_fq_codel dm_multipath
 scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon
 efi_pstore virtio_rng ip_tables x_tables autofs4 btrfs blake2b_generic
 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
 async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
 hid_generic usbhid hid qxl drm_ttm_helper ttm crct10dif_pclmul
 crc32_pclmul ghash_clmulni_intel drm_kms_helper sha512_ssse3
 syscopyarea sysfillrect sysimgblt aesni_intel crypto_simd i2c_i801 ahci
 cryptd psmous e drm virtio_net i2c_smbus libahci lpc_ich net_failover
 xhci_pci virtio_blk failover xhci_pci_renesas [last unloaded: ib_core]
[  311.818698] CR2: 0000000000000008
[  311.819437] ---[ end trace 0000000000000000 ]---

Cheers,
