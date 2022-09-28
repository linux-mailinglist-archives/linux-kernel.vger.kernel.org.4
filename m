Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBD5EDA56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiI1Kqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiI1Kqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:46:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2520ADCCF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLXvPYD0+5p4hX6Cib04zuFdpvL8XeSNLX/SR7l6dklPL36OxP+bkfTYxLq9CKH3Vit+4j06HkAPHSnhrVoDilk+kEBYr/WEkEXUagXXxOKF/TSXFXzy8q1jsaikJf421k+uv3p4FfmWE3vAZEyoQOyy3gzYo8kZbfFJYx1o/0IlFmjtGKbJy4PflvxHxGR3wWqMpoqy/iYs2gNJK0FOte4cANFBsiX4KoJhlK8G8eCCDLIVmTZP2PY2ys5x2AyuOezzkSv/j42VDrm1lWTXfAby3RNVD4zZ4FHTmIAKx+fi7UiU8537BImpE5hOMKuz9vETfgO6PX7YsmKGWIB7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myne8LuqDdibLpSF7gbKSnRqLGSWpOYrW3tAokIRvDM=;
 b=XyBei1iBRcuX1zwieaeCD84FftLb1X4vmWJjY8ppJaWQyZJHx57YneK7CQBDMoJxKRvC+pbaTd2XIt98zEJOAZNhlV9cGUBkoWSwMWBoHDVmX+wfgASSXvj2fSWTxW7zY3DQma2S+NL6PSMJ3nRlVRwLaZCgioEqtC64B3IiESE8MG1kSXl+JfFGDA4wlxR6hTRRdjsd/RWIPAJOF4fyui0/t+TYVOxNFtAIwBG93nKTlx54X0lU/EMbPnPSPNzVBF2/vDxZM2c4WOSwr0wsWT1/mGBwULcYxCm3LWcHisR277HHgLXKazM5KAGV48JnUeNRh3t/6l0eS+8KCbRxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myne8LuqDdibLpSF7gbKSnRqLGSWpOYrW3tAokIRvDM=;
 b=naYPC8WPaaBLm5pMEBCkD3aKiKBlB5LycBtVC7p8DNgE9IKpKE/R9BrGvY7rz2DUn1DQHQSz6S8E56Mldr1kLAaKRLvrv07q7iWX5/oNVFOWQGdMMU/Dv8MvEMV76inZsdIj02VYgFXGABftZsikhK+uQ6eoyf4YPom4mySWwHQI5yUXPZGccLyLvAszJ3RUzOaGJVYrQAFigO8Pq+sU5caEAL7A6boENYyPBHAXtP1YzW3wdX3L+UVKCAzu+khe+ZQFny6BJzKUPbtzRYJSaVx9c4vFYnse4g2poLAUKXaTmGiS5aXD/KXTcF+r9kuxJpFsqmQZq0ZSOXQ6zxPXeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4194.apcprd06.prod.outlook.com (2603:1096:820:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:46:47 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 10:46:46 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
Date:   Wed, 28 Sep 2022 18:46:28 +0800
Message-Id: <20220928104628.521-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5be924-4781-4bcc-7bab-08daa13ebd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7phD9MhrqGfYvs3wk1W5CHNsshMlPj9fhgz3w1m744E6gSeU0QEloLh+ByeaZEBsKvWnOlIFikgoEt5Eyf2yYNNalM8Cga31isMLM1BQfHWWSZSF2Um6RgMJKIYL0DXNw4uRlDTEyGOECetDWaZK6QAmLsSyqxA8HdVj2eDQsrvPFu7d7WaWFEFT8rC7sPIY4sXMNQPZZfyflUFXu58nNI/2i9H4HFhobe1u1QLDbk3GNbfC2bg1u2Ys5P7056N+gn79Pze15+Rv03qY2auIh1OmPJpCNUXEGykuKOEjvHMX3dUy8MflAqL2xEjnQNqGC8v4W8N/heiv6PCIL075fa7apKUM6hc4Hr6sDyCor164p0CVX/q74mxTfUqt4ui1ZnuVdsZ/iOgmyFMjDZ85+IvYzzPzZ+5wNa1Kr/11L+m0cJig9+f+BoD+ODvceodc+DtY88DOJNTbxTP7PWy7JiPtHkZpPgx77Anb6ODteme5uvyUrBE1kDJtwqRLFJ36I7kLDuyxIGnEhb2/COivsDCcK9XA2F3deHiOHQoQDRKdAVqO66lxYjNMoq6S65Hc9pNMhmXWt8KZcLRDu83O70rngbGxkYjkoJYs7Uo6Noguls350HuXLmp0Xyi5qv+nUFRgJTla4lSWqpEKHLi2ds/QbKon+TZk3ynboBq7r92V0SEnt3Mxdd00A9q6hDqC3nRaI1imdyHR39EXAcU3S4iXD3pT/oRstZBDIOuO64ASJ/vUvvHDIE5/IwdhzccgVpLcaWnOHd8KIqwexjkR1uQiJkqrxPEUOVj4n6C0T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(366004)(376002)(39840400004)(451199015)(83380400001)(5660300002)(1076003)(8936002)(186003)(107886003)(38350700002)(6666004)(52116002)(26005)(6506007)(86362001)(38100700002)(8676002)(6486002)(66476007)(66556008)(478600001)(2616005)(4326008)(6512007)(66946007)(316002)(41300700001)(2906002)(36756003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PU9BzIItODsuL8QxbXPMLfWLm2Eg5LTmNio43N5rmKub+0d1bdthkPP9fis?=
 =?us-ascii?Q?+W6JuL6QmYL32rktPL3YaKBowzOpwQC4y3h8UW5IYXyt8FE8JyLe71g4WK0Q?=
 =?us-ascii?Q?F8cclQRJw8FGcltLXgOd8uflTt5WhoJtqC7+ALBLcm/XLnJjMEfiC6gqU8ON?=
 =?us-ascii?Q?0PnYP/BflrmTVwBGTi4uj23xLxc9ZYAT+XN3P0bD+b6AZe7otVX7UziN1uDF?=
 =?us-ascii?Q?CHbduv5kl7rk+7NgDLgFYSAwrEPwbGh5JMs1bzD41apV4/WjozinX5uucIHy?=
 =?us-ascii?Q?MBYKEhctbXh7DYRTtc0loLj0CM/VkbEpLkLg4+F/4J3egBYkffigDqO+Q45r?=
 =?us-ascii?Q?COcLsbTaVO/hpZkoMUkuKR6xgRXyk1AIaX5XsYmKFkxNWeu6JSzhvXDUZyXE?=
 =?us-ascii?Q?ztmQUzWu9ERXc4iELMMm5WkbAMLmIsxri+NeJpTw1ogCUZcrAwGVusaj86Fu?=
 =?us-ascii?Q?5AOmqsAZKmjcWlgkurIpZbQVcisYFoED1zv0fHMogvqtR2Jb4MPtp7s5OlCa?=
 =?us-ascii?Q?ssu2KzvzC8CEf0SbNF/VsugIK0fX9MpW9sTnYTH1vN8uqhCDIEXXxWn9qW7T?=
 =?us-ascii?Q?Q1F4/hL6768SHRpwkqmHObfXPcvCBEsnfazuwPZyrf/xhxHVo30ePumfx9lo?=
 =?us-ascii?Q?ymENSo6VTKELoI79/yes5J5G+l5qRIwzPZGdFd6DyHicdC4lF6zvaW20RT7c?=
 =?us-ascii?Q?KwBXU9wHXBFbQ5ECwUSAUld6q5/Ad5I5VtZar7RluK4kg9tRUW9MbVGara/d?=
 =?us-ascii?Q?KYSF/gFYIcJG7J58dKJSiJM0wUXoXk+/OarK7I3O56S9cUCzW/bnl3Ngljpl?=
 =?us-ascii?Q?q1XZBujkOhavk4ZISXCRGFfygScVayUvaB4et9tc/9EjPSrgjiqofYBjQBKT?=
 =?us-ascii?Q?ygul6h2GjbPrH4ElSf4myrJ/2BQarHdUGSY3Atbc3gn6K1yHkQe/XP4oyx8W?=
 =?us-ascii?Q?KEKZrJ0bFH5PpEqz5io14tnegkyKpcy0bKe+GS9XS94VRn+MyxNtOurg44QB?=
 =?us-ascii?Q?KRtD1gvr0Sa+6PWfu/5hsHc4oVc8uaQNHJHlv+DT3Io+x9mqBuGaCuJnCrWy?=
 =?us-ascii?Q?wB82aPjvukASrb62hAgXpQLvc3Np/ER95TNzlZXkpnO2g8cqkvDvsGEa7E+m?=
 =?us-ascii?Q?n4YjGyFMgB0pGPSC4j9tm3+1et4+KYxCoQ7jPx3BCVGb06nAorDsB9WfKP6J?=
 =?us-ascii?Q?Giq9QYRuiy4X5G27Ayo5SEp8t0PjKF2JNXZnLNyr0fCg28vh2G6kGKxx+Fko?=
 =?us-ascii?Q?3F0RjMdB1CVaFzGX/f76Ro7eoa3426pg9N1wMyboDhhH0Aw8YncFaTVfTiMO?=
 =?us-ascii?Q?bcfxgAVUKq5aCKAvvxTndVl9FHJ+0mrYIu3SZY8TJjeHKEayam4Z9Aafs5kn?=
 =?us-ascii?Q?T0jbh/fatt7W/Wqv92nUm8d/lF3jUX5GIdTVxlSm0b9hj2EWZMijVAGBKMLA?=
 =?us-ascii?Q?NMsPqvWEbEGVF5Kc0777OlmlOvqYM86Jql2ykbk32sXeHpBLNoWftPXxkle4?=
 =?us-ascii?Q?/84j/jVoP6q4JT0stX3eK2TW55fNRugADU0u5tEyCREBh44CTzt8YB6RtI2l?=
 =?us-ascii?Q?cKXdXWGw0+6XvvKlnQEfe8ssaqgtHBDhGNcrpHHkUJpFYtE80ZH6weegdJsT?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5be924-4781-4bcc-7bab-08daa13ebd65
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:46:46.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xecraHnm0lpHydFk9lx7EvnEzKs/hgyzxyEc5uDIwC6eDRjG8+HhFZQFLLzEzxMa5gIkV/M19S8RfOGo1EnJVwcwXhf3texOxgAU5JMygwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The background is that we use dpu in cloud computing,the arch is x86,80
cores.We will have a lots of virtio devices,like 512 or more.
When we probe about 200 virtio_blk devices,it will fail and
the stack is print as follows:

[25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
[25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)
[25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
[25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
[25338.523881] Workqueue: events work_for_cpu_fn
[25338.528235] Call Trace:
[25338.530687]  dump_stack+0x5c/0x80
[25338.534000]  __setup_irq.cold.53+0x7c/0xd3
[25338.538098]  request_threaded_irq+0xf5/0x160
[25338.542371]  vp_find_vqs+0xc7/0x190
[25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
[25338.550223]  ? ncpus_cmp_func+0x10/0x10
[25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
[25338.558846]  virtio_dev_probe+0x158/0x1f0
[25338.562861]  really_probe+0x255/0x4a0
[25338.566524]  ? __driver_attach_async_helper+0x90/0x90
[25338.571567]  driver_probe_device+0x49/0xc0
[25338.575660]  bus_for_each_drv+0x79/0xc0
[25338.579499]  __device_attach+0xdc/0x160
[25338.583337]  bus_probe_device+0x9d/0xb0
[25338.587167]  device_add+0x418/0x780
[25338.590654]  register_virtio_device+0x9e/0xe0
[25338.595011]  virtio_pci_probe+0xb3/0x140
[25338.598941]  local_pci_probe+0x41/0x90
[25338.602689]  work_for_cpu_fn+0x16/0x20
[25338.606443]  process_one_work+0x1a7/0x360
[25338.610456]  ? create_worker+0x1a0/0x1a0
[25338.614381]  worker_thread+0x1cf/0x390
[25338.618132]  ? create_worker+0x1a0/0x1a0
[25338.622051]  kthread+0x116/0x130
[25338.625283]  ? kthread_flush_work_fn+0x10/0x10
[25338.629731]  ret_from_fork+0x1f/0x40
[25338.633395] virtio_blk: probe of virtio418 failed with error -16

The log :
"genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
was print because of the irq 0 is used by timer exclusive,and when
vp_find_vqs call vp_find_vqs_msix and return false twice for
whatever reason,then it will call vp_find_vqs_intx for the last try.
Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
flag IRQF_SHARED,we will get a backtrace like above.

According to PCI spec about "Interrupt Pin" Register (Offset 3Dh):
"The Interrupt Pin register is a read-only register that identifies the
 legacy interrupt Message(s) the Function uses. Valid values are 01h, 02h,
 03h, and 04h that map to legacy interrupt Messages for INTA,
 INTB, INTC, and INTD respectively. A value of 00h indicates that the
 Function uses no legacy interrupt Message(s)."

So if vp_dev->pci_dev->pin is zero, we should not request legacy
interrupt.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
v3:
- add quotes of PCI spec
- Move the judgment from vp_find_vqs_intx to vp_find_vqs

v2:
- Decide whether to request an intx interrupt by pin instead of irq
- suggested by mst

v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-mst@kernel.org/T/#u

 drivers/virtio/virtio_pci_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index ad258a9d3b9f..44a839127f2b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -409,6 +409,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
+	/* Is there an interrupt pin? If not give up. */
+	if (!(to_vp_device(vdev)->pci_dev->pin))
+		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
 }
-- 
2.17.1

